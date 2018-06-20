                %%% Sistemas de control Grupo 5. %%%%%%
%%%%                 Control PI  de posición                    %%%%%%%%%
%%%                del motor de corriente directa                %%%%%%%%%
%%%         ejemplo del primer método de Ziegler y Nichols
%%%% Prof. Alejandra de la Guerra                                %%%%%%%%%
%% Parámetros del motor Veneta
global K tau Td % para poder usarlos en SIMULINK 
La=2.8e-9; %inductancia
Ra=5.5; %resistencia
Jm=5.18e-6; % inercia
ki=0.046; % constantes
kb=0.0191;
%% Parametros de la FT de primer orden La<< (salida posición)
tau=(Ra*Jm)/(kb*ki);
K=1/kb;

num2=K*tau;
den2=[tau 1 0];
G1=tf(num2, den2);
%% Retardo (aproximacion de Pade)
Td=0.0001;%tiempo de retardo
N =1;% grado de la aproximacion
[numrp,denrp]=pade(Td,N);
Grp = tf(numrp,denrp); % FT con pade()
%%% FT usando la aproximación dada en clase
numr=[-Td/2 1];
denr=[Td/2 1];
Gr=tf(numr,denr);
%%% comparación entre el retardo puro y su aproximación usando pade()
figure(1)
pade(Td,N)
%%% FT de lazo
Gl=G1*Gr;
%%%% lazo cerrado
%M = feedback(M1,M2) calcula la FT M para el lazo cerrado: 
 
 %          u --->O---->[ M1 ]----+---> y
  %               |               |           y = M * u
   %              +-----[ M2 ]<---+
M=feedback(G1,1);
figure(2)% Respuesta escalón unitario Lazo cerrado
step(M)% 
figure(3)% Respuesta escalón unitario Lazo abierto
bode(Gl)

figure(7)
nyquist(G1)
%%%%
%% 
%% FT del controlador PI
%%% Kp(1+ 1/Tis)= Kp(Tis + 1)/Tis
%%%% Primer método de Ziegler y Nichols
L=0.0853;% parámetros de la respuesta escalón(tiempo de levantamiento 10% tiempo de lavantamiento  90%-L)
          % ver fig1-fig3
T=1.22-L;
Kp=0.9*(T/L);
Ti=L/(0.3);
numC = Kp*[Ti 1];
denC = [Ti  0];
GC=tf(numC,denC);
%% Respuesta escalon lazo cerrado
%M = feedback(M1,M2) calcula la FT M para el lazo cerrado: 
 
 %          u --->O---->[ M1 ]----+---> y
  %               |               |           y = M * u
   %              +-----[ M2 ]<---+
figure(4)
 bode(GC*Gl)
 grid on
 figure(5)
Lc=feedback(GC*Gl,1);% M1=GC*GL, M2=1
step(Lc)% Respuesta escalon unitario de lazo cerrado
%%% COMPARE LOS TIEMPOS DE ASENTAMIENTO Y LEVANTAMIENTO DE LA RESPUESTA
%%% ESCALON EN LAZO CERRADO DE LAS FIGURAS 2 Y 6.
figure(6)
nyquist(GC*G1)
grid on
