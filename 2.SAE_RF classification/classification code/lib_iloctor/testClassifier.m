function [evalCriteria, outputs, preTable] = testClassifier(model,testData,testTarget,criway)

% 1. Test
[preTable,outputs] = testModel(model,testData,criway);
 
% 2. Evaluation
evalCriteria.subset_accuracy = S_accuracy(preTable,testTarget);
[evalCriteria.accuracy,evalCriteria.recall,evalCriteria.precision] = Accuracy(preTable,testTarget);
[evalCriteria.label_accuracy, evalCriteria.average_label_accuracy] = L_accuracy(preTable,testTarget);
