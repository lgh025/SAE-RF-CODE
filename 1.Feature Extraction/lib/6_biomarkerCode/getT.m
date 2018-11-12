function threshold = getT(output_data,target)
n1 = 0;
n2 = 0;
num = size(output_data,2);
if (size(output_data)~=size(target))
    error( 'The size of two inputs are not match.');
end
for i = 1:num
 [tmp,IX]=sort(output_data(:,i),'descend');
      if target(IX(1),i) ~= 1
         continue;
      end
     le = length(find(target(:,i) == 1));
     if le==1
       n1=n1+1;
       dif1(n1)=tmp(1)-tmp(2);
     end
     if le==2   
       n1=n1+1;
       dif1(n1)=tmp(1)-tmp(3);
       n2=n2+1;
       dif2(n2)=tmp(1)-tmp(2);
     end
    if le==3  
       n1=n1+1;
       dif1(n1)=tmp(1)-tmp(4);
       n2=n2+1;
       dif2(n2)=tmp(1)-tmp(3);
       n2=n2+1;
       dif2(n2)=tmp(1)-tmp(2);
    end
end

n1=size(dif1,2);
n2=size(dif2,2);
dif_max=max(max(dif1),max(dif2));
dif_max=ceil(dif_max); 
p=50;
dif_sub=dif_max/p;
num1=zeros(1,p); %dif1
num2=zeros(1,p); %dif2
for i=1:p
   for j=1:n1
       if ((dif_sub*(i-1))<dif1(j))&&(dif1(j)<=(dif_sub*i))
           num1(i)=num1(i)+1;
       end
   end
   for k=1:n2
       if ((dif_sub*(i-1))<dif2(k))&&(dif2(k)<=(dif_sub*i))
           num2(i)=num2(i)+1;
       end
   end
end
dif=(dif_sub/2) : dif_sub : (dif_max-dif_sub/2);

dif=[0,dif];
num1=[0,num1];
num2=[0,num2];

% fitting
cftool(dif,num1);
cftool(dif,num2); 

threshold = fitGetT(n1,n2);

