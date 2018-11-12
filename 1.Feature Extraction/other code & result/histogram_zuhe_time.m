 format compact, clear all, close all; clc;tic
 y1=[];
 
CatNames = {'Best1', 'Best2', 'Best3','Best4'};
% load zuhe_dna_lbp_h.mat
% % acc10=1-acc10;
% % acc11=100*acc10(1,:);
% y1=[y1;zuhe];
% 
% load zuhe_dna_lbp_original.mat
% 
% y1=[y1;zuhe];
% 
% load zuhe_dna_h_original.mat
% y1=[y1;zuhe];
% 
% load zuhe_dna_lbp_h_original.mat
% y1=[y1;zuhe];

y1=[54.073018 30.860 45.489 57.240];
% y2=[y1(:,1:2) y1(:,4) y1(:,3)];
 y1=y1';
[m,n]=size(y1);

subplot(1,1,1),bar(y1)
set(gca, 'XTickLabel', CatNames) ; 
%  xlabel('original target positions');     
  ylabel('迭代一次消耗的时间（秒）'); 
for ii=1:m
    for jj=1:n
    str=sprintf('%4.2f',y1(ii,jj))
     text(ii+jj*0.01,y1(ii,jj)+0.5,str,'rotation',90);
    end
end
% text(3,-6,['\squre' '3'],'FontSize',12)
hi= legend('Best1', 'Best2', 'Best3','Best4' );
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