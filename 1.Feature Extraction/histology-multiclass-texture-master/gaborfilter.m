
%%GABOR�˲�����һ������

%The Gabor filter is basically a Gaussian (with variances sx and sy along x and y-axes respectively)
%gabor�˲�����һ�������ĸ�˹�������� x �� y ��Ĳ�� sx ��sy��
%modulated by a complex sinusoid (with centre frequencies U and V along x and y-axes respectively) 
%��һ�����ӵ����ҵ��� ���ֱ���x���y�������Ƶ�� U �� V��
%described by the following equation
%��ʽ��������
%%
%                            -1     x' ^     y'  ^             
%%% G(x,y,theta,f) =  exp ([----{(----) 2+(----) 2}])*sin(2*pi*f*x');
%                             2    sx'       sy'
%%% x' = x*cos(theta)-y*sin(theta);
%%% y' = y*cos(theta)+x*sin(theta);

%% ���� :

%% I : Input image����ͼ��
%% Sx & Sy : Variances along x and y-axes respectively�ֱ��� x �� y ��Ĳ�� 
%% f : The frequency of the sinusoidal function  �˲�Ƶ��
%% theta : The orientation of Gabor filter�˲�����

%% G : The output filter as described above ����������������˲���
%% gabout : The output filtered image �����˲������ͼ��


function [G,gabout] = gaborfilter(I,Sx,Sy,f,theta);
if isa(I,'double')~=1                 % ���I�Ƿ������Ķ���
    I = double(I);
end

for x = -fix(Sx):fix(Sx)           %ѭ��������sx����ȡ��
    for y = -fix(Sy):fix(Sy)           %ѭ��������sx����ȡ��
        xPrime = x * cos(theta) - y * sin(theta); %����xPrime
        yPrime = y * cos(theta) + x * sin(theta); %����yPrime
        G(fix(Sx)+x+1,fix(Sy)+y+1) = exp(-.5*((xPrime/Sx)^2+(yPrime/Sy)^2))*sin(2*pi*f*xPrime);
    end
end

Imgabout = conv2(I,double(imag(G)),'same');%��ά���
Regabout = conv2(I,double(real(G)),'same');%��ά���
gabout = sqrt(Imgabout.*Imgabout + Regabout.*Regabout);%����