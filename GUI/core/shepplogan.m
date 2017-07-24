 function image = shepplogan(nx, ny, isemis, dx, dy)
%function image = shepplogan(nx, ny, isemis, dx, dy)
%
% generate a nx by ny image using Shepp Logan phantom ellipse parameters
% if third argument is nonzero, then use "emission" values

if nargin < 1, nx = 64; end
if nargin < 2, ny = nx; end
if nargin < 3, isemis = 0; end

image = zeros(nx, ny);
if ~isvar('dy')
	xx = linspace(-1, 1, nx);
	yy = linspace(-1, 1, ny);
else
	xx = ([1:nx] - (nx+1)/2) * dx;
	yy = ([1:ny] - (ny+1)/2) * dy;
end
[xx yy] = ndgrid(xx,yy);

%
% parameters from Kak and Slaney text, p. 255
%
ellpar = [...
0	0	0.92	0.69	90	2;
0	-0.0184	0.874	0.6624	90	-0.98;
0.22	0	0.31	0.11	72	-0.02;
-0.22	0	0.41	0.16	108	-0.02;
0	0.35	0.25	0.21	90	0.01;
0	0.1	0.046	0.046	0	0.01;
0	-0.1	0.046	0.046	0	0.01;
-0.08	-0.605	0.046	0.023	0	0.01;
0	-0.605	0.023	0.023	0	0.01;
0.06	-0.605	0.046	0.023	90	0.01];

if isemis
	ellpar(:,6) = [1 2 4 4 5 6 7 8 8 8]';
end

for ie = 1:nrow(ellpar)
	ell = ellpar(ie, :);
	cx = ell(1);	rx = ell(3);
	cy = -ell(2);	ry = ell(4);
	theta = -ell(5) / 180 * pi;
	x = cos(theta) * (xx-cx) + sin(theta) * (yy-cy);
	y = -sin(theta) * (xx-cx) + cos(theta) * (yy-cy);
	tmp = (x/rx).^2 + (y/ry).^2 < 1;
	if isemis
		image(tmp > 0) = ell(6);
	else
		image = image + tmp * ell(6) / 100;	% scale by 100 for 1/mm 
	end
end
