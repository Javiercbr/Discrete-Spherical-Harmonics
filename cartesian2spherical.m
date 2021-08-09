function [ F, r, theta, phi, tk, w ] = cartesian2spherical( x, y, z, f, Nphi, Nr, Ntheta, flag )

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

% FUNCTION: cartesian2spherical
% converts the original function to spherical coordinates F(r, theta, phi)

% theta in [  0  pi]
% phi   in [  0 2pi]
% r     in [rm   rM]

% INPUT

% x, y, z           :
% f                 : 
% Nphi, Nr, Ntheta  :
% flag              : type of integration (Gaussian Quadrature, ordinary grid, etc.)


% OUTPUT

% F             : the function in spherical coordinates (Nr x Ntheta x Nphi)
% r, theta, phi :
% tk            : t = cos(theta) for integration
% w             : inegration weights

% Angular parameters range
theta_m =   0; theta_M =   pi  ; % elevation
phi_m =     0; phi_M =  2* pi  ; % azimuthal

% Radial range
[ x_, y_, z_] = meshgrid( x, y, z );
r_ = sqrt(x_.^2 +  y_.^2 + z_.^2);

r_m = min(min(min(r_)));
r_M = max(max(max(r_)));

% Discretization of variables
dr     = (r_M - r_m)/(Nr - 1);
r     = r_m : dr : r_M ;

dphi   = (phi_M - phi_m)/(Nphi - 1);
phi   = phi_m : dphi : phi_M ;

switch flag
    
    
    case 'gaussian'
        % elevation is discretised in a non-regular grid 
        % for using Gaussian quadrature in integration
        [tk, w ]= lgwt(Ntheta, cos(theta_M), cos(theta_m));
        theta = acos(tk); % the nonregular grid is in theta
        
       
    case 'naive'
        
        % elevation is discretised in a regular grid 
        % for ordinary integration
        dtheta   = (theta_M - theta_m)/(Ntheta + 1 );
        theta   = (theta_m + dtheta : dtheta : theta_M - dtheta )' ;
        tk = cos(theta);
        dt = -(-sin(theta)*dtheta); % t = cos(theta) -> dt/dtheta=-sin(theta)
                                    % limits: theta = 0 -> t = 1
        w = dt;                     % theta = pi -> t = -1
        
    otherwise
        
        warning('Unexpected option.')
        
        
end

[ theta_, r_, phi_] = meshgrid( theta, r, phi );

x_ = r_.*sin(theta_).*cos(phi_);
y_ = r_.*sin(theta_).*sin(phi_);
z_ = r_.*cos(theta_);


F = interp3(x, y, z, f, x_, y_, z_);
F(isnan(F))=0;



end

