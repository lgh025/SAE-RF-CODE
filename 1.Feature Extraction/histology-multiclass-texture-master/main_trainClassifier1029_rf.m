% created by Jakob Nikolas Kather 2015 - 2016
% license: see separate LICENSE file in same folder, includes disclaimer

% this script is used to train a new classifier. The resulting classifier
% will be saved with a random unique ID

%% HEADER
format compact, clear all, close all; clc
addpath([pwd,'/subroutines'],'-end'); % my own subroutines
tic
% set constants
cnst.crossVal = 10;             % number of cross validations, default 10
cnst.noOverheat = false;  % default false; true = will pause in between runs
cnst.pie =0;                   % show pie chart of class distributions?
cnst.scale = false;                 % scale all variables again? default false
cnst.showResults = true;           % show confusion matrix etc? default true
cnst.crossbar = '---';          % decoration for status report
cnst.allClassifiers = {'1NN', 'ensembleTree', 'linSVM', 'rbfSVM'}; %{'1NN', 'ensembleTree', 'linSVM', 'rbfSVM'}; 
cnst.allFSets = {'best5'}; %{'histogram_lower','histogram_higher','gabor','perceptual','f-lbp','glcm','best5'};  
cnst.FeatureDataSource = 'PRIMARY'; % default 'PRIMARY'
    cnst.reduceFeatSet = false; % experimental, works for combined_ALL only

% internal variables
rng('shuffle');         % reset random number generator for random ID
randID = ['UID_',num2str(round(rand()*100000))]; % create random ID
cnst.saveDir = ['./output/',randID,'/']; % create directory name
mkdir(cnst.saveDir);    % create directory for current experiment
rng('default');         % reset random number generator for reproducibility
shownPie = 0;           % internal variable, do not change
countr = 1;             % do not change. Table indices for summary.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load db821.mat db10
% load db_label821.mat db_label10
%   data1= db10{1};
% 
% %  Xdata= [data1(:,1:36) data1(:,38:41) data1(:,878:end)];
% %    Xdata= [data1(:,1:36) data1(:,75:254) data1(:,256:259) data1(:,1096:end)];
%   Xdata= [ data1(:,112:115) data1(:,952:end)];
% %   Xdata= [ data1(:,1:110) data1(:,112:115) data1(:,952:end)];
% %  Xdata= [ data1(:,75:254) data1(:,256:259) data1(:,1096:end)];
%  label_all=db_label10{1};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% BODY
% iterate through all methods and classifiers, perform all experiments
meanAUC10=[];
 stdAUC10=[];
 acc10=[];
for ii=1:10
    meanAUC4=[];
 stdAUC4=[];
 acc4=[];
for ClassifCount = cnst.allClassifiers; 

featureID = 1; % for summary grid

for FSetCount = cnst.allFSets;
    
% prepare variables for display and show status
currFSet = char(FSetCount); currClassifier = char(ClassifCount);
disp([cnst.crossbar,10,'starting iteration with ',currFSet]); countdown(5);

%load and preprocess data
[CatNames, source_and_target, myData, myLabels] = ...
    load_feature_dataset1029(currFSet, cnst.FeatureDataSource);

% - this block is obsolete - 
% if cnst.reduceFeatSet && strcmp(currFSet,'combined_ALL')
%     warning('reducing feature set...');
%     load('./datasets/PRIMARY/featSetOut_combined_ALL_reduced_2016_01_24.mat');
%     source_and_target = source_and_target(:,[featSet,true]);
%     myData = myData(featSet,:);
% end
    
maxClasses = 2:max(unique(source_and_target(:,end)));

% optional: force scaling of variables (again)
if cnst.scale, source_and_target = enforceScale(source_and_target); end
% optional: show pie chart of class distribution and save to file
if cnst.pie && ~shownPie, 
    showMyPie(myLabelCats,CatNames,[cnst.saveDir,randID,'_Dataset.png']); shownPie = 1; end

% iterate through maxClass: perform experiments with 2,3,4,... classes
for currNumClass = [numel(maxClasses)] % first and last element [1,numel(maxClasses)]
    rng(currNumClass);  % reset random number generator for reproducibility
    maxClass = maxClasses(currNumClass); % extract max. class
    source_target_limit_classes = ...
      source_and_target(1:find(source_and_target(:,end)==(maxClass), 1, 'last' ),:);
  
%     currClassifierName = [randID, '-row_',num2str(countr),...
%       '-MaxClass_',num2str(maxClass), '-Feat_',currFSet,...
%        '-Data_',cnst.FeatureDataSource, '-Classif_',currClassifier];
   currClassifierName = [randID, '-row_',num2str(countr),...
      '-MaxClass_',num2str(maxClass), '-Feat_',currFSet,...
       '-Data_',cnst.FeatureDataSource, '-Classif_',currClassifier];
    % train and cross-validate classifier
    tic,   [trainedClassifier, validationAccuracy, ConfMat, ROCraw,acc] = ...
           trainMyClassifier1029(source_target_limit_classes,...
               1:maxClass,cnst.crossVal,currClassifier); elapsedTime = toc;
    
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %% 创建随机森林分类器
% 
%    ntree=100;
%     mtry=30;
% %    model = classRF_train(P_train1,T_train1,ntree, mtry);
%  model=TreeBagger(ntree,source_target_limit_classes,T_train1,'NVarToSample',mtry);
%  
%  %% 仿真测试
% % [T_sim,votes] = classRF_predict(testN{k},model);
% [T_sim,votes] = predict(model,testN{k});
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           
    % save classifier (only for the highest number of different classes)
    if currNumClass == numel(maxClasses)
        save([cnst.saveDir,currClassifierName,'-CLASSIFIER.mat'],'trainedClassifier');
    end
    
	% display status
    disp([currClassifierName ' -> accuracy ', num2str(validationAccuracy)]); 
    disp([cnst.crossbar,10,10]);
    
    % save result to summary table
    summaryTable(countr).experiment =   countr;
    summaryTable(countr).classes =      maxClass;
    summaryTable(countr).samples =      size(source_target_limit_classes,1);
    summaryTable(countr).method =       currFSet;
    summaryTable(countr).features =     size(source_target_limit_classes,2)-1;
    summaryTable(countr).classifier =   currClassifier; 
    summaryTable(countr).crossVal =     cnst.crossVal;
    summaryTable(countr).enforceScale = cnst.scale;
    summaryTable(countr).time =         round(elapsedTime);
    summaryTable(countr).accuracy =     round(validationAccuracy,3);
    countr = countr + 1;
    
    % write result to summary grid
                                        % (strrep(char(currFSet),'-','_')).
    summaryGrid.(['numcl_',num2str(maxClass)]).(['cl_',char(currClassifier)])(featureID) = ...
        round(validationAccuracy,3);
    
    % optional: pause to avoid core overheat
    if cnst.noOverheat && (currNumClass<numel(maxClasses)), waitFor(elapsedTime,15); end

end

featureID = featureID + 1;

if cnst.showResults
    % create and save confusion matrix for last experiment
   showMyConfusionMatrix(ConfMat, currClassifierName, CatNames, cnst.saveDir);
% showMyConfusionMatrix(ConfMat, 'DNA-LBP_Classify_linSVM', CatNames, cnst.saveDir);
    % create and save ROC plot for last experiment
    AUC = showMyROC(ROCraw, currClassifierName, CatNames, cnst.saveDir);   
%      AUC = showMyROC(ROCraw,  'DNA-LBP_Classify_linSVM', CatNames, cnst.saveDir); 
    meanAUC = mean(cell2mat(AUC))
    stdAUC = std(cell2mat(AUC))
end 

end % end iteration through methods (feature sets)
meanAUC4=[meanAUC4 meanAUC];
 stdAUC4=[stdAUC4 stdAUC];
 acc4=[acc4 acc];
end % end iteration through classifier (classifier methods)
meanAUC10=[meanAUC10;meanAUC4];
 stdAUC10=[stdAUC10;stdAUC4];
 acc10=[acc10;acc4];
 toc
end
save meanAUC10 meanAUC10
save stdAUC10 stdAUC10
save acc10 acc10
mean(meanAUC10,1)
 mean(stdAUC10,1)
 mean(acc10,1)

%% SAVE RESULTS
% display all results as a table and play notification sound 
disp(cnst.crossbar);   struct2table(summaryTable);  sound(sin(1:0.3:800));
writetable(struct2table(summaryTable),[cnst.saveDir,randID,'_summary','.csv']);   
%%                
save([cnst.saveDir,randID,'_summary_grid','.mat'],'summaryGrid');

summaryGrid                                                                                                                                   

% play notification sound 
sound(sin(1:0.3:800)); disp('done all.');
toc
