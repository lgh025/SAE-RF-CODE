function results(datapath,writepath,class,T)
% Compare predictions in normal and cancer condtions and save the
% biomarker information. 

if exist(writepath,'file')
    return
end
prp = writepath;
prp((prp == '/') | (prp == '.')) = '_';
pr = ['tmp/detecting_' prp '.txt'];
if ~exist( pr,'file')
    fr = fopen( pr, 'w');
else
    return
end

classifierNum=20;
normalNum=length(datapath{1})/classifierNum;
cancerNum=length(datapath{2})/classifierNum;
normal_scores=zeros(normalNum,class);
cancer_scores=zeros(cancerNum,class);

% normal scores
for i=1:normalNum
    outputs_tmp = zeros(1,class);
    for j=i:normalNum:length(datapath{1})
        load(datapath{1}{j},'outputs');
        outputs_tmp=outputs_tmp+outputs';
    end
    normal_scores(i,:)=outputs_tmp/classifierNum;
end

% cancer scores
for i=1:cancerNum
    outputs_tmp = zeros(1,class);
    for j=i:cancerNum:length(datapath{2})
        load(datapath{2}{j},'outputs');
        outputs_tmp=outputs_tmp+outputs';
    end
    cancer_scores(i,:)=outputs_tmp/classifierNum;
end

% cancer label 
tmpAdd_c = ones(1,cancerNum);
cancer_scores_aver = (tmpAdd_c*cancer_scores)./cancerNum;
[label_c,ind_c] = getLabel(cancer_scores_aver,T);

% normal label 
tmpAdd_n = ones(1,normalNum);
normal_scores_aver = (tmpAdd_n*normal_scores)./normalNum;
[label_n,ind_n] = getLabel(normal_scores_aver,T);

[h,p_value]=ttest2(cancer_scores,normal_scores,0.01); 

flag = 0;
if ~strcmp(label_n,label_c) % label sets are different
    d = setdiff(union(ind_c,ind_n),intersect(ind_c,ind_n)); % changed locations
    e = intersect(ind_c,ind_n);
     if h(:,d)==1
        if (normal_scores_aver(:,d).* cancer_scores_aver(:,d)<0)
            flag =1;
        else
            flag = 0;
        end
     else
        flag = 0;
     end
else
    flag = 0;
end

if flag==1
    biomarker = 'yes';
else
    biomarker = 'no';
end
save(writepath,'h','p_value','normal_scores_aver','cancer_scores_aver','biomarker','label_n','label_c');
fclose(fr);
delete(pr);

function [str,ind] = getLabel(outputs,T)
prelabel_1 = -zeros(1,7);
prelabel_2 = -zeros(1,7);

[maximum,index]=max(outputs);
 % Top criterion
 if(max(outputs) <= 0) 
     prelabel_1(index)=1;
 else
     prelabel_1(outputs>0)=1;
 end

  % using threshold
  prelabel_2(maximum-outputs<T)=1;

  prelabel = prelabel_1 & prelabel_2;
  prelabel = single(prelabel);
  
 str = '';
 ind = find(prelabel==1);
 for i = 1:length(ind)
         switch ind(i)
             case 1
                 str = [str '   Cytoplasm'];
                 continue;
             case 2
                 str = [str '   ER'];
                 continue;
             case 3
                 str = [str '   Golgi apparatus'];
                 continue;
             case 4
                 str = [str '   Lysosome'];
                 continue;
             case 5
                 str = [str '   Mitochondria'];
                 continue;
            case 6
                 str = [str '   Nucleus'];
                 continue;
            case 7
                 str = [str '   Vesicles'];
                 continue;
         end
 end      
 