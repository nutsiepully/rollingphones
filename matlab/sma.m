function [ret] = sma(x,y,z)
%Signal magnitude area
   ret = mean(abs(x)+abs(y)+abs(z), 2);
end
