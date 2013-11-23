function [rnorm] = rowNorm(a)
% Takes the norm of each row 
   rnorm = sqrt(sum(abs(a).^2,2));
end
