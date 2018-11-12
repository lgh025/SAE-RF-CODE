function Biomage_Feature_Extraction()
% The code is an implementation of feature extraction algorithms described in the paper:
% "Guang-Hui Liu*, Bei-Wei Zhang, Gang Qian, Bin Wang, Member, IEEE, and Bo Mao. Bioimage-based Prediction of Protein Subcellular Location in Human Tissue with Ensemble Features and Deep Networks."
% part of algorithms interface to Xu Y-Y, and Jakob Nikolas Kather et al.'s code.

close all, clear all, clc;
currentFolder = pwd;
addpath(genpath(currentFolder))

task = {'parse','separate','featcalc','classification','prediction','results'};
addPath;

antibody_ids = {'2384','17097','29804','2321','5853',...
                '3901','18884','5480','992','10638',...
                '37770','41788','1523','4479','28202','20637',...
                '6669','3890','6429','13606','30372', ...
               };

classlabels{1,1}={'Cytoplasm'};
classlabels{1,2}={'Cytoplasm'};
classlabels{1,3}={'Cytoplasm'};
classlabels{1,4}={'Cytoplasm'};
classlabels{1,5}={'Cytoplasm'};
classlabels{1,6}={'ER'};
classlabels{1,7}={'ER'};
classlabels{1,8}={'ER'};
classlabels{1,9}={'Golgi_apparatus'};
classlabels{1,10}={'Golgi_apparatus'};
classlabels{1,11}={'Lysosome'};
classlabels{1,12}={'Lysosome'};
classlabels{1,13}={'Mitochondria'};
classlabels{1,14}={'Mitochondria'};
classlabels{1,15}={'Mitochondria'};
classlabels{1,16}={'Mitochondria'};
classlabels{1,17}={'Nucleus'};
classlabels{1,18}={'Nucleus'};
classlabels{1,19}={'Nucleus'};
classlabels{1,20}={'Vesicles'};
classlabels{1,21}={'Vesicles'};
 

umet = {'lin','nmf'};  
dbs = {'db1','db2','db3','db4','db5','db6','db7','db8','db9','db10'};
featType = {'SLFs','SLFs_LBPs'}; %  'SLFs_LBPs_CL'
classifyMethod = {'BR','CC'};

for i1=1:length(antibody_ids)
    options.general.ANTIBODY_IDS = antibody_ids(i1);
    params = setOptions( options);
    data = prepareData( 'parse',params);
  handleData( data, params);
end
 features_all=[];
  writepath2 ='./data//features_21.mat';
     save features_all2   features_all 
    db10=cell(10,1); 
    label_all=[];
  writepath3 ='./data//label_21.mat';
     save writepath3  label_all 
    db_label10=cell(10,1);  
     number=0;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
id =2;
if (~strcmp(task{id},'results'))  
    for m = 2:length(featType) 
        options.featCalc.FEATTYPE = featType{m}; 
        for k=1:1    
            options.separate.UMETHOD = umet{k};        
            if strcmp(options.featCalc.FEATTYPE,'SLFs_LBPs') && strcmp(options.separate.UMETHOD,'nmf')
               continue;
            end
            for j=1:length(dbs)
               options.featCalc.FEATSET = dbs{j};
               switch task{id}
                    case 'separate'
                        for i=1:21
                            options.general.ANTIBODY_IDS = antibody_ids(i);
                            options.general.CLASSLABELS = classlabels(i);
                            params = setOptions( options);
                             number=i;
                            save numbers number
                            data = prepareData( 'separate',params);
                            handleData( data, params);
                        end                  
                  end
               end           
        end
    end
  
end     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
     
     
id =3;     
if (~strcmp(task{id},'results'))  
    for m = 2:length(featType) 
        options.featCalc.FEATTYPE = featType{m}; 
        for k=1:1    
            options.separate.UMETHOD = umet{k};        
            if strcmp(options.featCalc.FEATTYPE,'SLFs_LBPs') && strcmp(options.separate.UMETHOD,'nmf')
               continue;
            end
            for j=1:length(dbs)
               options.featCalc.FEATSET = dbs{j};
               switch task{id}
                    
                    case 'featcalc'
                        for i=1:length(antibody_ids)
                            options.general.ANTIBODY_IDS = antibody_ids(i);
                            params = setOptions( options);
%                            
                             number=i;
                            save numbers number
                            data = prepareData( 'featcalc',params);
                            handleData( data, params);
                        end                                                             
                    otherwise
               end
                load features_all2   features_all
                db10(j)={features_all};
                save db821.mat db10
                 load writepath3  label_all 
                db_label10(j)={label_all };
                save db_label821.mat db_label10
                if j>1
                    break
                end
            end

        end
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function addPath( dataroot)
%  addPath( DATAROOT)  initializes folder paths 
%    Input DATAROOT is by default './data'

if ~exist( 'dataroot','var')
    dataroot = 'data';
end

addpath ./lib/0_generalCode;
addpath ./lib/1_imageParseCode;
addpath ./lib/2_separationCode;
addpath ./lib/3_featureCode;
addpath ./lib/4_classificationCode;
addpath ./lib/5_predictionCode;
addpath ./lib/6_biomarkerCode;

addpath ./lib/3_featureCode/texture;
addpath ./lib/4_classificationCode/libsvm-mat-2.91-1;

directoryFun( '.', dataroot);
directoryFun( dataroot, '1_images');
directoryFun( dataroot, '2_separatedImages');
directoryFun( dataroot, '3_features');
directoryFun( dataroot, '4_classification');
directoryFun( dataroot, '5_prediction');
directoryFun( dataroot, '6_biomarkerResults');

function directoryFun( prnt, chld)
d = [prnt '/' chld];
if ~exist( d, 'dir')
    mkdir( prnt, chld);
end
    


