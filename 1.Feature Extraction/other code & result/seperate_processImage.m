%function processImage( readpath, writepath, params)
% PROCESSIMAGE( READPATH, WRITEPATH, PARAMS)
currentFolder = pwd;
addpath(genpath(currentFolder))
readpath='F:/01111code XYY2013/code/Í¼Ïñ/AAMDC.jpg';
writepath='F:/01111code XYY2013/code/png/AAMDC.png';
writepath1='F:/01111code XYY2013/code/png/AAMDC1.jpg';
% if ~exist( writepath,'file')
%     return
% end

prp = writepath;
% prp((prp == '/') | (prp == '.')) = '_';
% pr = ['tmp/processing_' prp '.txt'];
% if ~exist( pr,'file')
%     fr = fopen( pr, 'w');
% else
%     return
% end

% Always perform linear unmixing...
imdata= imread( readpath);
I2 = rgb2gray(imdata);
imwrite(I2, writepath1); 

I3=imread( writepath1);

I=imdata;
imshow(I);
bf = 'lib/2_separationCode/Wbasis.mat';
load( bf);
options.W = W;
% W = params.W;

s = size(I);
[V i j] = unique( 255-reshape( I, [s(1)*s(2) s(3)]), 'rows');
V = unique(V,'rows');

% LIN
H = findH( V, W);

% ...Note images without enough staining
% J = reconIH( I, H, j);
% [c b] = imhist(J(:,:,1));
% [a ind] = max(c);
% J(:,:,1) = J(:,:,1) - b(ind);
% [c b2] = imhist(J(:,:,2));
% [a ind2] = max(c);
% J(:,:,2) = J(:,:,2) - b2(ind2);
% ratio = sum(sum(J(:,:,2))) / sum(sum(J(:,:,1)));
% 
% if ratio<.5
%     imwrite( 0, writepath, 'comment', readpath);
%     fclose(fr);
%     delete(pr);
%     return
% end

% if strcmp( params.UMETHOD,'nmf')
%     [W,H] = findWH( V, params);
%     % J = reconIH( I, H, j);
% end

imwrite( H, writepath, 'comment', readpath);

fclose(fr);
delete(pr);

%return
