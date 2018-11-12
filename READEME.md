The source code is an implementation of our method described in the paper "Guang-Hui Liu*, Bei-Wei Zhang, Gang Qian, Bin Wang, Member, IEEE, and Bo Mao. Bioimage-based Prediction of Protein Subcellular Location in Human Tissue with Ensemble Features and Deep Networks". 

--Dependence
Before running this code, you need install Matlab. In our experiment, Matlab R2015a and R2015b are tested. This code is tested in WINDOWS 7 64 Bit. It should be able to run in other Linux or Windows systems.

--How to run
   step1. In Matlab, run Biomage_Feature_Extraction.m in fold /SAE-RF CODE/1.Feature Extraction/. If the code runs successfully, the extracted biomage features and labels are saved as db821.mat and db_label821.mat,respectively.
   step2. After obtaining the specific feature representation in step1, copy features and labels to fold /SAE-RF CODE/2.SAE_RF classification/. In Matlab, run SAE_RF_main.m in fold /SAE-RF CODE/2.SAE_RF classification/. 
--Output
if the code runs successfully, the prediction results will be placed in /SAE-RF CODE/2.SAE_RF classification/zhibiao.mat. 

For your convenience, the independent validation dataset used in our paper are located in fold /SAE-RF CODE/1.Feature Extraction/testdata/data/1_images/.

Email:lgh025@163.com.
