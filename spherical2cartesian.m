function [ f ] = spherical2cartesian( F, r, theta, phi, x, y , z )

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

% FUNCTION: spherical2cartesian
% converts the function in spherical coordinates F(r, theta, phi) into the
% function in Cartesian coordinates

% INPUT
% F             : the function in spherical coordinates (Nr x Ntheta x Nphi)
% r, theta, phi :
% x, y, z       :

% OUTPUT
% f     : f(x, y, z)        



% obtains the spherical coordinates corresponding to each (x, y, z) triplet
[ x_, y_, z_] = meshgrid( x, y, z );            % grid for evaluation
r_            = sqrt(x_.^2 + y_.^2 + z_.^2);    % radial coordinate

phi_          = atan2(y_,x_) ;                  % azimuthal coordinate
phi_          =  phi_ + 2*pi*(phi_<0);          % converted to [ 0 2 pi] range as required

theta_        = acos(z_./sqrt(x_.^2 + y_.^2 + z_.^2)); % elevation coordinate


% limits of the elevation angle
theta_M = max(theta); theta_m = min(theta);

% in case that the calculated angle exceds the limits, I approximate with the nearest value 
theta_(theta_ > theta_M) = theta_M;
theta_(theta_ < theta_m) = theta_m;
theta_(isnan(theta_))    = theta_m; % the case  x = y = z = 0;




f = interp3( theta, r, phi, F, theta_, r_, phi_);
% f(isnan(f))=0;

% 
% M = length(r);
% for i = 1: M/2
% 
% figure, imagesc(x, y, squeeze( F(i,:,:))), colorbar, colormap(gray), axis equal
% xlabel('x')
% ylabel('y')
% 
% end



end

