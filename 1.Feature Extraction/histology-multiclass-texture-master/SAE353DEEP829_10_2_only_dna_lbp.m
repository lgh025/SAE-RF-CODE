
% avarage =
% 
%     7.1851
% 
% acc4
% 
% acc4 = 
% 
%           []          []          []          []          []          []          []          []          []          []
%           []          []          []          []          []          []          []          []          []          []
%           []          []          []          []          []          []          []          []          []          []
%           []          []          []          []          []          []          []          []          []          []
%           []          []          []          []          []          []          []          []          []          []
%           []          []          []          []          []          []          []          []          []          []
%           []          []          []          []          []          []          []          []          []          []
%           []          []          []          []          []          []          []          []          []          []
%           []          []          []          []          []          []          []          []          []          []
%     [0.7182]    [0.7149]    [0.7140]    [0.7169]    [0.7228]    [0.7203]    [0.7207]    [0.7211]    [0.7199]    [0.7165]

clear all
clc
close all
tic
DISPLAY = true;
% inputSize =1096;
numClasses = 7;
hiddenSizeL1 = 200;    % Layer 1 Hidden Size
hiddenSizeL2 =200;    % Layer 2 Hidden Size
sparsityParam = 0.1;   % desired average activation of the hidden units.
                       % (This was denoted by the Greek alphabet rho, which looks like a lower-case "p",
                       %  in the lecture notes). 
lambda = 2e-4;         % weight decay parameter       
beta =3;              % weight of sparsity penalty term      
labels1=[];
result2=[];
  result3=[];
currentFolder = pwd;
addpath(genpath(currentFolder))
 load idx_sda.mat
% trainLabels1=struct;
activation222=cell(10,10);
activation333=cell(10,10);
activation444=cell(10,10);
activation555=cell(10,10);
trainLabels1=cell(10,10);
 testLabels11=cell(10,10);
 number10=cell(10,10);
 pred1=cell(10,10);
ACC2=cell(10,10); 
acc4=cell(10,10);
 DATA=cell(10,1); 
load db821.mat db10
load db_label821.mat db_label10
  data1= db10{1};
% load db10.mat db10
%  load db_label10.mat db_label10
%  for ii=1:10
%      DATA{ii}=db10{10}(353*(ii-1)+1:353*ii,2:end);
%      DATA{ii}=[ DATA{ii}(:,1:4) DATA{ii}(:,841:end) data1(:,1:11) data1(:,50:end)];
% 
%  end
%  Xdata= [data1(:,1:36) data1(:,38:41) data1(:,878:end)];
%    Xdata= [data1(:,1:36) data1(:,75:254) data1(:,256:259) data1(:,1096:end)];
  Xdata= [ data1(:,112:115) data1(:,952:end)];
%   Xdata= [ data1(:,1:110) data1(:,112:115) data1(:,952:end)];
%  Xdata= [ data1(:,75:254) data1(:,256:259) data1(:,1096:end)];
 label_all=db_label10{1};
 aa=0;
%  labels0=[]; labels01=[]; l1=[];l2=[];l3=[];l4=[];l5=[];l6=[];
% 
%      for i1=1:size(label_all,1)
%        
%               if label_all(i1)==1
%               label1=label_all(i1);
%               label00=[1 0 0 0 0 0]';
%               l1=[l1;i1];
%               end
%                if label_all(i1)==2
%               label1=label_all(i1);
%               label00=[0 1 0 0 0 0]'
%               l2=[l2;i1];
%                end;
%                if label_all(i1)==3
%               label1=label_all(i1);
%               label00=[0 0 1 0 0 0]'
%               l3=[l3;i1];
%                end;
%                if label_all(i1)==5
%               label1=4;
%               label00=[0 0 0 1 0 0]';
%               l4=[l4;i1];
%                end
%               if label_all(i1)==6
%               label1=5;
%               label00=[0 0 0 0 1 0]';
%               l5=[l5;i1];
%               end
%               if label_all(i1)==7
%               label1=6;
%               label00=[0 0 0 0 0 1]';
%               l6=[l6;i1];
%               end
%     
%      labels0=[labels0  label00];         
%      labels01=[labels01;  label1];           
%      end  
%       save labels_all353 labels0
%         save labels_all353 labels01       
 
 
 
%   order1=size(labels01(labels01==1),1)  %50   25/25 
%  order2=size(labels01(labels01==2),1)  %49     25/24
%  order3=size(labels01(labels01==3),1)  %51      25/26
%  order4=size(labels01(labels01==4),1)  %49      25/24
%  order5=size(labels01(labels01==5),1)  %102      51/51
%  order6=size(labels01(labels01==6),1)  %52        26/26
% size(labels01(labels01==7))  %52
for j=1:10
    result2=[];
% number1=randperm(order1);
% number2=randperm(order2);
% number3=randperm(order3);
% number4=randperm(order4);
% number5=randperm(order5);
% number6=randperm(order6);
% 
% 
% 
% 
% 
% % tr_select1=[l1(1:25);l2(1:25);l3(1:25);l4(1:25);l5(1:51);l6(1:26)];
% % te_select1=[l1(26:end);l2(26:end);l3(26:end);l4(26:end);l5(52:end);l6(27:end)];
% tr_select1=[l1(number1(1:25));l2(number2(1:25));l3(number3(1:25));l4(number4(1:25));l5(number5(1:51));l6(number6(1:26))];
% te_select1=[l1(number1(26:end));l2(number2(26:end));l3(number3(26:end));l4(number4(26:end));l5(number5(52:end));l6(number6(27:end))];
number=randperm(size(label_all,1))
number10{j,1}=number;
% load tr_select1 tr_select1
% load te_select1 te_select1
% load idx_sda1 idx_sda

for i=1:10
      fileName=strcat(num2str(i),'.mat');
      load(fileName);
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     writePath = ['idx_sdaPath'];
  logname = ['./' writePath '/' strcat('idx_sda',num2str(i))];
  if ~exist(logname,'dir')
        mkdir(logname);
  end
    
%  idx_sda=A{i}{j}
%         temp_result_multi_kernel_structure=0;
%         temp_result_multi_kernel_forest=0;
%         temp_result_multi_kernel=0;
%         [trainSet,testSet]=jb_kfold(labels,5,j);
% train_x = Xdata(tr_select1,:);
% test_x = Xdata(te_select1,:);
% train_y =labels01(tr_select1,:);
% test_y =labels01(te_select1,:);
 if i~=10
    
train_x = [Xdata(number(1:241*(i-1)),:); Xdata(number(241*i+1:end),:)];
test_x = Xdata(number(241*(i-1)+1:241*i),:);
train_y =[label_all(number(1:241*(i-1)),:)  ; label_all(number(241*i+1:end),:)];
test_y =label_all(number(241*(i-1)+1:241*i),:);
 end
if i==10
    
train_x = Xdata(number(1:241*(i-1)),:);
test_x = Xdata(number(241*(i-1)+1:end),:);
train_y =label_all(number(1:241*(i-1)),:);
test_y =label_all(number(241*(i-1)+1:end),:);
end
        trainLabels=train_y;
        testLabels=test_y;
        traindata=train_x;
        testdata=test_x;
        trainLabels1{i,j}=trainLabels;
         testLabels11{i,j}=testLabels;
%  save trainLabels11 trainLabels1
%  save testLabels11 testLabels1
        [train_data,test_data] = featnorm(traindata,testdata);
        train_data = double(train_data*2-1);
        test_data = double(test_data*2-1);
        
        trainData = train_data;
     trainLabels =trainLabels;
%  trainX=[trainData;pdb_feature(1:19400,:)];
%  trainX=[trainData];
%      testData1 = test_data;%测试集数据
    testLabels1 =  testLabels;%测试集标签  
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%尝试产生SDA
 target= trainLabels;
  %SDA: stepwise discriminant analysis
% idx_sda = sda2(train_data,target,logname)   
%   idx_sda = sda2([train_data;train_data],[target;target],logname)   
     trainData=train_data;            %trainSet
%       trainData=train_data;  
      trainX=[trainData];
      testData = test_data;            %testSet
      testData1 = testData;            %testSet
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   inputSize =size(trainX,2); 
    
    
    
    sae1Theta = initializeParameters(hiddenSizeL1, inputSize);

%% ---------------------- YOUR CODE HERE  ---------------------------------
%  Instructions: Train the first layer sparse autoencoder, this layer has
%                an hidden size of "hiddenSizeL1"
%                You should store the optimal parameters in sae1OptTheta
addpath minFunc/;
options = struct;
options.Method = 'lbfgs';
options.maxIter = 200;
options.display = 'on';
[sae1OptTheta, cost] =  minFunc(@(p)sparseAutoencoderCost(p,...
    inputSize,hiddenSizeL1,lambda,sparsityParam,beta, trainX),sae1Theta,options);%训练出第一层网络的参数
% save('saves/step2.mat', 'sae1OptTheta');

if DISPLAY
  W1 = reshape(sae1OptTheta(1:hiddenSizeL1 * inputSize), hiddenSizeL1, inputSize);
%   display_network(W1');
end
% -------------------------------------------------------------------------

%%======================================================================
%% STEP 2: Train the second sparse autoencoder
%  This trains the second sparse autoencoder on the first autoencoder
%  featurse.
%  If you've correctly implemented sparseAutoencoderCost.m, you don't need
%  to change anything here.

[sae1Features] = feedForwardAutoencoder(sae1OptTheta, hiddenSizeL1, ...
                                        inputSize, trainData);

%  Randomly initialize the parameters
sae2Theta = initializeParameters(hiddenSizeL2, hiddenSizeL1);

%% ---------------------- YOUR CODE HERE  ---------------------------------
%  Instructions: Train the second layer sparse autoencoder, this layer has
%                an hidden size of "hiddenSizeL2" and an inputsize of
%                "hiddenSizeL1"
%
%                You should store the optimal parameters in sae2OptTheta

[sae2OptTheta, cost] =  minFunc(@(p)sparseAutoencoderCost4(p,...
    hiddenSizeL1,hiddenSizeL2,lambda,sparsityParam,beta,sae1Features),sae2Theta,options);%训练出第一层网络的参数
% save('saves/step3.mat', 'sae2OptTheta');

% figure;
if DISPLAY
  W11 = reshape(sae1OptTheta(1:hiddenSizeL1 * inputSize), hiddenSizeL1, inputSize);
  W12 = reshape(sae2OptTheta(1:hiddenSizeL2 * hiddenSizeL1), hiddenSizeL2, hiddenSizeL1);
  % TODO(zellyn): figure out how to display a 2-level network
%  display_network(log(W11' ./ (1-W11')) * W12');
%   W12_temp = W12(1:196,1:196);
%   display_network(W12_temp');
%   figure;
%   display_network(W12_temp');
end
% -------------------------------------------------------------------------

%%======================================================================
%% STEP 3: Train the softmax classifier
%  This trains the sparse autoencoder on the second autoencoder features.
%  If you've correctly implemented softmaxCost.m, you don't need
%  to change anything here.

[sae2Features] = feedForwardAutoencoder4(sae2OptTheta, hiddenSizeL2, ...
                                        hiddenSizeL1, sae1Features);
% x21=sae2Features(:,1:m1); 
% 
% x22=sae2Features(:,m1+1:end);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x11=sae1Features(:,1:m1) ;
% x12=sae1Features(:,m1+1:end);  
% save GPCRsae2Features150  sae2Features
% save GPCRsae1Features250  sae1Features
% save GPCRlabel  T_train
           
                                    
 %%%%%%%%% %从这儿开始要自己来建立自己的分类器%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%  Randomly initialize the parameters
saeSoftmaxTheta = 0.005 * randn(hiddenSizeL2 * numClasses, 1);


%% ---------------------- YOUR CODE HERE  ---------------------------------
%  Instructions: Train the softmax classifier, the classifier takes in
%                input of dimension "hiddenSizeL2" corresponding to the
%                hidden layer size of the 2nd layer.
%
%                You should store the optimal parameters in saeSoftmaxOptTheta 
%
%  NOTE: If you used softmaxTrain to complete this part of the exercise,
%        set saeSoftmaxOptTheta = softmaxModel.optTheta(:);

softmaxLambda = 2e-5;
numClasses = 7;
softoptions = struct;
softoptions.maxIter =200;
softmaxModel = softmaxTrain(hiddenSizeL2,numClasses,softmaxLambda,...
                            sae2Features,trainLabels,softoptions);
saeSoftmaxOptTheta = softmaxModel.optTheta(:);

% save('saves/step4.mat', 'saeSoftmaxOptTheta');
% -------------------------------------------------------------------------

%%======================================================================
%% STEP 5: Finetune softmax model

% Implement the stackedAECost to give the combined cost of the whole model
% then run this cell.

% Initialize the stack using the parameters learned
stack = cell(2,1);
%其中的saelOptTheta和sae1ptTheta都是包含了sparse autoencoder的重建层网络权值的
stack{1}.w = reshape(sae1OptTheta(1:hiddenSizeL1*inputSize), ...
                     hiddenSizeL1, inputSize);
stack{1}.b = sae1OptTheta(2*hiddenSizeL1*inputSize+1:2*hiddenSizeL1*inputSize+hiddenSizeL1);
stack{2}.w = reshape(sae2OptTheta(1:hiddenSizeL2*hiddenSizeL1), ...
                     hiddenSizeL2, hiddenSizeL1);
stack{2}.b = sae2OptTheta(2*hiddenSizeL2*hiddenSizeL1+1:2*hiddenSizeL2*hiddenSizeL1+hiddenSizeL2);

% Initialize the parameters for the deep model
[stackparams, netconfig] = stack2params(stack);
stackedAETheta = [ saeSoftmaxOptTheta ; stackparams ];%stackedAETheta是个向量，为整个网络的参数，包括分类器那部分，且分类器那部分的参数放前面

%% ---------------------- YOUR CODE HERE  ---------------------------------
%  Instructions: Train the deep network, hidden size here refers to the '
%                dimension of the input to the classifier, which corresponds 
%                to "hiddenSizeL2".
%
%

[stackedAEOptTheta, cost] =  minFunc(@(p)stackedAECost(p,inputSize,hiddenSizeL2,...
                         numClasses, netconfig,lambda, trainData, trainLabels),...
                        stackedAETheta,options);%训练出第一层网络的参数
% save('saves/step5.mat', 'stackedAEOptTheta');

toc
stackedTEST=struct;
stackedTEST.stackedAETheta=stackedAETheta;
stackedTEST.stackedAEOptTheta=stackedAEOptTheta;
stackedTEST.inputSize=inputSize;
stackedTEST.hiddenSizeL2=hiddenSizeL2;
stackedTEST.numClasses=numClasses;
stackedTEST.netconfig=netconfig;
% save(['G:\DPparameter186_2\', name1,'_stackedTEST'], 'stackedTEST') %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%保存深度学习参数%%%%%%%%%%%%%%%%%%%%%%%%
% save stackedTEST stackedTEST
% save sae1Features11 x11
% save sae1Features12 x12
%            save sae2Features21 x21
%            save sae2Features22 x22
[p0,pred0,activation22,activation33] = stackedAEPredict333(stackedAEOptTheta, inputSize, hiddenSizeL2, ...
                          numClasses, netconfig, trainData);
%                       activation222{i,j}=activation22;
%                        activation333{i,j}=activation33;
%                      save activation201602train22 activation22
%                        save activation201602train33 activation33
acc0 = mean(trainLabels == pred0')
%%%%%%测试%%%%%%%%%%%%%%%%%%%%%%%%
[pred2] = stackedAEPredict(stackedAETheta, inputSize, hiddenSizeL2, ...
                          numClasses, netconfig, testData1);
pred=pred2';
acc1 = mean(testLabels == pred);
fprintf('Before Finetuning Test Accuracy: %0.3f%%\n', acc1 * 100);
% save pred1.txt pred -ascii -append
% save acc1.txt acc1 -ascii -append
[p,pred,activation44,activation55] = stackedAEPredict333(stackedAEOptTheta, inputSize, hiddenSizeL2, ...
                          numClasses, netconfig, testData1);
%            save sae1Features sae1Features
%            save sae2Features sae2Features
%            save(['G:\DPfeature186\', 'activation2'], 'activation2')
%            save(['G:\DPfeature186\', 'activation3'], 'activation3')
%                       activation444{i,j}=activation44;
%                        activation555{i,j}=activation55;
                       pred1{i,j}=pred;
%            save activation44ALL activation44
%             save activation55ALL activation55
% [p1,pred1,activation4,activation5] = stackedAEPredict333(stackedAEOptTheta, inputSize, hiddenSizeL2, ...
 acc2 = mean(testLabels  == pred')
 ACC2{i,j}=acc2;
fprintf('After Finetuning Test Accuracy: %0.3f%%\n', acc2 * 100);
save acc222.txt acc2 -ascii -append

toc
   i
   aa=aa+acc2
   result2=[result2;pred'];
    end
   acc3 = mean(label_all(number) == result2);
   acc4{i,j}=acc3;
end
avarage=aa/10
%  save activation201602train2225 activation222
%  save activation201602train3335 activation333
%   save activation444ALL5 activation444
%   save activation555ALL5 activation555
%   save trainLabels108 trainLabels1
  save testLabels829_dna_lbp testLabels11
%   save pred108 pred1
  save ACC829_dna_lbp ACC2
   save avarage829_dna_lbp avarage
   save number829_dna_lbp number10;
   save acc4829_dna_lbp acc4
%    ensemble_Accuracy=ensembleStrategy353(testLabels11,pred1);
   toc
% ensemble_SPSorter=ensembleStrategy(multi_kernel_labels_structure,multi_kernel_predict_labels_struture);
% result0=[result2-3 labels-3];
% save resultDEEP.txt result0 -ascii 
%  mean(result0(:,1)==result0(:,2))
% % ensemble_SPSorter=ensembleStrategy(multi_kernel_labels_structure,multi_kernel_predict_labels_struture);
% toc
% a2=load ('resultDEEP.txt');
%  tl=a2(:,1);
% pred=a2(:,1);
% tl=a2(:,2);
% acc1= mean( tl(find( tl ==1))== pred(find( tl==1)));
% acc2= mean( tl(find( tl ==2))== pred(find( tl==2)));
% acc3= mean( tl(find( tl ==3))== pred(find( tl==3)));
% acc4= mean( tl(find( tl ==4))== pred(find( tl==4)));
% acc_all=mean(tl==pred) %acc_all=0.8324
%  size(tl(find( tl ==4)),1)*acc4
%  a1=find( tl==1);
% a11=pred(find( tl==1));
% [a1';a11']
% toc
