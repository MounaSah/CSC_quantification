function [finalimage ]=RedLine_shift(orig,seg,vect)
% orig : input original image
% seg: input segmented SC image

%%
I=bwmorph(seg,'remove'); % remove interior pixels
% figure
% imshow(I,[]);
% title('exterior contour');

binaryImage = imfill(I, 'holes');
% figure
% imshow(binaryImage, []);
% title('filled Image');

white_skeletonizedImage = bwmorph(binaryImage, 'skel', inf);
% figure
% imshow(white_skeletonizedImage);
% title('Skeletonized Image');
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
% figure
% imshow(skeletonizedImage);
% title('red Skeletonized Image');
 
%% 
[x1,y1,z1]=size(orig);
%vect=52; % translation vector
white_skeletonizedImage = imtranslate(white_skeletonizedImage,[-vect,0],'OutputView','full');
% figure
% imshow(white_skeletonizedImage);
% title('trans');

white_skeletonizedImage = imresize(white_skeletonizedImage,[x1 y1]);
% figure
% imshow(white_skeletonizedImage);
% title('white_skeletonizedImage');
%%
[x1,y1,z1]=size(orig);
tt = imtranslate(skeletonizedImage,[-vect,0],'OutputView','full');
% figure
% imshow(tt);
% title('translated');

B = imresize(tt,[x1 y1]);
B=B(:,:,1);
% figure
% imshow(B);
% title('trans0');

rgbImage  = imfuse(B, orig,'blend','Scaling','joint');
% figure(1)
% imshow(rgbImage);
% title('final image red');
% close(figure(1))


%%
white_skeletonizedImage = cat(3,white_skeletonizedImage*255,white_skeletonizedImage,white_skeletonizedImage);       % make line red
white_skeletonizedImage = uint8(white_skeletonizedImage);

finalimage  = imfuse(white_skeletonizedImage, orig,'blend','Scaling','joint');
% figure(3)
% imshow(finalimage);
% hold on
