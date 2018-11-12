function [cost, grad] = softmaxCost(theta, numClasses, inputSize, lambda, data, labels)

% numClasses - the number of classes 
% inputSize - the size N of the input vector
% lambda - weight decay parameter
% data - the N x M input matrix, where each column data(:, i) corresponds to
%        a single test set
% labels - an M x 1 matrix containing the labels corresponding for the input data
%

% Unroll the parameters from theta
theta = reshape(theta, 1, inputSize);

numCases = size(data, 1);
labels(labels==2)=0;
%这个函数就是建立矩阵，以labels为横坐标，1:numCases为纵坐标的位置值为1，其他位置值为0.
% 矩阵为M*N，M = max(labels); N = numCases
% groundTruth = full(sparse(labels, 1:numCases, 1));
cost = 0;

thetagrad = zeros(numClasses, inputSize);

%% ---------- YOUR CODE HERE --------------------------------------
%  Instructions: Compute the cost and gradient for softmax regression.
%                You need to compute thetagrad and cost.
%                The groundTruth matrix might come in handy.
% denom = 0;
% for i = 1 : numClasses
%     denom = denom + exp(theta(i,:)*data(:,j));
% end
% 
% % cost = (1. / m) * sum()
% [j, i] = find(groundTruth~=0);

% cost = -(1. / m) * (groundTruth*log(exp(theta*data)./))

% m = size(data, 2);
% k = numClasses;
% r = zeros(size(groundTruth));
% for i = 1 : m
%     for j = 1 : k
%         p = exp(theta(j,:) * data(:,i)) / sum(exp(theta*data(:,i)));
%         r(j, i) = groundTruth(j, i) .* log(p);
%     end
% end
% 
z=theta*data;
g = zeros(size(z));
num=size(z);
for i=1:num(:,1)
    for j=1:num(:,2)
        g(i,j)=1/(1+exp(-z(i,j)));
    end
end

h=g;


t = theta(1,2:length(theta));
S = labels.*log(h)+(1-labels).*log(1-h);
cost = (-1/numCases)*sum(S(:))+(lambda/(2))*sum(t.^2);
grad_1 = (1/numCases)*((h-labels)'*data)';
grad_2 = (1/numCases)*((h-labels)'*data)'+(lambda/2)*theta;
grad = [grad_1(1,1);grad_2(2:length(theta),1)];



% % cost = sum(sum(r));
% 
% M = theta * data;
% M = bsxfun(@minus, M, max(M, [], 1));
% % p = exp(theta*data) ./ repmat(sum(exp(theta*data)), numClasses, 1);
% p = exp(M) ./ repmat(sum(exp(M)), numClasses, 1);
% cost = -(1. / numCases) * sum(sum(groundTruth .* log(p))) + (lambda / 2.) * sum(sum(theta.^2));
% thetagrad = -(1. / numCases) * (groundTruth - p) * data' + lambda * theta;

%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
% m = length(y); % number of training examples
% 
% % You need to return the following variables correctly 
% J = 0;
% grad = zeros(size(theta));
% 
% % ====================== YOUR CODE HERE ======================
% % Instructions: Compute the cost of a particular choice of theta.
% %               You should set J to the cost.
% %               Compute the partial derivatives and set grad to the partial
% %               derivatives of the cost w.r.t. each parameter in theta
% h = sigmoid(X*theta);
% t = theta(2:length(theta),1);
% S = y.*log(h)+(1-y).*log(1-h);
% J = (-1/m)*sum(S(:))+(lambda/(2*m))*sum(t.^2);
% grad_1 = (1/m)*((h-y)'*X)';
% grad_2 = (1/m)*((h-y)'*X)'+(lambda/m)*theta;
% grad = [grad_1(1,1);grad_2(2:length(theta),1)];

% =============================================================




% ------------------------------------------------------------------
% Unroll the gradient matrices into a vector for minFunc
% grad = [thetagrad(:)];
end

