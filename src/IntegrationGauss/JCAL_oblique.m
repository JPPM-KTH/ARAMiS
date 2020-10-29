% Compute the normal sound absorption coefficient of an acoustical porous
% material sample backed by a rigid impervious wall using 
% Johnson-Champoux-Allard-Lafarge model
%
% Johnson D. L., Koplik J. and Dashen R., 
% Theory of dynamic permeability and tortuosity in fluid-saturated porous media, 
% J. Fluid Mech., 176, 1987, pp. 379-402
%
% Champoux Y. and Allard J.-F., 
% Dynamic tortuosity and bulk modulus in air-saturated porous media, 
% J. Appl. Phys., 70, 1991, pp. 1975-1979
% 
% Lafarge D., Lemarinier P., Allard, J-F. and Tarnow V., 
% Dynamic compressibility of air in porous structures at audible frequencies, 
% J. Acoust. Soc. Am. 102 (4), 1997, pp. 1995-2006
%
% Copyleft 2007 luc.jaouen@matelys.com
% cf. APMR on the web,
% PropagationModels/MotionlessSkeleton/JohnsonChampouxAllardLafarge.html
% for more information

function alpha = JCAL_oblique(params,L,theta,T,P0) 
    
  phi          = params.phi;
  sigma        = params.sigma;
  alpha_infty  = params.alpha_infty;
  lambda       = params.lambda;
  lambda_prime = params.lambda_prime;
  k_0_prime    = params.k_0_prime;


  %%%%% Frequency range
  frequencies = [10:10:4000];
  omega = 2*pi*frequencies;

  %%%%% Compute air properties at T and P0
  [rho0,c0,eta,Cp,gamma,kappa,Pr] = properties_of_air(T,P0);


  %%%%%
  %%%%% Compute the dynamic density rho_eq and bulk modulus K_eq 
  %%%%% for the material
  %%%%%
  Gj = sqrt( 1 + 4*j*alpha_infty^2*eta*rho0*omega / ...
             (sigma^2*lambda^2*phi^2)          );
  
  rho_eq = (1/phi) * alpha_infty * rho0 * ( 1 + sigma*phi*Gj ./ ... 
	                                  (j*omega*rho0*alpha_infty) );

  K_eq = (1/phi) * gamma*P0 ./ ...
           ( gamma - (gamma-1) ./ ...
	             ( 1 -  j*phi*kappa./(k_0_prime*Cp*omega*rho0) .* ...
	                    sqrt( 1+j*4*rho0*omega*Cp*k_0_prime^2/(kappa*lambda_prime^2*phi^2) ) ) );


  %%%%% Compute the characteristic impedance Z, the wave number k
  %%%%% and deduce the sound absorption coefficient alpha
  %%%%% Allard, 1993, pp. 37-38
  Z = sqrt(rho_eq.*K_eq);
  k = omega.*sqrt(rho_eq./K_eq);

 
   	k3 = sqrt( k.^2 - (omega/c0*sin(theta)).^2 );
 	Z_M2 = -j*Z.*k./k3./tan(k3*L);

	%hh = 0.2;
 	%Z_M1 = -j*rho0*c0./(cos(theta))./tan(omega.*cos(theta)/c0*hh);
   	
	%Z_M1 = 1e+20;
    %Z_M2 =  Z.*k./k3 .* ( -j*Z_M1./tan(k3*L) + Z.*k./k3) ...
	%			./ ( Z_M1 -j*Z.*k./k3./tan(k3*L) );
				
	alpha    = 1 - ( abs( (Z_M2-rho0*c0/cos(theta))./(Z_M2+rho0*c0/cos(theta)) ) ).^2;



