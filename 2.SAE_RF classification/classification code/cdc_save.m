tic
load CDC_DATA CDC_DATA;
 cdc_data=CDC_DATA{1,1};
%  save G:\Bioimaging based detection of mislocalized proteins in human cancers by semi-supervised learning\S-PSorter-master\code\data\CDC\CDC1 cdc1
save CDC1 cdc_data
cdc_data=CDC_DATA{2,1};
save CDC2 cdc_data
cdc_data=CDC_DATA{3,1};
save CDC3 cdc_data
cdc_data=CDC_DATA{4,1};
save CDC4 cdc_data
cdc_data=CDC_DATA{5,1};
save CDC5 cdc_data
cdc_data=CDC_DATA{6,1};
save CDC6 cdc_data
cdc_data=CDC_DATA{7,1};
save CDC7 cdc_data
cdc_data=CDC_DATA{8,1};
save CDC8 cdc_data
cdc_data=CDC_DATA{9,1};
save CDC9 cdc_data
cdc_data=CDC_DATA{10,1};
save CDC10 cdc_data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%LABEL
 load CDC_NUMBER18 CDC_NUMBER
 cdc_LABEL=CDC_NUMBER{1,1};
%  save G:\Bioimaging based detection of mislocalized proteins in human cancers by semi-supervised learning\S-PSorter-master\code\data\CDC\CDC1 cdc1
save cdc_LABEL18 cdc_LABEL
toc
