function predict(featPaths,writepath, classifierpath,cmethod,class)
    
doofus = 1;
if doofus == 1
    if exist( writepath,'file')
        return
    end

    prp = writepath;
    prp((prp == '/') | (prp == '.')) = '_';
    pr = ['tmp/predicting_' prp '.txt'];
   if ~exist( pr,'file')
        fr = fopen( pr, 'w');
   else
        return
   end
end

if ~exist (classifierpath, 'file')
    error( 'Please train classifiers before prediction.');
end

load(featPaths);
features = features(:,2:end);

[outputs,T] = getScores(classifierpath,features,cmethod,class);

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
prelabel(prelabel==0)=-1;    
  
save( writepath, 'outputs','prelabel');
if doofus ==1
    fclose(fr);
    delete(pr);
end

return
