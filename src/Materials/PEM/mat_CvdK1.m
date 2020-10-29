phi=0.95;
sig=32950;
alpha=2.1;
LCV=50E-06;
LCT=150E-06;
rho_1=55.000;
E=20203;
poisson=0.25;
eta=0.21;

%% hooke's


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