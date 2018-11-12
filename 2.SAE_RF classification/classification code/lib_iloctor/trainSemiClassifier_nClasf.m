function trainSemiClassifier_nClasf( data,target,semiData,semiTarget,indeData_db,indeTarget,resultPath,n,criway)

markStr = strfind(resultPath,'/');
str = resultPath(markStr(end)+1:end); % str = 'A2semiB' or 'A3semiB' 
                                      % or 'A2semiBC' or 'A3semiBC'
iterNum = 25;  % At most iteration for iterNum times
semiNum = size(semiData,1); 
Model = cell(1,iterNum); 

switch str
    case {'A2semiB','A3semiB'}  
        if ~exist([resultPath '/labeledNum.mat'],'file')
            for i = 1:n
                labeledNum{i} = bootstrapSample(data);
            end
            save([resultPath '/labeledNum.mat'],'labeledNum');
        else
            load([resultPath '/labeledNum.mat']);
        end
        for i = 1:n
            trainData{i} = data(labeledNum{i},:);
            trainTarget{i} = target(:,labeledNum{i});
        end
        if ~exist([resultPath '/classifier_' str '_1.mat'],'file')
            for i = 1:n
                model_origin{i} = trainClassifier(trainData{i},trainTarget{i},...
                    ['1_' num2str(i) ],resultPath,criway);
            end
        else
            load([resultPath '/classifier_' str '_1.mat'],['model_' str]);
            eval(['model_origin = model_' str ';']);
        end
    case {'A2semiBC','A3semiBC'}
        ADataNum = size(data{1},1);
        data = [data{1};data{2}];
        loadPath = resultPath(1:end-1);
        if ~exist([loadPath '/done.mat'],'file')
            error(['Please first complete the ' str(1:end-1) ' data.']);
        else
            load([loadPath '/done.mat']);
        end
        % find the results of the best iteration
        bestiter = size(done,2);
        load([loadPath '/classifier_' str(1:end-1) '_' num2str(bestiter) '.mat'],['model_' str(1:end-1)]);
        eval(['model_origin = model_' str(1:end-1) ';']);
        load([loadPath '/labeledNum.mat']);
        load([loadPath '/markNum.mat']);
        for i = 1:n
            labeledNum{i} = [labeledNum{i} markNum{bestiter}{i}+ADataNum];
            trainData{i} = data(labeledNum{i},:);
            trainTarget{i} = target(:,labeledNum{i});
        end
        clear markNum done 
end

markNum = cell(1,iterNum); % The selected images on semiData in each iteration
remainNum = cell(1,iterNum); % The remained images on semiData in each iteration
for i = 1:iterNum
    Model{i} = cell(1,n); % At most iteration for iterNum times
    markNum{i} = cell(1,n); % The selected images on semiData in each iteration
    remainNum{i} = cell(1,n); % The remained images on semiData in each iteration
end
for i = 1:n
    markNum{1}{i} = [];
    remainNum{1}{i} = 1:semiNum;
end

flag = ones(1,n); % Flag to stop iteration
i = 1; % The round number
while (sum(flag)) % stop when all of flag are 0
    matPath = [resultPath '/classifier_' str '_' num2str(i) '.mat'];
    % train model
    if ~exist(matPath,'file')
        if i == 1
            Model{i} = model_origin;
        else
            for j = 1:n
                Model{i}{j} = trainClassifier([trainData{j}; semiData(markNum{i}{j},:)],...
                    [trainTarget{j} semiTarget(:,markNum{i}{j})],[ num2str(i) '_' num2str(j)],...
                    resultPath,criway);
            end
        end
        eval(['model_' str ' = Model{i};']);
        [evalCriteria, outputs_nClasf, ~] = testClassifier_nClasf(Model{i},indeData_db,indeTarget,criway);
        eval(['evalCriteria_' str ' = evalCriteria;']);
        eval(['outputs_' str ' = outputs_nClasf;']);
        save([resultPath '/classifier_' str '_' num2str(i) '.mat'], ['model_' str],['evalCriteria_' str],['outputs_' str]);
    else
        load(matPath);
        eval(['Model{i} = model_' str ';']);
        eval(['evalCriteria = evalCriteria_' str ';']);
        eval(['outputs_nClasf = outputs_' str ';']);
    end
    % done: row1 is subset accuracy; row2 is the p-value; row3 is the
    % number of added samples; row 4 is effect.
    done(1,i) = evalCriteria.subset_accuracy;
    if n == 2
        for j = 1:n
            [preLabel,outputs{j}] = testModel(Model{i}{j},semiData(remainNum{i}{3-j},:),criway); 
            [markNum{i+1}{3-j},remainNum{i+1}{3-j}] = getSemiData(preLabel,outputs{j},...
                semiTarget(:,remainNum{i}{3-j}),markNum{i}{3-j},remainNum{i}{3-j},semiNum);
        end 
        if i >= 2
            p = [];
            for j = 1:n
                [~,index] = ismember(remainNum{i}{3-j},remainNum{i-1}{3-j});
                [~,p_j] = ttest2(outputs_resc{j}(:,index),outputs{j}); 
                p = [p p_j];
            end
        end
    end
    if n == 3
        for j = 1:n 
            if j==1, j1=2; j2=3; end
            if j==2, j1=3; j2=1; end
            if j==3, j1=1; j2=2; end
            [preLabel1,outputs{j2}{j}] = testModel(Model{i}{j},semiData(remainNum{i}{j2},:),criway);
            [preLabel2,outputs{j2}{j1}] = testModel(Model{i}{j1},semiData(remainNum{i}{j2},:),criway);
            [markNum{i+1}{j2},remainNum{i+1}{j2}] = getSemiData_2clasf(preLabel1,outputs{j2}{j},...
                preLabel2,outputs{j2}{j1},semiTarget(:,remainNum{i}{j2}),markNum{i}{j2},remainNum{i}{j2},semiNum);     
        end
        if i>=2
            p = [];
            for j2 = 1:n
                if j2==1, j=2; j1=3; end
                if j2==2, j=3; j1=1; end
                if j2==3, j=1; j1=2; end
                [~,index] = ismember(remainNum{i}{j2},remainNum{i-1}{j2});
                [~,p_j] = ttest2(outputs_resc{j2}{j}(:,index),outputs{j2}{j}); 
                p = [p p_j];
                [~,p_j] = ttest2(outputs_resc{j2}{j1}(:,index),outputs{j2}{j1}); 
                p = [p p_j];
            end
        end
    end

    if i>=2
        done(2,i) = sum(p)/length(p);        
        for j = 1:n
            leMark(j) = length(markNum{i}{j}) - length(markNum{i-1}{j});
        end
        done(3,i) = sum(leMark)/n;
        done(4,i) = (done(3,i)/size(semiData,1))/done(2,i);

        for j = 1:n
            if isempty(setdiff(markNum{i}{j},markNum{i-1}{j}))
                flag(j) = 0;
            end
        end
    else
        done(2:4,i) = Inf;
    end
    outputs_resc = outputs;
    save([resultPath '/markNum.mat'],'markNum');

    if i == iterNum || done(4,i)<0.01 || done(2,i)==1
        flag = zeros(1,n);
    end
    i = i+1;    
end
save([resultPath '/done.mat'],'done');
    