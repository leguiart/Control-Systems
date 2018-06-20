%%                     MOTOR Corriente Directa
%                      Control PI de velocidad
%                       FT salida velocidad
clc;
%% Parámetros motor venetta
Ra=5.5; %resistencia
Jm=5.18e-6; % inercia
ki=0.046; % constantes
kb=0.0191;
global Td;
Td = 0.0001;
FLAG = false;

%% Parámetros FT de primer orden
tau=(Ra*Jm)/(kb*ki);
K=1/kb; %% esta es Kcd
global G1a G1r;
num1=K;
den1=[tau 1];
G1a=tf(num1, den1)

%% Retardo (Aproximación de Padé) a un término de la serie de Taylor
Td = 0.0001;
[numrp, denrp] = pade(Td, 1);
Grp = tf(numrp, denrp);
G1r = G1a*Grp;

%% Respuesta escalón en lazo abierto con retardo
figure(1)
hold on;
step(G1r);
hold off;
grid


%% Traza de Bode del sistema
% con retardo
figure(2)
bode(G1r)
grid
% sin retardo
figure(3)
bode(G1a)
grid

%% Traza de Nyquist del sistema
% con retardo
figure(4)
nyquist(G1r)
grid

% sin retardo
figure(5)
nyquist(G1a)
grid

%% FT del controlador PI
% Kp(1 + 1/sTi) = Kp(sTi + 1)/sTi
%% Método Haalman
% Kph(1 + 1/sTi); Kph = (2*T)/(3*K*L), Ti = T
global T;
L = 0.00327;
T = 0.0712 - L;
Kph = (2*T)/(3*K*L);
Gch = tf([Kph*T Kph],[T 0]);

%% Método lambda
% Kpl( 1 + 1/sTi); Kpl = (1/K)*T/(L + lambda), Ti = T
global Gclambda;
lambda = 0.00652;
Kpl = (1/K)*T/(L + lambda);
Gclambda = tf([Kpl*T Kpl],[T 0]);

%% Respuesta escalon lazo cerrado
Lc1 = feedback(G1r*Gch, 1); %haalman
Lc2 = feedback(G1r*Gclambda, 1); %lambda

figure(6)
hold on;
opt = stepDataOptions('StepAmplitude', 1000);
step(Lc1, opt)
step(Lc2, opt)
legend('lambda', 'halman');
hold off;
grid

%% Traza de bode para función de lazo
% haalman
figure(7)
bode(G1r*Gch);
grid

% lambda
figure(8)
bode(G1r*Gclambda);
grid

