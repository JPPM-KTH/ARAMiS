%% Function for the calculation of the Weighted sound reduction index

function [Rw_out]=Rw(TL,f)

[newf,newTL]=narrow_to_to(f,TL);
treat_f=newf();
treat_TL=newTL(find(newf==100):find(newf==3150));

weight       = [13 13 15 17 18 19 20 21 22 24 25 24 23 22 20 18];
f_to = [100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150];



while sum(weight-treat_TL)<32;
    weight=weight+1;
end

Rw_out=weight(find(f_to==500));


end

%  Juan Pablo Parra Martinez
%  jppm@kth.se
%  July,2014