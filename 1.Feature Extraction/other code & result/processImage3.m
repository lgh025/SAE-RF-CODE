function processImage3( readpath, writepath, params)
% PROCESSIMAGE( READPATH, WRITEPATH, PARAMS)
load numbers number
labels_name=params.general.CLASSLABELS{1}
if strcmp(labels_name,'Cytoplasm')
    labels=1;
end
 if strcmp(labels_name,'ER')
    labels=2;
end   
if strcmp(labels_name,'Golgi_apparatus')
    labels=3;
end
if strcmp(labels_name,'Lysosome')
    labels=4;
end
if strcmp(labels_name,'Mitochondria')
    labels=5;
end
if strcmp(labels_name,'Nucleus')
    labels=6;
end
if strcmp(labels_name,'Vesicles')
    labels=7;
end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    writepath3 ='./data//label_21.mat';
    %      save writepath2  features_all 
      load writepath3  label_all 
     label_all=[ label_all; labels];
     save writepath3  label_all 
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





% if exist( writepath,'file')
%     return
% end
% 
% prp = writepath;
% prp((prp == '/') | (prp == '.')) = '_';
% pr = ['tmp/processing_' prp '.txt'];
% if ~exist( pr,'file')
%     fr = fopen( pr, 'w');
% else
%     return
% end
% 
% % Always perform linear unmixing...
% I = imread( readpath);
% W = params.W;
% 
% s = size(I);
% [V i j] = unique( 255-reshape( I, [s(1)*s(2) s(3)]), 'rows');
% V = unique(V,'rows');
% 
% % LIN
% H = findH( V, W);
% 
% % ...Note images without enough staining
% % J = reconIH( I, H, j);
% % [c b] = imhist(J(:,:,1));
% % [a ind] = max(c);
% % J(:,:,1) = J(:,:,1) - b(ind);
% % [c b2] = imhist(J(:,:,2));
% % [a ind2] = max(c);
% % J(:,:,2) = J(:,:,2) - b2(ind2);
% % ratio = sum(sum(J(:,:,2))) / sum(sum(J(:,:,1)));
% % 
% % if ratio<.5
% %     imwrite( 0, writepath, 'comment', readpath);
% %     fclose(fr);
% %     delete(pr);
% %     return
% % end
% 
% if strcmp( params.UMETHOD,'nmf')
%     [W,H] = findWH( V, params);
%     % J = reconIH( I, H, j);
% end
% 
% imwrite( H, writepath, 'comment', readpath);
% 
% fclose(fr);
% delete(pr);

return
