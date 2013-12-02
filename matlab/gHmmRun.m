
[ initState, transmat, mu, sigma ] = gausshmm_train_observed(Xtrain', Ytrain', 6);

B = mixgauss_prob(Xtest', mu, sigma, ones(6, 1));

[path] = viterbi_path(prior, transmat, B);

res = (path' == Ytest);

display(length(res == 1) / length(Ytest) * 100);
