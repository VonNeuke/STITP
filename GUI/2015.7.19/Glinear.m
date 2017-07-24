 function G = Glinear(nx, ny, nb, na, ray_pix, mask, chat)
%function G = Glinear(nx, ny, nb, na, ray_pix, mask, chat)
%
%	Generate a geometric system matrix for tomographic projection
%	based on simple linear interpolation.
%	Contains exactly two g_{ij}'s per pixel per projection angle.
%	This system model is pretty inadequate for reconstructing
%	real tomographic data, but is useful for simple simulations.
%
%	in:
%		nx,ny		image size
%		nb,na		sinogram size (n_radial_bins X n_angles).
%		ray_pix		ray_spacing / pixel_size (usually 1 or 0.5)
%		mask [nx,ny]	which pixels are to be reconstructed
%	out:
%		G [nb*na,nx*ny]	all of G, regardless of mask
%				since entire size is needed for wtfmex saving.
%
%	Caller must do G = G(:,mask(:)) for masked reconstructions.
%
%	Copyright Apr 2000, Jeff Fessler, University of Michigan

if nargin < 1, nx = 32; end
if nargin < 2, ny = nx; end
if nargin < 3, nb = nx; end
if nargin < 4, na = floor(nb * pi/2); end
if nargin < 5, ray_pix = 1; end
if nargin < 6, mask = logical(ones(nx,ny)); end
if nargin < 7, chat = logical(0); end

if ray_pix < 0.5
	warning('small ray_pix will give lousy results!')
end

%
%	default: run a test demo
%
if nargin < 1
	help(mfilename)
	x = shepplogan(nx, ny, 1);
	ix = [-(nx-1)/2:(nx-1)/2]';
	iy = [-(ny-1)/2:(ny-1)/2];
	rr = sqrt(outer_sum(ix.^2, iy.^2));
	mask = rr < nx/2-1;
	clf
	G = Glinear(nx, ny, nb, na, mask);
	y = G * x(:);		% forward projection
	y = reshape(y, nb, na);	% reshape into sinogram array
	sino = zeros(nb, na);	sino(nb/2, 10) = 1;
	b = reshape(G' * sino(:), nx, ny);
	im(221, mask, 'support mask')
	im(222, x, 'test image')
	im(223, y, 'sinogram'), xlabel ib, ylabel ia
	im(224, b, 'backproject 1 ray')
	clear G
return
end

%
%	pixel centers
%
x = [0:nx-1] - (nx-1)/2;
y = (-1)*([0:ny-1] - (ny-1)/2);		% trick: to match aspire
[x,y] = ndgrid(x, y);
x = x(mask(:));
y = y(mask(:));
np = length(x);		% sum(mask(:)) - total # of support pixels

angle = [0:na-1]'/na * pi;
tau = cos(angle) * x' + sin(angle) * y';	% [na,np] projected pixel center
tau = tau / ray_pix;		% account for ray_spacing / pixel_size
tau = tau + (nb+1)/2;		% counting from 1 (matlab)
ibl = floor(tau);		% left bin
val = 1 - (tau-ibl);		% weight value for left bin

ii = ibl + [0:na-1]'*nb*ones(1,np);	% left sinogram index

good = ibl(:) >= 1 & ibl(:) < nb;	% within FOV cases
if any(~good), warning 'FOV too small', end

%np = sum(mask(:));
%nc = np;	jj = 1:np;		% compact G
nc = nx * ny;	jj = find(mask(:))';	% all-column G
jj = jj(ones(1,na),:);

val1 = 1-val;
if 0	% make precision match aspire?
	val = double(single(val));
	val1 = double(single(val1));
end

G1 = sparse(ii(good), jj(good), val(good), nb*na, nc);		% left bin
G2 = sparse(ii(good)+1, jj(good), val1(good), nb*na, nc);	% right bin
G = G1 + G2;

if 0
%	subplot(121), im(embed(sum(G)', mask))		% for compact
	subplot(121), im(reshape(sum(G), nx, ny))	% for all-column
	subplot(122), im(reshape(sum(G'), nb, na))
end
