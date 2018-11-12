function f = Tfun(x)
% When pause, please replace p1,b1,c1,p2,b2,c2 by the values from getT.m

% y1=p1*exp(-((x-b1)/c1).^2);
% y2=p2*exp(-((x-b2)/c2).^2);

y1=115.9137*exp(-((x-2.041)/0.6214).^2);
y2=13.4188*exp(-((x-0.2748)/0.5443).^2);

f=y1-y2;