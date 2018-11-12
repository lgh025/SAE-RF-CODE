function classifyPatterns(Data,cmethod,db,feattype,umethod)
%   Classification wrapper function. 

writepath = Data.writeData{1};
doofus = 1;
if doofus == 1
if exist( writepath,'file')
   return
end

    prp = writepath;
    prp((prp == '/') | (prp == '.')) = '_';
    pr = ['tmp/classifying_' prp '.txt'];
    if ~exist( pr,'file')
        fr = fopen( pr, 'w');
    else
        return
    end
end

featPaths = Data.pathData;
statsData = Data.statsData;
dataclass = Data.dataclass;
singleclass = Data.singleLabel;
classes = Data.classnumber;
tissueLabels = Data.tissueLabels;

% 1. Load data
s_fp = zeros(length(featPaths),1);
for i=1:length(featPaths)
    s_fp(i) = size(featPaths{i},2);
end
su_fp = sum(s_fp);
cs_fp = [0; cumsum( s_fp)]; cs_fp( end) = [];

tlabels = zeros( su_fp, 1);
alabels = zeros( su_fp,1);
stats = zeros( su_fp, 3);
images = []; images{su_fp} = [];
for i=1:length(featPaths)
    for j=1:s_fp(i)
        ind = cs_fp(i)+j;
        fid=fopen( statsData{i}{j},'r');  stat = fread(fid);  fclose(fid);
        stat(end)=[];  stat=char(stat)';  stat=str2num(stat);
        load( featPaths{i}{j});
        data(ind,:) = features;
        tlabels(ind) = tissueLabels{i}(j);
        stats(ind,:) = stat;
        images(ind) =  {[statsData{i}{j}(1:end-3) 'jpg']};
        idx_abID = find( statsData{i}{j}=='/');
        alabels(ind) = str2num( statsData{i}{j}(idx_abID(2)+1:idx_abID(3)-1));
        clabels{ind}=dataclass{i}{j};
        
    end
    if i==singleclass
        indx=ind;
    end
end

% 2. Remove bad images based on features/labels
% Remove cyan staining and images with too much black in them.
if strcmp(db,'db1')
    tmp=isnan(data);
    tmpp=zeros(3240,1);
    for i=1:3240
       tmpp(i) = sum(tmp(i,:));
    end
    ind_data=find(tmpp~=0);
    file_ind=[ Data.writedir '/' Data.str '/ind_data.mat'];
    save (file_ind,'ind_data');
else
    load(['./data//4_classification//' cmethod '/' feattype '/' umethod '_db1/ind_data.mat']);
end
   data(ind_data,:) = [];
   stats(ind_data,:) = [];
   clabels(ind_data) = [];
   tlabels(ind_data) = [];
   alabels(ind_data) = [];
   images(ind_data) = [];
   
for i=1:length(ind_data)
    if ind_data(i)<=indx
        indx=indx-1;
    end
end

ind = find(stats(:,1)>13);
data(ind,:) = [];
stats(ind) = [];
clabels(ind) = [];
tlabels(ind) = [];
alabels(ind) = [];
images(ind) = [];
for i=1:length(ind)
    if ind(i)<=indx
        indx=indx-1;
    end
end

% 3. Remove bad features
data = data(:,[2:end]);

% 4. Remove cases where there is only one tissue/location combination
sampleID = str2num([num2str(tlabels)]);
[c b] = hist( sampleID, [1:1:max(sampleID)]);
idx = find(c==1);

ind = zeros(size(idx));
for i=1:length(idx)
    ind(i) = find(sampleID==idx(i));
end

data(ind,:) = [];
stats(ind) = [];
clabels(ind) = [];
tlabels(ind) = [];
alabels(ind) = [];
images(ind) = [];

for i=1:length(ind)
    if ind(i)<=indx
        indx=indx-1;
    end
end


% 5. Data partitioning
% Done in the even tissues/class then even antibodies/class approach

alabels1=alabels(1:indx);
clabels1=clabels(1:indx);
data1=data(1:indx,:);
images1=images(1:indx);
tlabels1=tlabels(1:indx);

for i=1:length(clabels1)         
    clabels2(i,1)=cell2mat(clabels1(1,i));
    clabels2(i,1)=sym2poly(sym(clabels2(i,1)));
 end

u_c = unique( clabels2);
[u_Abs I J] = unique(alabels1);
bool = 0;
ttlist = zeros( size( clabels2));
for i=1:length(u_c)
    idx = find( clabels2==u_c(i));
    s_tlabels = tlabels1(idx);
    s_alabels = J(idx);
    
    [c_t u_t] = hist( s_tlabels, 1:1:53);
    u_t = u_t(c_t>0);
    
    for j=1:length(u_t)
        idx2 = find(s_tlabels==u_t(j));
        s2_alabels = s_alabels(idx2);
        [c_a u_a] = hist( s2_alabels, 1:1:max(u_Abs));
        u_a = u_a(c_a>0);
        
        for k=1:length(u_a)
            idx3 = find(s2_alabels==u_a(k));
            my_idx = mod(bool:bool+length(idx3)-1,2)+1;
            if mod( length(idx3), 2)
                bool = mod(bool + 1,2);
            end
            ttlist(idx(idx2(idx3))) = my_idx;
        end
    end
end

set1_labels = clabels2(ttlist==1);
set2_labels = clabels2(ttlist==2);
set1_labels_tissue = tlabels(ttlist==1);
set2_labels_tissue = tlabels(ttlist==2);
set1_labels_antibody = alabels(ttlist==1);
set2_labels_antibody = alabels(ttlist==2);
set1_images = images(ttlist==1);
set2_images = images(ttlist==2);

set1_data = data(ttlist==1,:);
set2_data = data(ttlist==2,:);

target=zeros(classes,length(data))-1;

for i=1:classes
    ind=find(clabels2==i);
    target(i,ind)=1;
end
set1_target=target(:,ttlist==1);
set2_target=target(:,ttlist==2);

for i=(indx+1):length(data)
    i1=clabels{i}(1);
    target(i1,i)=1;
    i2=clabels{i}(2);
    target(i2,i)=1;
    if length(clabels{i})==3
       i3=clabels{i}(3);
       target(i3,i)=1;
    end
end

[dd,d]=size(set1_data);
[ee,e]=size(set2_data);
tt=dd;
 
for i=(indx+1):length(data)
        if rem(i,2)==1
            dd=dd+1;
            set1_data(dd,:)=data(i,:);
            set1_target(:,dd)=target(:,i);
        end
        if rem(i,2)==0
            ee=ee+1;
            set2_data(ee,:)=data(i,:);
            set2_target(:,ee)=target(:,i);
        end
end

% define traindata and testdata
traindata=set1_data;
testdata=set2_data;
traintarget=set1_target;
testtarget=set2_target;
trainlabels=set1_labels;
testlabels=set2_labels;
trainlabels_tissue=set1_labels_tissue;
testlabels_tissue=set2_labels_tissue;
trainlabels_antibody=set1_labels_antibody;
testlabels_antibody=set2_labels_antibody;
trainimages=set1_images;
testimages=set2_images;

% 6. Feature selection by SDA
[train_data,test_data] = featnorm( traindata, testdata);
train_data = double( train_data*2-1);
test_data = double(test_data*2-1);

 u = unique( trainlabels);
 feat = []; feat{length(u)} = [];
 for i=1:length(u)
     feat{i} = train_data( trainlabels==u(i), :);
 end
 logfilename = [writepath '_sdalog.txt'];
 idx_sda = ml_stepdisc( feat,logfilename);
 
% 7. Classification

    if strcmp(cmethod,'BR')
        [outputs,Pre_Labels,model,T,outputs_train]=BR(train_data(:,idx_sda),traintarget,test_data(:,idx_sda),testtarget);
    else
        if  strcmp(cmethod,'CC')
           [outputs,Pre_Labels,model,T,outputs_train]=CC(train_data(:,idx_sda),traintarget,test_data(:,idx_sda),testtarget);
        end
    end

% 8. Evaluate metrics

  subset_accuracy = S_accuracy(Pre_Labels,testtarget);
  [accuracy,recall,precision] = Accuracy(Pre_Labels,testtarget);
  [label_accuracy, average_label_accuracy] = L_accuracy(Pre_Labels,testtarget);
  
     
save( writepath, 'model','idx_sda','Pre_Labels','outputs',...
    'accuracy','precision','recall','subset_accuracy','label_accuracy','average_label_accuracy',...
    'traintarget','testtarget','traindata','testdata','classes',...
    'trainlabels_tissue','testlabels_tissue','trainlabels_antibody','testlabels_antibody',...
    'trainimages','testimages','T','outputs_train');

if doofus ==1
    fclose(fr);
    delete(pr);
end

return
