clc, clear, close all

%% Generisanje funkcije
% Funkciju predstavlja zasumljeni sinus, i cilj predikcije pomocu neuralne
% mreze jeste fitovanje ove funkcije kroz niz tacaka
x = linspace(0,6,100);
f_sin = sin(3*x);
f = f_sin + 0.1*randn(size(x));

figure
plot(x,f, 'o')

%% Slucajna podela na trening i test skup
ind = randperm(length(x));
br = 0.9*length(ind);

ulazTrening = x(ind(1 : br));
izlazTrening = f(ind(1 : br));

ulazTest = x(ind(br + 1 : end));
izlazTest = f(ind(br + 1 : end));

%% Overfitted neural network
% % Kreiranje preobucene neuralne mreze
br_neurona = 25; % Broj neurona u skriven sloju
br_slojeva = 5; % Broj slojeva
net = feedforwardnet(br_neurona*ones(1, br_slojeva), 'trainlm');
net.divideFcn = ''; % Iskljucivanje zastite od preobucavanja

% Podesavanje parametra obucavanja - maksimalan broj epoha treninranja i
% maksimalna dozvoljena greska
net.trainParam.epochs = 1000; 
net.trainParam.goal = 1e-5;

%% Underfitted neural network
% Kreiranje neuralne mreze koja nije dovoljno obucena
% br_neurona = 1;
% br_slojeva = 2;
% net = feedforwardnet(br_neurona*ones(1, br_slojeva), 'trainlm');
% 
% % Uzazni skup za obucavanje NM se deli na random nacin na treninrajuci,
% % testirajuci i validacioni skup
% net.divideFcn = 'dividerand';
% % Definisanje koliki udeo u datom skupu podataka imaju ovi skupovi
% net.divideParam.trainRatio = 0.9;
% net.divideParam.testRatio = 0;
% net.divideParam.valRatio = 0.1;
% 
% net.trainParam.epochs=1000;
% net.trainParam.goal=1e-5;

%% Just right
% Kreiranje neuralne mreze koja je dobro generalizuje
% br_neurona = 5;
% br_slojeva = 8;
% net = feedforwardnet(br_neurona*ones(1, br_slojeva), 'trainlm');
% net.divideFcn = 'dividerand';
% net.divideParam.trainRatio = 0.9;
% net.divideParam.testRatio = 0;
% net.divideParam.valRatio = 0.1;
% 
% net.trainParam.epochs=1000;
% net.trainParam.goal=1e-5;

%% Treniranje i vizualizacija
[net, tr] = train(net, ulazTrening, izlazTrening);
% Rezultat rada neuralne mreze nad skupom za obucavanje
x_trening = ulazTrening(tr.trainInd);
f_trening = sim(net, ulazTrening(tr.trainInd));

% Rezultat rada neuralne mreze nad skupom za testiranje
f_test = sim(net, ulazTest);

figure, hold all
% plotovanje realnih podataka ulaza i izlaza
p1 = plot(x,f);

% plotovanje trening set podataka (ulaz i dobijeni izlaz i ulaz i target)
p2 = plot(x_trening, f_trening, 'ro');
plot(x_trening, izlazTrening(tr.trainInd), 'r.')

% plotovanje test set podataka (ulaz i dobijeni izlaz i ulaz i target)
p3 = plot(ulazTest, f_test, 'bo');
plot(ulazTest, izlazTest, 'b.')

legend([p1, p2, p3], {'Original','Trening','Test'})

% plotovanje za ceo set podataka x (bez noise)
fn_pred = sim(net, x);
figure, hold all
plot(x, f_sin, 'b')
plot(x, fn_pred, 'r')