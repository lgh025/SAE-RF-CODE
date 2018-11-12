function [evalCriteria, outputs, preTable] = testClassifier_nClasf(model,testData,testTarget,criway)
% The difference between testClassifier_nClasf.m and testClassifier.m is
% that the former tests n models with the 'model' contains n classifiers.

n = length(model);
outputs = zeros(size(testTarget));
% 1. Test
for i = 1:n
    [~,output_i] = testModel(model{i},testData,criway);
    outputs = outputs + output_i;
end
outputs = outputs/n;

if criway == 2
    cons=[]; sita=[];
    for i=1:n
        cons = [cons model{i}.cons];
        sita = [sita model{i}.sita];
    end
    preTable = getLabelset(outputs,criway,cons,sita);
else
    preTable = getLabelset(outputs,criway);
end
 
% 2. Evaluation
evalCriteria.subset_accuracy = S_accuracy(preTable,testTarget);
[evalCriteria.accuracy,evalCriteria.recall,evalCriteria.precision] = Accuracy(preTable,testTarget);
[evalCriteria.label_accuracy, evalCriteria.average_label_accuracy] = L_accuracy(preTable,testTarget);