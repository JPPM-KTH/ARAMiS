%% Eleonora Lind Nordgren, JASA EL 2013
% inputs: omega
% outputs: rho_1, LCV, LCT, tort, phi, sig_i, C_i
 % sig_i and C_i are given in the material coordinate system.

rho_1=22.1;

LCV=1.1E-4;
LCT=7.4E-4;

tort_i=[1.5 0 0;
    0 1.0 0;
    0 0 2.0];

phi=0.98;

sig_i=[38 0 0;
    0 38 0;
    0 0 55]*1E3;

%% Mechanical parameters

C_i=[40 33 37 0 0 0;
    33  89 131 0 0 0;
    37 131 300 0 0 0;
    0 0 0 26 0 0;
    0 0 0 0 21 0;
    0 0 0 0 0 26]*1E3;