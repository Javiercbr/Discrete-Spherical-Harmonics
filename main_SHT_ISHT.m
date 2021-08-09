
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
% This script performs the Spherical Harmonic Transform (SHT) for a function in 
% Cartesian coordinates and returns the recosntructed function via the ISHT. 
% As the original function is in Cartesian coordinates and SHE is intended 
% for functions in sperical coordinates, actually on the surface of a sphere,
% the original function is split up in spherical surfaces for discrete radii 
% on its support.


clc, clear all, close all
tic

% load the function to expand: f(x,y,z)
load('phSL3D64.mat');
f = p; clear('p'); % to load the object of interest

M = length(f);

% Cartesian coordinates
x = 0 : M-1;
R = M/4;
 x = x +   R; % off-center object 
% x = x - 2*R; %   centered object

y = x ; z = x ; % Remaining coordinates


% Simulation parameters

% Spherical Harmonic Expansion of order N ( l= 0, 1, ... N .... and |m|<= l)
N       =  4*64; % 4*

% converts the original function to spherical coordinates F(r, theta, phi)
% theta in [  0   pi]
% phi   in [  0 2 pi]
% r     in [rm    rM]

% Discretization of the radial coordinate 
Nr      =  1*  128; 

% Discretization of the elevation coordinate
Ntheta  =    6* 64; %6* 
% Discretization of the azimuthal coordinate
Nphi    = 2*N +1; 

flag = 'naive'; % 'gaussian'; %'naive'; % type of integration weigths

[ F, r, theta, phi, tk, w ] = cartesian2spherical( x, y, z, f, Nphi, Nr, Ntheta, flag );

[ PL ] = LegPoly( tk, N ); % calls the function to generate Legendre functions up to order N

%%


% receives data in the form F(r, theta, phi) and returns the
% Spherical Harmonic Expansion in the form of its coefficients Flm

clc
[Flm]  =  SHT(F, N, PL, w);



%%

% receives the coefficients Flm of the Spherical Harmonic Expansion and
% returns the function in spherical coordinates

clc
[Frec         ] = ISHT(         Flm, theta, N, PL);

%%
clc
close all

[ f            ] = spherical2cartesian(         F   , r, theta, phi, x, y , z );
[ frec         ] = spherical2cartesian(         Frec, r, theta, phi, x, y , z );


%%


%% FILTERING OPERATIONS
% adjust the inner parameter as necessary

[Flm_filtered]   =  filter_SHT(Flm, N, Ntheta, Nr);
[Frec_filtered]  =  ISHT(Flm_filtered, theta, N, PL);
[ frec_filtered] =  spherical2cartesian(Frec_filtered, r, theta, phi, x, y , z );



%%
clc, close all


% frec= frec - min(min(min(frec)));
% f= f - min(min(min(f)));

% frec= frec /max(max(max(frec)));
% f   = f    /max(max(max(f   )));



for i = 1: M

figure,     
%             subplot(131), imagesc(   squeeze( frec         (:,:,i)),[0 1] ), colorbar, colormap(gray), axis equal, title('Rec') 
%             subplot(132), imagesc(   squeeze( frec_filtered(:,:,i)),[0 1] ), colorbar, colormap(gray), axis equal, title('Rec Filt') 
%             subplot(133), imagesc(   squeeze( f            (:,:,i)),[0 1] ), colorbar, colormap(gray), axis equal, title('Orig')  

            subplot(121), imagesc(   squeeze( frec         (:,:,i)),[0 1] ), colorbar, colormap(gray), axis equal, title('Rec') 
            subplot(122), imagesc(   squeeze( frec_filtered(:,:,i)),[0 1] ), colorbar, colormap(gray), axis equal, title('Rec Filt') 
            % subplot(122), imagesc(   squeeze( f            (:,:,i)),[0 1] ), colorbar, colormap(gray), axis equal, title('Orig')  






end

disp('Elapsed time is:')
toc/60
disp('minutes.')
