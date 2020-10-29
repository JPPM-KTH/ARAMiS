% function [X W] = gauss_rule(N)
% Gauss-Legendre integration points and weights
% 
% X: coordinates of the N integration points
% W: corresponding weights
%
% TODO: comment and clean up this awful code
% !!!!!!!!!!!!!!! ROUTINE OK POUR MULTIPLE ORDRE 4 !!!!!!!!!!!!!!!!!

function [X,W] = gauss_rule(N)
 
      M = floor((N+1)/2);
      E1=N*(N+1);
for I=1:M
  T=(4*I-1)*pi/(4*N+2);
  X0=(1.0-(1.0-1.0/N)/(8.0*N*N))*cos(T);
  PKM1=1.0;
  PK=X0;
  for K=2:N
    T1=X0*PK;
    PKP1=T1-PKM1-(T1-PKM1)/K+T1;
    PKM1=PK;
    PK=PKP1;
  end
  DEN=1.0-X0*X0;
  D1=N*(PKM1-X0*PK);
  DPN=D1/DEN;
  D2PN=(2.0*X0*DPN-E1*PK)/DEN;
  D3PN=(4.0*X0*D2PN+(2.0-E1)*DPN)/DEN;
  D4PN=(6.0*X0*D3PN+(6.0-E1)*D2PN)/DEN;
  U=PK/DPN;
  V=D2PN/DPN;
  H=-U*(1.0+0.50*U*(V+U*(V*V-D3PN/(3.0*DPN))));
  P=PK+H*(DPN+0.50*H*(D2PN+H/3.0*(D3PN+0.250*H*D4PN)));
  DP=DPN+H*(D2PN+0.50*H*(D3PN+H*D4PN/3.0));
  H=H-P/DP;
  X(I)=X0+H;
  FX=D1-H*E1*(PK+0.50*H*(DPN+H/3.0*(D2PN  +0.250*H*(D3PN+0.20*H*D4PN))));
  W(I)=2.0*(1.0-X(I)*X(I))/(FX*FX);
end

if ( (M+M) == N ) % even number of points: N
  for I = 1:M
    X(N-I+1) =  X(I);
    X(I)     = -X(I);
    W(N-I+1) =  W(I);
  end
else              % odd number of points: N
  X(M) = 0.0;     % 0 is a first point
  for I = 1:M-1
    X(N-I+1) =  X(I);
    X(I)     = -X(I);
    W(N-I+1) =  W(I);  
  end
end
