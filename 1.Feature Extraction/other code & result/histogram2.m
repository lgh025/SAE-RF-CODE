 format compact, clear all, close all; clc;tic
 y1=[];
 
CatNames = {'Histogram', 'GLCM', 'Perceptual', 'Gabor', 'DNA', ...
        'Haralick', 'LBP'};
load acc10.mat
acc10=1-acc10;
acc11=100*acc10(1,:);
y1=[y1;acc11];

load acc10_glcm.mat
acc10=1-acc10;
acc11=100*acc10(1,:);
y1=[y1;acc11];

load acc10_per.mat
acc10=1-acc10;
acc11=100*acc10(1,:);
y1=[y1;acc11];

load acc10_gabor.mat
acc10=1-acc10;
acc11=100*acc10(1,:);
y1=[y1;acc11];

load acc10_dna.mat
acc10=1-acc10;
acc11=100*acc10(1,:);
y1=[y1;acc11];

load acc10_haralick810.mat
acc10=1-acc10;
acc11=100*acc10(1,:);
y1=[y1;acc11];

load acc10_lbp.mat
acc10=1-acc10;
acc11=100*acc10(1,:);
y1=[y1;acc11];
y2=[y1(:,1:2) y1(:,4) y1(:,3)];
y1=y2;
[m,n]=size(y1);

subplot(1,1,1),bar(y1)
set(gca, 'XTickLabel', CatNames) ; 
%  xlabel('original target positions');     
 ylabel('cross-validation classifiction error (%)'); 
for ii=1:m
    str=sprintf('%4.2f',y1(ii,n))
     text(ii+0.02,y1(ii,n)+0.5,str,'rotation',90);
end
% text(3,-6,['\squre' '3'],'FontSize',12)
hi= legend('1-NN', 'ensTree', 'rbfSVM','linSVM' );
% 高级用法3：legend横排
% hl = legend(H([1 6 11 16 21],'1,'6','11’,'16','21');
set(hi,'Orientation','horizon')
% 高级用法4：不显示方框：
% hl = legend(H([1 6 11 16 21],'1,'6','11’,'16','21');
set(hi,'Box','off');
z=title('pure feature set error rate over 4 classifiers');
% set(z,'FontSize',10,'Color','k')
% x=[5 9 11];
% subplot(2,2,2),bar3(x,y)
% subplot(2,2,3),bar(x,y,'grouped')
% subplot(2,2,4),bar(rand(2,3),.75,'stack')
toc