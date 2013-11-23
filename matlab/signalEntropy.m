function [ret] = signalEntropy(x)
%Returns the entropy of a signal
   hisP = hist(x', 25)';
   numrows = size(hisP,1);
   hisP(~hisP) = 1;
   hisP = spdiags(1./sum(hisP,2),0,numrows,numrows)*hisP;
   ret = -sum(hisP.*log2(hisP) ,2);
end
