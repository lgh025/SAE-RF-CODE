function calculateFeatures2(readpath, writepath, dbtype, NLEVELS, params)
% CALCULATEFEATURES( READPATH, WRITEPATH, DBTYPE, NLEVELS)
feattype=params.featCalc.FEATTYPE;
 gaborArray = gabor(2:2:12,0:30:150);
load numbers number
labels_name=params.general.CLASSLABELS{number}
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


if strcmp(feattype, 'SLFs')
    if exist( writepath,'file')
        load (writepath);
        if length(features)==841
            return
        end
    end
    prp = writepath;
       prp((prp == '/') | (prp == '.')) = '_';
       pr = ['tmp/calculating_' prp '.txt'];
      if ~exist( pr,'file')
        fr = fopen( pr, 'w');
      else
        return
      end
      
    I = imfinfo( readpath);
    H = imread( readpath);
    J = reconIH( imread(I.Comment), H);

    features = tissueFeatures( J(:,:,2), J(:,:,1), dbtype, NLEVELS, feattype);

    save( writepath, 'features');

    fclose(fr);
    delete(pr);
end

if strcmp(feattype, 'SLFs_LBPs')
%    if exist( writepath,'file')
%         load (writepath);
%         if length(features)==1097
%             return
%         end
%    end
%     prp = writepath;
%        prp((prp == '/') | (prp == '.')) = '_';
%        pr = ['tmp/calculating_' prp '.txt'];
%       if ~exist( pr,'file')
%         fr = fopen( pr, 'w');
%       else
%         return
%       end
      
    I = imfinfo( readpath);
    H = imread( readpath);
    J = reconIH( imread(I.Comment), H);
%      J(:,:,1) = adapthisteq(J(:,:,1));
%      fig5 = figure();
%      imshow(J(:,:,1))
%      J(:,:,2) = adapthisteq(J(:,:,2));
%      fig6 = figure();
%      imshow(J(:,:,2))
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  imgIn1 = imread(I.Comment); 
    imgIn =imresize( imgIn1,[1500,1500]);
    imgInGray = double(rgb2gray(imgIn))/255;
% % imageRGB1=imageRGB;
% % set of standard values for stain vectors (from python scikit)
% % He = [0.65; 0.70; 0.29];
% % Eo = [0.07; 0.99; 0.11];
% % DAB = [0.27; 0.57; 0.78];
% 
% % alternative set of standard values (HDAB from Fiji)
% He = [ 0.6500286;  0.704031;    0.2860126 ];
% DAB = [ 0.26814753;  0.57031375;  0.77642715];
% Res = [ 0.7110272;   0.42318153; 0.5615672 ]; % residual

% 
% % combine stain vectors to deconvolution matrix
% HDABtoRGB = [He/norm(He) DAB/norm(DAB) Res/norm(Res)]';
% RGBtoHDAB = inv(HDABtoRGB);
%     
% % separate stains = perform color deconvolution
% tic
% J = SeparateStains(imageRGB1, RGBtoHDAB);
%      J(:,:,1) = adapthisteq(J(:,:,1));
%     fig5 = figure();
%      imshow(J(:,:,1))
%      J(:,:,2) = adapthisteq(J(:,:,2));
%      fig6 = figure();
%      imshow(J(:,:,2)) 
%       imgInGray = double(rgb2gray(J))/255;
%       fig7 = figure();
%      imshow(imgInGray) 
%    J(:,:,2) = adapthisteq(J(:,:,2));
%    imgInGray = imresize( J(:,:,2),[2500,2500]);
%  imgInGray = double(imgInGray)/255;

%       fig6 = figure();
%      imshow(imgInGray) 
% gaborArray = gabor(2:2:12,0:30:150);% create gabor filter bank, requires Matlab R2015b
  features0 = [histogramJoint(imgInGray),...
                         glcmRotInvFeatures(imgInGray),...
                         perceptualFeatures(imgInGray),...
                         flbpFeatures(imgInGray)         ];   
                     
%        features0= [histogramJoint(imgInGray),...
%                            glcmRotInvFeatures(imgInGray),...
%                           perceptualFeatures(imgInGray)];    
%                       features0= [histogramJoint(imgInGray),...
%                          flbpFeatures(imgInGray),...
%                          glcmRotInvFeatures(imgInGray),...
%                          perceptualFeatures(imgInGray)]; 
%     gaborArray = gabor(2:2:12,0:30:150);
    features2 =gaborRotInvFeatures(imgInGray,gaborArray);
   features1 = tissueFeatures0817( J(:,:,2), J(:,:,1), dbtype, NLEVELS, feattype);
   features =[features0  features2 features1];
    save( writepath, 'features');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    writepath2 ='./data//features_21.mat';
%      save writepath2  features_all
     
      load features_all2  features_all 
     features_all=[ features_all; features];
     save features_all2   features_all 
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    writepath3 ='./data//label_21.mat';
    %      save writepath2  features_all 
      load writepath3  label_all 
     label_all=[ label_all; labels];
     save writepath3  label_all 
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     fclose(fr);
%     delete(pr);
end 
 if strcmp(feattype, 'SLFs_LBPs_CL')
   if exist( writepath,'file')
        load (writepath);
        if length(features)==1097
            return
        end
   end
    prp = writepath;
       prp((prp == '/') | (prp == '.')) = '_';
       pr = ['tmp/calculating_' prp '.txt'];
      if ~exist( pr,'file')
        fr = fopen( pr, 'w');
      else
        return
      end
      
    I = imfinfo( readpath);
    H = imread( readpath);
    J = reconIH( imread(I.Comment), H);
    J(:,:,1) = adapthisteq(J(:,:,1));
     J(:,:,2) = adapthisteq(J(:,:,2));
    features = tissueFeatures( J(:,:,2), J(:,:,1), dbtype, NLEVELS, feattype);

    save( writepath, 'features');
    fclose(fr);
    delete(pr);
 end 
 
end
    
 