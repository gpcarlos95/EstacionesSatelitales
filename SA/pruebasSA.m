clear all; close all;

N=500; % Número de satelites
M=40; % Número de representantes
rand('seed',5);

coordinatesO = randi(N,N,2); % Coordenadas de los satélites en el espacio
T=[1000 1000000];
T_limit=[0.1 0.01];
pcool=[0.9 0.98];

% Al poner solo estos datos, da diferente que cuando se hace en el bucle
% T=1000000; T_limit=0.0100; pcool=0.9800;
t
CBest=inf; Best=[];
itera=1;
for temp=T
   for templ=T_limit
       for enf=pcool
           coordinates=coordinatesO;
           tic
           [X,C] = simulatedAnnealing(N,M,coordinates,temp,templ,enf);
           time=toc;
           if C<CBest
               CBest=C
               Best=X;
           end
           results{itera,1}=temp; results{itera,2}=templ;
           results{itera,3}=enf; results{itera,4}=C;
           results{itera,5}=time;
           itera=itera+1;
       end
   end
end

figure;
plot(coordinates(:,1),coordinates(:,2),'.'); hold on;
plot(coordinates(Best,1),coordinates(Best,2),'*'); hold on;
legend('Satélites', 'Representantes')

figure;
[~,pos_]=sort([results{:,4}],'descend');
info=[[results{pos_,1}]' [results{pos_,2}]' [results{pos_,3}]' [results{pos_,5}]' [results{pos_,4}]'/1.0e+04];
h=[];
for i=1:8
   scatter(info(i,4),info(i,5),'filled'); hold on;
   h=[h 'Temp:'+string(info(i,1))+'  Tlim:'+string(info(i,2))+'  Enf:'+string(info(i,3))]; hold on;
end
grid on
legend(h); ylabel('Valor Representantes/1.0e+04'); xlabel('Tiempo en segundos')
