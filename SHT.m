function [Flm] = SHT(F, N, PL, w)


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

% This function receives data in the form F(r, theta, phi) and returns the
% Spherical Harmonic Expansion in the form of its coefficients Flm. The
% algorithm is based in the following articles and references therein
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

Nr = size(F, 1);
K  = size(F, 2);

Flm = zeros(Nr, N+1, 2*N +1 );



progress_bar = waitbar(0,'Performing SHT');


for i = 1 : Nr % for each radial distance
    
    waitbar(i/Nr);
    
    Fkn = squeeze( F( i, :, :) ); % a spherical surface
    
    Fkm =   fft(Fkn,[],2); % calculates the DFT in ROWS, index: m = 0, 1, ... 2N
    Fkm = fftshift(Fkm,2); % index: m = -N, ..., 0, ... N
 
   
    
    for m = -N : N
        
        for l = abs(m) : N
            
        % for each pair ml, calculates the Inverse Discrete Legendre Transform (IDLT) for each
        % column of Fkm
        Flm(i, l+1, m + N + 1) = IDLT(Fkm(:, m + N + 1), l, m, w, PL);
          
           
        end
        
        
        
    end
    
      
    
end
    
    close(progress_bar)
    
end  
