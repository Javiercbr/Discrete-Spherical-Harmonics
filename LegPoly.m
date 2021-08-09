function [ PL ] = LegPoly( tk, N )

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

% This script returns a 3D array with the Legendre functions up to degree l = N
% with orders m = 0, 1, ..., l evaluated in tk. For instance, theLegendre
% function of degree l0 and order m0 is in the array PL at positions l = l0
% +1 and m = m0 +1, so P = PL(:, l0 +1, m0 +1). For m<0 a factor (-1)^m*(m<0)
% must be applied outside of this function.


K = length(tk); 

PL = zeros(K, N+1, N+1);

for l = 0 : N % degree
    
    
    
    P = legendre(l, tk, 'norm') ; % the NORMALIZED Legendre functions
    
    for m = 0 : l % order
        
                
        PL(:, l + 1,  m + 1 )= P( m + 1, : )';
        
    end
    
    
end



end
