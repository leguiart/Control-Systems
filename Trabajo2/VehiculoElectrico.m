%%%%%%%% Parametros VE Sistemas de Control %%%%%%%%%%%%
%%%%%%%%%%% Parametros del motor ME1115 %%%%%%%%%%%%%%%
%%% Voltaje maximo 72 [V]
%%% Velocidad nominal 3000 [RPM] = 314.159265 [rad/s]
NMx=5000; %[RPM] % Velocidad maxima
global La Ra Kbm
%%% Subsistema electrico
Ra = 0.013; %[Ohms]

La = 0.1e-3;%[H]
Kb = 50; %[RPM/V]
Kbm =1/((pi/30)*Kb); % [V/rads]
global J b Ktm
%%% Subsistema mecanico
J1 = 45*0.0001;% [kgm2] %%inercia del motor
b = 0.01;%[kgm/s2]
Kt = 1.6; %[lb-in/A]
% inlb = (0.11298482933333) Nm
Ktm = (0.1130)*Kt; % Nm/A
global Kpwm Ts
%%% Inversor
Kpwm = 5;
Ts = 6.6666e-5; % constante de tiempo de la etapa de potencia
global n r1
%% Parametros del VE
% mlb=1235 [lb]

m = 560.1866; % [kg] % masa del vehculo
%%% Velocidad maxima en m/s
VM=44;
n=3; %relacion de transmision de potencia
%% Radio de la llanta= 20.3in modelo TIIS170D14 88MSL
Rin=20.3/2;
r1 = Rin*0.0254; %[m]
%%% inercia total
% mtlb=7 [lb]
mt = 3.17515; %Kg masa de la llanta
Jw = 0.5*2*mt*r1^2;
lam=0.8; %coeficiente de friccion/pavimento
Jv=0.5*m*(r1^2/n^2)*(1-lam);
J = Jv+Jw+J1
%%%% Referencia %%%%%%%%%%%%%%%%%%%%%%
global wr
Wr =455; %RPM % valor de la referencia
wr =((2*pi)/60)*Wr; %conversion a rad/s

%% Respuesta escalón del sistema
Gc = tf(Kpwm, [Ts, 1])
Ge = tf(1 , [La, Ra])
Gm = tf(1, [J, 1])
opt = stepDataOptions('StepAmplitude', Wr);
figure(1)
hold on
plot(simout)
plot(simout1)
plot(simout2)
grid on
hold off
title('Respuesta escalón lazo cerrado desde simulink con referencia = 70[V]');
legend('Tau', 'i','wr');

figure(2)
%subplot(3,1,1);
step(Gc*Ge);
grid on
title('Respuesta escalón lazo abierto del sistema eléctrico (i)');
%subplot(3,1,2);
figure(3)
step(Gc*Ge*Ktm);
grid on
title('Respuesta escalón lazo abierto del sistema eléctrico (tau)');
%subplot(3,1,3);
figure(4)
hold on
step(Gm,opt);
plot([J J], [J wr*0.632], 'r');
hold off;
grid on
title('Respuesta escalón lazo abierto del mecánico');


%% Caracterización del sistema
%Inversor
ei = feedback(Gc*Ge,1);
wsal = Gc + feedback(Ge*Ktm + feedback(Gm*1/n, 0.01), Kbm)
zero(wsal)
pole(wsal)
pole(ei)
pole(Gc)
pole(Ge)
pole(Gc*Ge)
pole(Gm)

figure(5)
opt1 = stepDataOptions('StepAmplitude', 10);
step(ei, opt1)
grid on
title('Respuesta escalón lazo cerrado (ei) con eb = 0');

figure(6)
bode(Gc*Ge);
grid on;
title('Bode del eléctrico');

figure(7)
bode(Gm);
grid on;
title('Bode del mecánico');

figure(8)
nyquist(Gc*Ge);
grid on;
title('Nyquist del eléctrico');

figure(9)
nyquist(Gm);
grid on;
title('Nyquist del mecánico');

figure(10)
rlocus(ei);
grid on;
title('LGR de ei');

figure(11)
rlocus(Ge*Gc);
grid on;
title('LGR del electrico');

figure(12)
rlocus(Gm);
grid on;
title('LGR del mecánico');

figure(13)
rlocus(wsal)
grid on;

figure(14)
hold on;
pzmap(Gc*Ge);
pzmap(Gm);
grid on;
hold off;
title('Raices del eléctrico y el mecánico');

figure(15)
pzmap(ei);
grid on;
title('Raices de ei');

%% FT del PI
global Ti;
global Kp;
global PI;
Kp = 20.5;
Ti = 5.3;
PI = tf([Kp Kp*Ti],[1 0]);

%% Compensador del sistema mecánico
phi_d = -135
alfa = (1 + sin(phi_d))/(1 - sin(phi_d))
Kaux= 10*log10(alfa)
wd = (0.621 + 0.727)/2.0
T = 1/(sqrt(alfa)*wd)
Gc1 = alfa*tf([1, 1/(alfa*T)],[1, 1/T])
figure(16)
bode(Gc1*Gm);
grid on;

figure(17)
plot(simout4)
grid on
title('Respuesta escalón lazo cerrado del sistema controlado con referencia = 455[RPM]');

figure(18)
nyquist(Gc1*Gm)
grid on;









