tic
load DATA629_ADN_BDN ADN_BDN_DATA
 cdc_data=ADN_BDN_DATA{1,1};
%  save G:\Bioimaging based detection of mislocalized proteins in human cancers by semi-supervised learning\S-PSorter-master\code\data\CDC\CDC1 cdc1
save ADN_BDN1 cdc_data
cdc_data=ADN_BDN_DATA{2,1};
save ADN_BDN2 cdc_data
cdc_data=ADN_BDN_DATA{3,1};
save ADN_BDN3 cdc_data
cdc_data=ADN_BDN_DATA{4,1};
save ADN_BDN4 cdc_data
cdc_data=ADN_BDN_DATA{5,1};
save ADN_BDN5 cdc_data
cdc_data=ADN_BDN_DATA{6,1};
save ADN_BDN6 cdc_data
cdc_data=ADN_BDN_DATA{7,1};
save ADN_BDN7 cdc_data
cdc_data=ADN_BDN_DATA{8,1};
save ADN_BDN8 cdc_data
cdc_data=ADN_BDN_DATA{9,1};
save ADN_BDN9 cdc_data
cdc_data=ADN_BDN_DATA{10,1};
save ADN_BDN10 cdc_data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%LABEL
 load NUMBER629_ADN_BDN ADN_BDN_NUMBER
 cdc_LABEL=ADN_BDN_NUMBER{1,1};
%  save G:\Bioimaging based detection of mislocalized proteins in human cancers by semi-supervised learning\S-PSorter-master\code\data\CDC\CDC1 cdc1
save cdc_LABEL_ADN_BDN cdc_LABEL
toc
