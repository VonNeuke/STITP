function sino=get_sino(nb,na)
sino=zeros(nb,na);
p=na; %number of view angles between 0 and pi
q=nb/2; %q=1/d, d = detector spacing


%Specify parameters of ellipses for mathematical phantom. 
% xe = vector of x-coordinates of centers 
% ye = vector of y-coordinates of centers 
% ae = vector of first half axes
% be = vector of second half axes
% alpha = vector of rotation angles (degrees)
% rho = vector of densities 
xe=[0 0 0.22 -0.22 0 0 0 -0.08 0 0.06];
ye=[0 -0.0184 0 0 0.35 0.1 -0.1 -0.605 -0.605 -0.605];
be=[0.69 0.6624 0.11 0.16 0.21 0.046 0.046  0.023 0.023 0.023];
ae=[0.92 0.874 0.31 0.41 0.25 0.046 0.046 0.046 0.023 0.046];
alpha=[90 90 72 108 90 0 0 0 0 90];
rho=  [1 2 4 4 5 6 7 8 8 8];

%end of input section 

alpha = alpha*pi/180;
h = 1/q;		
s = h*[-q:q-1];
for j = 1:p
  j
  phi = (pi*(j-1)/p);
  theta = [cos(phi);sin(phi)];
  RF = Rad(theta,phi,s,xe,ye,ae,be,alpha,rho);%compute line integrals
  sino(:,j)=RF';
end
