function makeTable()
% make_tables:  a wrapper script that make the table containing the testing 
% results of classifiers.

methods={'BR','CC'};
featType = {'SLFs','SLFs_LBPs'};
unmix={'lin'};   % unmix={'lin','nmf'};
dbs={'db1','db2','db3','db4','db5','db6','db7','db8','db9','db10'};
count=length(methods)*length(featType)*length(unmix)*length(dbs);

table.methods = [];
table.methods{count} = [];
table.subset = [];
table.subset{count} = [];
table.Accuracy = [];
table.Accuracy{count} = [];
table.recall = [];
table.recall{count} = [];
table.precision = [];
table.precision{count} = [];
table.average_label = [];
table.average_label{count} = [];

table.cytoplasm = [];
table.cytoplasm {count} = [];
table.ER = [];
table.ER{count} = [];
table.golgi = [];
table.golgi{count} = [];
table.lysosome = [];
table.lysosome{count} = [];
table.mitochondria = [];
table.mitochondria{count} = [];
table.nuclues = [];
table.nuclues{count} = [];
table.vesicles = [];
table.vesicles{count} = [];

counter=0;
for i = 1:length(methods)
    c_method = methods{i};
    for j = 1:length(featType)
        f_method = featType{j};
        for k = 1:length(unmix)
           u_method = unmix{k};
           if strcmp(f_method,'SLFs_LBPs')&&strcmp(u_method,'nmf')
               continue;
           end
           for n = 1:length(dbs)
               d_method = dbs{n};               
               counter=counter+1;
               % load
               files=['data/4_classification/' c_method '/' f_method '/' u_method '_' d_method '/classifier.mat'];
               load(files);
               
               table.methods{counter} = [c_method '_' f_method '_' u_method '_' d_method];
               table.subset{counter} = num2str(subset_accuracy);
               table.Accuracy{counter} = num2str(accuracy);
               table.recall{counter} = num2str(recall);
               table.precision{counter} = num2str(precision);
               table.average_label{counter} = num2str(average_label_accuracy);

               table.cytoplasm{counter}=num2str(label_accuracy(1));
               table.ER{counter}=num2str(label_accuracy(2));
               table.golgi{counter}=num2str(label_accuracy(3));
               table.lysosome{counter}=num2str(label_accuracy(4));
               table.mitochondria{counter}=num2str(label_accuracy(5));
               table.nuclues{counter}=num2str(label_accuracy(6));
               table.vesicles{counter}=num2str(label_accuracy(7));  
           end
        end
    end
end

fid = fopen( 'testResults.csv','w');
fwrite( fid, ['methods,Subset accuracy,Accuracy,recall,precision,Average label,cytopl,ER,golgi,lyso,mito,nucl,vesi' char(10)]);
for i=1:counter
    str = [table.methods{i} ',' table.subset{i} ',' table.Accuracy{i} ',' table.recall{i} ...
        ',' table.precision{i} ',' table.average_label{i} ',' table.cytoplasm{i} ',' table.ER{i} ',' table.golgi{i} ...
        ',' table.lysosome{i} ',' table.mitochondria{i} ',' table.nuclues{i} ...
        ',' table.vesicles{i} char(10)];
    fwrite( fid, str);
end