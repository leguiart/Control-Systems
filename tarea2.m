clc;
%% Sistema RC
% Parámetros
R=1000; %[ohms]
C=0.1e-4; %[farads]

%%% FT 
K1 = 1/(R*C);
num1 = K1;
den1 = [1 K1];
tau1 = 1/K1;
G1 = tf(num1, den1);


%% Sistema masa amortiguador
% Parametros
M=1;%[kg]
d=0.01; %[N.S/m]
K2 = 1/M;
num2 = K2;
tau2 = 1/(d*K2);
den2 = [1 1/tau2];
G2 = tf(num2, den2);

%% Sistema Térmico
% Parametros
V = 10000; %[cm3]
w = 10; %[g/min]
rho =1; %[g/cm3]

%%% FT (por ejemplo para el sistema térmico)
K=1;
num=K; % numerador
den=[1 w/(V*rho)]; % denominador
G=tf(num,den);  % FT
tau= V*rho/w;

%% Gráficas
figure;
grid on;
subplot(4, 1, 1);
hold on;
step(G);
step(G1);
step(G2);
y1 = get(gca,'ylim');
plot([tau tau], y1, 'b');
plot([tau1 tau1], y1,'r');
plot([tau2 tau2], y1, 'y');
hold off;
grid on;
title('Respuesta escalón lazo abierto planta');
xlabel('Tiempo [s]');
ylabel('Amplitud');
legend('Térmico', 'Eléctrico','Mecánico');

subplot(4, 1, 2);
hold on;
step(G, 'r');
x1 = get(gca, 'xlim');
y1 = get(gca,'ylim');
plot(x1,[tau*K*0.632 tau*K*0.632],'r');
plot([tau tau], y1, 'r');
hold off;
grid on;
title('Sistema Térmico');
xlabel('Tiempo [s]');
ylabel('Amplitud');

subplot(4, 1, 3);
hold on;
step(G1 , 'b');
y1 = get(gca,'ylim');
x1 = get(gca, 'xlim');
plot(x1, [tau1*K1*0.632 tau1*K1*0.632] ,'b');
plot([tau1 tau1], y1, 'b');
hold off;
grid on;
title('Sistema Eléctrico');
xlabel('Tiempo [s]');
ylabel('Amplitud');

subplot(4, 1, 4);
hold on;
step(G2, 'g');
y1 = get(gca,'ylim');
plot([tau2 tau2], y1, 'g');
x1 = get(gca, 'xlim');
plot(x1, [tau2*K2*0.632 tau2*K2*0.632],'g');
hold off;
grid on;
title('Sistema Mecánico');
xlabel('Tiempo [s]');
ylabel('Amplitud');
