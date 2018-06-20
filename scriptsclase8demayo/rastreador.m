%%% Diseño de un compensador de adelanto 
%%% Sistemas de control   Grupo 5
%%% ejemplo tomado de Kuo
%% Planta: Rastreador solar
%%% FT original
K=1;  % ganancia inicial
num=2500;  % numerador
den=[1 25 0];  %denominador
G=tf(num,den)  %FT
figure     %traza de Bode
bode(G)
Gl=feedback(G,1);    %lazo cerrado K=1
figure
step(Gl)            %respuesta escal+on lazo cerrado
p=[1 25 0];
roots(p)              %polos

%% calculo del angulo de deficiencia 
phi=(25*pi)/180;   %grados a radianes
%%% calculo de a
a=(1+sin(phi))/(1-sin(phi))
%%% Ganancia de alta frecuencia
Ka=20*log10(a);
Kaux=-10*log10(a)  % ganancia en la media geométrica
%%% en el diagrama de Bode esta ganancia corresponde a 
wnd=60.2;  %frecuenia de la  ganancia en la media geométrica
T=1/(wnd*sqrt(a))
% 
%% compensador a>1
%%%    G = a (s+1/aT)
%%%          ---------
%%%          ( s+1/T)
% 
numc2=a*[1 1/(a*T)];
denc2=[1 1/T];
Gc2=tf(numc2,denc2);
%
%% sistema compensado 
Gcc2=Gc2*G
figure
bode(Gcc2)
% 
Glc=feedback(Gcc2,1);
figure
step(Glc)
%%% raíces polinomio deseado 
p1=[1 119.5 2362];
s=roots(p1)
%wn=sqrt(2362);
wn=60
ep=119.5/(2*wn) % se obtiene un sistema subamortiguado
