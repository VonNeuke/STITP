% getG.m
% writer: J. Zhou
% date: 2003.12.14
% modified: 2003.12.16
%
% make probablity matrix
%
% parameter: 
%   nx, ny: image size (nx -by- ny)
%   nb: number of detector bin
%   na: number of angles
%   G: probability matrix (linear, simulation only) (nb*na -by- nx*ny)
function    G = getG(nx, ny, nb, na)

% WARNING:ANY CHECKS FOR PARAMETERS ARE IGNORED!
disp('getG: WARNING! ANY CHECKS FOR INPUT PARAMETERS ARE IGNORED!'); 

% image center
ix = [-(nx-1)/2:(nx-1)/2]';
iy = [-(ny-1)/2:(ny-1)/2];

% radium of mask
rr = sqrt(outer_sum(ix.^2, iy.^2));
%mask = rr < nx/2-1;
mask = rr < nx;
% call Glinear (refer to: Glinear.m (writen by Fessler)) 
% to generate probablity matrix
G = Glinear(nx, ny, nb, na, 1.0, mask, 0);
