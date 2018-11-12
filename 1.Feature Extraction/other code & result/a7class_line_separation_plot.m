close all, clear all, clc;
tic
currentFolder = pwd;
addpath(genpath(currentFolder))
% I = imread('D:/7yxb/8119_B_7_2.jpg');
%   subplot(3,3,1);
I1 = imread('D:/7yxb/jietu/Cytopl_01.png');
% imdisp(I);
% grad on
% subplot(3,3,2);
I2 = imread('D:/7yxb/jietu/Cytopl_DNA1.png');
% imshow(I);
% grad on
% subplot(3,3,3);
I3 = imread('D:/7yxb/jietu/Cytopl_PROTEIN1.png');
pic=cat(3,I1,I2,I3);
figure, imshow(pic);
% imshow(I);
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
