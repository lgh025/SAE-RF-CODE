Files = dir(fullfile('G:\xiaoweide\dataset_mat\dset72_mat_a\','*.mat'));
%  labels = dir(fullfile('F:\魏志森的数据\dataset_mat\dset186_mat\\','*.label'));
  LengthFiles = length(Files);
  MCC1=0;
  bestx=[];
 result=cell(1,LengthFiles);
 votes=cell(1,LengthFiles);
 modelGOOD=cell(1,LengthFiles);
 result5=[];
votes5=[];
SAMPLE=[];
LABEL=[];
T_sim2=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
 for CT = 1:LengthFiles;
%     for CT = 1:2
     result5=[];
votes5=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     wlength=length(Files(CT).name);
     name1=strcat(Files(CT).name(1:wlength-4));
     load(['G:\PPIclean72\', name1,'_test1_data_score1'], 'test_data_score1')
       load(['G:\PPIclean72\', name1,'_test1_label_score1'], 'test_label_score1')
       data1= test_data_score1{20} ;
       label1=  test_label_score1{20} ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                   data= load(strcat('G:\xiaoweide\dataset_mat\dset72_mat_a\',Files(CT).name));
%                   data1=data.feature;
%                   label1=data.lb;
                  label1(label1==-1)=2;
                  SAMPLE=[SAMPLE;data1];
                     LABEL=[LABEL;label1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 testData1 = data1;%测试集数据
testLabels1 = label1;%测试集标签
%  testData=trainData ;
% testLabels=trainLabels;


testLabels1(testLabels1 == 0) = 2; % Remap 0 to 10

[pred2] = stackedAEPredict(stackedAETheta, inputSize, hiddenSizeL2, ...
                          numClasses, netconfig, testData1);
pred=pred2';
acc1 = mean(testLabels1 == pred);
fprintf('Before Finetuning Test Accuracy: %0.3f%%\n', acc1 * 100);
% save pred1.txt pred -ascii -append
% save acc1.txt acc1 -ascii -append
[p,pred,activation2,activation3] = stackedAEPredict333(stackedAEOptTheta, inputSize, hiddenSizeL2, ...
                          numClasses, netconfig, testData1);
%            save sae1Features sae1Features
%            save sae2Features sae2Features
           
%            save PPIactivation2ALL activation2
%            save PPIactivation3ALL activation3
% [p1,pred1,activation4,activation5] = stackedAEPredict333(stackedAEOptTheta, inputSize, hiddenSizeL2, ...
%                           numClasses, netconfig, testData1);
%                  save activation4 activation4
%                  save activation5 activation5      

acc2 = mean(testLabels1  == pred');
fprintf('After Finetuning Test Accuracy: %0.3f%%\n', acc2 * 100);
save pred2.txt pred -ascii -append

% Accuracy is the proportion of correctly classified images
% The results for our implementation were:
%
% Before Finetuning Test Accuracy: 87.7%
% After Finetuning Test Accuracy:  97.6%
%
% If your values are too low (accuracy less than 95%), you should check 
% your code for errors, and make sure you are training on the 
% entire data set of 60000 28x28 training images 
% (unless you modified the loading code, this should be the case)
votes1=p';
PSEp2=[];
for t=1:size(testLabels1,1)
PSEp1= (double(votes1(t,1)))/(double(votes1(t,1)+votes1(t,2)));
PSEp2=[PSEp2;PSEp1];
end
 M=PSEp2;
% T_good=0.23;
M(M >T_good)=1;
M(M <=T_good)=2;
% result3= [testLABEL M];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
testlabels=[];
pred1=pred';
%  testlabels=[testlabel1; testLABEL];
% pred=[testlabel_sim;M];
 testlabels=testLabels1;
pred=M;

result2 = [testlabels  pred];
acc2 = mean(result2(:,1) == result2(:,2))
fprintf('Accuracy: %0.3f%%\n', acc2 * 100);
acc_pos= mean( testlabels(find( testlabels ==1))== pred(find( testlabels==1)));
 fprintf('positive_Accuracy: %0.3f%%\n', acc_pos * 100);
acc_neg=mean( testlabels(find( testlabels ==2))== pred(find( testlabels==2)));
 fprintf('neg_Accuracy: %0.3f%%\n', acc_neg * 100);
 
 TP=sum(testlabels(find(testlabels==1))== pred(find(testlabels==1)));
  FP=sum(testlabels(find(testlabels==2))~= pred(find(testlabels==2)));
  TN=sum(testlabels(find(testlabels==2))== pred(find(testlabels==2)));
  FN=sum(testlabels(find(testlabels==1))~= pred(find(testlabels==1)));
  ConfusionMatrix=[TP,FP;FN,TN]
  
  MCC(CT)=(TP*TN-FP*FN)/(sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)))


toc
end