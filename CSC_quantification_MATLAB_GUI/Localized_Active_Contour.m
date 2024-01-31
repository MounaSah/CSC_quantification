function [finalImage]=Localized_Active_Contour(num_it, inputImage,mss)

for k = mss: mss
inputImage=imrotate(inputImage,-90);
OriginalDataArray= double(inputImage .* (255/max(max(inputImage)))); 
I=OriginalDataArray; 
I=imrotate(I,90);
% figure
% imshow(I,[]);
  %% Sobel    
pp= sobel(I);
% pp=I;
pp=imerode(pp,strel('disk', 0));
% figure
% imshow(pp,[]);
%%
Img=double(pp);
[h,hh]=size(Img);
epsilon = 1; 

        rad = 4;  % the side length of the square window
        alpha = 0.03;  % coefficient of the length term =0.03
        mask_init0 = zeros(size(Img(:,:,1)));
% figure
% imshow(Img,[]);

        [x, y] = getpts
        x=floor(x);
        y=floor(y);
        mask_init=mask_init0;
        mask_init(y:y+5,x:x+5) = 1;        
        seg = local_AC_MS(Img,mask_init,rad,alpha,num_it,epsilon);
        
finalImage = I; 
finalImage(~seg) = 0;
% figure
% imshow(finalImage, []);

end
