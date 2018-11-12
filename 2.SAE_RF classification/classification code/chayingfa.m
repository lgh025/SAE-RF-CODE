%%%%%%%%%%%%%%%%%%%%%%%%定义祛除背景的函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function chayingfa = chayingfa();

i1='G:\Bioimaging based detection of mislocalized proteins in human cancers by semi-supervised learning\code 2013\code\data\1_images\2384\normal\Breast\8119_B_1_4.jpg'
figure;
imshow('G:\Bioimaging based detection of mislocalized proteins in human cancers by semi-supervised learning\code 2013\code\data\1_images\2384\normal\Breast\8119_B_1_4.jpg');
i = imread( i1);
title('原图显示')

I=rgb2gray(i);%灰度转化
figure;
imshow(I);
title('灰度图显示')
bw1=im2bw(I);
imshow(bw1);
title('原图的二值化图片')
s=strel('disk',5);%根据背景的复杂程度修改圆盘半径
bg=imopen(I,s);
figure,imshow(bg);%对‘原始图象’进行开操作得到图象背景
title('背景图显示')
bw=imsubtract(I,bg);
figure,imshow(bw);%用原始图象与背景图象作减法
title('使用差影法后的图片')
level=0.3;
bw2=im2bw(bw,level);
figure,imshow(bw2);%通过图象的直方图取得阈值，将图象二值化
title('差影法后的二值化图片')