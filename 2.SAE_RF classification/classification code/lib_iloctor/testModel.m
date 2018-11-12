function [preTable,outputs] = testModel(model,testData,criway)
% 1. Normalization
for i=1:size(testData,2)
    testData(:,i) = testData(:,i) - model.MI(i);
    testData(:,i) = testData(:,i) / model.MA(i);
end
testData(testData>1)=1;
testData(testData<0)=0;
testData = double(testData*2-1);

% 2. Test
dataNum = size(testData,1);
outputs = zeros(6,dataNum);
 for i=1:6 
    eval(['model_br = model.model_' num2str(i) ';']);
    % predict testing set
    [~, ~, dec_values] = svmpredict(ones(dataNum,1), testData(:,model.idx_sda), model_br);
    dec_values=dec_values';
    if(model_br.Label(1)==1)
        outputs(i,:)=dec_values(1,:);
    else
        outputs(i,:)=-dec_values(1,:);
    end
 end

if criway==2
    preTable = getLabelset(outputs,criway,model.cons,model.sita);
else
    preTable = getLabelset(outputs,criway);
end
 