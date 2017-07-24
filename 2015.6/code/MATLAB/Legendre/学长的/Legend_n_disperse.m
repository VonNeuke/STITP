function [ fp ] =  Legend_n_disperse( n_img,N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%递推法求前N阶legendre多项式组成的矩阵
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

x = linspace(-1,1,n_img);
% i = 1:1:n_img;
% x = 2*i/n_img-1;

p_0 = ones(1,n_img );
p_1 = x;
p_2 = ones(1,n_img ); 
fp = ones(N,n_img);

fp(1,:) = p_0;
fp(2,:) = p_1;

for n = 2:N;
    p_2 = ((2*n-1)*x.*p_1-(n-1)*p_0)/n;
    p_0 = p_1;
    p_1 = p_2;
    
    fp(n+1,:) = p_2;
%     plot(x, fp(n+1,:));
%     hold on
end

end

