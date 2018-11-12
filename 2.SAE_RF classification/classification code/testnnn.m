load testN614 testN
nn=[];
 n1=testN{1,1};
for i3=1:9
    nn=[];
   
    n2=testN{i3+1,1};
    n2=unique(n2);
    i4=size(n1,2);
    i5=size(n2,2);
    for ii=1:i4
       for ii2=1:i5 
        if n2(ii2)==n1(ii)
            nn=[nn n2(ii2)];
        end
       end
    end
    nn=unique(nn);
    n1=nn;
end
save number_n1 n1
a=3;
        