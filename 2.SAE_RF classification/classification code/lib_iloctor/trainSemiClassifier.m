function trainSemiClassifier(model_origin, data,target,semiData,semiTarget,indeData_db,indeTarget,resultPath,criway)

markStr = strfind(resultPath,'/');
str = resultPath(markStr(end)+1:end); % str = 'AsemiB' or 'AsemiBC'
semiNum = size(semiData,1);
iterNum = 25;
Model = cell(1,iterNum); % At most iteration for 25 times
markNum = cell(1,iterNum); % The selected images on semiData in each iteration
remainNum = cell(1,iterNum); % The remained images on semiData in each iteration
markNum{1} = [];
remainNum{1} = 1:semiNum;

flag = 1; % Flag to stop iteration
i = 1; % The round number
while (flag)
    matPath = [resultPath '/classifier_' str '_' num2str(i) '.mat'];
    if ~exist(matPath,'file')
        if i == 1
            Model{i} = model_origin;
        else
            Model{i} = trainClassifier([data; semiData(markNum{i},:)],[target semiTarget(:,markNum{i})],...
                num2str(i),resultPath,criway);
        end
        eval(['model_' str ' = Model{i};']);
        eval(['[evalCriteria, outputs, ~] = testClassifier(model_' str ',indeData_db,indeTarget,criway);']);
        eval(['evalCriteria_' str ' = evalCriteria;']);
        eval(['outputs_' str ' = outputs;']);
        save(matPath, ['model_' str],['evalCriteria_' str],['outputs_' str]);
    else
        load(matPath);
        eval(['Model{i} = model_' str ';']);
        eval(['evalCriteria = evalCriteria_' str ';']);
        eval(['outputs = outputs_' str ';']);
    end
    % done: row1 is subset accuracy; row2 is the p-value; row3 is the
    % number of added samples; row 4 is effect.
    done(1,i) = evalCriteria.subset_accuracy;
    [preLabel,outputs_semi] = testModel(Model{i},semiData(remainNum{i},:),criway);
    [markNum{i+1},remainNum{i+1}] = getSemiData(preLabel,outputs_semi,semiTarget(:,remainNum{i}),...
        markNum{i},remainNum{i},semiNum);
    if i>=2
        [~,index] = ismember(remainNum{i},remainNum{i-1});
        [~,p] = ttest2(outputs_semi_resc(:,index),outputs_semi); 
        done(2,i) = sum(p)/size(outputs_semi,2); 
        done(3,i) = length(markNum{i}) - length(markNum{i-1});
        done(4,i) = (done(3,i)/size(semiData,1))/done(2,i);
    else
        done(2:4,i) = Inf;
    end
    outputs_semi_resc = outputs_semi;
    save([resultPath '/markNum.mat'],'markNum');
    
    % stopping condition
    if isempty(setdiff(markNum{i+1},markNum{i})) || done(4,i)<= 0.01 || i == iterNum
        flag = 0;
    end
    i = i+1;
end
save([resultPath '/done.mat'],'done');