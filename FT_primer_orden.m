%%% Ejemplo de tres FT de primer orden
%%% parámetros
R = 1000;   
C = 0.1e-4;
M = 1;
d = 0.01;
V = 10000;
w = 10;
rho = 1;
%%% FT Cicuito RC
Ke = 1/(R*C);
nume = Ke;
dene = [1 1/R*C];
pe = roots(dene) % polo
Ge = tf(nume,dene) %% FT
Kte=0.632*1e10 %% Valor en estado estacionario
taue=-1/pe     %% Constante de tiempo
% Sistema mecánico
 Km = 1/M;
 numm = Km;
 denm = [1 d/M];
 pm = roots(denm) %polo
 Gm = tf(numm,denm) %FT
 Ktm=0.632*Km %% Valor en estado estacionario
 taum=-1/pm %% Constante de tiempo
%% Sistema hidraúlico
 Kt = 1;
 numt = 1;
 dent = [1 w/(V*rho)];
 pt = roots(dent) %polo
 Gt = tf(numt,dent) % FT
 Ktt=0.632*1000 %% valor en estado estacionario
 taut=-1/pt %% Constante de tiempo

%%% Respuesta escalón unitario para cada sistema
 figure (1)
 step(Ge)
% figure (2)
% step(Gm)
% figure(3)
% step(Gt)
