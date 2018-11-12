function gaborFea=gaborFeatures(imgInGray)

[x,y]=size(imgInGray ); 
% [G,gabout] = gaborfilter(InputImage,2,4,16,pi/3);  
G1=[];
for i=2:2:10
    if i~=6
[G,gabout] = gaborfilter(imgInGray,2,4,16,(pi/12)*i);
G1=[G1 G(1,:) G(2,:) G(3,:) G(4,:) G(5,:)];
% figure,imshow(uint8(gabout));           %显示gabor特征提取后的图片
    end
end
gaborFea=G1;
end
