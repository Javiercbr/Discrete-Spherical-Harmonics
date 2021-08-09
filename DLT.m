function [ Fm ] = DLT( Flm, m, theta, N, PL )

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
% Calculates the Discrete Legendre Transform (DLT) for index m using nodes tk and weights w

% INPUT
% Flm   : coefficients of the SHE 
% m     :
% theta :
% N     :
% PL    :
%
%


% OUTPUT
% Fm



Flm = Flm( abs(m) + 1 : end ); % to keep just the last non zero values

K = length(theta);

Plm = zeros( N - abs(m) + 1 , length(theta) ); % array for the Legendre functions


for l = abs(m) : N % arranges Legendre functions for integration
 
    Plm( l - abs(m) + 1 , : ) =  PL(:, l + 1, abs(m)+1).';
 
    
end


if m>=0 % multiplies for the apropriate factor
    
    THETAlm =         Plm;

else
    
    THETAlm = (-1)^m *Plm;
    
end



Flm = repmat(Flm,1,K); % to repeat the vector Flm in order to multiply each 
                       % row of Flm for the same number     

Fm = sum(Flm.*THETAlm, 1 ); % INTEGRATION: multiplies and sum over index l


Fm = Fm.';

end

