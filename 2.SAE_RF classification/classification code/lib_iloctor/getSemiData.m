function [mark2,remain2] = getSemiData(preLabel,outputs,target,mark1,remain1,totalNum)

if size(preLabel,2)~=size(target,2) || size(preLabel,2)~= length(remain1) || length(remain1)+length(mark1)~= totalNum
    error('Please input the right data.');
end
mark2 = mark1;
num = length(remain1);

for i = 1:num
    pre = find(preLabel(:,i)==1);
    tar = find(target(:,i)==1);
    output = outputs(:,i);
    % if pre = target
    if isempty(setdiff(union(pre,tar),intersect(pre,tar))) 
       mark2 = [mark2, remain1(i)];
    end
end
remain2 = setdiff(1:totalNum,mark2);
