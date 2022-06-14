clear
close all
clc
%% Ucitavanje podataka - nebalansirajuci podaci
load('data_c2_balanced.mat')
X = data(1:2,:);
Y = data(3,:);

%razdvajanje po klasama zbog iscrtavanja
X_0 = X(:,Y==0);
X_1 = X(:,Y==1);
%% Prikaz podataka

figure()
hold all
scatter(X_0(1, :), X_0(2, :), 'r.')
scatter(X_1(1, :), X_1(2, :), 'bx')
xlabel('x_1')
ylabel('x_2')
title('Podaci')
legend('Klasa 0', 'Klasa 1')

%% Slucajna podela podataka na trening i test skup
%X_0
ind = randperm(length(X_0));
br = round(0.9*length(ind)); %90% od X0 izdvajamo za trening 

X_0_train = X_0(:, ind(1 : br)); % trening set X0
Y_0_train = zeros(1, br);

X_0_test = X_0(:, ind(br + 1 : end)); %test set X0
Y_0_test = zeros(1, length(br + 1 : length(ind)));

%X_1
ind = randperm(length(X_1)); % isto sad za X1 klasu
br = round(0.9*length(ind));

X_1_train = X_1(:, ind(1 : br));
Y_1_train = ones(1, br);

X_1_test = X_1(:, ind(br + 1 : end));
Y_1_test = ones(1, length(br + 1 : length(ind)));

%Bitno je pomesati podatke da se ne desi da mreza uci nekoliko
%iteracija na podacima iz jedne klase, pa onda nekoliko 
%iteracija na podacima iz druge klase. Ovo moze da oteza
%treniranje jer ce mreza nekoliko puta za redom podesavati parametre tako
%da bude sto bolja u nultoj klasi, pa nekoliko puta za redom da bude bolja
%na prvoj klasi, pa tako u krug.
X_train = [X_0_train, X_1_train];
Y_train = [Y_0_train, Y_1_train];

ind = randperm(length(X_train)); % mesanje podataka za trening
X_train = X_train(:,ind);
Y_train = Y_train(:,ind);

X_test = [X_0_test, X_1_test];
Y_test = [Y_0_test, Y_1_test];

ind = randperm(length(X_test)); %mesanja podataka za test
X_test = X_test(:,ind);
Y_test = Y_test(:,ind);
%% Prikaz podele
X_train_0 = X_train(:, Y_train == 0);
X_train_1 = X_train(:, Y_train == 1);
X_test_0 = X_test(:, Y_test == 0);
X_test_1 = X_test(:, Y_test == 1);

% Klasa 0
figure()
hold all
scatter(X_0_train(1, :) , X_0_train(2, :), 'r.')
scatter(X_0_test(1, :), X_0_test(2, :), 'bx')
xlabel('x_1')
ylabel('x_2')
title('Klasa 0')
legend('trening','test')

% Klasa 1
figure()
hold all
scatter(X_1_train(1, :) , X_1_train(2, :), 'r.')
scatter(X_1_test(1, :), X_1_test(2, :), 'bx')
xlabel('x_1')
ylabel('x_2')
title('Klasa 1')
legend('trening','test')

%% Izvoz u mat fajl
%Podaci za treniranje
train_data = [X_train; Y_train];
save('train_data.mat', 'train_data')

%Podaci za testiranje
test_data = [X_test; Y_test];
save('test_data.mat', 'test_data')

%Broj trenirajucih podataka
N_train = length(X_train);

%% Krosvalidacija
% Potrebno je napraviti proceduru za
% krosvalidaciju kojom cemo utvrditi najbolje hiperparametre za neuralnu
% mrezu.
%
% Zelimo da isprobamo razlicite strukture, aktivacione funkcije,
% koeficijent regularizacije, tezine klasa... 
%
%(Da bi mogli da iteriramo po strukturama NM, pomoci ce
% nam da iskoristimo cell array strukturu podataka koja se zapisuje na
% sledeci nacin structure={[2 2], [5 5],...}. Ako zelimo da procitamo njen prvi
% element [2 2], potrebno je napisati structure{1}. Kad vec koristimo taj tip 
% podataka da vrtimo iteracije po strukturi, mozda bi bilo najlase 
% iskoristiti ga i za sve druge hiperparametre.)
%
% U slucaju balansiranih podataka, krosvalidaciju radimo prema
% tacnosti (accuracy) kao meri performanse. To znaci da je potrebno da 
% pronadjemo kombinaciju hiperparametara koja ce dati najvecu tacnost
% (accuracy) na validacionom skupu podataka. Takodje hocemo da vratimo
% informaciju o tome koji je bio optimalan broj epoha za treniranje NM sa
% tom kombinacijom hiperparametara.
%
% U slucaju nebalansiranih podataka, krosvalidaciju radimo prema f1 oceni
% za klasu koju zelimo da pogadjamo. Sada ne koristimo accuracy jer
% nije mnogo merodavna u ovom slucaju. Zamislite da imamo 2 klase i da se u
% jednoj nalazi 90% podataka. Ako bi napravili los klasifikator koji uvek 
% kaze da je podatak iz vece klase, on bi imao 90% accuracy.
%
% Da bi ubrzali celu proceduru, pomoci ce nam da iskljucimo graficko
% okruzenje NM toolboxa naredbom --> net.trainparam.showWindow = false;

% Prvo treba inicijalizovati sve prommenljive koje ce biti potrebne za
% krosvalidaciju (trenutno najbolje vrednosti za hiperparametre 
% i mere ocenjivanja performansi)

%%%%%%%%%%%%%%%%%%%%%%%
best_acc=0;
best_f1=0;
best_structure=[3 3];
best_trainFcn = 'poslin';
best_reg= 0.2;
best_c1_weight=0;
%%%%%%%%%%%%%%%%%%%%%%%

%Potrebno je vrteti iteracije po svim vrednostima hiperparametara koje 
%zelimo da ispitamo.  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PETLJE koje vrte kombinacije hiperparametara
for structure = {[17 17],[31 31],[25,25]}
    for trainFcn = {'logsig','tansig'}
        for reg = {0.14, 0.05, 0.2 0.3, 0.5, 0.8}
             for c1_weight ={6}
                net = patternnet(structure{1});

                net.layers{1}.transferFcn = trainFcn{1};
                net.layers{2}.transferFcn = trainFcn{1};
                net.performParam.regularization = reg{1};

                net.divideFcn = 'divideind';
                net.divideParam.trainInd = [1:round(0.7/0.9*N_train)];
                net.divideParam.valInd = [round(0.7/0.9*N_train)+1:N_train];
                net.divideParam.testInd = [];

                % Dobavljanje validacionih podataka
                X_val = X_train(:, net.divideParam.valInd);
                Y_val = Y_train(:, net.divideParam.valInd);

                net.trainParam.max_fail = 30;
                net.trainParam.goal = 1e-6;

                net.trainParam.epochs = 2000;
                net.trainParam.min_grad = 0;
                net.trainparam.showWindow = false;

                w = ones(1,length(X_train));
                w(Y_train==0)= c1_weight{1};
                [net,tr] = trainlm(net, X_train, Y_train,[],[],w);

                Y_val_pred = sim(net,X_val);

                % odredjivanje performansi mreze
                [c,cm_val,ind,per] = confusion(Y_val,Y_val_pred);
                cm_val = cm_val';
                recall = cm_val(1,1)/(cm_val(2,1)+cm_val(1,1));
                precision = cm_val(1,1)/(cm_val(1,2)+cm_val(1,1));
                f1=2*precision*recall/(precision+recall);
                acc=(cm_val(1,1)+cm_val(2,2))/sum(sum(cm_val));
                %----------------------------------------------
                if  f1>best_f1
                    best_acc=acc;
                    best_f1=f1;
                    best_structure=structure{1};
                    best_trainFcn=trainFcn{1};
                    best_reg=reg{1};
                    best_epoch=tr.best_epoch;
                    best_c1_weight = c1_weight;

            end
            end
        end
    end
end

disp(' ')
disp('Rezultat krosvalidacije: ')

X1=['Najbolja struktura:  ',num2str(best_structure)];
disp(X1)

X2=['Najbolja aktivaciona funkcija:  ', best_trainFcn];
disp(X2)

X3=['Najbolji koeficijent regularizacije:  ', num2str(best_reg)];
disp(X3)

X4=['Najbolja duzina treniranja sa ovim parametrima:',  num2str(best_epoch)];
disp(X4)

%X5=['Najbolja tezina klase 1:', num2str(best_c1_weight)];
%disp(X5)

X6=['Najbolji accuracy:  ',num2str(best_acc)];
disp(X6)

X7=['Najbolji f1:  ', num2str(best_f1)];
disp(X7)
disp(' ')
%% Treniranje NM sa najboljim hiperparametrima na celom trening+val
% S obzirom da smo validacione podatke iskoristili da pronadjemo
% hiperparametre, sada mozemo istrenirati finalnu verziju neuralne mreze na
% trenirajucim + validacionim podacima, koristeci najbolje hiperparametre.
% Ovo je opravdano jer validacione podatke necemo vise koristiti za
% evaluiranje. Ovo je dobra praksa, jer moc zakljucivanja neuralnih mreza
% raste kako nam se povecava kolicina podataka za treniranje.
%
% Iskoristiti kod za treniranje NM iz prethodne tacke.
% Sada je zgodno podesiti --> net.trainparam.showWindow = true;
%%%%%%%%%%%%%%%%%%%%%%%
net = patternnet(best_structure);
            
            net.layers{1}.transferFcn = best_trainFcn;
            net.layers{2}.transferFcn = best_trainFcn;
            net.performParam.regularization = best_reg;
            
            net.divideFcn = 'divideind';
            net.divideParam.trainInd = [1:length(X_train)];
            net.divideParam.valInd = [];
            net.divideParam.testInd = [];
            
            % Dobavljanje validacionih podataka
            X_val = X_train(:, net.divideParam.valInd);
            Y_val = Y_train(:, net.divideParam.valInd);
            
            net.trainParam.max_fail = 10;
            net.trainParam.goal = 1e-6;
            
            net.trainParam.epochs = 2000;
            net.trainParam.min_grad = 0;
            net.trainparam.showWindow = false;
            
           
             w = ones(1,length(X_train));
             w(Y_train==0)= cell2mat(best_c1_weight);
             [net,tr] = trainlm(net, X_train, Y_train,[],[],w);
%% Testiranje NM
% Potrebno je tesitrati finalnu NM nad testirajucim podacima kako bi se
% dobila realna estimacija performansi. Ovi podaci nisu korisceni
% prilikom prilagodjavanja parametara i hiperparametara mreze i posto ih
% mreza prvi put vidi verujemo da je to realna estimacija performansi.

% Potrebno je testirati mrezu na testirajucem skupu. Usput ne bi bilo lose
% da se to uradi i na trening+val skupu, kako bi mogli da im poredimo
% performanse (na primer da vidimo da li je doslo do preobucavanja).
% Zbog toga je prvo potrebno izvrsiti predikciju nad ovim skupovima podataka.
% Koristiti funkciju --> Y = sim(net, X);
%%%%%%%%%%%%%%%%%%%%%%%
Y_train_pred = sim(net,X_train);
Y_test_pred = sim(net,X_test);
%%%%%%%%%%%%%%%%%%%%%%%

% Matrica konfuzije za treninrajuci skup
figure
plotconfusion(Y_train, Y_train_pred,'Train set');
% Matrica konfuzije za testirajuci skup
figure
plotconfusion(Y_test, Y_test_pred,'Test set');

% preciznost (precision) i osetljivost (recall) za klasu od interesa na 
%skupu za treniranje i testiranje.

%%%%%%%%%%%%%%%%%%%%%%%
[c,cm_test,ind,per] = confusion(Y_test,Y_test_pred);
cm_test = cm_test';
recall = cm_test(1,1)/(cm_test(2,1)+cm_test(1,1));
precision = cm_test(1,1)/(cm_test(1,2)+cm_test(1,1));
f1=2*precision*recall/(precision+recall);

disp(' ')
disp('Testirajuci skup: ')
X91=['Preciznost za klasu 1:  ', num2str(precision)];
disp(X91)
X92=['Osetljivost za klasu 1:  ', num2str(recall)];
disp(X92)
disp(' ')
%%%%%%%%%%%%%%%%%%%%%%%

[c,cm_pred,ind,per] = confusion(Y_train,Y_train_pred);
cm_pred = cm_pred';
recall = cm_pred(1,1)/(cm_pred(2,1)+cm_pred(1,1));
precision = cm_pred(1,1)/(cm_pred(1,2)+cm_pred(1,1));
f1pred=2*precision*recall/(precision+recall);

disp(' ')
disp('Trenirajuci skup: ')
X911=['Preciznost za klasu 1:  ', num2str(precision)];
disp(X911)
X922=['Osetljivost za klasu 1:  ', num2str(recall)];
disp(X922)

%% Crtanje granice odlucivanja
% Kreiramo mrežu podataka za iscrtavanje
xTest = [];
opseg_y = -7:0.1:7;
opseg_x = -9:0.1:9;
for i = opseg_x
    xTest = [xTest [i*ones(size(opseg_y)); opseg_y]];
end

% Predikcija za mrezu odbiraka
plot_output = sim(net, xTest);

% Crtanje granice odlucivanja
figure()
hold all
for i = 1 : length(xTest)
    % Ispitujemo kojoj klasi rezultat pripada. Nas sigmoid ce izbaciti
    % broj [0,1] sto znaci da je on sigurniji da je klasa 1 kako je izlaz
    % blizi jedinici, i da je klasa 0 kako je izlaz blizi nuli. Mozemo
    % napraviti neki region nesigurnosti, tako sto cemo za podatak ciji je
    % izlaz niti blizu nuli, niti blizu jedinici, reci da tu NM ne moze da
    % donese odluku. Postavljamo zonu nesigurnosti na 30%
    if plot_output(i) < 0.3
        plot(xTest(1, i), xTest(2, i), 'b.')
    elseif plot_output(i) > 0.7
        plot(xTest(1, i), xTest(2, i), 'r.')
    else
        plot(xTest(1, i), xTest(2, i), 'w.')
    end
end

% Crtanje orginalnih odbiraka klasa - trening skup i test skup
plot(X_0_train(1, :), X_0_train(2, :), 'o', 'linewidth', 2)
plot(X_0_test(1, :), X_0_test(2, :), 'o', 'linewidth', 2)
plot(X_1_train(1, :), X_1_train(2, :), '*', 'linewidth', 2)
plot(X_1_test(1, :), X_1_test(2, :), '*', 'linewidth', 2)
axis equal 
hold off
title ('Granica odlucivanja')