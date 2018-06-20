% Clase 1, Tema 1, Sistemas de control
% Alejandra De La Guerra
% Función de transferencia G1
% parámetros
R=1000;
L=.002;
C=0.5e-5;
%x=[Vc iL]
A=[0 1/C;-1/L -R/L];
B=[0 ;1/L];
C1=[0 1]; %iL
C2=[1 0]; %Vc

% cuando la salida es iL (muestra el cambio 
% en la corriente con respecto al voltage de entrada)
num1=[1/L 0];
den1=[1 R/L 1/(L*C)];
G1=tf(num1, den1)
[num1a,den1a]=ss2tf(A,B,C1,0,1);
G1a=tf(num1a,den1a)
% cuando la salida es Vc (muestra el proceso de carga del capacitor)

num2=1/(L*C);
den2=[1 R/L 1/(L*C)];
G2=tf(num2, den2)
[num2a,den2a]=ss2tf(A,B,C2,0,1);
G2a=tf(num2a,den2a)


% Graficas
figure(1)
subplot(211);% esta figura consta de dos graficas (2), 
%             acomodadas 1|(1) esta es la primera figura
step(G1) % respuesta escalon FT G1 
hold on  % para graficar en la misma figura
step(G1a) % respuesta escalon FT G1a
legend ('G_1', 'G_{1a}')% para poner una leyenda que contenga los nombres 
%                        de las dos señales
grid on % para poner la cuadricula
subplot(212); % segunda figura 1|(2)
impulse(G1) %respuesta impulso FT G1
grid on 

figure(2)
subplot(211), step(G2)
hold on
step(G2a)
legend ('G_2', 'G_{2a}')
grid on
subplot(212), impulse(G2)
grid on
