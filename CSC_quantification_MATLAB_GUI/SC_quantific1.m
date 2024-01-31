function [finalimage ]=SC_quantific1(orig,seg,vect)
% orig : input original image
% seg: input segmented spinal cord image

%%
I=bwmorph(seg,'remove'); % remove interior pixels
binaryImage = imfill(I, 'holes');
white_skeletonizedImage = bwmorph(binaryImage, 'skel', inf);
%%
skeletonizedImage = uint8(white_skeletonizedImage);
[x,y,z]=size(skeletonizedImage);

 for i=1:x
     for j=1:y
         if (skeletonizedImage(i,j)==1)
             skeletonizedImage(i,j,1)=255;
             skeletonizedImage(i,j,2)=0;
             skeletonizedImage(i,j,3)=0;
         end
     end
 end
 
%% 
[x1,y1,z1]=size(orig);
white_skeletonizedImage = imtranslate(white_skeletonizedImage,[-vect,0],'OutputView','full');
white_skeletonizedImage = imresize(white_skeletonizedImage,[x1 y1]);
%%
[x1,y1,z1]=size(orig);
tt = imtranslate(skeletonizedImage,[-vect,0],'OutputView','full');
B = imresize(tt,[x1 y1]);
B=B(:,:,1);
rgbImage  = imfuse(B, orig,'blend','Scaling','joint');
 %%
white_skeletonizedImage = cat(3,white_skeletonizedImage*255,white_skeletonizedImage,white_skeletonizedImage);       % make line red
white_skeletonizedImage = uint8(white_skeletonizedImage);
finalimage  = imfuse(white_skeletonizedImage, orig,'blend','Scaling','joint');
