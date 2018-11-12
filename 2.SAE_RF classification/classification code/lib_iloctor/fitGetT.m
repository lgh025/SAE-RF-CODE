function threshold = fitGetT(para_num1,para_num2,p1,p2,dif_max1,dif_max2,str)

a1 = para_num1(1);
b1 = para_num1(2);
c1 = para_num1(3);
a2 = para_num2(1);
b2 = para_num2(2);
c2 = para_num2(3);

x1=dif_max1(1):0.0001:dif_max1(2);
y1=a1*exp(-((x1-b1)/c1).^2);
x2=dif_max2(1):0.0001:dif_max2(2);
y2=a2*exp(-((x2-b2)/c2).^2);

f1=@(x)a1*exp(-((x-b1)/c1).^2);
f2=@(x)a2*exp(-((x-b2)/c2).^2);

dec1=quadl(f1,dif_max1(1),dif_max1(2));
dec2=quadl(f2,dif_max2(1),dif_max2(2));

if strcmp(str,'t')
    a1=a1*(1/dec1)*p1/(p1+p2);
    a2=a2*(1/dec2)*p2/(p1+p2);
else
    a1=a1*(1/dec1)*p1/p2;
    a2=a2*(1/dec2);
end

p = [a1,a2,b1,b2,c1,c2];
if strcmp(str,'t')
    threshold = fzero(@(x)p(1)*exp(-((x-p(3))/p(5)).^2)-p(2)*exp(-((x-p(4))/p(6)).^2), 1);
    if isnan(threshold)
        threshold = (p(4)+p(3))/2;
    end
else
    if strcmp(str,'c')
        threshold = fzero(@(T)quadl(@(x)p(1)*exp(-((x-p(3))/p(5)).^2),T,dif_max1(2))-0.95/(p1/p2)*quadl(@(x)p(2)*exp(-((x-p(4))/p(6)).^2),T,dif_max2(2)), 1);
        if isnan(threshold)
            threshold = p(3);
        end
    end
end


   