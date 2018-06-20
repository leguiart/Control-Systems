%%                     MOTOR Corriente Directa
%% Se obtienen las tres funciones de transferencia obtenidas en clase del
%% motor de corriente directa. Se usan los parámetros de los motores Veneta 
%%  que se encuantran en el laboratorio de Sistemas de Control
%%% Paŕámetros del motor Veneta
La=2.8e-9; %inductancia
Ra=5.5; %resistencia
Jm=5.18e-6; % inercia
ki=0.046; % constantes
kb=0.0191;
%% Parámetros de la FT de primer orden La<< (salida velocidad)
tau=(Ra*Jm)/(kb*ki);
K=1/kb;

num1=K;
den1=[tau 1];
G1=tf(num1, den1)
%% Respuesta escalón FT G1 primer orden (salida velocidad)
% se muestra como se pueden poner dos graficas en la misma figura
figure()
subplot(211), step(G1)
grid on
subplot(212), impulse(G1)
grid on
%% Parámetros de la FT de segundo orden (salida velocidad)
num1a=ki;
den1a=[Jm*La Ra*Jm kb*ki];
G1a=tf(num1a, den1a)

%% Respuesta escalón FT Gia (salida velocidad)
figure()
step(G1a)
grid on

%% FT de tercer orden (salida posición)
num2=ki;
den2=[Jm*La Jm*Ra kb*ki 0];
G2=tf(num2, den2)
%% Respuesta escalón FT G2 (salida posición)
figure()
step(G2)
grid on
%% se grafican los diagramas de bode de cada una de las FTs
%% Bode G1
figure()
bode(G1)
%% Bode G1a
figure()
bode(G1a)
%% Bode G2
figure()
bode(G2)

