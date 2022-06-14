close all, clear all, clc

% definisanje ulaza
% broj uzoraka u svakom klasteru
K = 100;

% definisanje klastera - ulazi
q = 0.6; % ofset - rastojanje
A = [rand(1,K)-q; rand(1,K)+q];
B = [rand(1,K)+q; rand(1,K)+q];
C = [rand(1,K)+q; rand(1,K)-q];
D = [rand(1,K)-q; rand(1,K)-q];

% graficki prikaz
figure(1)
plot(A(1,:),A(2,:),'k+')
hold on
grid on
plot(B(1,:),B(2,:),'b*')
plot(C(1,:),C(2,:),'rx')
plot(D(1,:),D(2,:),'gd')

% nazivi klastera
text(0.5-q,0.5+2*q,'Class A')
text(0.5+q,0.5+2*q,'Class B')
text(0.5+q,0.5-2*q,'Class C')
text(0.5-q,0.5-2*q,'Class D')

%% definisanje izlaza - kodiranje (+1/-1) 4 klastera
a = [-1 -1 -1 +1]';
b = [-1 -1 +1 -1]';
d = [-1 +1 -1 -1]';
c = [+1 -1 -1 -1]';

%% definisanje ulaza (spajanje uzoraka iz cetiri klase)
P = [A B C D];
% definisanje zeljenih izlaza
T = [repmat(a,1,length(A)) repmat(b,1,length(B)) ...
     repmat(c,1,length(C)) repmat(d,1,length(D)) ];
 
 % kreiranje neuronske mreze
net = feedforwardnet([4 3]);

% podesavanje parametara za treniranje
% net.divideFcn = 'divideblock';
net.divideParam.trainRatio = 1; % training set [%]
net.divideParam.valRatio   = 0; % validation set [%]
net.divideParam.testRatio  = 0; % test set [%]
net.layers{3}.transferFcn = 'tansig';

% treniranje neuronske mreze
[net,tr,Y,E] = train(net,P,T);

% prikaz mreze
view(net)

%% Analiza performansi mreze i prikaz rezultata
% analiza performansi mreze
[m,i] = max(T); % klasa zeljenih izlaza
[m,j] = max(Y); % klasa dobijenih izlaza
N = length(Y);  % broj uzoraka
k = 0;          % broj pogresno klasifikovanih uzoraka
if find(i-j),   % ako postoje pogresno klasifikovani uzorci
  k = length(find(i-j)); % naci broj pogresno klasifikovanih uzoraka
end
fprintf('Tacno klasifikovani uzorci: %.1f%% samples\n', 100*(N-k)/N)

% prikaz rezultata
figure;
subplot(211)
plot(T')
title('Zeljeni izlazi')
ylim([-2 2])
grid on
subplot(212)
plot(Y')
title('Odgovor mreze')
xlabel('broj uzoraka')
ylim([-2 2])
grid on

% drugi nacin
% figure(2)
% plot(T','linewidth',2)
% hold on
% plot(Y','r--')
% grid on
% legend('Zeljeni izlazi','Odgovor mreze','location','best')
% ylim([-2 2])

plotconfusion(T,Y)

%% kreirati mrezu podataka
span = -1:.01:2;
[P1,P2] = meshgrid(span,span);
pp = [P1(:) P2(:)]';

% simulirati neuronsku mrezu na kreiranim podacima
aa = net(pp);

% prikazati rezultate klasifikacije zasnovane na MAX aktivaciji
figure(1)
m = mesh(P1,P2,reshape(aa(1,:),length(span),length(span))-5);
set(m,'facecolor',[1 0.2 .7],'linestyle','none');
hold on
m = mesh(P1,P2,reshape(aa(2,:),length(span),length(span))-5);
set(m,'facecolor',[1 1.0 0.5],'linestyle','none');
m = mesh(P1,P2,reshape(aa(3,:),length(span),length(span))-5);
set(m,'facecolor',[.4 1.0 0.9],'linestyle','none');
m = mesh(P1,P2,reshape(aa(4,:),length(span),length(span))-5);
set(m,'facecolor',[.3 .4 0.5],'linestyle','none');
view(2)

% Na primer, klasifikovati ulazni podatak [0.7; 1.2]
p = [0.7; 1.2];
y = net(p);
% uporediti rezultat sa kodiranjem izlaza u 4 klastera (-1,+1)(a,b,c,d)

% plotperform(tr)
% plottrainstate(tr)
% ploterrhist(E)
% plotregression(T,Y)
