function [mark2,remain2] = getSemiData_2clasf(preLabel_a,outputs_a,preLabel_b,outputs_b,target,mark1,remain1,totalNum)

if size(preLabel_a,2)~=size(target,2) || size(preLabel_b,2)~=size(target,2) || size(preLabel_a,2)~= length(remain1) || length(remain1)+length(mark1)~= totalNum
    error('Please input the right data.');
end
mark2 = mark1;
num = length(remain1);

for i = 1:num
    pre_a = find(preLabel_a(:,i)==1);
    pre_b = find(preLabel_b(:,i)==1);
    tar = find(target(:,i)==1);
    output_a = outputs_a(:,i);
    output_b = outputs_b(:,i);

    % if pre_a = pre_b = target
    if isempty(setdiff(union(pre_a,pre_b),intersect(pre_a,pre_b)))...
            && isempty(setdiff(union(pre_a,tar),intersect(pre_a,tar))) 
       mark2 = [mark2, remain1(i)];
    end
end
remain2 = setdiff(1:totalNum,mark2);