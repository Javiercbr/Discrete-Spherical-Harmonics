function [ Flm ] = IDLT( Fkm, l, m, w, PL )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Spherical Harmonic Expansion
% By Javier Cebeiro and Marcela Morvidone
% Centro de Matemática Aplicada, Universidad Nacional de San Martin
% Buenos Aires, Argentina
% Labo ETIS, Equipes Traitement de l'Information et Systèmes/ENSEA/UCP
% France
% 2019
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the Inverse Discrete Legendre Transform (IDLT) for indices  m 
% and l using weights w and Legendre functions PL.

% INPUT
% Fkm : for a given m
% w   : integration weight
% PL  : set of legendre functions
% l, m: indices for SHE


% OUTPUT
% Flm: 


Plm = PL( :, l + 1, abs(m) + 1 );

if m>=0 
    
    THETAlm =         Plm;

else
    
    THETAlm = (-1)^m *Plm;
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IMPORTANT: Previous if is indeed FASTER than the following commands, do 
% not feel tempted to use it
% factor = m>=0 + (-1)^m*(m<0);
% THETAlm = factor*Plm;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% performs numerical integration using the vector of coefficients w
Flm =  sum(Fkm.*THETAlm.*w);


end
