%% compensador de adelanto
%%% FT original
num=4;        %num
den=[1 2 0];  %den 
G=tf(num,den);  %FT
figure
bode(G)
Gl=feedback(G,1);
figure
step(Gl)
p=[1 2 0];
roots(p);
%% raíces polinomio deseado 
%%% se busca wn=4 y coeficiente de amortiguamiento de 0.5
p1=[1 4 15];
s=roots(p1)
%% cálculo del angulo de deficiencia 
phi_r=atan2(0.1443,0.25);
%phi=(phi_r*180)/pi;
%phi=0.7854;
%phi=0.3142;
%% calculo de a
a=(1+sin(phi_r))/(1-sin(phi_r))
T=1/(4*sqrt(a))   %calculo de T

%% compensador a>1
%%%    G = a (s+1/aT)
%%%          ---------
%%%          ( s+1/T)

numc2=a*[1 1/(a*T)];
denc2=[1 1/T];
Gc2=tf(numc2,denc2);

%% sistema compensado 
Gcc2=Gc2*G;
figure
bode(Gcc2)

Glc=feedback(Gcc2,1);
figure
step(Glc)
%% forma alternativa
%%% Ganancia de alta frecuencia
Ka=20*log10(a);
Kaux=-10*log10(a)
%%% en el diagrama de Bode esta ganancia corresponde a 
wg=2.28;% frecuencia de cruce de ganancia
T2=1/(wg*sqrt(a))
%% Compensador
 numc=a*[1 1/(a*T2)];
 denc=[1 1/T2];
 Gc=tf(numc,denc);
 
%% sistema compensado 2
 Gcc1=Gc*G;
 figure
 bode(Gcc1)

Glc1=feedback(Gcc1,1);
figure
step(Glc1)