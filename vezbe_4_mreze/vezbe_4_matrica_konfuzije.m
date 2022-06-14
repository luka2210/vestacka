clc, clear, close all

%% Generisanje odbiraka - linearno separabilne klase
% Generisanje slucajnih odbiraka sa Gausovom raspodelom
x1 = randn(1, 100) + 3;
y1 = randn(1, 100) + 3;

x2 = randn(1, 100) + 6;
y2 = randn(1, 100) + 5;

plot (x1,y1,'ro',x2,y2,'b*')

%% Generisanje odbiraka - nelinarno separabilne klase
% Klasa 1 je definisana kao krug sa centrom u (4.5, 4.5), sa poluprecnikom
% koji je definisan kao slucajan broj sa Gausovom raspodelom sa standardnom 
% dev = 2 i srednjom vrednsoti = 0
% r1 = 2*rand(1, 100);
% phi1 = 2*pi*rand(1, 100);
% x1 = r1.*cos(phi1) + 4.5;
% y1 = r1.*sin(phi1) + 4.5;
% 
% %Klasa 2 je definisana kao djevrek sa centrom u (4.5, 4.5)
% r2 = rand(1, 100) + 2.5;
% phi2 = 2*pi*rand(1, 100);
% x2 = r2.*cos(phi2) + 4.5;
% y2 = r2.*sin(phi2) + 4.5;
% 
% plot (x1,y1,'ro',x2,y2,'b*')

%% Realni podaci
%Ucitavanje realnih podataka
% load('cinija.mat');
% load('kanta.mat');
% 
% x1 = k2(1, :); 
% y1 = k2(2, :);
% 
% x2 = k3(1, :); 
% y2 = k3(2, :);
% 
% plot (x1,y1,'ro',x2,y2,'b*')
%% Crtanje klasa  - drugi nacin pomocu scatter plot
% % scatter plot je pogodan za vizualizaciju varijabli unutar nekog data set-a
figure
hold all
scatter(x1, y1, 'ro')
scatter(x2, y2, 'b*')
xlabel('x')
ylabel('y')
title('Odbirci dve (ne)linearno separabilne klase')
axis equal
grid on

%% Klasifikacija dve linearno separabilne klase
% Formiranje ulaza i izlaza perceptrona. Ulazi se forimiraju kao matrica sa
% dva reda (oznacava broj ulaza) i 200 kolona (oznacava velicinu data
% set-a). Izlaz se formira kao niz nula i jedinica, gde 0 predstavlja prvu
% klasu, a 1 drugu
ulaz = [x1, x2; y1, y2];
izlaz = [zeros(1, length(x1)) ones(1, length(x2))];     

%% Kreiranje, obucavanje i validacija perceptrona
 per = newp(ulaz, izlaz);
 per = train(per, ulaz, izlaz); %trening
 izlazP = sim(per, ulaz); %test
 
 %% Kreiramo mrežu podataka za test perceptron
 xTest = [];
 opseg = 0:0.2:9;
 for i = opseg
     xTest = [xTest [i*ones(size(opseg)); opseg]];
 end
 
 % Validacija za mrezu odbiraka
 yTest = sim(per, xTest);
 
 %% Crtanje granice odlucivanja
 figure
 hold all
 for i = 1 : length(xTest)
    % Ispitivanje da li je rezultat jednak 0 ili 1, odnostno da li pripada
    % prvoj ili drugoj klasi, i u zavisnosti od rezultata njega na grafiku
    % prikazujemo odgovarajucom bojom (plava K1, crvena K2)
    if yTest(i) == 0
        plot(xTest(1, i), xTest(2, i), 'b.')
    elseif yTest(i) == 1
         plot(xTest(1, i), xTest(2, i), 'r.')
    end
end

% Crtanje orginalnih odbiraka klasa
plot(x1, y1, 'o', x2, y2, '*', 'linewidth', 2)
axis equal 
hold off

%% Matrica konfuzija
% Matrica konfuzije daje informaciju o tacnosti celokupne klasifikacije,
% kao i o preciznosti i osetljivosti prilikom predikcije jedne klase
figure
plotconfusion(izlaz, izlazP)

[C,CM,~,~] = confusion(izlaz,izlazP);
%% Racunanje i prikaz tacnosti
% Tacnost se odnosi na ukupnu tacnost klasifikacije
tacnost = (1 - C)*100;
CM=CM'; % da bi bilo kao na slici

%% Racunanje i prikaz preciznosti
% Preciznost predstavlja odnos svih odbiraka koji su tacno klasifikovani
% kao PRVA klasa, i svih odbiraka koji su smesteni u tu klasu
% PPV=TP/(TP+FP)
preciznost = 100*CM(2,2)/(CM(2,1) + CM(2,2));

%% Racunanje i prikaz osetljivosti
% Osetljivost predstavlja odnos svih odbiraka koji su tacno klasifikovani
% kao prva klasa, i svih odbiraka koji stvarno pripadaju prvoj klasi
%TPR=TP/(TP+FN)
recall = 100*CM(2,2)/(CM(1,2) + CM(2,2));