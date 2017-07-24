function [ u ] = level_set_3D(Img,iterNum)

%参数初始化
mu = 100;
lambda = 1;
inner_iter=2;
% slice=15;


Img = double(Img);
Img = (Img - min(Img(:)))./(max(Img(:)) - min(Img(:)));
ROI = double(Img>0.75);
%segmentation of mask region
u = Img;%output
u = u./max(u(:));


pfdx1 = zeros(size(Img));
pfdy1 = zeros(size(Img));
pfdz1 = zeros(size(Img));
pfbx1 = zeros(size(Img));
pfby1 = zeros(size(Img));
pfbz1 = zeros(size(Img));

save pf1 pfdx1 pfdy1 pfdz1 pfbx1 pfby1 pfbz1
clear pfdx1; clear pfdy1;clear pfdz1; clear pfbx1; clear  pfby1; clear  pfbz1

iNbItersUpdateHr = 1;  % number of iterations to update the region function g_r

fct1 = 1./6.;
fct2 = ones(size(Img)).*lambda/(6.0*mu);
fct1b = 1./5.;
fct2b = ones(size(Img)).*lambda/(5.0*mu);
fct1c = 1./4.;
fct2c = ones(size(Img)).*lambda/(4.0*mu);
fct1d = 1./3.;
fct2d = ones(size(Img)).*lambda/(3.0*mu);


[Height Wide Z] = size(Img);

iNI=0; % number of iterations (outer iterations)
t = 0;t0=cputime;
fError = 1e10;

while ( iNI<iterNum )
    
    clear r;

    c_1 = sum(sum(sum(Img.*u.*ROI)))./sum(sum(sum(u.*ROI)));
    c_2 = sum(sum(sum(Img.*(1-u).*ROI)))./sum(sum(sum((1-u).*ROI)));
    r = (Img - c_1).^2 - (Img-c_2).^2;
    r=r.*ROI;
    clear e
    t = t +  cputime -t0;
    load pf1;
    t0 = cputime;
    % Compute u^{k+1} with Gauss-Seidel */
    % Solve u^k+1 = arg min int lambda h_r u + mu/2 |d - grad u - b^k|^2 */
    %Euler-Lagrange is  mu Laplacian u = lambda hr + mu div (b^k-d^k),
    %u in [0,1] */
    iGS=0; % number of iterations for Gauss-Seidel (inner iterations)
    fError = 1e10;
    while (  iGS<inner_iter )
        
        %center
        for i = 2:Height-1
            for j = 2:Wide-1
                for z = 2:Z-1
                    alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z) + pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z) + pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
                    beta_ijz = fct1*(u(i-1,j,z) + u(i+1,j,z)+ u(i,j-1,z) + u(i,j+1,z) + u(i,j,z-1) + u(i,j,z+1)+ alpha_ijz) - fct2(i,j,z)*r(i,j,z);
                    temp = min(beta_ijz,1);
                    temp = max(temp,0);
                    u(i,j,z) = temp;
                end
            end
        end
        
        %%%%%%%%%?????????center
        z = 1;
        for i = 2:Height-1
            for j = 2:Wide-1
                alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ 0- pfdz1(i,j,z) - 0 + pfbz1(i,j,z);
                beta_ijz = fct1b*(u(i-1,j,z) + u(i+1,j,z) + u(i,j-1,z) + u(i,j+1,z) + 0 + u(i,j,z+1)+ alpha_ijz) - fct2b(i,j,z)*r(i,j,z);
                temp = min(beta_ijz,1);
                temp = max(temp,0);
                u(i,j,z) = temp;
            end
        end
        
        %%%%%%%%%?????????center
        z = Z;
        for i = 2:Height-1
            for j = 2:Wide-1
                alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
                beta_ijz = fct1b*(u(i-1,j,z) + u(i+1,j,z) + u(i,j-1,z) + u(i,j+1,z) + u(i,j,z-1) + 0 + alpha_ijz) - fct2b(i,j,z)*r(i,j,z);
                temp = min(beta_ijz,1);
                temp = max(temp,0);
                u(i,j,z) = temp;
            end
        end
        
        %%%%%%%%%?????????center
        j = 1;
        for i = 2:Height-1
            for z = 2:Z-1
                alpha_ijz = 0 - pfdx1(i,j,z) - 0 + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z) + pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
                beta_ijz = fct1b*(u(i-1,j,z) + u(i+1,j,z) + 0 + u(i,j+1,z) + u(i,j,z-1) + u(i,j,z+1) + alpha_ijz) - fct2b(i,j,z)*r(i,j,z);
                temp = min(beta_ijz,1);
                temp = max(temp,0);
                u(i,j,z) = temp;
            end
        end
        
        
        %%%%%%%%%?????????center
        j = Wide;
        for i = 2:Height-1
            for z = 2:Z-1
                alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
                beta_ijz = fct1b*(u(i-1,j,z) + u(i+1,j,z) + u(i,j-1,z) + 0 + u(i,j,z-1) + u(i,j,z+1)+ alpha_ijz) - fct2b(i,j,z)*r(i,j,z);
                temp = min(beta_ijz,1);
                temp = max(temp,0);
                u(i,j,z) = temp;
            end
        end
        
        %%%%%%%%%????????center
        i=1;
        for j = 2:Wide-1
            for z = 2:Z-1
                alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ 0- pfdy1(i,j,z) - 0 + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
                beta_ijz = fct1b*(0 + u(i+1,j,z) + u(i,j-1,z) + u(i,j+1,z) + u(i,j,z-1) + u(i,j,z+1)+ alpha_ijz) - fct2b(i,j,z)*r(i,j,z);
                temp = min(beta_ijz,1);
                temp = max(temp,0);
                u(i,j,z) = temp;
            end
        end
        
        %%%%%%%%%????????center
        i=Height;
        for j = 2:Wide-1
            for z = 2:Z-1
                alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z) + pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
                beta_ijz = fct1b*(u(i-1,j,z) + 0 + u(i,j-1,z) + u(i,j+1,z) + u(i,j,z-1) + u(i,j,z+1) + alpha_ijz) - fct2b(i,j,z)*r(i,j,z);
                temp = min(beta_ijz,1);
                temp = max(temp,0);
                u(i,j,z) = temp;
            end
        end
        
        
        %%%%%%%%%????????????
        z = 1;
        j = 1;
        for i = 2:Height-1
            alpha_ijz = 0 - pfdx1(i,j,z) - 0 + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ 0 - pfdz1(i,j,z) - 0 + pfbz1(i,j,z);
            beta_ijz = fct1c*(u(i-1,j,z) + u(i+1,j,z) + 0 + u(i,j+1,z) + 0 + u(i,j,z+1)+ alpha_ijz) - fct2c(i,j,z)*r(i,j,z);
            temp = min(beta_ijz,1);
            temp = max(temp,0);
            u(i,j,z) = temp;
        end
        
        z = 1;
        j = Wide;
        for i = 2:Height-1
            alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z) + pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ 0 - pfdz1(i,j,z) - 0 + pfbz1(i,j,z);
            beta_ijz = fct1c*(u(i-1,j,z) + u(i+1,j,z) + u(i,j-1,z) + 0 + 0 + u(i,j,z+1)+ alpha_ijz) - fct2c(i,j,z)*r(i,j,z);
            temp = min(beta_ijz,1);
            temp = max(temp,0);
            u(i,j,z) = temp;
        end
        
        z = 1;
        i = 1;
        for j = 2:Wide-1
            alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ 0 - pfdy1(i,j,z) - 0 + pfby1(i,j,z)+ 0 - pfdz1(i,j,z) - 0 + pfbz1(i,j,z);
            beta_ijz = fct1c*(0 + u(i+1,j,z) + u(i,j-1,z) + u(i,j+1,z) + 0 + u(i,j,z+1) + alpha_ijz) - fct2c(i,j,z)*r(i,j,z);
            temp = min(beta_ijz,1);
            temp = max(temp,0);
            u(i,j,z) = temp;
        end
        
        z = 1;
        i = Height;
        for j = 2:Wide-1
            alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z) + pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ 0 - pfdz1(i,j,z) - 0 + pfbz1(i,j,z);
            beta_ijz = fct1c*(u(i-1,j,z) + 0 + u(i,j-1,z) + u(i,j+1,z) + 0 + u(i,j,z+1) + alpha_ijz) - fct2c(i,j,z)*r(i,j,z);
            temp = min(beta_ijz,1);
            temp = max(temp,0);
            u(i,j,z) = temp;
        end
        
        %%%%%%%%%%%%??????????????
        i = Height;
        j = 1;
        for z = 2:Z-1
            alpha_ijz = 0 - pfdx1(i,j,z) - 0 + pfbx1(i,j,z) + pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
            beta_ijz = fct1c*(u(i-1,j,z) + 0 + 0 + u(i,j+1,z) + u(i,j,z-1) + u(i,j,z+1)+ alpha_ijz) - fct2c(i,j,z)*r(i,j,z);
            temp = min(beta_ijz,1);
            temp = max(temp,0);
            u(i,j,z) = temp;
        end
        
        
        i = Height;
        j = Wide;
        for z = 2:Z-1
            alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
            beta_ijz = fct1c*(u(i-1,j,z) + 0 + u(i,j-1,z) + 0 + u(i,j,z-1) + u(i,j,z+1) + alpha_ijz) - fct2c(i,j,z)*r(i,j,z);
            temp = min(beta_ijz,1);
            temp = max(temp,0);
            u(i,j,z) = temp;
        end
        
        
        i = 1;
        j = 1;
        for z = 2:Z-1
            alpha_ijz = 0 - pfdx1(i,j,z) - 0 + pfbx1(i,j,z) + 0 - pfdy1(i,j,z) - 0 + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
            beta_ijz = fct1c*(0 + u(i+1,j,z) + 0 + u(i,j+1,z) + u(i,j,z-1) + u(i,j,z+1) + alpha_ijz) - fct2c(i,j,z)*r(i,j,z);
            temp = min(beta_ijz,1);
            temp = max(temp,0);
            u(i,j,z) = temp;
        end
        
        i=1;
        j = Wide;
        for z = 2:Z-1
            alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ 0 - pfdy1(i,j,z) - 0 + pfby1(i,j,z) + pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
            beta_ijz = fct1c*(0 + u(i+1,j,z) + u(i,j-1,z) + 0 + u(i,j,z-1) + u(i,j,z+1)+ alpha_ijz) - fct2c(i,j,z)*r(i,j,z);
            temp = min(beta_ijz,1);
            temp = max(temp,0);
            u(i,j,z) = temp;
        end
        
        %%%%%%%%%%???????????
        j =1;
        z=Z;
        for i = 2:Height-1
            alpha_ijz = 0 - pfdx1(i,j,z) - 0 + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
            beta_ijz = fct1c*(u(i-1,j,z) + u(i+1,j,z) + 0 + u(i,j+1,z) + u(i,j,z-1) + 0+ alpha_ijz) - fct2c(i,j,z)*r(i,j,z);
            temp = min(beta_ijz,1);
            temp = max(temp,0);
            u(i,j,z) = temp;
            
        end
        
        j =Wide;
        z=Z;
        for i = 2:Height-1
            alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
            beta_ijz = fct1c*(u(i-1,j,z) + u(i+1,j,z) + u(i,j-1,z) + 0 + u(i,j,z-1) + 0 + alpha_ijz) - fct2c(i,j,z)*r(i,j,z);
            temp = min(beta_ijz,1);
            temp = max(temp,0);
            u(i,j,z) = temp;
            
        end
        
        i =1;
        z=Z;
        for j = 2:Wide-1
            alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ 0 - pfdy1(i,j,z) - 0 + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
            beta_ijz = fct1c*(0 + u(i+1,j,z) + u(i,j-1,z) + u(i,j+1,z) + u(i,j,z-1) + 0 + alpha_ijz) - fct2c(i,j,z)*r(i,j,z);
            temp = min(beta_ijz,1);
            temp = max(temp,0);
            u(i,j,z) = temp;
            
        end
        
        i =Height;
        z=Z;
        for j = 2:Wide-1
            alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
            beta_ijz = fct1c*(u(i-1,j,z) + 0 + u(i,j-1,z) + u(i,j+1,z) + u(i,j,z-1) + 0+ alpha_ijz) - fct2c(i,j,z)*r(i,j,z);
            temp = min(beta_ijz,1);
            temp = max(temp,0);
            u(i,j,z) = temp;
            
        end
        
        %%%%%%%%%%%%%%%????
        i=1;j=1;z=1;
        alpha_ijz = 0 - pfdx1(i,j,z) - 0 + pfbx1(i,j,z)+ 0 - pfdy1(i,j,z) - 0 + pfby1(i,j,z)+ 0 - pfdz1(i,j,z) - 0 + pfbz1(i,j,z);
        beta_ijz = fct1d*(0 + u(i+1,j,z) + 0 + u(i,j+1,z) + 0 + u(i,j,z+1) + alpha_ijz) - fct2d(i,j,z)*r(i,j,z);
        temp = min(beta_ijz,1);
        temp = max(temp,0);
        u(i,j,z) = temp;
        
        i = 1; j = 1; z = Z;
        alpha_ijz = 0 - pfdx1(i,j,z) - 0 + pfbx1(i,j,z) + 0 - pfdy1(i,j,z) - 0+ pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
        beta_ijz = fct1d*(0 + u(i+1,j,z) + 0 + u(i,j+1,z) + u(i,j,z-1) + 0+ alpha_ijz) - fct2d(i,j,z)*r(i,j,z);
        temp = min(beta_ijz,1);
        temp = max(temp,0);
        u(i,j,z) = temp;
        
        i=1;j=Wide;z=1;
        alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ 0 - pfdy1(i,j,z) - 0 + pfby1(i,j,z)+ 0 - pfdz1(i,j,z) - 0 + pfbz1(i,j,z);
        beta_ijz = fct1d*(0 + u(i+1,j,z) + u(i,j-1,z) + 0 + 0 + u(i,j,z+1)+ alpha_ijz) - fct2d(i,j,z)*r(i,j,z);
        temp = min(beta_ijz,1);
        temp = max(temp,0);
        u(i,j,z) = temp;
        
        i=1;j=Wide;z = Z;
        alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ 0 - pfdy1(i,j,z) - 0 + pfby1(i,j,z) + pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
        beta_ijz = fct1d*(0 + u(i+1,j,z) + u(i,j-1,z) +0 + u(i,j,z-1) + 0 + alpha_ijz) - fct2d(i,j,z)*r(i,j,z);
        temp = min(beta_ijz,1);
        temp = max(temp,0);
        u(i,j,z) = temp;
        
        i = Height; j = 1;z=1;
        alpha_ijz = 0 - pfdx1(i,j,z) -0 + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ 0 - pfdz1(i,j,z) - 0 + pfbz1(i,j,z);
        beta_ijz = fct1d*(u(i-1,j,z) + 0 + 0 + u(i,j+1,z) + 0 + u(i,j,z+1) + alpha_ijz) - fct2d(i,j,z)*r(i,j,z);
        temp = min(beta_ijz,1);
        temp = max(temp,0);
        u(i,j,z) = temp;
        
        i=Height;j=1;z=Z;
        alpha_ijz = 0 - pfdx1(i,j,z) - 0 + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
        beta_ijz = fct1d*(u(i-1,j,z) + 0 + 0 + u(i,j+1,z) + u(i,j,z-1) + 0+ alpha_ijz) - fct2d(i,j,z)*r(i,j,z);
        temp = min(beta_ijz,1);
        temp = max(temp,0);
        u(i,j,z) = temp;
        
        i = Height;j=Wide;z=1;
        alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ 0 - pfdz1(i,j,z) - 0 + pfbz1(i,j,z);
        beta_ijz = fct1d*(u(i-1,j,z) + 0 + u(i,j-1,z) + 0 + 0+ u(i,j,z+1) + alpha_ijz) - fct2d(i,j,z)*r(i,j,z);
        temp = min(beta_ijz,1);
        temp = max(temp,0);
        u(i,j,z) = temp;
        
        i = Height;j=Wide;z=Z;
        alpha_ijz = pfdx1(i,j-1,z) - pfdx1(i,j,z) - pfbx1(i,j-1,z) + pfbx1(i,j,z)+ pfdy1(i-1,j,z) - pfdy1(i,j,z) - pfby1(i-1,j,z) + pfby1(i,j,z)+ pfdz1(i,j,z-1) - pfdz1(i,j,z) - pfbz1(i,j,z-1) + pfbz1(i,j,z);
        beta_ijz = fct1d*(u(i-1,j,z) + 0 + u(i,j-1,z) + 0 + u(i,j,z-1) + 0 + alpha_ijz) - fct2d(i,j,z)*r(i,j,z);
        temp = min(beta_ijz,1);
        temp = max(temp,0);
        u(i,j,z) = temp;
        
        
        iGS = iGS+1;
        
    end
    %     iGS
    
    % Compute d^{k+1} (Soft-Thresholding) and b^{k+1} (Bregman
    % function)
    % d^k+1 = arg min int g_b |d| + mu/2 |d - grad u - b^k|^2
    % d^k+1 = (grad u^k+1 + b^k)/ |grad u^k+1 + b^k| max(|grad u^k+1 +
    % b^k|-1/mu,0)
    % b^k+1 = b^k + grad u^k+1 - d^k+1
    % Center */
    
    
    for i = 1:Height-1
        for j = 1:Wide-1
            for z = 1:Z-1
                f1 = pfbx1(i,j,z) + u(i,j+1,z) - u(i,j,z);
                f2 = pfby1(i,j,z) + u(i+1,j,z) - u(i,j,z);
                f3 = pfbz1(i,j,z) + u(i,j,z+1) - u(i,j,z);
                temp = sqrt(f1*f1 + f2*f2 + f3*f3);
                if(temp < 1/mu)
                    pfdx1(i,j,z) = 0;
                    pfdy1(i,j,z) = 0;
                    pfdz1(i,j,z) = 0;
                else
                    pfdx1(i,j,z) = (temp - 1/mu)*f1/temp;
                    pfdy1(i,j,z) = (temp - 1/mu)*f2/temp;
                    pfdz1(i,j,z) = (temp - 1/mu)*f3/temp;
                end
                pfbx1(i,j,z) = pfbx1(i,j,z) + u(i,j+1,z) - u(i,j,z) - pfdx1(i,j,z);
                pfby1(i,j,z) = pfby1(i,j,z) + u(i+1,j,z) - u(i,j,z) - pfdy1(i,j,z);
                pfbz1(i,j,z) = pfbz1(i,j,z) + u(i,j,z+1) - u(i,j,z) - pfdz1(i,j,z);
            end
        end
    end
    
    %??
    i = Height;
    for j = 1:Wide-1
        for z = 1:Z-1
            f1 = pfbx1(i,j,z) + u(i,j+1,z) - u(i,j,z);
            f2 = pfby1(i,j,z) + 0;
            f3 = pfbz1(i,j,z) + u(i,j,z+1) - u(i,j,z);
            temp = sqrt(f1*f1 + f2*f2 + f3*f3);
            if(temp < 1/mu)
                pfdx1(i,j,z) = 0;
                pfdy1(i,j,z) = 0;
                pfdz1(i,j,z) = 0;
            else
                pfdx1(i,j,z) = (temp - 1/mu)*f1/temp;
                pfdy1(i,j,z) = (temp - 1/mu)*f2/temp;
                pfdz1(i,j,z) = (temp - 1/mu)*f3/temp;
            end
            pfbx1(i,j,z) = pfbx1(i,j,z) + u(i,j+1,z) - u(i,j,z) - pfdx1(i,j,z);
            pfby1(i,j,z) = pfby1(i,j,z) + 0 - pfdy1(i,j,z);
            pfbz1(i,j,z) = pfbz1(i,j,z) + u(i,j,z+1) - u(i,j,z) - pfdz1(i,j,z);
        end
    end
    
    j = Wide;
    for i = 1:Height-1
        for z = 1:Z-1
            f1 = pfbx1(i,j,z) + 0;
            f2 = pfby1(i,j,z) + u(i+1,j,z) - u(i,j,z);
            f3 = pfbz1(i,j,z) + u(i,j,z+1) - u(i,j,z);
            temp = sqrt(f1*f1 + f2*f2 + f3*f3);
            if(temp < 1/mu)
                pfdx1(i,j,z) = 0;
                pfdy1(i,j,z) = 0;
                pfdz1(i,j,z) = 0;
            else
                pfdx1(i,j,z) = (temp - 1/mu)*f1/temp;
                pfdy1(i,j,z) = (temp - 1/mu)*f2/temp;
                pfdz1(i,j,z) = (temp - 1/mu)*f3/temp;
            end
            pfbx1(i,j,z) = pfbx1(i,j,z) + 0 - pfdx1(i,j,z);
            pfby1(i,j,z) = pfby1(i,j,z) + u(i+1,j,z) - u(i,j,z) - pfdy1(i,j,z);
            pfbz1(i,j,z) = pfbz1(i,j,z) + u(i,j,z+1) - u(i,j,z) - pfdz1(i,j,z);
        end
    end
    
    z = Z;
    for i = 1:Height-1
        for j = 1:Wide-1
            f1 = pfbx1(i,j,z) + u(i,j+1,z) - u(i,j,z);
            f2 = pfby1(i,j,z) + u(i+1,j,z) - u(i,j,z);
            f3 = pfbz1(i,j,z) + 0;
            temp = sqrt(f1*f1 + f2*f2 + f3*f3);
            if(temp < 1/mu)
                pfdx1(i,j,z) = 0;
                pfdy1(i,j,z) = 0;
                pfdz1(i,j,z) = 0;
            else
                pfdx1(i,j,z) = (temp - 1/mu)*f1/temp;
                pfdy1(i,j,z) = (temp - 1/mu)*f2/temp;
                pfdz1(i,j,z) = (temp - 1/mu)*f3/temp;
            end
            pfbx1(i,j,z) = pfbx1(i,j,z) + u(i,j+1,z) - u(i,j,z) - pfdx1(i,j,z);
            pfby1(i,j,z) = pfby1(i,j,z) + u(i+1,j,z) - u(i,j,z) - pfdy1(i,j,z);
            pfbz1(i,j,z) = pfbz1(i,j,z) + 0 - pfdz1(i,j,z);
        end
    end
    
    %%%??
    i = Height;
    j = Wide;
    for z = 1:Z-1
        f1 = pfbx1(i,j,z) + 0;
        f2 = pfby1(i,j,z) + 0;
        f3 = pfbz1(i,j,z) + u(i,j,z+1) - u(i,j,z);
        temp = sqrt(f1*f1 + f2*f2 + f3*f3);
        if(temp < 1/mu)
            pfdx1(i,j,z) = 0;
            pfdy1(i,j,z) = 0;
            pfdz1(i,j,z) = 0;
        else
            pfdx1(i,j,z) = (temp - 1/mu)*f1/temp;
            pfdy1(i,j,z) = (temp - 1/mu)*f2/temp;
            pfdz1(i,j,z) = (temp - 1/mu)*f3/temp;
        end
        pfbx1(i,j,z) = pfbx1(i,j,z) + 0 - pfdx1(i,j,z);
        pfby1(i,j,z) = pfby1(i,j,z) + 0 - pfdy1(i,j,z);
        pfbz1(i,j,z) = pfbz1(i,j,z) + u(i,j,z+1) - u(i,j,z) - pfdz1(i,j,z);
    end
    
    
    j = Wide;
    z= Z;
    for i = 1:Height-1
        f1 = pfbx1(i,j,z) + 0;
        f2 = pfby1(i,j,z) + u(i+1,j,z) - u(i,j,z);
        f3 = pfbz1(i,j,z) + 0;
        temp = sqrt(f1*f1 + f2*f2 + f3*f3);
        if(temp < 1/mu)
            pfdx1(i,j,z) = 0;
            pfdy1(i,j,z) = 0;
            pfdz1(i,j,z) = 0;
        else
            pfdx1(i,j,z) = (temp - 1/mu)*f1/temp;
            pfdy1(i,j,z) = (temp - 1/mu)*f2/temp;
            pfdz1(i,j,z) = (temp - 1/mu)*f3/temp;
        end
        pfbx1(i,j,z) = pfbx1(i,j,z) + 0 - pfdx1(i,j,z);
        pfby1(i,j,z) = pfby1(i,j,z) + u(i+1,j,z) - u(i,j,z) - pfdy1(i,j,z);
        pfbz1(i,j,z) = pfbz1(i,j,z) + 0 - pfdz1(i,j,z);
    end
    
    
    z = Z;
    i = Height;
    for j = 1:Wide-1
        f1 = pfbx1(i,j,z) + u(i,j+1,z) - u(i,j,z);
        f2 = pfby1(i,j,z) + 0;
        f3 = pfbz1(i,j,z) + 0;
        temp = sqrt(f1*f1 + f2*f2 + f3*f3);
        if(temp < 1/mu)
            pfdx1(i,j,z) = 0;
            pfdy1(i,j,z) = 0;
            pfdz1(i,j,z) = 0;
        else
            pfdx1(i,j,z) = (temp - 1/mu)*f1/temp;
            pfdy1(i,j,z) = (temp - 1/mu)*f2/temp;
            pfdz1(i,j,z) = (temp - 1/mu)*f3/temp;
        end
        pfbx1(i,j,z) = pfbx1(i,j,z) + u(i,j+1,z) - u(i,j,z) - pfdx1(i,j,z);
        pfby1(i,j,z) = pfby1(i,j,z) + 0 - pfdy1(i,j,z);
        pfbz1(i,j,z) = pfbz1(i,j,z) + 0 - pfdz1(i,j,z);
    end
    
    
    %%%%%????????
    z = Z;
    i = Height;
    j = Wide;
    f1 = pfbx1(i,j,z) + 0;
    f2 = pfby1(i,j,z) + 0;
    f3 = pfbz1(i,j,z) + 0;
    temp = sqrt(f1*f1 + f2*f2 + f3*f3);
    if(temp < 1/mu)
        pfdx1(i,j,z) = 0;
        pfdy1(i,j,z) = 0;
        pfdz1(i,j,z) = 0;
    else
        pfdx1(i,j,z) = (temp - 1/mu)*f1/temp;
        pfdy1(i,j,z) = (temp - 1/mu)*f2/temp;
        pfdz1(i,j,z) = (temp - 1/mu)*f3/temp;
    end
    pfbx1(i,j,z) = pfbx1(i,j,z) + 0 - pfdx1(i,j,z);
    pfby1(i,j,z) = pfby1(i,j,z) + 0 - pfdy1(i,j,z);
    pfbz1(i,j,z) = pfbz1(i,j,z) + 0 - pfdz1(i,j,z);
    
    t = t +  cputime -t0;
    save pf1 pfdx1 pfdy1 pfdz1 pfbx1 pfby1 pfbz1
    clear pfdx1; clear pfdy1;clear pfdz1; clear pfbx1; clear  pfby1; clear  pfbz1
    
     iNI = iNI+1;
     
%     if(mod(iNI,1) ==0)
%       subplot(121),imshow(Img(:,:,slice),[]),title(num2str(iNI));  
%      hold on,contour(u(:,:,slice),[0.5 0.5],'r');hold off;
%     subplot(122),imshow(u(:,:,slice),[]),title('fuzzy segmentation');
%     pause(0.1)
%     end
    
end
end