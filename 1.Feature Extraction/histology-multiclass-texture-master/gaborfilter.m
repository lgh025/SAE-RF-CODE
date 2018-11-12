
%%GABOR滤波器的一个描述

%The Gabor filter is basically a Gaussian (with variances sx and sy along x and y-axes respectively)
%gabor滤波器是一个基本的高斯函数（沿 x 和 y 轴的差额 sx 和sy）
%modulated by a complex sinusoid (with centre frequencies U and V along x and y-axes respectively) 
%由一个复杂的正弦调制 （分别沿x轴和y轴的中心频率 U 和 V）
%described by the following equation
%公式描述如下
%%
%                            -1     x' ^     y'  ^             
%%% G(x,y,theta,f) =  exp ([----{(----) 2+(----) 2}])*sin(2*pi*f*x');
%                             2    sx'       sy'
%%% x' = x*cos(theta)-y*sin(theta);
%%% y' = y*cos(theta)+x*sin(theta);

%% 描述 :

%% I : Input image输入图像
%% Sx & Sy : Variances along x and y-axes respectively分别沿 x 和 y 轴的差额 
%% f : The frequency of the sinusoidal function  滤波频率
%% theta : The orientation of Gabor filter滤波方向

%% G : The output filter as described above 如上面所述的输出滤波器
%% gabout : The output filtered image 经过滤波的输出图像


function [G,gabout] = gaborfilter(I,Sx,Sy,f,theta);
if isa(I,'double')~=1                 % 检测I是否给定类的对象
    I = double(I);
end

for x = -fix(Sx):fix(Sx)           %循环，并且sx向零取整
    for y = -fix(Sy):fix(Sy)           %循环，并且sx向零取整
        xPrime = x * cos(theta) - y * sin(theta); %计算xPrime
        yPrime = y * cos(theta) + x * sin(theta); %计算yPrime
        G(fix(Sx)+x+1,fix(Sy)+y+1) = exp(-.5*((xPrime/Sx)^2+(yPrime/Sy)^2))*sin(2*pi*f*xPrime);
    end
end

Imgabout = conv2(I,double(imag(G)),'same');%二维卷积
Regabout = conv2(I,double(real(G)),'same');%二维卷积
gabout = sqrt(Imgabout.*Imgabout + Regabout.*Regabout);%计算