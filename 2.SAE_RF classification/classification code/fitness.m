function result=fitness(saeOptTheta,hiddenSizeL1,inputSize,hiddenSizeL2,data,labels)
% Initialize the stack using the parameters learned
result = {};
saeOptTheta=saeOptTheta';
num=size(saeOptTheta,1);
stack = cell(2,1);
%其中的saelOptTheta和sae1ptTheta都是包含了sparse autoencoder的重建层网络权值的
stack{1}.w = reshape(saeOptTheta(1:hiddenSizeL1*inputSize), ...
                     hiddenSizeL1, inputSize);
stack{1}.b = saeOptTheta(2*hiddenSizeL1*inputSize+1:2*hiddenSizeL1*inputSize+hiddenSizeL1);
num1=2*hiddenSizeL1*inputSize+inputSize+hiddenSizeL1;
stack{2}.w = reshape(saeOptTheta(num1+1:num1+hiddenSizeL2*hiddenSizeL1), ...
                     hiddenSizeL2, hiddenSizeL1);
stack{2}.b = saeOptTheta(num1+2*hiddenSizeL2*hiddenSizeL1+1:num1+2*hiddenSizeL2*hiddenSizeL1+hiddenSizeL2);

[ndims1, m1] = size(data');
% First hidden layer activiations
W1 = stack{1}.w;
b1 = stack{1}.b;
activation2 = sigmoid(W1 * data' + repmat(b1, 1, m1));

% Second hidden layer activiations
W2 = stack{2}.w;
b2 = stack{2}.b;
activation3 = sigmoid(W2 * activation2 + repmat(b2, 1, size(activation2, 2)));
%%%%%%%%%%%%%%
%调用随机森林
extra_options.classwt = [1 1]; 
extra_options.cutoff = [0.45 0.55];
 ntree=100;%决策树个数
    mtry=30;%特征属性数量个数
    T_train=labels;
    data1=[data activation2'];
 model = classRF_train(data1,T_train,ntree, mtry,extra_options);
% 
result2 = [T_train  model.outcl];

 testlabels=T_train;
 pred=model.outcl;
 
 acc2 = mean(result2(:,1) == result2(:,2))
fprintf('Accuracy: %0.3f%%\n', acc2 * 100);
acc_pos= mean(T_train(find(T_train ==1))== pred(find(T_train==1)));
acc_neg= mean(testlabels(find(testlabels ==2))== pred(find(testlabels==2)));
 fprintf('neg_Accuracy: %0.3f%%\n', acc_neg * 100);
 
 
 TP=sum(testlabels(find(testlabels==1))== pred(find(testlabels==1)));
  FP=sum(testlabels(find(testlabels==2))~= pred(find(testlabels==2)));
  TN=sum(testlabels(find(testlabels==2))== pred(find(testlabels==2)));
  FN=sum(testlabels(find(testlabels==1))~= pred(find(testlabels==1)));
  ConfusionMatrix=[TP,FP;FN,TN]
  
  MCC=(TP*TN-FP*FN)/(sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 BER=sum(model.outcl~=T_train)/size(T_train,1)
  
%     BER=model.errtr(100,1);
%     if err1>BER(times)
%         if  mcc<MCC
%             mcc=MCC;
%         err1=BER;
%         
%         T3=T1;
%         model1=model;
%         end
%     end
% %% 仿真测试
% [T_sim,votes] = classRF_predict(data,model);


% result=1/MCC;
result.acc=1/acc2;
result.MCC=MCC;
result.model=model;