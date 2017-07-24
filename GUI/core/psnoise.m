% psnoise.m
% writer: J. Zhou
% date: 2004.02.05
% ²úÉú²´ËÉÔëÉù
%
function [pe, c] = psnoise(proj, counts);
%
% proj: noiseless projection
% counts: realized photon number, e.g. 10e5
% pe: noisy projection 
% c: detected number of photon
%
proj = proj / (sum(sum(proj)));
%
proj = counts * proj;
%
pe = poissrnd(proj);
% 
c = sum(sum(pe));