function [ret] = mag(x, y, z)
% Returns the matrix that gives the magnitude pointwise
   ret = sqrt(x.^2 + y.^2 + z.^2);
end
