%%                     MOTOR Corriente Directa
%%                       FT salida velocidad
%%          Se usan los parámetros de los motores Veneta 
%%  que se encuentran en el laboratorio de Sistemas de Control

Ra=1.5; %resistencia
Jm=5.18e-6; % inercia
ki=0.046; % constantes
kb=0.0191;

tau=(Ra*Jm)/(kb*ki);
K=1/kb; %% esta es Kcd

num1=K;
den1=[tau 1];
G1a=tf(num1, den1) % FT de primer orden
FLAG = true;

%% Control Proporcional de velocidad %%
% Ganancia proporcional
Kp=2000; % si se modifica esta ganancia cambiará la respuesta escalón y el bode
% FT de lazo
Gl=Kp*G1a;

figure()
nyquist(Gl)
grid

figure()
bode(Gl)
grid

%% Bode FT de lazo
%M = feedback(M1 ,M2) calcula la FT M
Glc = feedback(Gl, 1);

if(FLAG)
    figure()
    step(Glc)
    grid
    figure()
    nyquist(Glc)
    grid
end

%% Control PID
Gpi = feedback(Kp*(1+tf(1,[0.000008 0]+tf([0.004 0],[0.0008 1])))*G1a,1);
if(FLAG)
    figure()
    step(Gpi)
    grid
    figure()
    nyquist(Gpi)
    grid
end