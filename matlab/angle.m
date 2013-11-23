function [ang] = angle(a,b)
% Angle between two vectors, should be done row by row
ang = acosd(dot(a,b,2)./(rowNorm(a) .* rowNorm(b)));
end
