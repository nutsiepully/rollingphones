function [ accuracy ] = getAccuracy( yPredict, yActual )
    res_bools = (yPredict == yActual);

    total = length(yActual);
    correct = length(find(res_bools == 1));
    
    accuracy = correct / total * 100;
end
