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
ACC23=cell(10,10); 
acc4=cell(10,10);
 DATA=cell(10,1); 
load db821.mat db10
load db_label821.mat db_label10
  data1= db10{1};

  %  Xdata= [data1(:,1:36) data1(:,37:74) data1(:,75:110) data1(:,112:115) data1(:,116:951) data1(:,952:end)];
  Xdata= [ data1(:,952:end)];
  label_all=db_label10{1};
   load db1104.mat db10
load db_label1104.mat db_label10
 
 data044= db10{1};
%  data04=[data044(10:25,:); data044(35:51,:) ;data044(62:79,:) ];
%  label_all04=[db_label10{1}(10:25,:) ;db_label10{1}(35:51,:) ;db_label10{1}(62:79,:) ]; 
%  data04=[data044(26:80,:) ];
%  label_all04=[db_label10{1}(26:80,:)  ];
 data04=[data044(1:18,:); data044(24:44,:) ;data044(50:72,:) ;data044(79:80,:)];
 label_all04=[db_label10{1}(1:18,:) ;db_label10{1}(24:44,:) ;db_label10{1}(50:72,:) ;db_label10{1}(79:80,:)]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        SVM
%  [train_data,test_data] = featnorm( Xdata, Xdata);
% [bestacc,bestc,bestg] = SVMcgForClass(label_all, train_data,2,4,3,5,4,1,1,4)
% cmd = [' -c ',num2str(bestc),' -g ',num2str(bestg)];
%  %% 利用最佳的参数进行SVM网络训练
%  cmd = [' -c ',num2str(bestc),' -g ',num2str(bestg)];
% % cmd = [' -c 4 -g 32'];
% cmd=['-s 0 -t 2 -v 10 ' cmd];
% %   cmd = [' -c 4 -g 32'];
% % cmd=['-s 0 -t 2' cmd];
% %   cmd = [' -c 4 -g 32 -v 5 '];
% % cmd=['-s 0 -t 2' cmd];
% % predict = svmtrain(label_all,  Xdata, cmd);  
% % train_label表示训练输出样本数据；
% % data_train表示训练输入样本数据；
%  model = svmtrain(label_all,  Xdata, cmd);% cmd就是训练参数的设置，如设置为cmd='-v 5'就表示进行5折交叉验证（该设置中省略了其他参数的设置，即保存默认设置）。
% %% 仿真测试
% 
% [predict_label, accuracy, dec_values] = svmpredict(testLabels, testData1, model); %

  
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  label_all=db_label10{1};
 aa=0;
 labels0=[]; labels01=[]; l1=[];l2=[];l3=[];l4=[];l5=[];l6=[];l7=[];
% 
     for i1=1:size(label_all04,1)
       
              if label_all04(i1)==1
              label1=label_all04(i1);
              label00=[1 0 0 0 0 0 0]';
              l1=[l1;i1];
              end
               if label_all04(i1)==2
              label1=label_all04(i1);
              label00=[0 1 0 0 0 0 0]'
              l2=[l2;i1];
               end;
               if label_all04(i1)==3
              label1=label_all(i1);
              label00=[0 0 1 0 0 0 0]'
              l3=[l3;i1];
               end;
               if label_all04(i1)==4
              label1=4;
              label00=[0 0 0 1 0 0 0]';
              l4=[l4;i1];
               end
              if label_all04(i1)==5
              label1=5;
              label00=[0 0 0 0 1 0 0]';
              l5=[l5;i1];
              end
              if label_all04(i1)==6
              label1=6;
              label00=[0 0 0 0 0 1 0]';
              l6=[l6;i1];
              end
              if label_all04(i1)==7
              label1=7;
              label00=[0 0 0 0 0 0 1]';
              l7=[l7;i1];
              end
    
     labels0=[labels0  label00];         
     labels01=[labels01;  label1];           
     end  
%       save labels_all1207 labels0
%         save labels_all111 labels01       
 

%   order1=size(labels01(labels01==1),1)  %50   25/25 
%  order2=size(labels01(labels01==2),1)  %49     25/24
%  order3=size(labels01(labels01==3),1)  %51      25/26
%  order4=size(labels01(labels01==4),1)  %49      25/24
%  order5=size(labels01(labels01==5),1)  %102      51/51
%  order6=size(labels01(labels01==6),1)  %52        26/26
% size(labels01(labels01==7))  %52
 TESTp_rf_ij=cell(10,10);
 TESTp_svm_ij=cell(10,10);
 TESTp_softmax_ij=cell(10,10);
 TESTl_label_ij=cell(10,10);
 label0_ij=cell(10,10);
for j=1:10
    result2=[];
     result2_svm=[];
      result2softmax=[];
       TESTp_sftmax=[];

 TESTp_rf=[];
  TESTp_svm=[];
% number1=randperm(order1);
TESTd=[];
 TESTl=[];
 TESTp=[];
 
 acc00=[];
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

for i=1:1
      fileName=strcat(num2str(i),'.mat');
      load(fileName);
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     writePath = ['idx_sdaPath2'];
  logname = ['./' writePath '/' strcat('idx_sda',num2str(round(rand()*100000)))];
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
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        trainLabels=label_all;
        testLabels=label_all04;
    traindata=data1;
%         traindata0=mapminmax(traindata00,0,1);
%         traindata=traindata0';
        testdata=data04;
%         testdata0=mapminmax(testdata00,0,1);
%         testdata=testdata0';
        trainLabels1{i,j}=trainLabels;
         testLabels11{i,j}=testLabels;
%  save trainLabels11 trainLabels1
%  save testLabels11 testLabels1
        [train_data,test_data] = featnorm(traindata,testdata);
        train_data = double(train_data*2-1);
        test_data = double(test_data*2-1);
        
%         trainData = train_data;
     trainLabels =trainLabels;
%  trainX=[trainData;pdb_feature(1:19400,:)];
%  trainX=[trainData];
%      testData1 = test_data;%测试集数据
    testLabels1 =  testLabels;%测试集标签  
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%尝试产生SDA
target= trainLabels;
  %SDA: stepwise discriminant analysis
 train_data_sda=train_data(:,142:951);
%  [train_data_sda,inputps]=mapminmax(train_data_sda1);%数据规一化
% train_data_sda=1./(1+exp(-train_data_sda));
  idx_sda = sda2(train_data_sda,target,logname)   
%   idx_sda = sda2([train_data;train_data],[target;target],logname)   
   trainData=[train_data(:,1:36)  train_data(:,75:110) train_data(:,112:115) train_data_sda(:,idx_sda) train_data(:,952:end)];            %trainSet
%   trainData=[train_data(:,1:36)  train_data(:,75:110) train_data(:,112:115)  train_data(:,952:end)];            %trainSet
%   trainData=train_data;  
     trainX=[trainData];
    test_data_sda=test_data(:,142:951);
%       test_data_sda=1./(1+exp(-test_data_sda));
%    testData =test_data;
       testData =[ test_data(:,1:36)   test_data(:,75:110)  test_data(:,112:115) test_data_sda(:,idx_sda)  test_data(:,952:end)];               %testSet
%          testData =[ test_data(:,1:36)   test_data(:,75:110)  test_data(:,112:115)   test_data(:,952:end)];               %testSet
        
      testData1 = testData;            %testSet
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        SVM
%   [bestacc,bestc,bestg] = SVMcgForClass(trainLabels,trainData,2,4,3,5,4,1,1,4)
% % 打印选择结果
% disp('打印选择结果');
% str = sprintf( 'Best Cross Validation Accuracy = %g%% Best c = %g Best g = %g',bestacc,bestc,bestg);
% disp(str);

%% 利用最佳的参数进行SVM网络训练
% cmd = [' -c ',num2str(bestc),' -g ',num2str(bestg)];
 %% 利用最佳的参数进行SVM网络训练
%  cmd = [' -c ',num2str(bestc),' -g ',num2str(bestg)];
% cmd = [' -c 4 -g 32'];
% cmd=['-s 0 -t 2 -v 10' cmd];
 cmd = ['-c 1 -g 0.1'];
cmd=['-s 0 -t 2 -b 1' cmd];
 model = svmtrain(trainLabels,trainData, cmd);
% %% 仿真测试
% 
[predict_label, accuracy, dec_values] = svmpredict(testLabels, testData1, model,'-b 1'); %

[ms,ns]=size(dec_values);
Psvm=[];
for isvm=1:ns
      for isvm2=1:ns
        if model.Label(isvm2)==isvm
           Psvm=[ Psvm dec_values(:,isvm2)];
        end
      end
end
% [~,mdex]=max(dec_values(i,:));
% p=model.Label(mdex)
   result2_svm=[result2_svm;predict_label];
ACC23{i,j}=accuracy;
acc_svm=accuracy(1,:)/100
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% 创建随机森林分类器

   ntree=200;
    mtry=40;
%    model = classRF_train(P_train1,T_train1,ntree, mtry);
 model=TreeBagger(ntree,trainData, trainLabels ,'NVarToSample',mtry);
 
 %% 仿真测试
% [T_sim,votes] = classRF_predict(testN{k},model);
[T_sim,votes] = predict(model,testData1);
pred22=cell2mat(T_sim(1:end));
pred22=str2num(pred22);
% cl=class(pred)
acc_rf = mean(testLabels  ==pred22)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   acc2 = mean(testLabels  ==pred)
 ACC2{i,j}=acc_rf;
% fprintf('After Finetuning Test Accuracy: %0.3f%%\n', acc2 * 100);
% save acc222.txt acc2 -ascii -append

toc
   i
%    aa=aa+acc2
   result2=[result2;pred22];
  
  
TESTp=[TESTp; votes];
 TESTl=[TESTl;testLabels];
 TESTp_rf=[TESTp_rf votes];
  TESTp_svm=[TESTp_svm;  Psvm];
   
end
   
    acc_svm = mean(label_all04 == result2_svm)
   acc3 = mean(label_all04 == result2)

% a123=[TESTl label_all(number)]';
  CatNames = {'1 Cytopl', '2 ER', '3 Gol', '4 Lyso', '5 Mito', ...
        '6 Nucl', '7 Vesi'};
    saveDir='./output/';
 ConfMat = confusionmat(label_all04,result2_svm);
    % Prepare data for ROC curves (reformat arrays)
    
    ROCraw.true = labels0; ROCraw.predicted =TESTp_svm;
showMyConfusionMatrix(ConfMat, 'DNA-LBP_Classify_RF', CatNames, saveDir);
    % create and save ROC plot for last experiment
%     AUC = showMyROC(ROCraw, currClassifierName, CatNames, cnst.saveDir);   
     AUC = showMyROC(ROCraw,  'DNA-LBP_Classify_RF', CatNames,  saveDir); 
    meanAUC = mean(cell2mat(AUC))
    stdAUC = std(cell2mat(AUC))
end
 
 