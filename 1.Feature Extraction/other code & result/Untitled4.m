x = -2.9:0.5:2.9;
y=exp(-x.*x);
bar(x,y,'r');
for ii=1:length(x)
    str=sprintf('%4.2f',y(ii));
    text(x(ii)-0.2,y(ii)+0.02,str);
end