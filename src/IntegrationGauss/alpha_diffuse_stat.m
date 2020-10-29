% function [] = diffuse_field(frequencies,params,L,T,P0)
%
% Compute the acoustic absorption coefficient in diffuse field.
%
% Bibliography:
% A. London, J. Acoust. Soc. Am. 22(2), 1950.
% M. Bruneau, Manuel fondamental d'acoustique, Hermes, 1998, p. 396.
%
% version 23.02.2005

clear all
close all


params.sigma = 6200;
params.phi = 0.90;
params.alpha_infty = 1.90;
params.lambda = 100e-06;;
params.lambda_prime = 200e-06;
params.k_0_prime = 6e-10;

L = 0.024;
T = 20;
P0 = 101325;

radian_max  = 90 * pi/180.d00; % cf. M. Bruneau (2nd ed.), p. 396
nb_of_angle = 4*4;

% Calculation of the Gauss integration points along theta
[Xtheta,Wtheta] = gauss_rule( nb_of_angle );

Xtheta = Xtheta + 1.0;                  
Xtheta = ( radian_max/2.0 ) * Xtheta;  
Wtheta = ( radian_max/2.0 ) * Wtheta;


% Loop on integration point
alpha_stat = 0;
for a = 1:nb_of_angle,
	weight = Wtheta(a);
	theta  = Xtheta(a);

	alpha = JCAL_oblique(params,L,theta,T,P0);
	alpha_stat = alpha_stat + 2 * alpha*cos(theta)*sin(theta)*weight;


end



alphacell = load('OnRigidWall.rok');
%alphacell = load('With200mmPlenum.rok');



figure
set(gca,'FontSize',16)
plot([10:10:4000],alpha_stat,'b-','linewidth',2)
hold on
%plot(gtmma_DF(:,1),gtmma_DF(:,6),'r-')
%plot(gtmma(:,1),gtmma(:,6),'k-')
plot(alphacell(:,1),alphacell(:,2),'r--','linewidth',2)
%plot(nova(:,1),nova(:,2),'y-')
%legend('Matlab','gTMMa DF','gTMMa','Nova DF','Nova')
set(gca,'ylim',[0 1])
