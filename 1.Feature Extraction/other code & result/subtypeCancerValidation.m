function subtypeCancerValidation()
% validate the subtype of cancers detected by our methods

addpath .\lib\6_biomarkerCode;
load('.\lib\6_biomarkerCode\T.mat');

processAntibody = {'992','28202','13606','5922','1873','29722'};
processAntiTissue = {{'Breast','Lung','Thyroid_gland'},{'Lung'},{'Lung'},{'Thyroid_gland'},{'Lung'},{'Breast'}};
processAntiTissueCancer = {{'Breast cancer','Lung cancer','Thyroid cancer'},{'Lung cancer'},{'Lung cancer'},{'Thyroid cancer'},{'Lung cancer'},{'Breast cancer'}};

%  classify
cmethod = {'CC','BR'};
for i=1:length(processAntibody)
    antibody = processAntibody{i};
    for j=1:length(processAntiTissue{i})
        tissue = processAntiTissue{i}{j};
        tissueCancer = processAntiTissueCancer{i}{j};
        normalPath = ['./data/7_subtypeCancerValidation/' antibody '/normal/' tissue];
        listNormal = dir(normalPath);
        listNormal = listNormal(3:end);
       
        switch tissue
            case 'Breast'
                tissueCancer1 = 'Duct';
                tissueCancer2 = 'Lobular';
            case 'Lung'
                tissueCancer1 = 'Adenocarcinoma';
                tissueCancer2 = 'Squamous';
            case 'Thyroid_gland'
                tissueCancer1 = 'Follicular';
                tissueCancer2 = 'Papillary';
        end
        % cancer subtype 1
        cancerPath1 = ['./data/7_subtypeCancerValidation/' antibody '/cancer/' tissueCancer '/' tissueCancer1];
        listCancer1 = dir(cancerPath1);
        listCancer1 = listCancer1(3:end);
        cancerPath2 = ['./data/7_subtypeCancerValidation/' antibody '/cancer/' tissueCancer '/' tissueCancer2];
        listCancer2 = dir(cancerPath2);
        listCancer2 = listCancer2(3:end);
        
        numNormal = 0;
        numCancer1 = 0;
        numCancer2 = 0; 
        datapath = {};
        datapathCancer1={};
        datapathCancer2={};
        for db=1:10
            for c=1:length(cmethod)
                for n=1:length(listNormal)
                    numNormal = numNormal+1;
                    datapath{1}{numNormal}=['./data/5_prediction/lin_db' num2str(db) '/' antibody '/normal/' tissue '/' cmethod{c} '/' listNormal(n,1).name(1:end-3) 'mat'];
                end
                for n=1:length(listCancer1)
                    numCancer1 = numCancer1+1;
                    datapathCancer1{numCancer1}=['./data/5_prediction/lin_db' num2str(db) '/' antibody '/cancer/' tissueCancer '/' cmethod{c} '/' listCancer1(n,1).name(1:end-3) 'mat'];
                end
                for n=1:length(listCancer2)
                    numCancer2 = numCancer2+1;
                    datapathCancer2{numCancer2}=['./data/5_prediction/lin_db' num2str(db) '/' antibody '/cancer/' tissueCancer '/' cmethod{c} '/' listCancer2(n,1).name(1:end-3) 'mat'];
                end   
            end
        end
        writePath1 = ['./data/7_subtypeCancerValidation/' antibody '/cancer/' tissueCancer '/predict_result_' tissueCancer1 '.mat'];
        datapath{2}=datapathCancer1;
        results(datapath,writePath1,7,T);
        writePath2 = ['./data/7_subtypeCancerValidation/' antibody '/cancer/' tissueCancer '/predict_result_' tissueCancer2 '.mat'];
        datapath{2}=datapathCancer2;
        results(datapath,writePath2,7,T);
    end           
end
return


        