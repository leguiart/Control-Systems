%%% Sistemas utilizados para el segundo examen parcial
%%% Sistemas de control
%% ejemplo (ejercicio 3)
n1=[1 8]; %numerador
d1=[1 4.2 7.8 16.6 12 0];%denominador
G1=tf(n1,d1) %FT
[gm1,pm1,wg1,wp1]=margin(G1) % con este comando se pueden conocer los márgenes de fase y ganancia 
                             % gm-gain margin -margen de ganancia, pm-phase margin-margen de fase,
                             % wg-frecuencia de cruce ganancia,
                             % wp-frecuencia de cruce de fase

figure(1)   %traza de bode
bode(G1)
figure(2)
nyquist(G1);axis([-2.5,0,-5.5,5.5]); %traza de nyquist, se definen los valores de los ejes


M1=feedback(G1,1); %respuesta escalón lazo cerrado
figure(3)
step(M1)
%% ejemplo (ejercicios 2 y 4)
n=1;         %numerador
d=[1 0.8 1]; %denominador
G2=tf(n,d)  %FT
[gm2,pm2,wg2,wp2]=margin(G2) % con este comando se pueden conocer los márgenes de fase y ganancia
figure(7)
bode(G2)         %traza de Bode

figure(8)
nyquist(G2); % traza de Nyquist  

M2=feedback(G2,1);   % respuesta escalón lazo cerrado
figure(9)
step(M2)