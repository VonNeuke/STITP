 function printf(str, varargin)
%function printf(str, varargin)
% shorthand for disp(sprintf())
% Jeff Fessler
disp(sprintf(str, varargin{:}))
