function ind = splitData(dataNum,foldNum)
ind = cell(1,foldNum);

% random split
eachNum = floor(dataNum/foldNum);
num = eachNum * ones(1,foldNum);
a = rem(dataNum,foldNum);
if a~=0
    num(1:a) = eachNum + 1;
end
remain = 1:dataNum;
selected = [];
for i = 1:foldNum-1
    indi = randsample(1:length(remain),num(i));
    ind{i} = sort(remain(indi));
    selected = [selected ind{i}];
    remain = setdiff(remain,selected);
end
ind{foldNum} = sort(remain);
