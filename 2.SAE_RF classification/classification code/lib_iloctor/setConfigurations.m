function [dbs, datamat, strs, num, criway, resultsFolder] = setConfigurations()
% set all the configurations
% 
% 1. set dbs
dbs = {'db1','db2','db3','db4','db5','db6','db7','db8','db9','db10'};

% 2. select the preparedData
datamat = './data/datasets/data.mat';
        
% 3. set the strs
disp(' ');
disp('1.Supervised-ADN   2.Supervised-BDN');
disp('3.Supervised-ADN+BDN');
disp('4.Semisupervised-AsemiB1');
disp('5.Semisupervised-AsemiBn ');
disp('6.Semisupervised-AsemiBC1');
disp('7.Semisupervised-AsemiBCn ');
strway = input('Select the strway:');
num = 0;
switch strway
    case 1
        strs = {'onlyA'};
    case 2
        strs = {'onlyB'};
    case 3
        strs = {'AB'};
    case 4
        strs = {'onlyA','AsemiB'};             
    case 5
        strs = {'AnsemiB'};
        disp('Training mode, 2 or 3 ?');
        num = input('');
    case 6
        strs = {'AsemiB','AsemiBC'};
    case 7
        strs = {'AnsemiBC'};
        disp('Training mode, 2 or 3 ?');
        num = input('');
    otherwise
        error('Please select the strway.');
end

% 4. the criterion to get label set
disp(' ');
disp('1.top criterion');
disp('2.dynamic criterion');
criway = input('Select the criterion:');


% 5. folder name of the experimental results
switch criway
    case 1
        resultsFolder = 'results_Tcriterion';
    case 2
        resultsFolder = 'results_Dcriterion';
    otherwise
        error('Please input the correct number !');
end
disp(' ');
disp(['The results will be saved in "' resultsFolder '"?']);
disp('1.Yes');
disp('2.No')
confirmway = input('Select the confirmway:');
if confirmway == 1
    disp(' ');
    disp('Begin!');
else
    error('Please check your configurations !');
end

             
        