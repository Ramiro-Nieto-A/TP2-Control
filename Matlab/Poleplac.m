% Pole Placement.
%Calcula k1 y k2 para hacer Realimentación Lineal de Estados , para
%que tenga polos en -10+/-j10.
clc

A = [0 1;
     0 0]

B = [0;
     212.766]

C = [1 0]

D = [0]

% Calcula la transferencia a lazo abierto.
[numG,denG] = ss2tf(A,B,C,D);     % convierte a la forma TF
G = tf(numG, denG);
minreal(G)

% Calcula la matriz de controlabilidad.
Cm=ctrb(A,B)                        
% Encuentra el rango de la matriz controlabilidad.
Rank=rank(Cm)     

% autovalores de A
eig(A)                

% Determina las ganancias de realimentación para los polos a lazo cerrado propuestos.
%cp = [-10+10*j, -10-10*j]
%k = place(A,B,cp)

k = [1 0.055]

% Calcula la matriz del sistema a lazo cerrado.
Acl = A-B*k

% autovalores de Acl
eig(Acl)            

% Calcula la transferencia a lazo cerrado.
[numT,denT] = ss2tf(Acl,B,C,D);     % convierte a la forma TF
T = tf(numT, denT);
minreal(T)

ess = 1 - dcgain(T)
step(T)
grid;

