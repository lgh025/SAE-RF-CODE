    % Get T of ensembled classifier
    file = 'data\4_classification\BR\SLFs_LBPs\lin_db1\classifier.mat';
    if ~exist(file,'file')
        error('Please train classifiers before prediction.');
    else
        load(file,'outputs_train','traintarget');
    end
    sum_outputs = zeros(size(outputs_train));
    
    for i = 1:length(classifyMethod)   
       for j = 1:length(dbs)
           file = ['data\4_classification\' classifyMethod{i} '\SLFs_LBPs\lin_' dbs{i} '\classifier.mat'];
           load(file,'outputs_train');
           sum_outputs = sum_outputs + outputs_train;
       end
    end
    aver_outputs = sum_outputs/20;
    T = getT(aver_outputs,traintarget);
    save ('lib\6_biomarkerCode\T.mat','T');