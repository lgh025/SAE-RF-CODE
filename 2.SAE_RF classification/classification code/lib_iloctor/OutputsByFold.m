function outputs = OutputsByFold(trainData,target,num_class,foldNum)
% get outputs by foldNum fold
trainData = double(trainData);
trainInd = splitData(size(trainData,1),foldNum);
trainNum = size(trainData,1);
outputs = zeros(num_class,trainNum);
for i = 1:foldNum
    testdata = trainData(trainInd{i},:);
    testtarget = target(:,trainInd{i});
    traindata = trainData(setdiff(1:trainNum,trainInd{i}),:);
    traintarget = target(:,setdiff(1:trainNum,trainInd{i}));
    % train
    for j = 1:num_class
        str= '-c 128 -g 0.0625 -b 1';
        model_tmp(j,1) = svmtrain(traintarget(j,:)',traindata,str);
    end
    % test
    for j = 1:num_class
        [~, ~, dec_values] = svmpredict(testtarget(j,:)', testdata, model_tmp(j,1));
        if(model_tmp(j,1).Label(1)==1)
            outputs(j,trainInd{i})=dec_values(:,1)';
        else
            outputs(j,trainInd{i})=-dec_values(:,1)';
        end
    end
end
