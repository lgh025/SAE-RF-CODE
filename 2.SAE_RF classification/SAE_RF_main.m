
clear all
clc
close all
tic
DISPLAY = true;
numClasses = 7;
hiddenSizeL1 = 300;    % Layer 1 Hidden Size
hiddenSizeL2 =200;    % Layer 2 Hidden Size
sparsityParam = 0.1;   % desired average activation of the hidden units.
                       % (This was denoted by the Greek alphabet rho, which looks like a lower-case "p",
                       %  in the lecture notes). 
lambda = 2e-5;         % weight decay parameter       
beta =3;              % weight of sparsity penalty term      
labels1=[];
result2=[];
  result3=[];
currentFolder = pwd;
addpath(genpath(currentFolder))
 load idx_sda.mat
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
data2=data1(:,142:951);
Xdata=data1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 label_all=db_label10{1};
 aa=0;
 labels0=[]; labels01=[]; l1=[];l2=[];l3=[];l4=[];l5=[];l6=[];l7=[];
% 
     for i1=1:size(label_all,1)
       
              if label_all(i1)==1
              label1=label_all(i1);
              label00=[1 0 0 0 0 0 0]';
              l1=[l1;i1];
              end
               if label_all(i1)==2
              label1=label_all(i1);
              label00=[0 1 0 0 0 0 0]'
              l2=[l2;i1];
               end;
               if label_all(i1)==3
              label1=label_all(i1);
              label00=[0 0 1 0 0 0 0]'
              l3=[l3;i1];
               end;
               if label_all(i1)==4
              label1=4;
              label00=[0 0 0 1 0 0 0]';
              l4=[l4;i1];
               end
              if label_all(i1)==5
              label1=5;
              label00=[0 0 0 0 1 0 0]';
              l5=[l5;i1];
              end
              if label_all(i1)==6
              label1=6;
              label00=[0 0 0 0 0 1 0]';
              l6=[l6;i1];
              end
              if label_all(i1)==7
              label1=7;
              label00=[0 0 0 0 0 0 1]';
              l7=[l7;i1];
              end
    
     labels0=[labels0  label00];         
     labels01=[labels01;  label1];           
     end  
      save labels_all1207 labels0
        save labels_all111 labels01       
 
 TESTp_rf_ij=cell(10,10);
 TESTp_svm_ij=cell(10,10);
 TESTp_softmax_ij=cell(10,10);
 TESTl_label_ij=cell(10,10);
 label0_ij=cell(10,10);
label0_ij7=cell(10,10);
for j=1:10
    result2=[];
     result2_svm=[];
      result2softmax=[];
       TESTp_sftmax=[];
        label_all_all=[];
        label_all7=[];
        test_label7=[];
 TESTp_rf=[];
  TESTp_svm=[];
TESTd=[];
 TESTl=[];
 TESTp=[];
 
 acc00=[];
number=randperm(size(label_all,1));
number10{j,1}=number;

CVO = cvpartition(label_all', 'k', 10);

for i=1:10
     
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     writePath = ['idx_sdaPath'];
  logname = ['./' writePath '/' strcat('idx_sda',num2str(round(rand()*100000)))];
  if ~exist(logname,'dir')
        mkdir(logname);
  end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          cvpartition
    trIdxUn = CVO.training(i);
     teIdxUn = CVO.test(i);
     train_x= Xdata(trIdxUn,:);
     train_y= label_all(trIdxUn,:);
    test_x = Xdata(teIdxUn,:);
     test_y =label_all(teIdxUn,:);
      test_label7= labels0(:,teIdxUn);
    
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        trainLabels=train_y;
        testLabels=test_y;
        traindata=train_x;
        testdata=test_x;
        trainLabels1{i,j}=trainLabels;
         testLabels11{i,j}=testLabels;
        [train_data,test_data] = featnorm(traindata,testdata);
        train_data = double(train_data*2-1);
        test_data = double(test_data*2-1);
        
     trainLabels =trainLabels;
    testLabels1 =  testLabels;%test set label  
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   mRMR
target= trainLabels;
  train_data_mrmr=train_data(:,142:951);
[mRMRdataset] =mRMRfeatureSelect( train_data_mrmr, trainLabels);
 ranking=mRMRdataset.mrmrFea
%  k=100;
 train_data_mrmr2 = train_data_mrmr(:,ranking);

  
   trainData=[train_data(:,1:36)  train_data(:,75:110) train_data(:,112:115) train_data_mrmr2 train_data(:,952:end)];            %trainSet

  
     trainX=[trainData];
    test_data_mrmr=test_data(:,142:951);
 test_data_mrmr2= test_data_mrmr(:,ranking);
       testData =[ test_data(:,1:36)   test_data(:,75:110)  test_data(:,112:115) test_data_mrmr2  test_data(:,952:end)];               %testSet

        
      testData1 = testData;            %testSet
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     

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
    inputSize,hiddenSizeL1,lambda,sparsityParam,beta, trainX),sae1Theta,options);%train the first layer parameter

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
end
% -------------------------------------------------------------------------

%%======================================================================
%% STEP 3: Train the softmax classifier
%  This trains the sparse autoencoder on the second autoencoder features.
%  If you've correctly implemented softmaxCost.m, you don't need
%  to change anything here.

[sae2Features] = feedForwardAutoencoder4(sae2OptTheta, hiddenSizeL2, ...
                                        hiddenSizeL1, sae1Features);
          
                                    
 %%%%%%%%% %your own classifiers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
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
% saelOptTheta,sae1ptTheta include sparse autoencoder's weight
stack{1}.w = reshape(sae1OptTheta(1:hiddenSizeL1*inputSize), ...
                     hiddenSizeL1, inputSize);
stack{1}.b = sae1OptTheta(2*hiddenSizeL1*inputSize+1:2*hiddenSizeL1*inputSize+hiddenSizeL1);
stack{2}.w = reshape(sae2OptTheta(1:hiddenSizeL2*hiddenSizeL1), ...
                     hiddenSizeL2, hiddenSizeL1);
stack{2}.b = sae2OptTheta(2*hiddenSizeL2*hiddenSizeL1+1:2*hiddenSizeL2*hiddenSizeL1+hiddenSizeL2);

% Initialize the parameters for the deep model
[stackparams, netconfig] = stack2params(stack);
stackedAETheta = [ saeSoftmaxOptTheta ; stackparams ];%stackedAETheta

%% ---------------------- YOUR CODE HERE  ---------------------------------
%  Instructions: Train the deep network, hidden size here refers to the '
%                dimension of the input to the classifier, which corresponds 
%                to "hiddenSizeL2".
%
%

[stackedAEOptTheta, cost] =  minFunc(@(p)stackedAECost(p,inputSize,hiddenSizeL2,...
                         numClasses, netconfig,lambda, trainData, trainLabels),...
                        stackedAETheta,options);%Train the first layer
% save('saves/step5.mat', 'stackedAEOptTheta');

toc
stackedTEST=struct;
stackedTEST.stackedAETheta=stackedAETheta;
stackedTEST.stackedAEOptTheta=stackedAEOptTheta;
stackedTEST.inputSize=inputSize;
stackedTEST.hiddenSizeL2=hiddenSizeL2;
stackedTEST.numClasses=numClasses;
stackedTEST.netconfig=netconfig;
% save(['G:\DPparameter186_2\', name1,'_stackedTEST'], 'stackedTEST') %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%save parameter%%%%%%%%%%%%%%%%%%%%%%%%


[p0,pred0,activation22,activation33] = stackedAEPredict333(stackedAEOptTheta, inputSize, hiddenSizeL2, ...
                          numClasses, netconfig, trainData);

acc0 = mean(trainLabels == pred0')
%%%%%%testing%%%%%%%%%%%%%%%%%%%%%%%%
[pred2] = stackedAEPredict(stackedAETheta, inputSize, hiddenSizeL2, ...
                          numClasses, netconfig, testData1);
pred=pred2';
acc1 = mean(testLabels == pred);
fprintf('Before Finetuning Test Accuracy: %0.3f%%\n', acc1 * 100);
% save pred1.txt pred -ascii -append
% save acc1.txt acc1 -ascii -append
[p,pred,activation44,activation55] = stackedAEPredict333(stackedAEOptTheta, inputSize, hiddenSizeL2, ...
                          numClasses, netconfig, testData1);

                       pred1{i,j}=pred;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SVM method
%  cmd = [' -c ',num2str(bestc),' -g ',num2str(bestg)];
% cmd = [' -c 4 -g 32'];
% cmd=['-s 0 -t 2 -v 10' cmd];
 cmd = ['-c 1 -g 0.1'];
cmd=['-s 0 -t 2 -b 1' cmd];
 model = svmtrain(trainLabels,[ activation33'], cmd);
% %% 
% 
[predict_label, accuracy, dec_values] = svmpredict(testLabels, [activation55'], model,'-b 1'); %
[ms,ns]=size(dec_values);
Psvm=[];
for isvm=1:ns
      for isvm2=1:ns
        if model.Label(isvm2)==isvm
           Psvm=[ Psvm dec_values(:,isvm2)];
        end
      end
end
   result2_svm=[result2_svm;predict_label];
ACC23{i,j}=accuracy;
acc_svm=accuracy(1,:)/100
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% Random forest method

   ntree=250;
    mtry=40;
%    model = classRF_train(P_train1,T_train1,ntree, mtry);
 model=TreeBagger(ntree,[ activation33'], trainLabels ,'NVarToSample',mtry);
 
 %% 
[T_sim,votes] = predict(model, [activation55']);
pred22=cell2mat(T_sim(1:end));
pred22=str2num(pred22);
cl=class(pred)
acc_rf = mean(testLabels  ==pred22)
 %%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% softmax
acc_softmax=mean(testLabels  == pred')
 acc2 = mean(testLabels  == pred')
 ACC2{i,j}=[acc_svm  acc_rf acc_softmax];
fprintf('After Finetuning Test Accuracy: %0.3f%%\n', acc2 * 100);
save acc222.txt acc2 -ascii -append

toc
   i
   aa=aa+acc2
   result2=[result2;pred22];
    result2softmax=[result2softmax;pred'];
  TESTp_sftmax=[TESTp_sftmax; p'];
TESTp=[TESTp; votes];
 TESTl=[TESTl;testLabels];
 TESTp_rf=[TESTp_rf;votes];
  TESTp_svm=[TESTp_svm;  Psvm];
   label_all_all=[ label_all_all;testLabels ]; 
    label_all7=[label_all7 test_label7];
       
end

     acc_softmax0 = mean(label_all_all == result2softmax)
    acc_svm0 = mean(label_all_all == result2_svm)
   acc3 = mean(label_all_all== result2)
   acc4{i,j}=acc3;
   acc4_svm{i,j}=acc_svm;
   acc4_softmax{i,j}=acc_softmax;
   TESTp_rf_ij{i,j}=TESTp_rf;
 TESTp_svm_ij{i,j}=TESTp_svm;
 TESTp_softmax_ij{i,j}=TESTp_sftmax;
 TESTl_label_ij{i,j}=TESTl;
% a123=[TESTl label_all(number)]';
label0_ij{i,j}=  label_all_all;
label0_ij7{i,j}=  label_all7;
save lghlgh20181112mrmr acc4 acc_svm0  acc_softmax0 TESTp_rf_ij TESTp_svm_ij TESTp_softmax_ij TESTl_label_ij label0_ij label0_ij7
  CatNames = {'1 Cytopl', '2 ER', '3 Gol', '4 Lyso', '5 Mito', ...
        '6 Nucl', '7 Vesi'};
    saveDir='./output/';
 ConfMat = confusionmat(TESTl, result2);
    % Prepare data for ROC curves (reformat arrays)
    ROCraw.true =label_all7; ROCraw.predicted =TESTp_softmax_ij{i,j};
    showMyConfusionMatrix(ConfMat, 'DNA-LBP_Classify_dp', CatNames, saveDir);
    % create and save ROC plot for last experiment
     AUC = showMyROC(ROCraw,  'DNA-LBP_Classify_dp', CatNames,  saveDir); 
    meanAUC = mean(cell2mat(AUC))
    stdAUC = std(cell2mat(AUC))
end

avarage=aa/10
zhibiao=[acc3 meanAUC  stdAUC]
%
   save zhibiao20181112  zhibiao 
   

   toc
