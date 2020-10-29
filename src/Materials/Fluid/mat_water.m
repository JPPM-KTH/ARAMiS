
%% Constants

mu_0=.184e-4; % Dynamic viscosity           %(kg/m/s)
NPR=0.710;
lambda_0=0.0262;                              %[W.m^-1.K^-1]

%% Air properties
rho_0=1.204;                                %[kg.m^-3]
c_0=343.25946;                              %[m.s^-1]

K_0=c_0^2*rho_0;
Z_0=rho_0*c_0;

C_p=1006;
C_v=C_p/gamma;

nu_0=mu_0/rho_0;
nu_prime_0=nu_0/NPR;