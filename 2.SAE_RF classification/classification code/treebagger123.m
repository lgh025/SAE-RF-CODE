% acc3 =
%     0.6622
% meanAUC =
%     0.8545
% stdAUC =
%     0.0897
clear all
clc
close all
tic
labels1=[];
result2=[];
  result3=[];
currentFolder = pwd;
addpath(genpath(currentFolder))
 
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

  %  Xdata= [data1(:,1:36) data1(:,37:74) data1(:,75:110) data1(:,112:115) data1(:,116:951) data1(:,952:end)];
  Xdata= [data1(:,1:36)  data1(:,75:110) data1(:,112:115) data1(:,116:951) data1(:,952:end)];

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
 
 TESTd=[];
 TESTl=[];
 TESTp=[];
%   order1=size(labels01(labels01==1),1)  %50   25/25 
%  order2=size(labels01(labels01==2),1)  %49     25/24
%  order3=size(labels01(labels01==3),1)  %51      25/26
%  order4=size(labels01(labels01==4),1)  %49      25/24
%  order5=size(labels01(labels01==5),1)  %102      51/51
%  order6=size(labels01(labels01==6),1)  %52        26/26
% size(labels01(labels01==7))  %52
for j=1:1
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
  
  
  
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% 创建随机森林分类器

   ntree=200;
    mtry=40;
%    model = classRF_train(P_train1,T_train1,ntree, mtry);
 model=TreeBagger(ntree,trainData, trainLabels ,'NVarToSample',mtry);
 
 %% 仿真测试
% [T_sim,votes] = classRF_predict(testN{k},model);
[T_sim,votes] = predict(model,testData1);
pred=cell2mat(T_sim(1:end));
pred=str2num(pred);
cl=class(pred)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  acc2 = mean(testLabels  ==pred);
 ACC2{i,j}=acc2;
fprintf('After Finetuning Test Accuracy: %0.3f%%\n', acc2 * 100);
save acc222.txt acc2 -ascii -append

toc
   i
   aa=aa+acc2
   result2=[result2;pred];
   TESTp=[TESTp; votes];
   TESTd=[TESTd;testData1];
 TESTl=[TESTl;testLabels]; 
   
    end
   acc3 = mean(label_all(number) == result2)
   acc4{i,j}=acc3;

a123=[TESTl label_all(number)]';
  CatNames = {'1 Cytopl', '2 ER', '3 Gol', '4 Lyso', '5 Mito', ...
        '6 Nucl', '7 Vesi'};
    saveDir='./output/';
 ConfMat = confusionmat(label_all(number),result2);
    % Prepare data for ROC curves (reformat arrays)
    
    ROCraw.true = labels0(:,number); ROCraw.predicted =TESTp;
showMyConfusionMatrix(ConfMat, 'DNA-LBP_Classify_RF', CatNames, saveDir);
    % create and save ROC plot for last experiment
%     AUC = showMyROC(ROCraw, currClassifierName, CatNames, cnst.saveDir);   
     AUC = showMyROC(ROCraw,  'DNA-LBP_Classify_RF', CatNames,  saveDir); 
    meanAUC = mean(cell2mat(AUC))
    stdAUC = std(cell2mat(AUC))
end
 
 