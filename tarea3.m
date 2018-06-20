%% Sistema masa-resorte-amortiguador 2-acoplado
% Parametros
M1 = 1;%[kg]
M2 = 1.5;
d1 = 0.01; %[N.S/m]
d2 = 0.015;
k1 = 1; %[N/m]
k2 = 1.2;
g = 9.81;
%syms y;

%u1 = heaviside(y)+M1*g;
%u2 = M2*g;

A = [0 1 0 0; k1/M2 d1/M2 -(k1+k2)/M2 -d1/M2; 0 0 0 1; -k1/M1 -d1/M1 k1/M1 d1/M1];
B = [0 0; 0 1/M2; 0 0; 1/M1 0];
C = [1 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 0];
D = zeros(size(B));

%% Una forma, con ss(A,B,C,D,ui) y tf(sys)
sys = ss(A, B ,C, D);
tf(sys);
%ezplot(u1, [-1 3]);

%% Otra forma, con ss2tf
% for i=1:2
%     [num,den] = ss2tf(A,B,C,D,i);
%     for j=1:size(num,1)
%        tf(num(j, :),den) 
%     end
% end

[num , den] = ss2tf(A,B,C,D,1);
G1 = tf(num(1, :), den)
G3 = tf(num(3, :), den)

[num1 , den1] = ss2tf(A,B,C,D,2);
Gs1 = tf(num1(1, :), den1)
Gs3 = tf(num1(3, :), den1)

%% Ejemplo random
% sys2 = rss(2,2,2); %sistema aleatorio de 2x2
% [A1 B1, C1, D1]= ssdata(sys2); %dar matrices A B C D del sistema
% sys2tf = ss(A1, B1, C1, D1, 1);
% tf(sys2tf)
t=0:1:20;
% Graficas
figure()
subplot(211), step(G1)
grid on
subplot(212), impulse(G1)
grid on
figure()
subplot(211), step(G3)
grid on
subplot(212), impulse(G3)
grid on
figure()
subplot(211), step(Gs1)
grid on
subplot(212), impulse(Gs1)
grid on
figure()
subplot(211), step(Gs3)
grid on
subplot(212), impulse(Gs3)
grid on
