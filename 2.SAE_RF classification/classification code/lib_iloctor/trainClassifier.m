function model = trainClassifier(data,target,str,writePath,criway)
  
% 1. Normalization
MI = min(data,[],1);
MA = MI;
for i=1:size(data,2)
    data(:,i) = data(:,i) - MI(i);
    MA(i) = max(data(:,i));
    data(:,i) = data(:,i) / MA(i);
end
data = double(data*2-1);
model.MI = MI; model.MA = MA;

% 2. Feature selection
logname = [writePath '/' str];
idx_sda = sda(data,target,logname);
trainData = data(:,idx_sda);
model.idx_sda = idx_sda;

% 3. Train model
num_class = size(target,1); 
c = 128;
acc_cv = zeros(num_class,length(c)+1);
for i=1:num_class 
    target_i = target(i,:);
    target_i(target_i==-1)=2;
    beta = Getkernel_Supervised(trainData',target_i); % GFO
    for m=1:length(c),
        options = ['-v 10 -c ' num2str(c(m)) ' -g ' num2str(1/beta)];
        acc_cv(i,m) = svmtrain( target(i,:)', trainData, options);
    end
    [~, row] = max(acc_cv(i,:));
    acc_cv(i,m+1) = 1/beta;
    str= ['-c ' num2str(c(row)) ' -g ' num2str(1/beta) ' -b 1'];
    modelbr = svmtrain(target(i,:)',trainData,str);
    eval(['model.model_' num2str(i) '= modelbr;']);
end
model.acc_cv = acc_cv;

if criway==2 
    % outputs are determined by 5-fold validation 
    foldNum = 5;
    outputs = OutputsByFold(trainData,target,num_class,foldNum);         
    [model.cons,model.sita] = fitSita(outputs,target);
end  
  
    