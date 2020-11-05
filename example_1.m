%% EXAMPLE: Poroelastic material layer
%% Author: Juan Parra
%% Email: jppm@kth.se
%% Date: 2020-10-29
%% License: GNU LGPL 2.1

clear all

%% Constants
air_properties_maine;		% Load properties of air
global L in out

%% Definition of the frequency domain
fmin=10;			% initial frequency
fmax=1000;			% last frequency
fnb=200;				% amount of frequencies
in.f=linspace(fmin,fmax,fnb);	% linear discretization of the frequency space

%% Definition o the plane wave incidence
% solid_stroh is singular for theta_1=0 deg, so approximation needed
in.theta_1=1e-3*pi/180; % angle z0x
in.theta_2=1e-3*pi/180; % angle x0y

%% Termination
in.termination='rigid backing';

%% CONSTANTS PER LAYER
L(1).d=50e-2;			% Thickness of the layer
L(1).material.type='pem';	% 'pem' for poroelastic media
L(1).material.sheet='ANIPEM_ANAEL_Melamine';
L(1).material.rotation=2;  %% 1 == no // 2 == si
L(1).material.alfa_rot=0;
L(1).material.beta_rot=pi/2;
L(1).material.gamma_rot=0;



%% Resolution protocol. DO NOT CHANGE
[L,out]=ARAMiS(L,in);

%% Example plot
subplot(211)
plot(in.f,out.Absorpt)
xlabel('Frequency (Hz)')
ylabel('Absoprtion coefficient (-)')
ylim([0,1])

subplot(212)
semilogy(in.f,L(1).disspow.struct.tot)
xlabel('Frequency (Hz)')
ylabel('Dissipated power by structural means (W/m2)')
