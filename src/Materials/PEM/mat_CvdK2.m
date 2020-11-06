phi=0.94;
sig=80650;
alpha=2.5;
LCV=27*10^(-06);
LCT=81*10^(-06);
rho_1=63.000;
poisson=0.2;

switch aaa
    case 'given'
        E=41434;
        eta=0.29;
        young=E*(1+1j*eta);
        
    case 'estimated'
        
        %% young
        matrice1= ...
            [102.57  58646;
            115.52  64969;
            130.62  72697;
            153.28  82537;
            173.78  92374;
            205.05  1.0573e+5;
            237.40  1.1838e+5;
            265.45  1.3033e+5;
            306.42  1.4580e+5;
            320.43  1.5072e+5;
            346.30  1.5987e+5;
            388.34  1.7393e+5;
            410.97  1.8097e+5;
            475.63  2.0067e+5;
            537.03  2.1686e+5;
            563.96  2.2250e+5;
            611.34  2.3237e+5;
            630.72  2.3590e+5;
            687.78  2.4648e+5;
            734.06  2.5214e+5;
            804.01  2.5993e+5;
            842.74  2.6348e+5;
            934.17  2.6779e+5;
            1000.8  2.6577e+5];
        
        f1=matrice1(:,1);
        E1=matrice1(:,2);
        
        fff = polyfit(f1,E1,3);
        E=polyval(fff,f);
        E=E(i_f);
        %% eta
        matrice2=...
            [103.04  0.30897;
            168.85  0.31923;
            283.53  0.33718;
            428.12  0.36026;
            548.78  0.37906;
            645.50  0.39444;
            748.22  0.41026;
            840.95  0.42521;
            932.70  0.43932;
            983.55  0.44786];
        
        f2=matrice2(:,1);
        eta2=matrice2(:,2);
        
        fff2 = polyfit(f2,eta2,3);
        eta=polyval(fff2,f);
        eta=eta(i_f);
        %% hooke's
        
        young=E*(1+1j*eta);
        
end

lambda=(young*poisson)/((1+poisson)*(1-2*poisson));
mu=(young)/(2*(1+poisson));


C=zeros(6,6);
C(1,:)=[2*mu+lambda lambda lambda 0 0 0];
C(2,:)=[lambda 2*mu+lambda lambda 0 0 0];
C(3,:)=[lambda lambda 2*mu+lambda 0 0 0];
C(4,4)=2*mu;
C(5,5)=2*mu;
C(6,6)=2*mu;

C_i=C;
sig_i=sig;
