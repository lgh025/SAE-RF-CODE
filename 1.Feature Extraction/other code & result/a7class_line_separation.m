close all, clear all, clc;
currentFolder = pwd;
addpath(genpath(currentFolder))
I = imread('D:/7yxb/2274_B_4_5.jpg');
% I = imread('D:/7yxb/Vesi.png');
% W = params.W;
W =[0.5275    0.5023    0.3971;    0.4287    0.5149    0.5790];
s = size(I);
[V i j] = unique( 255-reshape( I, [s(1)*s(2) s(3)]), 'rows');
V = unique(V,'rows');

% LIN
H = findH( V, W);

%  I = imfinfo( H);
%     H = imread( readpath);
    J = reconIH( I, H);
     J(:,:,1) = adapthisteq(J(:,:,1));
     fig5 = figure();
     imshow(J(:,:,1)) %DNA
     J(:,:,2) = adapthisteq(J(:,:,2));
     fig6 = figure();
     imshow(J(:,:,2))  %PROTEIN
      fig7 = figure();
     imshow(I)  %ORIGINAL
     a=0;
