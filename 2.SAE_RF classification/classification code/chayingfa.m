%%%%%%%%%%%%%%%%%%%%%%%%������������ĺ���%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function chayingfa = chayingfa();

i1='G:\Bioimaging based detection of mislocalized proteins in human cancers by semi-supervised learning\code 2013\code\data\1_images\2384\normal\Breast\8119_B_1_4.jpg'
figure;
imshow('G:\Bioimaging based detection of mislocalized proteins in human cancers by semi-supervised learning\code 2013\code\data\1_images\2384\normal\Breast\8119_B_1_4.jpg');
i = imread( i1);
title('ԭͼ��ʾ')

I=rgb2gray(i);%�Ҷ�ת��
figure;
imshow(I);
title('�Ҷ�ͼ��ʾ')
bw1=im2bw(I);
imshow(bw1);
title('ԭͼ�Ķ�ֵ��ͼƬ')
s=strel('disk',5);%���ݱ����ĸ��ӳ̶��޸�Բ�̰뾶
bg=imopen(I,s);
figure,imshow(bg);%�ԡ�ԭʼͼ�󡯽��п������õ�ͼ�󱳾�
title('����ͼ��ʾ')
bw=imsubtract(I,bg);
figure,imshow(bw);%��ԭʼͼ���뱳��ͼ��������
title('ʹ�ò�Ӱ�����ͼƬ')
level=0.3;
bw2=im2bw(bw,level);
figure,imshow(bw2);%ͨ��ͼ���ֱ��ͼȡ����ֵ����ͼ���ֵ��
title('��Ӱ����Ķ�ֵ��ͼƬ')