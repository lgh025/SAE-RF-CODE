clear all;
close all;
clc;
tic
img1=imread('D:/7yxb/jietu/ER_PROTEIN1.png');
[m n]=size(img1);
  img = double(rgb2gray(img1))/255;
  [m n]=size(img);
imgn=zeros(m,n);
for i=2:m-1
   for j=2:n-2 
        
       pow=0;
        for p=i-1:i+1
            for q =j-1:j+1
                if img(p,q) > img(i,j)
                    if p~=i || q~=j         %�е�����������3*3��˳ʱ����룬�ҾͰ�����˳������ˡ�
                                            %����������������ɶ�ģ�ֻҪ����ͬ��������ˡ�
                      imgn(i,j)=imgn(i,j)+2^pow;
                      pow=pow+1;
                    end
                end
            end
        end
            
   end
end
figure;
imshow(img1,[]);
figure;
imshow(imgn,[]);
hist=cell(1,4);     %�����ĸ�������ֱ��ͼ��10*10��̫���ˣ������򵥵�
hist{1}=imhist(img(1:floor(m/2),1:floor(n/2)));
hist{2}=imhist(img(1:floor(m/2),floor(n/2)+1:n));
hist{3}=imhist(img(floor(m/2)+1:m,1:floor(n/2)));
hist{4}=imhist(img(floor(m/2)+1:m,floor(n/2)+1:n));
for i=1:4
   figure;
   plot(hist{i});
end
toc