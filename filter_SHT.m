function [Flm_filtered]  =  filter_SHT(Flm, N, K, Nr)


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
% algorithm is based in the following article and references therein
% 
% [1] Cone-beam image reconstruction using spherical harmonics
% K Taguchi, GL Zeng, GT Gullberg - Physics in Medicine & Biology, 2001


% FILTERING PARAMETERS: to adjust manually
% in reference [1]
%
% Cl = Cm = 0.0 for Shepp Logan
% Cl = Cm = 1.0 for Defrise
%
%
%

C_l = 0.0; % 1.0 ;% 0.3;
C_m = 0.0; % 1.0 ;% 0.3; 



N_l = K;
N_m = N; 


m = -N : N        ;
l =  0 : N;

[m_, l_] = meshgrid(m, l);


if  C_l == 1
     
 A_l = 1;
 
else 
     
A_l = 1 - C_l;

end



x_l = ( 1 - ( l_ - abs(m_))/N_l )/A_l;
W_l = 1.0.*( (l_-abs(m_))<=C_l*N_l ) + (3*x_l.^2 - 2*x_l.^3).*( (l_-abs(m_))>C_l*N_l );

if  C_m == 1
     
 A_m = 1;
 
else 
     
A_m = 1 - C_m;

end

x_m = ( 1 - abs(m_)/N_m )/A_m;

W_m = 1.0.*( abs(m_)<=C_m*N_m ) + (3*x_m.^2 - 2*x_m.^3).*( abs(m_)>C_m*N_m );


Wlm = W_l.*W_m;


size(Wlm)
Flm_filtered = zeros(size(Flm));

for i = 1 : Nr
   
    
    Flm_filtered(i,:,:)=squeeze(Flm(i,:,:)).*Wlm;
    
end




end

