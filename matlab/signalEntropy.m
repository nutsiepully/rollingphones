function [ret] = signalEntropy(x)
   C = num2cell(x,2);
   ret = cellfun(@entropy, C, 'UniformOutput', false);
   ret = cell2mat(ret);
end
