% function [rho0,c0,eta,Cp,gamma,kappa,Pr] = properties_of_air(T,P0)
%
% Compute viscous and thermal properties of the air from the
% measure of the room temperature (in Celsius degrees) and the static
% pressure (in Pascals).
%
% Hack of code_axi, dominic.pilon, 2001.
%
% Bibliography:
% Lide, D. R. and Kehiaian H. V.,
% CRC. Handbook of Thermophysical and Thermochemical Data,
% CRC. Press Inc, 1994
% 
% Touloukian, Y. S. and Makita, T.,
% Specific Heat - Non metallic Liquids and gases,
% The TPRC Data Series, Volume 6, IFI/PLENUM, 1970
%
% version 2004.11.16

function [rho0,c0,eta,Cp,gamma,kappa,Pr] = properties_of_air(T,P0)

  % Convert temperature from Celsius to Kelvin
  T = 273.16+T;  

  % Universal gas constant (J.K^-1.kg^-1)
  R = 287.031;			

  % Specific heat at constant pressure (J.kg^-1.K^-1; 260 K < T < 600 K
  Cp = 4168.8*(0.249679-7.55179e-5*T+1.69194e-7*T^2-6.46128e-11*T^3);  

  % Specific heat at constant volume (J.kg^-1.K^-1; 260 K < T < 600 K
  Cv = Cp-R;				

  % Dynamic viscosity (N.s.m^-2; 100 K < T < 600 K
  eta = 7.72488e-8*T-5.95238e-11*T^2+2.71368e-14*T^3;  

  % Ratio of specific heats
  gamma = Cp/Cv;

  % Density of air (kg.m^-3)
  rho0 = P0/(R*T);
  
  % Velocity of sound (m.s^-1)
  c0 = sqrt(gamma*R*T);
  
  % Thermal conductivity - cf Pierce p 513 - (W.m-1.K-1)
  kappa = 2.624e-02 * ( (T/300)^(3/2) * (300+245.4*exp(-27.6/300))/(T+245.4*exp(-27.6/T)) );

  % Prandtl's number
  Pr = eta*Cp/kappa;