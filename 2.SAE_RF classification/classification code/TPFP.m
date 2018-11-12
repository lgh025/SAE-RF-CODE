test_num=size(testlabels,2);
test_p_num=size(testlabels(testlabels==1),2);
tp = zeros(test_num,1);%1的个数
fp=zeros(test_num,1);
tn=zeros(test_num,1);%0的个数
fn=zeros(test_num,1);
tp1=0;
fp1=0;
tn1=0;
fn1=0;
index1 = 1;
index2 = 1;

for i=1:test_num

 if  ((testlabels(i)==1)&&( pred(i)==1))
     tp1=tp1+1;
%      index1 =index1+1;
 end
 if  ((testlabels(i)==1)&&( pred(i)==2))
     fn1=fn1+1;
 end

tp(i)=tp1;
fn(i)=fn1;

 if  ((testlabels(i)==2)&&(pred(i)==2))
     tn1=tn1+1;
 end
  if  ((testlabels(i)==2)&&( pred(i)==1))
     fp1=fp1+1;
 end

tn(i)=tn1;
fp(i)=fp1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


tpr=tp/(tp1+fn1);
fpr=fp/(fp1+tn1);
tnr=tn/(tn1+fp1);
fnr=fn/(fn1+tp1);

rates = [tnr tpr];


auc = CalculateAUC(rates)
plot(rates(:,1),rates(:,2));
set(gca,'FontName','Helvetica')
set(gca,'FontSize',12)
% set(gca,'xtick',[0 0.02 0.05 0.07 0.1 0.15 0.20 0.25 0.27 0.3 0.5 0.7 0.9 ]);
% % set(gca,'XSCALE','log');
% set(gca,'XMinorTick','off');
% hold on
string = {'ROC Curve';['AUC=' num2str(auc)]};
title(string)
% title('ROC Curve')
xlabel('false Positive Rate');
ylabel('Ture Positive  Rate');

text(0.5,0.3, 'AUC=');
text(0.6,0.3, num2str(auc));