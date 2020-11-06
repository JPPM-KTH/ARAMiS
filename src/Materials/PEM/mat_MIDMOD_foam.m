    %% Material : foam MIDMOD
    % Isotropic material, anisotropic model

    
    
    % Elastic prop
    
    
    rho_1=50;
    
    E=845e3;
    poisson=0.3;    
    eta=0.03;
    
    young=E*(1+1j*eta);
    
    lambda=(young*poisson)/((1+poisson)*(1-2*poisson));
    mu=(young)/(2*(1+poisson));
    
    
   C=zeros(6,6);
    C(1,:)=[2*mu+lambda lambda lambda 0 0 0];
    C(2,:)=[lambda 2*mu+lambda lambda 0 0 0];
    C(3,:)=[lambda lambda 2*mu+lambda 0 0 0];
    C(4,4)=2*mu;
    C(5,5)=2*mu;
    C(6,6)=2*mu;
    
    
    % Porous prop
    
    phi=0.925;
    LCV=9.37E-05;
    LCT=2.24-04;

    sig=18427;
    alpha=1.66;
    

    
    
    C_i=C;
sig_i=sig;

