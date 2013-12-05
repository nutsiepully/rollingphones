
Q = 6;          % Number of states 

Xtrain_ = Xtrain;
Ytrain_ = Ytrain;
Xtest_ = Xtest;
Ytest_ = Ytest;

% rand_inds = randperm(size(Xtrain,1));
% Xtrain_ = Xtrain(rand_inds, :);
% Ytrain_ = Ytrain(rand_inds, :);
% Xtrain_ = Xtrain_(:, 1:100);
% 
% rand_inds = randperm(size(Xtest,1));
% Xtest_ = Xtest(rand_inds, :);
% Ytest_ = Ytest(rand_inds, :);
% Xtest_ = Xtest_(:, 1:100);

%train
prior = normalise(rand(Q,1));
[ initState, transmat, mu, sigma ] = gausshmm_train_observed(Xtrain_', Ytrain_', Q);

% predict
B = mixgauss_prob(Xtest_', mu, sigma, ones(Q, 1));
[path] = viterbi_path(prior, transmat, B);

% verify
res = (path' == Ytest_);
display(length(find(res == 1)) / length(Ytest_) * 100);

c_correct = 0;
y_pred = [];
for i = 1:20:size(Xtest, 1)
    endi = i + 19;
    if i + 19 > size(Xtest, 1)
        endi = size(Xtest, 1);
    end
    %endi = i;
    
    B = mixgauss_prob(Xtest_(i:endi, :)', mu, sigma, ones(Q, 1));
    [path] = viterbi_path(prior, transmat, B);    
    y_pred = [ y_pred path ];

    res = (path' == Ytest_(i:endi));
    c_correct = c_correct + length(find(res == 1));

    % fprintf('Accuracy for %d is : %0.2f\n', [ i, (length(find(res == 1)) / length(res) * 100) ]);
end
y_pred = y_pred';

display(c_correct);
display(c_correct / size(Xtest, 1));
