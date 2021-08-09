function [Fkn] = ISHT(Flm, theta, N, PL)

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
% This function receives Flm coefficients of the SHE of a function and
% returns the Inverse Spherical Harmonic Transform, i.e. function
% F(r, theta, phi). The algorithm is based in the following articles and 
% references therein.
% 
% [1] Application of spherical harmonics to image reconstruction for the Compton camera
% R Basko, GL Zeng, GT Gullberg - Physics in Medicine & Biology, 1998. 
% 
% [2] Cone-beam image reconstruction using spherical harmonics
% K Taguchi, GL Zeng, GT Gullberg - Physics in Medicine & Biology, 2001


% INPUT

% F    : Nr x Ntheta x Nphi 
% N    : order of the expansion
% tk   : vector t = cos(theta)
% w    : integration weigths

% OUTPUT
%
% Flm : coeficients of the SH expansion
%

% INPUT
% Flm in N + 1 x 2*N+1 with m = -N,....0,...., N and l = abs(m),...., N
% N
% PL
% theta


% OUTPUT
% Fkn : the reconstructed image


Nr = size(Flm,1);
K  = length(theta);


Fmk = zeros( K,  2*N +1);
Fkn = zeros( Nr, K , 2*N +1);


progress_bar = waitbar(0,'Performing ISHT');
for i = 1 : Nr % for each radius
    
     waitbar(i/Nr);
    
    for m = -N : N
        
        a= Flm(i, :, m + N +1).'; % for all l-values and a given m
        Fmk(:,  m+N+1) = DLT(a, m, theta, N, PL); % calls the Discrete Legendre Transform
        
    end
       
   

     % performs the IDFT
     Fmk = ifftshift(Fmk,2); % goes back to indices: m = 0, 1, ... 2N
     Fkn(i, : , :)=  real(ifft(Fmk,[],2,'symmetric')); % calculates the IDFT
    

end

close(progress_bar)

end
