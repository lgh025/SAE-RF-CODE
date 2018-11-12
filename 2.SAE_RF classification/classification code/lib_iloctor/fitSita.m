function [cons,sita] = fitSita(outputs,target)
n1 = 0;
n2 = 0;
si1 = [];
si2 = [];
num = size(outputs,2);
if (size(outputs)~=size(target))
    error( 'The size of two inputs are not match.');
end
for i = 1:num
     [tmp,IX]=sort(outputs(:,i),'descend');
     realLabel = find(target(:,i) == 1);
     le = length(realLabel);
     if ~isempty(setdiff(realLabel,IX(1:le))) || tmp(1)<=0
         continue;
     end
     
     si1 = [si1 tmp(1:le)'];
     si2 = [si2 tmp'];
          
     if le==1        
         n1=n1+1;
         dif1(n1)=(tmp(1)-tmp(2))/tmp(1);
     end
     
     if le==2   
        n1=n1+1;
        dif1(n1)=(tmp(1)-tmp(3))/tmp(1);
        n2=n2+1;
        dif2(n2)=(tmp(1)-tmp(2))/tmp(1);       
     end
     
    if le==3  
       n1=n1+1;
       dif1(n1)=(tmp(1)-tmp(4))/tmp(1);
       n2=n2+1;
       dif2(n2)=(tmp(1)-tmp(3))/tmp(1);
       n2=n2+1;
       dif2(n2)=(tmp(1)-tmp(2))/tmp(1);
    end

end

dif1(dif1>8)=[]; 
dif2(dif2>4)=[]; 
si1(si1>6)=[]; si1(si1<-2)=[];
si2(si2>6)=[]; si2(si2<-8)=[];

threshold = calT(dif1,dif2,[0,8],[0 4],'t');
threshold(threshold>1)=1;
threshold(threshold<0)=0;
sita = 1-threshold;
cons = calT(si1,si2,[-2 6],[-8 6],'c');
cons(cons<0)=0;
cons(cons>2)=2;


function threshold = calT(dif1,dif2,min_max1,min_max2,str)
p = 19;
dif_sub1 = (min_max1(2)-min_max1(1))/p;
dif_sub2 = (min_max2(2)-min_max2(1))/p;
edge1 = min_max1(1):dif_sub1:min_max1(2);
edge2 = min_max2(1):dif_sub2:min_max2(2);
num1 = histc(dif1,edge1);
num2 = histc(dif2,edge2);
p1 = sum(num1);
p2 = sum(num2);

% fitting
% solve nonlinear curve-fitting problems in least-squares sense, lsqcurvefi
paras = [0.5 0.5 0.5]; % initialize paras of gaussian
fx = @(paras,x)paras(1)*exp(-((x-paras(2))./paras(3)).^2); % define the function of gaussian
for i = 1 : 100 % loop is for preparing for new samples 
    new_paras_num1 = lsqcurvefit(fx,paras,edge1,num1);
    if abs(norm(new_paras_num1,2)-norm(paras,2)) < 1e-04
        break;
    else
        paras = new_paras_num1;
    end    
end
fx_fun1 = new_paras_num1(1)*exp(-((edge1-new_paras_num1(2))./new_paras_num1(3)).^2); 

paras = [0.5 0.5 0.5]; % initialize paras of gaussian
fx = @(paras,x)paras(1)*exp(-((x-paras(2))./paras(3)).^2); % define the function of gaussian
for i = 1 : 100 % loop is for preparing for new samples 
    new_paras_num2 = lsqcurvefit(fx,paras,edge2,num2);
    if abs(norm(new_paras_num2,2)-norm(paras,2)) < 1e-04
        break;
    else
        paras = new_paras_num2;
    end    
end
fx_fun2 = new_paras_num2(1)*exp(-((edge2-new_paras_num2(2))./new_paras_num2(3)).^2);

% getT
threshold = fitGetT(new_paras_num1,new_paras_num2,p1,p2,min_max1,min_max2,str);
