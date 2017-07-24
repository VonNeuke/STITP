function [ value ] = dice(seg_image,truth_image,T)
truth_image(truth_image>0) = 1;
seg_image(seg_image>=T) = 1;
seg_image(seg_image<T) = 0;
V_st =  sum(sum(sum(truth_image&seg_image)));
V_s = sum(sum(sum(seg_image)));
V_t = sum(sum(sum(truth_image)));
value = 2*V_st/(V_s + V_t);
end