clear all
clc
close all
tic
DISPLAY = true;
inputSize =1096;
numClasses = 7;
hiddenSizeL1 = 200;    % Layer 1 Hidden Size
hiddenSizeL2 =200;    % Layer 2 Hidden Size
sparsityParam = 0.2;   % desired average activation of the hidden units.
                       % (This was denoted by the Greek alphabet rho, which looks like a lower-case "p",
                       %  in the lecture notes). 
lambda = 1e-3;         % weight decay parameter       
beta =3;              % weight of sparsity penalty term       
labels1=[];
result2=[];
  result3=[];
currentFolder = pwd;
addpath(genpath(currentFolder))
load idx_sda.mat
for i=1:1
      fileName=strcat(num2str(i),'.mat');
      load(fileName);
    for j=1:5
        idx_sda=A{i}{j}
        temp_result_multi_kernel_structure=0;
        temp_result_multi_kernel_forest=0;
        temp_result_multi_kernel=0;
        [trainSet,testSet]=jb_kfold(labels,5,j);
        trainLabels=labels(trainSet);
        testLabels=labels(testSet);
        traindata=data(trainSet,:);
        testdata=data(testSet,:);

        [train_data,test_data] = featnorm(traindata,testdata);
        train_data = double(train_data*2-1);
        test_data = double(test_data*2-1);
        
        trainData = train_data;
trainLabels =trainLabels;
%  trainX=[trainData;pdb_feature(1:19400,:)];
 trainX=[trainData];
     testData1 = test_data;%测试集数据
    testLabels1 =  testLabels;%测试集标签    
    
     for mm=100:	100:100
              for nn=20:20:20
                gamma=[mm,nn];
%                 base_params.idx_sda=idx_sda;
                base_params.gamma=gamma;
               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%S-PSorter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5                
%                 tic
                Parameters.coding='CUSTOM';
                Parameters.custom_coding='structure';
                Parameters.base='svm_train_multi_kernel';
                Parameters.base_test='svm_test_multi_kernel';
                Parameters.base_test_params= base_params;
                Parameters.base_params=base_params;
                 Parameters.ntree=mm;
                 Parameters.mtry=nn;
                [Classifiers,Parameters]=ECOCTrainRF(train_data,trainLabels,Parameters);
                [X,Labels,temp_Values,confusion]=ECOCTestRF(test_data,Classifiers,Parameters,testLabels);
                result_multi_kernel_structure(i,j)=sum(diag(confusion))/sum(sum(confusion));
                if  result_multi_kernel_structure(i,j)> temp_result_multi_kernel_structure
                    temp_result_multi_kernel_structure=result_multi_kernel_structure(i,j);
                    multi_kernel_predict_labels_struture{i,j}=Labels;
                    multi_kernel_labels_structure{j}=testLabels;
                else
                   result_multi_kernel_structure(i,j)= temp_result_multi_kernel_structure;
                end
               
                nn
              end
        mm
        end          
acc2 = mean(testLabels  == Labels)
result2=[result2;Labels];
save result1111.txt result2 -ascii 
result3=[result3;acc2];
save acc0127_pss.txt result3 -ascii 
toc
i


 toc   
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55  
        
%         for m=0.9:0.1:2.1
%               for n=0.9:0.1:2.1
%                 gamma=[m,n];
%                 base_params.idx_sda=idx_sda;
%                 base_params.gamma=gamma;
%                
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%S-PSorter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5                
%                 tic
%                 Parameters.coding='CUSTOM';
%                 Parameters.custom_coding='structure';
%                 Parameters.base='svm_train_multi_kernel';
%                 Parameters.base_test='svm_test_multi_kernel';
%                 Parameters.base_test_params= base_params;
%                 Parameters.base_params=base_params;
%                 [Classifiers,Parameters]=ECOCTrain(train_data,trainLabels,Parameters);
%                 [X,Labels,temp_Values,confusion]=ECOCTest(test_data,Classifiers,Parameters,testLabels);
%                 result_multi_kernel_structure(i,j)=sum(diag(confusion))/sum(sum(confusion));
%                 if  result_multi_kernel_structure(i,j)> temp_result_multi_kernel_structure
%                     temp_result_multi_kernel_structure=result_multi_kernel_structure(i,j);
%                     multi_kernel_predict_labels_struture{i,j}=Labels;
%                     multi_kernel_labels_structure{j}=testLabels;
%                 else
%                    result_multi_kernel_structure(i,j)= temp_result_multi_kernel_structure;
%                 end
%                 toc
%               end
% 
%         end          
      end
end
% ensemble_SPSorter=ensembleStrategy(multi_kernel_labels_structure,multi_kernel_predict_labels_struture);
result0=[result2-3 labels-3];
save resultDEEP.txt result0 -ascii 
 mean(result0(:,1)==result0(:,2))
% ensemble_SPSorter=ensembleStrategy(multi_kernel_labels_structure,multi_kernel_predict_labels_struture);
toc
a2=load ('resultDEEP.txt');
 tl=a2(:,1);
pred=a2(:,1);
tl=a2(:,2);
acc1= mean( tl(find( tl ==1))== pred(find( tl==1)));
acc2= mean( tl(find( tl ==2))== pred(find( tl==2)));
acc3= mean( tl(find( tl ==3))== pred(find( tl==3)));
acc4= mean( tl(find( tl ==4))== pred(find( tl==4)));
acc_all=mean(tl==pred) %acc_all=0.8324
 size(tl(find( tl ==4)),1)*acc4
 a1=find( tl==1);
a11=pred(find( tl==1));
[a1';a11']
toc
