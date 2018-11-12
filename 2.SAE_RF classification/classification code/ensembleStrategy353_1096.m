 function ensembleAccuracy=ensembleStrategy(testLabel,predictLabel,q)
%The code is a modification of part of SC-PSorte by W. Shao et al.
%The person who uses this code is expected to cite the following two papers:
% "Guang-Hui Liu, Hong-Bin Shen, and Dong-Jun Yu. Prediction of Protein-Protein Interaction Sites with Machine Learning based Data-Cleaning and Post-Filtering Procedures." 
% "W. Shao, M. Liu, and D. Zhang, ¡°Human cell structure-driven model construction for predicting protein subcellular location from biological images,¡± Bioinformatics, pp. btv521, 2015."

db1=[];db2=[];db3=[];db4=[];db5=[];db6=[];db7=[];db8=[];db9=[];db10=[];
Label=[];

for j=q:q
Label=[Label; testLabel{1,j}]; 
db1=[db1;predictLabel{1,j}'];
db2=[db2;predictLabel{2,j}'];
db3=[db3;predictLabel{3,j}'];
db4=[db4;predictLabel{4,j}'];
db5=[db5;predictLabel{5,j}'];
db6=[db6;predictLabel{6,j}'];
db7=[db7;predictLabel{7,j}'];
db8=[db8;predictLabel{8,j}'];
db9=[db9;predictLabel{9,j}'];
db10=[db10;predictLabel{10,j}'];
end

db=[db1,db2,db3,db4,db5,db6,db7,db8,db9,db10];

for i=1:10
 Accuracy(i)=length(find(mode(db')==Label'))/length(Label);
 Accuracy_best(i)=length(find(db(:,i)'==Label'))/length(Label);
end
ensembleAccuracy=max(Accuracy);
save ensembleAccuracy.txt ensembleAccuracy -ascii -append

 end