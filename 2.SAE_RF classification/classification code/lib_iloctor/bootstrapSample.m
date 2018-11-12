function labeled_i = bootstrapSample(labeledData)
% bootstrap sampling

dataNum = size(labeledData,1);
labeled_i = [];
for i=1:dataNum
    y = randsample(dataNum,1);
    labeled_i = [labeled_i,y];
end
labeled_i = unique(labeled_i);
