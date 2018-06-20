%%                     MOTOR Corriente Directa
%%                       FT salida velocidad
%%          Se usan los parámetros de los motores Veneta 
%%  que se encuentran en el laboratorio de Sistemas de Control

La=2.8e-3; %inductancia
Ra=1.5; %resistencia
Jm=5.18e-6; % inercia
ki=0.046; % constantes
kb=0.0191;
FLAG1 = false;
FLAG2 = false;

%% Parámetros de la FT de segundo orden (salida velocidad)
num1a=ki;
den1a=[Jm*La Ra*Jm kb*ki];
G1a=tf(num1a, den1a)

%% Respuesta escalón FT G1a (salida velocidad)
if(FLAG2)
    figure()
    step(G1a)
    grid on

    %% Bode G1a
    figure()
    bode(G1a)
    grid
end
%% Control Proporcional de velocidad %%%%%%%%%%%%%%%%%%%%%
% Ganancia proporcional
Kp=0.5; % si se modifica esta ganancia cambiará la respuesta escalón y el bode
% FT de lazo
Gl=Kp*G1a;

if(FLAG2)
    %% Respuesta escalón FT de lazo
    figure()
    step(Gl)
    grid on


    %% Bode FT de lazo
    figure()
    bode(Gl)
    grid
end

%M = feedback(M1 ,M2) calcula la FT M
Glc = feedback(Gl, 1);

figure()
step(Glc)
grid

figure()
bode(Glc)
grid


%% Control PI
Gpi = feedback(Kp*(1+tf(1,[0 1]))*G1a,1);
figure()
step(Gpi)
grid

figure()
bode(Gpi)
grid



