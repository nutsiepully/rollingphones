function [ret] = sma(x, y, z)
%Signal magnitude area

    if nargin == 1
        ret = mean(abs(x), 2);
        return
    end

    ret = mean(abs(x) + abs(y) + abs(z), 2);
end
