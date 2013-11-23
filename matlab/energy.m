function [ret] = energy(a)
%Energy measure. Sum of the squares divided by the number of values. 
   ret = mean((a.*a),2);
end
