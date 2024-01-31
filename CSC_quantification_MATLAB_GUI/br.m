clear all
close all
clc

%%
HeaderInfo = spm_vol('C:\Users\asus\Desktop\SEP\segmentation code\interface clinique\interface_mouna\T2_medull_sag_X071.nii');
[regs xyz]=spm_read_vols(HeaderInfo);
[x,y,z]=size(regs);
orig=regs(:,:,7);
orig=imrotate(orig,90);
figure
imshow(orig,[]);
title('orig')
% orig=enhancement(orig);
figure
imshow(orig,[]);
title('enh')
[orig,rect]=imcrop();

figure
imshow(orig,[]);
data=orig;
K = getframe;
% imwrite(K.cdata,'C:\Users\asus\Desktop\SEP\segmentation code\interface clinique\interface_mouna\SC_segmentation_results\X108_s6.tiff');
% orig=imread ('C:\Users\asus\Desktop\SEP\segmentation code\interface clinique\interface_mouna\SC_segmentation_results\T2_X108_s6.tiff');
% segment the spinal cord
inputImage=imrotate(orig,-90);
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
% segmentation process
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

        num_it=2500;
        seg = local_AC_MS(Img,mask_init,rad,alpha,num_it,epsilon);
        
finalImage = I; 
finalImage(~seg) = 0;
figure
imshow(finalImage, []);
Data=finalImage;
% K = getframe;
% imwrite(K.cdata,'C:\Users\asus\Desktop\SEP\segmentation code\interface clinique\interface_mouna\SC_segmentation_results\seg_X055_s8.tiff');
%%
% Data=imread('C:\Users\asus\Desktop\SEP\segmentation code\interface clinique\interface_mouna\SC_segmentation_results\44_S9.tiff')
Data=Data(:,:,1);

[x,y,z]=size(Data);
% Data=Data(:,:,6); 
Data= double(Data .* (255/max(max(Data))));
% Data=imrotate(Data,90);
I=Data;
spinal=I;
% display the segmented spinal cord
figure
imshow(I,[]);
title('segmented spinal cord');

% % resize the segmented spinal cord
% I = imresize(I,[512 512]);
% figure
% imshow(I,[]);
% title('I512');

%%
% I=imread('C:\Users\asus\Desktop\SEP\segmentation code\interface clinique\interface_mouna\SC_segmentation_results\X071_s7.tiff');
I=bwmorph(I,'remove'); % remove interior pixels
figure
imshow(I,[]);
title('exterior contour');

binaryImage = imfill(I, 'holes');
% binaryImage = imresize(binaryImage,[512 512]);
figure
imshow(binaryImage, []);
title('filled Image');

white_skeletonizedImage = bwmorph(binaryImage, 'skel', inf);
figure
imshow(white_skeletonizedImage);
title('Skeletonized Image');
%%


skeletonizedImage = uint8(white_skeletonizedImage);
 for i=1:x
     for j=1:y
         if (skeletonizedImage(i,j)==1)
             skeletonizedImage(i,j,1)=255;
             skeletonizedImage(i,j,2)=0;
             skeletonizedImage(i,j,3)=0;
         end
     end
 end
figure
imshow(skeletonizedImage);
title('red Skeletonized Image');
 
%% 
[x1,y1,z1]=size(orig);
vect=42;
white_skeletonizedImage = imtranslate(white_skeletonizedImage,[-vect,0],'OutputView','full');
% figure
% imshow(white_skeletonizedImage);
% title('trans');

white_skeletonizedImage = imresize(white_skeletonizedImage,[x1 y1]);
% figure
% imshow(white_skeletonizedImage);
% title('white_skeletonizedImage'); [0.51 70.51 5.119800000000000e+02 2.909800000000000e+02]
%%
[x1,y1,z1]=size(orig);
% vect=70;
tt = imtranslate(skeletonizedImage,[-vect,0],'OutputView','full');
figure
imshow(tt);
title('translated');

B = imresize(tt,[x1 y1]);
% figure
% imshow(B);
% title('trans0');

rgbImage  = imfuse(B, orig,'blend','Scaling','joint');
figure
imshow(rgbImage);
title('final image red');
 
 %%
 
[y,x] = find (white_skeletonizedImage>0);  % find the coordinates of white line
I1 = bwmorph(white_skeletonizedImage,'branchpoints'); % find branchpoint
figure
imshow(I1);
title('branchpoint');

figure
imshow(white_skeletonizedImage-I1);
title('diiference branchpoint');

% [x22,y22]=find (white_skeletonizedImage>0);  % verify coordinates of white line
% figure,imshow(white_skeletonizedImage);hold on;
%  plot(y22,x22,'*')

%% sort all points
[yc,xc] = find(I1);             % find (X,Y) of branchpoint

ix = y > min(yc);        % indices of top part
x1 = x(ix);         % top part
y1 = y(ix);

x2 = x(~ix);           % bottom part
y2 = y(~ix);

[y1, ix] = sort(y1);   % sort top part vertically
x1 = x1(ix);
[x2, ix] = sort(x2);   % sort bottom part horizontally
y2 = y2(ix);

%% intensity profile
n1=length(x1);
for i=1:n1
        k1=x1(i);
        k2=y1(i);
        c1(i)=orig(k2,k1);
    end
figure
plot(c1)

% find minimum
stdd=std(double(c1));
m=min(c1);
p=find(c1<=m+stdd);

n2=length(p);
l=1;
pmax(1)=p(1);
pmin(l)=p(1);
for i=2:n2
        if (p(i)-p(i-1))<10
            pmax(l)=p(i);
        else
            l=l+1;
            pmin(l)=p(i);
        end
end
n3=length(pmax);
r=1;
for j=1:n3
p_limit(r)=pmin(j);
p_limit(r+1)=pmax(j);
r=r+2;
end

% n4=length(p1);
r=1;
for j=1:n3
    pmoy(j)=round(pmin(j)+((pmax(j)-pmin(j))/2));
end
limitpoint=p_limit;
% yL = get(gca,'YLim');
% % line([k1 k1],yL,'Color','r');
% line([limitpoint' limitpoint'],yL,'Color','m');

% locs1=pmoy(pmoy~=0);
locs1=pmoy;
k1=locs1;
yL1 = get(gca,'YLim');
line([k1' k1'],yL1,'Color','r');
% hold on
% yL2 = get(gca,'YLim');
% line([limitpoint' limitpoint'],yL2,'Color','m');
% set(gca,'name',[yL1 yL2])
% xL = get(gca,'XLim');
% line(xL,[0 0],'Color','g');
ylabel('Intensity');
xlabel('distance along red line (pixels)');
% legend('intensity profile','pmoy');
% hold off

%%
white_skeletonizedImage = cat(3,white_skeletonizedImage*255,white_skeletonizedImage,white_skeletonizedImage);       % make line red
white_skeletonizedImage = uint8(white_skeletonizedImage);

finalimage  = imfuse(white_skeletonizedImage, orig,'blend','Scaling','joint');
figure
imshow(finalimage);
hold on
locs1=locs1';
plot(x1(locs1(:)),y1(locs1(:)),'.b','LineWidth', 5)
% % plot(x1(limitpoint(:)),y1(limitpoint(:)),'.m')
% plot(cx2(locs2(:)),cy2(locs2(:)),'.y')
%plot(xc,yc,'og')

%% normal vector (green)
pos1=[x1(locs1(:))];
pos2=[y1(locs1(:))];

[X,Y]=size(pos2);
[X1,Y1]=size(pos1);

[pos2, idx] = sort(pos2);
pos1 = pos1(idx);
points = [pos2 pos1];
xint = linspace(min(min(pos1,pos2)),max(max(pos1,pos2)),50)'; % generate 50 points espaced between 127 and 375
spl = spline(pos2,pos1); % generate polynomial cubic spline curve
tangent_vector = zeros(X,2);
for i=1:X
    if i==X % last polynomial need to evalauted at endpoint
        deri_coef = polyder(spl.coefs(i-1,:)); % returns the derivative of the polynomial represented ...
                                                 ... by the coefficients in spl.coefs(i-1,:),
        tangent_vector(i, :) = [1 polyval(deri_coef, pos2(end)-pos2(end-1))];
    else
        deri_coef = polyder(spl.coefs(i,:));
        tangent_vector(i, :) = [1 polyval(deri_coef, 0)];
    end
end
normal_vec = [-tangent_vector(:,2) tangent_vector(:,1)];
start_points = points;
end_points = 95*normal_vec + points;
% end_points = (max(c1)./min(c1))*normal_vec + points;

% t=plot(pos1,pos2,'.',ppval(spl,xint),xint,'m-');
plot(pos1,pos2,'.',ppval(spl,xint),xint,'m-');

for i=1:X
    p1 = start_points(i,:);
    p2 = end_points(i,:);
    plot([p1(2) p2(2)], [p1(1) p2(1)], 'g', 'LineWidth', 3);
end
% daspect([1 1 1]);
% xlim([0 512])
% ylim([0 512])
hold off % figure2
%%
% figure('Position', [680 678 512 512]);
figure1 = figure; %3
% axes1 = axes('Parent',figure1)
% hold(axes1,'all');
% figure
imshow(I,[]);
hold on
t=plot(pos1,pos2,'.',ppval(spl,xint),xint,'m-',ppval(spl,xint)+(vect/2),xint,'y-');
for i=1:X
    p1 = start_points(i,:);
    p2 = end_points(i,:);
    plot([p1(2) p2(2)], [p1(1) p2(1)], 'g', 'LineWidth', 3);
end
hold off
% save the figure
F = getframe;
figure
imshow(F.cdata)
% set(gca,'Units','pixels'); %changes the Units property of axes to pixels

% saveas(figure1,'y.png') 
% b= imread('y.png');
% c=imresize(b, [512 512]);
% figure(4);
% imshow(c);
%% save image 
% [x0 y0 z0]=size(figure1);
% HeaderInfo.dim=[x0 y0 z0];
% 
% HeaderInfo.fname = 'C:\Users\asus\Desktop\SEP\segmentation code\LocalizedActiveContour\LocalizedActiveContour\savedimage.nii'; 
% HeaderInfo.private.dat.fname = HeaderInfo.fname; 
% spm_write_vol(HeaderInfo,figure1);

%%
% saveas(figure1,'tttt.png')  %  save the figure
% imread('tttt.png');
% imshow('tttt.png');
   
%% display images: contour of spinal cord
% figure
% imshow(I,[]);
% plot(pos2,pos1,'.');
% xlim([0,512])
% ylim([0,512])

% bw = poly2mask(pos1,pos2,512,512);
% figure
% imshow(bw)
% hold on
% plot(pos1,pos2,'b','LineWidth',2)
% xlim([0,512])
% ylim([0,512])
% hold off

%% display images: segmented spinal cord with normal vectors
% figure (5)
% imshow(spinal,[]);
% hold on
% t=plot(pos1,pos2,'.');
% for i=1:X
%     p1 = start_points(i,:);
%     p2 = end_points(i,:);
%     plot([p1(2) p2(2)], [p1(1) p2(1)], 'g', 'LineWidth', 1);
% end
% hold off
%% display images: segmented spinal cord with normal vectors
figure
imshow(spinal,[]);
for i=1:X
    p1 = start_points(i,:);
    end_points = 40*normal_vec + points;
    p2 = end_points(i,:);
    hold on
    plot([p1(2) p2(2)], [p1(1) p2(1)], 'g', 'LineWidth', 5);
%     plot(p1(2), p1(1),'.'); % start_points
    end_points = 40*normal_vec + points;
    p2 = end_points(i,:);
%     plot([p2(2)],[ p2(1)], '.r'); % end_points
hold off
end
G = getframe;
figure
imshow(G.cdata)
imwrite(G.cdata,'C:\Users\asus\Desktop\SEP\segmentation code\LocalizedActiveContour\LocalizedActiveContour\test71_s7.tiff','resolution',[100 100])
% figure(7)
p=imread('C:\Users\asus\Desktop\SEP\segmentation code\LocalizedActiveContour\LocalizedActiveContour\test71_s7.tiff');
figure
imshow(p);

%% measure areas

im=im2double(p);
im(:,end-5:end,:) = 0; % remove the white line at right and bottom of image
im(end-5:end,:,:) = 0;
mask = (im(:,:,1)>0.75) & (im(:,:,2)>0.75) & (im(:,:,3)>0.75);
% figure
% imshow(im(:,:,3));
regions = bwconncomp(mask);
areas = cellfun(@(x) numel(x), regions.PixelIdxList);

[val ind] = sort(areas,'descend');
% required_areas=val(1:(length(p2)+1));

%% labeled areas
im1=im(:,:,1);
figure
imshow(im1);

% thresholdValue=0.4;
% binaryImage= im1 > thresholdValue;
% figure
% imshow(binaryImage);
% 
% binaryImage(:,end-5:end) = 0; % remove the white line at right of image
% binaryImage(end-5:end,:) = 0; % ok remove the white line at bottom of image
% binaryImage(:,1:2) = 0; % ok
% 
% binaryImage = imfill(binaryImage, 'holes');
% figure
% imshow(binaryImage);

im1(:,end-5:end) = 0; % remove the white line at right of image
im1(end-5:end,:) = 0; % ok remove the white line at bottom of image
im1(:,1:2) = 0; % ok
labeledImage = bwlabel(im1, 4);    
figure
imshow(labeledImage, []);  % Show the gray scale image.
o = getframe;
imwrite(labeledImage,'C:\Users\asus\Desktop\SEP\segmentation code\interface clinique\interface_mouna\SC_partition_results\71_s7.tiff');
% labeled_regions=imread('labeled_regions.tiff');
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle'); % pseudo random color labels

% %% sort from top to bottom
% blobMeasurements = regionprops(labeledImage,  'Area', 'EquivDiameter','MinorAxisLength','MajorAxisLength','Centroid' );
% % Get all centroids
% allCentroids = vertcat(blobMeasurements.Centroid);
% % Sort according to centroid's vertical location.
% [sorted_y, sortOrder] = sort(allCentroids(:, 2), 'ascend');
% % Reorder blobMeasurements
% blobMeasurements = blobMeasurements(sortOrder);
% numberOfBlobs = size(blobMeasurements, 1);
% 
% %%
% figure
% imshow(coloredLabels,[]);
% %%
% textFontSize = 5;	% Used to control size of "blob number" labels put atop the image.
% labelShiftX = -3;	% Used to align the labels in the centers of the coins.
% blobECD = zeros(1, numberOfBlobs);
% % Loop over all blobs printing their measurements to the command window.
% for k = 1 : numberOfBlobs           % Loop through all blobs.
% 	blobCentroid = (blobMeasurements(k).Centroid);		% Get centroid one at a time
%     % Put the "blob number" labels on the "boundaries" grayscale image.
% 	text(blobCentroid(1) + labelShiftX, blobCentroid(2), num2str(k), 'FontSize', textFontSize, 'FontWeight', 'Bold');
% end
% % title('labeled regions')
% % hold off
% 
% K = getframe;
% % figure
% % imshow(K.cdata)
% imwrite(K.cdata,'C:\Users\asus\Desktop\SEP\segmentation code\interface clinique\interface_mouna\SC_partition_results\T2_X126_s7.tiff');
% % labeled_regions=imread('labeled_regions.tiff');
% %% test
% labeled_regions=imread('C:\Users\asus\Desktop\SEP\segmentation code\interface clinique\interface_mouna\SC_partition_results\T2_X126_s7.tiff');
% % labeled_regions=imcrop(double(labeled_regions(:,:,1)),rect);
% % labeled_regions=labeled_regions(:,:,1);
% % [x,y,z]=size(orig);
% % labeled_regions=imresize(labeled_regions, [x y]);
% % figure(4);
% % imshow(c);
% % labeled_regions=imcrop(labeled_regions,rect);
% figure
% imshow(orig,[]);
% title('orig')
% figure
% imshow(labeled_regions,[]);
% title('labels')
% % hold on
% % imshow(labeled_regions,[])
% % hold off
% % title('labeled regions');
% figure
% imshow(imfuse(orig,labeled_regions,'blend','Scaling','joint'));
% title('m');
% % hold on
% % imshow('C:\Users\asus\Desktop\SEP\segmentation code\interface clinique\interface_mouna\SC_segmentation_results\T2_X013_s5.tiff')
% 
% % figure
% % imshow(I,[]);
% % hold on
% % imshow('labeled_regions.tiff')
% %% save image 
% % [x0 y0 z0]=size(figure1);
% % HeaderInfo.dim=[x0 y0 z0];
% % 
% % HeaderInfo.fname = 'C:\Users\asus\Desktop\SEP\segmentation code\LocalizedActiveContour\LocalizedActiveContour\savedimage.nii'; 
% % HeaderInfo.private.dat.fname = HeaderInfo.fname; 
% % spm_write_vol(HeaderInfo,figure1);