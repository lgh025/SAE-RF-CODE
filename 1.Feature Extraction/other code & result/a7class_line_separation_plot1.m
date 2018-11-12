close all, clear all, clc;
tic
currentFolder = pwd;
addpath(genpath(currentFolder))



% N = 10;
% w = 1.0/N; h = 1.0/N;
% wi = 0.9*w; hi = 0.9*h;
% for i = 1:100
%     [x,y] = ind2sub([N,N],i);
%     subplot('Position', [(x-1)*w 1-y*h wi hi]);
%     %subplot(N,N,i);
% end
% axes('position',[.1  .1  .8  .6])
% mesh(peaks(20));
% axes('position',[.1  .7  .8  .2])
% pcolor([1:10;1:10]);
% I = imread('D:/7yxb/8119_B_7_2.jpg');
  subplot(3,3,1);
I = imread('D:/7yxb/jietu/Cytopl_01.png');
imshow(I);
% grad on
subplot(3,3,2);
I = imread('D:/7yxb/jietu/Cytopl_DNA1.png');
imshow(I);
% grad on
subplot(3,3,3);
I = imread('D:/7yxb/jietu/Cytopl_PROTEIN1.png');
imshow(I);
% I = imread('D:/7yxb/8119_B_7_2.jpg');
% set(gca, 'Units', 'normalized', 'Position', [0 0.1 0.2 0.7]);
  subplot(3,3,4);
I = imread('D:/7yxb/jietu/Cytopl_01.png');
imshow(I);
% grad on
subplot(3,3,5);
I = imread('D:/7yxb/jietu/Cytopl_DNA1.png');
imshow(I);
% grad on
subplot(3,3,6);
I = imread('D:/7yxb/jietu/Cytopl_PROTEIN1.png');
imshow(I);
 subplot(3,3,7);
I = imread('D:/7yxb/jietu/Cytopl_01.png');
imshow(I);
% grad on
subplot(3,3,8);
I = imread('D:/7yxb/jietu/Cytopl_DNA1.png');
imshow(I);
% grad on
subplot(3,3,9);
I = imread('D:/7yxb/jietu/Cytopl_PROTEIN1.png');
imshow(I);
% axis tight
% grad on
% I = imread('D:/7yxb/jietu/Cytopl_DNA1.png');
% I = imread('D:/7yxb/jietu/Cytopl_PROTEIN1.png');
%  fig5 = figure();
 
toc
% W = params.W;
% W =[0.5275    0.5023    0.3971;    0.4287    0.5149    0.5790];
% s = size(I);
% [V i j] = unique( 255-reshape( I, [s(1)*s(2) s(3)]), 'rows');
% V = unique(V,'rows');
% 
% % LIN
% H = findH( V, W);
% 
% %  I = imfinfo( H);
% %     H = imread( readpath);
%     J = reconIH( I, H);
%      J(:,:,1) = adapthisteq(J(:,:,1));
%      fig5 = figure();
%      imshow(J(:,:,1)) %DNA
%      J(:,:,2) = adapthisteq(J(:,:,2));
%      fig6 = figure();
%      imshow(J(:,:,2))  %PROTEIN
%       fig7 = figure();
%      imshow(I)  %ORIGINAL
%      a=0;
