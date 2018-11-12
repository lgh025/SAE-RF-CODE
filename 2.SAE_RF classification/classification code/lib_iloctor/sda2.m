function idx_sda = sda2(data,target,logPath)
% feature selection using SDA.

% only use single-label samples
% classNum = 1:size(target,1);
classNum = unique(target);
feat = []; feat{length(classNum)} = [];
for i=1:length(classNum)
    ind = [];
    for j=1:length(target)
        if (target(j,1)==i )
            ind=[ind j];
        end
    end
    feat{i} = data(ind, :);
end

logfilename = [logPath '_sdalog.txt'];
idx_sda = ml_stepdisc( feat,logfilename);
