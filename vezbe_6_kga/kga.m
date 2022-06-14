clc
clear all
close all

%% funkcija

 x = 0:0.001:1;
 f = (sin(10*x).^2)./(1+x);
 
 figure(1)
 plot(x,f,'b')
 %% program
 a=0;
 b=1;
 N=30;
 L=20;
 pu=0.95;
 pm=0.05;
 
 [pop] = inicijalizacija(N,L,a,b);                      %inicijalizacija
 
 figure(2)
 plot(x,f);
 hold on
 plot(pop(:,L+1),pop(:,L+2),'r*');
 hold off
 
 % kriterijumi zaustavljanja stavljeni na 24 i 30
 indeks=1;                   % broj koraka kao kriterijum zaustavljanja
 oldpop=pop;
 totalF=sum(oldpop(:,L+2));  %suma svih fitnes funkcija kao kriterijum zaustavljanja
 
 while totalF<24 && indeks<30
     [newpop]=rulet(oldpop,N,L);                        %selekcija
     % cetvrtina populacije se podvrgava mutaciji
     m=round(N/4);                                      % mutacija
     % polovina populacije se podvrgava rekombinaciji(ukrstanju)
     u=round(N/2);
     if mod(u,2)==1
        u=u+1;
        m=m-1;
     end
     %ostatak se podvrgava rekombinaciji(ukrstanju) i mutaciji
     mu=N-(m+u);
     if mod(mu,2)==1
         mu=mu+1;
         m=m-1;
     end
     xx=0;
     
     % samo ukrstanje
     for i=1:u/2
         xx=xx+1;
         pop=newpop;
         X=round(rand(1,2)*(N-1)+1); % dva broja izmedju 1 i N
         x1=X(1); % indeks rodjitelja 1
         x2=X(2); % indeks roditelja 2
         [potomak1,potomak2]=ukrstanje(pop(x1,:),pop(x2,:),pu,L,a,b);
         oldpop(xx,:)=potomak1;
         xx=xx+1;
         oldpop(xx,:)=potomak2;
     end
     
     % samo mutacija
     for i=1:m
         xx=xx+1;
         pop=newpop;
         xa=round(rand*(N-1)+1);  % indeks jedinke na kojoj ce se vrsiti mutacija
         [potomak]=mutacija(pop(xa,:),pm,L,a,b);
         oldpop(xx,:)=potomak;
     end
     
     % ukrstanje i mutacija na tim
     for i=1:mu/2
         xx=xx+1;
         pop=newpop;
         X=round(rand(1,2)*(N-1)+1);
         x1=X(1);
         x2=X(2);
         [potomak1,potomak2]=ukrstanje(pop(x1,:),pop(x2,:),pu,L,a,b);
         [mupotomak1]=mutacija(potomak1,pm,L,a,b);   
         [mupotomak2]=mutacija(potomak2,pm,L,a,b); 
         oldpop(xx,:)=mupotomak1;
         xx=xx+1;
         oldpop(xx,:)=mupotomak2;
     end
     
     indeks=indeks+1;
     figure(indeks);
     plot(x,f)
     hold on
     plot(pop(:,L+1),pop(:,L+2),'r*');
     hold off
     totalF=sum(oldpop(:,L+2));
 end
     
 %% funkcija inicijalizacija
 function [pop]=inicijalizacija(N,L,a,b)
 % pop - populacija
 % N - velicina populacije
 % L = duzina niza (hromozoma)
 % a i b odredjuju interval od interesa
 
 % kreiramo N x (L+2) matricu pop koju ispunjavamo sa 0 i 1
 pop = round(rand(N,L+2));
 
 % u L+1 kolonu smestamo prave vrednosti x-a
 pop(:,L+1)=(((2.^(size(pop(:,1:L),2)-1:-1:0))*pop(:,1:L)')')*(b-a)/(2.^L-1)+a;

 % u L+2 kolonu smestamo vrednosti funkcije od interesa
 pop(:,L+2) = ((sin(10.*pop(:,L+1))).^2)./(1+pop(:,L+1));
 
 end
 
 %% funkcija ukrstanja
 function [potomak1,potomak2]=ukrstanje(roditelj1,roditelj2,pu,L,a,b)
 % L - duzina niza (hromozoma)
 % pu - verovatnoca ukrstanja
 % a i b odredjuju interval od interesa
 
 if (rand < pu)
     %tu - tacka ukrstanja
     % dobijamo broj od 1 do L-1
    tu = round(rand*(L-2))+1;  % radimo ukrstanje u jednoj tacki
    potomak1=[roditelj1(:,1:tu) roditelj2(:,tu+1:L)];
    potomak2=[roditelj2(:,1:tu) roditelj1(:,tu+1:L)];
    
    potomak1(:,L+1)=(((2.^(size(potomak1(:,1:L),2)-1:-1:0))*potomak1(:,1:L)')')*(b-a)/(2.^L-1)+a;
    potomak2(:,L+1)=(((2.^(size(potomak2(:,1:L),2)-1:-1:0))*potomak2(:,1:L)')')*(b-a)/(2.^L-1)+a;
    
    potomak1(:,L+2)=((sin(10.*potomak1(:,L+1))).^2)./(1+potomak1(:,L+1));
    potomak2(:,L+2)=((sin(10.*potomak2(:,L+1))).^2)./(1+potomak2(:,L+1));
 else
     potomak1=roditelj1;
     potomak2=roditelj2;
 end
 end
 
 %% funkcija mutacija
 function [potomak]=mutacija(roditelj,pm,L,a,b)
 % L- duzina niza (hromozoma)
 % pm - verovatnoca mutacije
 % a i b odredjuju interval od interesa
     if (rand<pm)
         %tm - tacka mutacije
         % dobijamo broj od 1 do L
         tm = round(rand*(L-1))+1;
         potomak=roditelj;
         %vrsimo mutaciju, tj. na lokaciji tm 1 zamenjujemo sa 0 i obratno
         potomak(tm)=abs(roditelj(tm)-1);
         potomak(:,L+1)=(((2.^(size(potomak(:,1:L),2)-1:-1:0))*potomak(:,1:L)')')*(b-a)/(2.^L-1)+a;
         potomak(:,L+2)=((sin(10.*potomak(:,L+1))).^2)./(1+potomak(:,L+1));
     else
         potomak=roditelj;
     end
 end
 
 %% funkcija selekcija
 function [newpop]=rulet(oldpop, N,L)
 % N - velicina populacije
 % L - duzina niza(hromozoma)
 ukupnoF=sum(oldpop(:,L+2));
 prob=oldpop(:,L+2)/ukupnoF;
 prob=cumsum(prob);
 % rns je matrica dimenzija Nx1 u koju smestamo
 % slucajne vrednosti od 0 do 1 ali po rastucem 
 % redosledu iduci od prve vrste pa nadalje
 
 rns=sort(rand(N,1));
 fitin=1;
 newin=1;
 while newin<=N
     if (rns(newin)<prob(fitin))
         newpop(newin,:)=oldpop(fitin,:);
         newin=newin+1;
     else
         fitin=fitin+1;
     end
 end
 end