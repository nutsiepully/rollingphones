
O = 561;        % Number of coefficients in a vector 
M = 2;          % Number of mixtures 
Q = 6;          % Number of states 

% num of sequences - per person
% length of each vector - per sequence

% initial guess of parameters
prior = normalise(rand(Q,1));
transmat = mk_stochastic(rand(Q,Q));

cov_type = 'full';
[mu, Sigma] = mixgauss_init(Q*M, Xtrain', cov_type);
mu = reshape(mu, [O Q M]);
Sigma = reshape(Sigma, [O O Q M]);
mixmat = mk_stochastic(rand(Q,M));

[LL, prior, transmat, mu, Sigma, mixmat] = ...
    mhmm_em(Xtrain', prior, transmat, mu, Sigma, mixmat, 'max_iter', 10);

% % for each person, there is one sequence of data
% for i = 1:size(subject_train, 1)
%     fprintf('Training on subject %d\n', i);
%     subj_inds = find(subject_train == i);
%     
%     if (length(subj_inds) <= 0)
%         continue
%     end
%     
%     Xtrain_subj = Xtrain(subj_inds, :);
%     Ytrain_subj = Ytrain(subj_inds, :);
% 
%     % create data out of Xtrain_subj and Ytrain_subj
%     data = Xtrain_subj';
% 
%     % train over this subjects data.
%     [LL, prior, transmat, mu, Sigma, mixmat] = ...
%         mhmm_em(data, prior, transmat, mu, Sigma, mixmat, 'max_iter', 10);
% end

% predict data using the built model.
loglik = mhmm_logprob(data, prior, transmat, mu, Sigma, mixmat);

B = mixgauss_prob(Xtest', mu, Sigma, mixmat);
[path] = viterbi_path(prior, transmat, B);