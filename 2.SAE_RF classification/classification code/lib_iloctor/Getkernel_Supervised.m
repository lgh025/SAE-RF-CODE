function beta = Getkernel_Supervised(data,label)

[totalSize, dim] = size(data);
sampleSize(1) = length(find(label == 1));
sampleSize(2) = length(find(label == 2));
data2Sum = zeros(1, totalSize);
for i = 1 : totalSize
    for j = 1 : dim
        data2Sum(1, i) = data2Sum(1, i) + data(i, j) * data(i, j);
    end
end
dist1 = 0;
dist2 = 0;
for i = 1 : totalSize
    for j = i : totalSize
        tmp = 0;
        for k = 1 : dim
            tmp = tmp + data(i, k) * data(j, k);
        end
        dist = sqrt(data2Sum(1, i) + data2Sum(1, j) - 2 * tmp);
        if (i <= sampleSize(1) && j <= sampleSize(1)) || (i >= sampleSize(1) + 1 && j >= sampleSize(1) + 1)
            if i == j
                dist1 = dist1 + dist;
            else
                dist1 = dist1 + 2 * dist;
            end
        end
        if i <= sampleSize(1) && j >= sampleSize(1) + 1
            dist2 = dist2 + 2 * dist;
        end
    end
end
lend1 = 0;
lend1 = lend1 + sampleSize(1) * sampleSize(1) + sampleSize(2) * sampleSize(2);
lend2 = totalSize * totalSize - lend1;
lend1 = lend1 - totalSize;
beta = (dist1 + dist2) / (lend1 + lend2);
beta = 2 * (beta^2);