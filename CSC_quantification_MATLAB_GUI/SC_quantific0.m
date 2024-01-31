function [coloredLabels,labeledImage] = SC_quantific0(orig,seg,vect)
% orig : input original image
% seg: input segmented spinal cord image

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
 figure(1)
 imshow(skeletonizedImage);
 close(figure(1))
% title('red Skeletonized Image');
%% 
[x1,y1,z1]=size(orig);
%vect=52; % vecteur de transalation de la courbe rouge sur la colonne
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
% figure
% imshow(B);
% title('trans0');

rgbImage  = imfuse(B, orig,'blend','Scaling','joint');
% figure(2)
% imshow(rgbImage);
 
%%
[y,x] = find (white_skeletonizedImage>0);  % find the coordinates of white line
I1 = bwmorph(white_skeletonizedImage,'branchpoints'); % find branchpoint
% figure
% imshow(I1);

[x22,y22]=find (white_skeletonizedImage>0);  % find the coordinates of white line

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
figure(3)
plot(c1,'r','LineWidth', 1);
ylabel('Intensity');
xlabel('Distance along centerline (pixels)');
% title('Intensity Profile')
% find minimum
stdd=std(c1);
% stdd=75
m=min(c1);
p=find(c1<=m+stdd);

n2=length(p);
l=1;
pmax(1)=p(1);
pmin(l)=p(1);
for i=2:n2
        if (p(i)-p(i-1))<12
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

r=1;
for j=1:n3
    pmoy(j)=round(pmin(j)+((pmax(j)-pmin(j))/2));
end
limitpoint=p_limit;

locs1=pmoy;
k1=locs1;
yL1 = get(gca,'YLim');
line([k1' k1'],yL1,'Color','b','LineWidth', 1);
% ylabel('Intensity');
% xlabel('distance along red line (pixels)');
 close(figure(3))
%%
white_skeletonizedImage = cat(3,white_skeletonizedImage*255,white_skeletonizedImage,white_skeletonizedImage);       % make line red
white_skeletonizedImage = uint8(white_skeletonizedImage);

coloredLabels  = imfuse(white_skeletonizedImage, orig,'blend','Scaling','joint');
figure(4)
imshow(coloredLabels);
hold on
locs1=locs1';
plot(x1(locs1(:)),y1(locs1(:)),'ob','LineWidth', 1);
% title('Final image + intersection points')
% close(figure(4))

%% normal vector (green)
pos1=[x1(locs1(:))];
pos2=[y1(locs1(:))];

[X,Y]=size(pos2);
[X1,Y1]=size(pos1);

save('pqfile.mat','X','Y','X1','Y1');

[pos2, idx] = sort(pos2);
pos1 = pos1(idx);
points = [pos2 pos1];
xint = linspace(min(min(pos1,pos2)),max(max(pos1,pos2)),100)'; % generate 50 points espaced between 127 and 375
spl = spline(pos2,pos1);           % generate polynomial cubic spline curve
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
end_points = 30*normal_vec + points;

for i=1:X
    p1 = start_points(i,:);
    p2 = end_points(i,:);
%     plot([p1(2) p2(2)], [p1(1) p2(1)], 'g', 'LineWidth', 3);
end

for i=1:X
    p1 = start_points(i,:);
    p2 = end_points(i,:);
%     plot([p1(2) p2(2)], [p1(1) p2(1)], 'g', 'LineWidth', 1);
end

%% display images: segmented SC with green normal vectors

for i=1:X
    p1 = start_points(i,:);
    end_points = 60*normal_vec + points;
    p2 = end_points(i,:);
     hold on
    plot([p1(2) p2(2)], [p1(1) p2(1)], 'g', 'LineWidth', 3);
% %     plot(p1(2), p1(1),'.'); % start_points
    end_points = 60*normal_vec + points;
    p2 = end_points(i,:);
% %     plot([p2(2)],[ p2(1)], '.r'); % end_points
hold off
end
Kk = getframe;
labeled_regions=Kk.cdata;
% figure()
% imshow(labeled_regions ,[]);
close(figure(4))
%% measures
spinal=seg;  % used with crop
figure(5)
imshow(spinal,[]);

for i=1:X
    p1 = start_points(i,:);
    end_points = 60*normal_vec + points;
    p2 = end_points(i,:);
     hold on
    plot([p1(2) p2(2)], [p1(1) p2(1)], 'g', 'LineWidth', 3);
% %     plot(p1(2), p1(1),'.'); % start_points
    end_points = 60*normal_vec + points;
    p2 = end_points(i,:);
% %     plot([p2(2)],[ p2(1)], '.r'); % end_points
hold off
end
G = getframe;
im=im2double(G.cdata);
im(:,end-5:end,:) = 0; % remove the white line at right and bottom of image
im(end-5:end,:,:) = 0;

mask = (im(:,:,1)>0.75) & (im(:,:,2)>0.75) & (im(:,:,3)>0.75);
% figure
% imshow(im(:,:,3));
regions = bwconncomp(mask);
areas = cellfun(@(x) numel(x), regions.PixelIdxList);

[val ind] = sort(areas,'descend');

%% labeled areas
im1=im(:,:,1);
im1(:,end-5:end) = 0; % remove the white line at right of image
im1(end-5:end,:) = 0; % ok remove the white line at bottom of image
im1(:,1:2) = 0; % ok
labeledImage = bwlabel(im1, 4); 
% title('labeled regions');

colored = label2rgb (labeledImage, 'hsv', 'k', 'shuffle'); % pseudo random color labels
figure(6)
imshow(colored, []);  % Show the gray scale image.
%% sort from top to bottom
blobMeasurements = regionprops(labeledImage,  'Area', 'EquivDiameter','MinorAxisLength','MajorAxisLength','Centroid' );
% Get all centroids
allCentroids = vertcat(blobMeasurements.Centroid);
% Sort according to centroid's vertical location.
[sorted_y, sortOrder] = sort(allCentroids(:, 2), 'ascend');
% Reorder blobMeasurements
blobMeasurements = blobMeasurements(sortOrder);
numberOfBlobs = size(blobMeasurements, 1);
close(figure(5))
%%
% close(figure(4))
% figure(6)
% imshow(im,[]);
% coloredLabels=im;

%%
textFontSize = 5;	% Used to control size of "blob number" labels put atop the image.
labelShiftX = -3;	% Used to align the labels in the centers of the coins.
blobECD = zeros(1, numberOfBlobs);
% Loop over all blobs printing their measurements to the command window.
for k = 1 : numberOfBlobs           % Loop through all blobs.
	blobCentroid = (blobMeasurements(k).Centroid);		% Get centroid one at a time
    % Put the "blob number" labels on the "boundaries" grayscale image.
	text(blobCentroid(1) + labelShiftX, blobCentroid(2), num2str(k), 'FontSize', textFontSize, 'FontWeight', 'Bold');
end
% title('labeled regions')
% hold off


K = getframe;
labeled_regions0=K.cdata;
% figure()
% imshow(labeled_regions ,[]);
recap_image  = imfuse(orig, labeled_regions0,'blend','Scaling','joint');
% figure()
% imshow(recap_image ,[]);
close(figure(6))


