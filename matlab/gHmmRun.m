
Q = 6;          % Number of states 

%train
prior = normalise(rand(Q,1));
[ initState, transmat, mu, sigma ] = gausshmm_train_observed(Xtrain', Ytrain', Q);

% predict
B = mixgauss_prob(Xtest', mu, sigma, ones(Q, 1));
[path] = viterbi_path(prior, transmat, B);

% verify
res = (path' == Ytest);
display(length(res == 1) / length(Ytest) * 100);
