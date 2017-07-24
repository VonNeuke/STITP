function P=my_fbp(sino,nb,na,nx,ny)
%Parallel-beam filtered backprojection algorithm
% for the standard lattice
% Last revision: August 29, 2001

%specify input parameters here 

p=na; %number of view angles between 0 and pi
q=nb/2; %q=1/d, d = detector spacing
MX=nx;  MY = ny; %matrix dimensions 
roi=[-1  1 -1  1]; %roi=[xmin xmax ymin ymax]
                   %region of interest where 
                   %reconstruction is computed 
circle = 1; % If circle = 1 image computed only inside 
            % circle inscribed in roi.

%end of input section 

b=pi*q; rps=1/b;


if MX > 1 
 hx = (roi(2)-roi(1))/(MX-1);
 xrange = roi(1) + hx*[0:MX-1];
else 
 hx = 0; xrange = roi(1);
end

if MY > 1 
 hy = (roi(4)-roi(3))/(MY-1);
 yrange = flipud((roi(3) + hy*[0:MY-1])');
else 
 hx = 0; yrange = roi(3);
end

center = [(roi(1)+roi(2)), (roi(3)+roi(4))]/2;
x1 = ones(MY,1)*xrange; %x-coordinate matrix
x2 = yrange*ones(1,MX); %y-coordinate matrix
if circle == 1
  re = min([roi(2)-roi(1),roi(4)-roi(3)])/2;
  chi = ((x1-center(1)).^2 + (x2-center(2)).^2 <= re^2); %char. fct of roi;
else
  chi = isfinite(x1);
end
x1 = x1(chi); x2 = x2(chi);
P = zeros(MY,MX);Pchi = P(chi);


h = 1/q;		
s = h*[-q:q-1];
bs = [-2*q:2*q-1]/(q*rps);
wb = slkernel(bs)/(rps^2); %compute discrete convolution kernel.
for j = 1:p
  %j
  phi = (pi*(j-1)/p);
  theta = [cos(phi);sin(phi)];
  RF =sino(:,j); 
  

%    convolution 
  C = conv(RF,wb);
  Q = h*C(2*q+1:4*q); 
 % Q(2*q+1)=0; 
  

%    interpolation and backprojection 

     Q = [real(Q');0];
     t = theta(1)*x1 + theta(2)*x2;
     k1 = floor(t/h);
     u = (t/h-k1);
     k = max(1,k1+q+1); k = min(k,2*q);
     Pupdate =  ((1-u).*Q(k)+u.*Q(k+1));
     Pchi=Pchi+ Pupdate;

end   % j-loop
P(chi) = Pchi*(2*pi/p);







