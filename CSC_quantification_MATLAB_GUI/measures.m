function [blobArea,blobECD,MinorAxisLength,MajorAxisLength,blobVolume_cylindre,blobVolume_cone,numberOfBlobs,totalVolume_cone,total_length ]=measures(labeledImage,slice_thickness,voxel_heigth,voxel_width)
%% sort from top to bottom
blobMeasurements = regionprops(labeledImage,'Area','EquivDiameter','MinorAxisLength','MajorAxisLength','Centroid','Perimeter');
% Get all centroids
allCentroids = vertcat(blobMeasurements.Centroid);
% Sort according to centroid's vertical location.
[sorted_y, sortOrder] = sort(allCentroids(:, 2), 'ascend');
% Reorder blobMeasurements
blobMeasurements = blobMeasurements(sortOrder);
numberOfBlobs = size(blobMeasurements, 1);

%%
textFontSize = 5;	% Used to control size of "blob number" labels put atop the image.
labelShiftX = -3;	% Used to align the labels in the centers of the coins.
blobArea = zeros(1, numberOfBlobs);
blobECD = zeros(1, numberOfBlobs);
MinorAxisLength = zeros(1, numberOfBlobs);
MajorAxisLength = zeros(1, numberOfBlobs);
Perimeter= zeros(1, numberOfBlobs);
blobVolume_cylindre = zeros(1, numberOfBlobs);
blobVolume_cone=zeros(1, numberOfBlobs);

for k = 1 : numberOfBlobs           % Loop through all blobs.
	blobArea(k) = (blobMeasurements(k).Area);		% Get area.

    MinorAxisLength(k)=(blobMeasurements(k).MinorAxisLength).*voxel_width; % Get minor axis length (in pixels) of an ellipse
    MinorAxisLength(k)=round(MinorAxisLength(k),2);
    
    MajorAxisLength(k)=(blobMeasurements(k).MajorAxisLength).*voxel_heigth;
    MajorAxisLength(k)=round(MajorAxisLength(k),2);
    
    r(k)=MinorAxisLength(k)./2;

    blobECD(k) = (sqrt((blobArea(k) ./ pi)-(r(k).^2))).*voxel_heigth;					% Compute ECD - Equivalent Circular Diameter
    blobECD(k)=(((MinorAxisLength(k)-blobECD(k))./2)+MinorAxisLength(k));
    blobECD(k) =round(blobECD(k),2);
    
        R(k)=blobECD(k)./2;
%         blobECD(k)=round(blobECD(k),2);

%     end        

    blobVolume_cylindre(k)=(pi.*((MinorAxisLength(k)/2).^2).*MajorAxisLength(k));
    blobVolume_cylindre(k)=round(blobVolume_cylindre(k),2);
    
    blobVolume_cone(k)=(pi.*MajorAxisLength(k).*(1/3).*((r(k).^2)+(R(k).^2)+(r(k).*R(k))));

%     fprintf(1,'#%1d  %8.1f %15.1f  %15.1f %15.1f\n ', k, blobECD(k),MinorAxisLength(k), MajorAxisLength(k),blobVolume_cylindre(k),blobVolume_cone(k));
    blobVolume_cone(k)=round(blobVolume_cone(k),2);
    totalVolume_cone=sum(blobVolume_cone);
    total_length=sum(MajorAxisLength);
%     total_length(k)=round(total_length(k),2);

end
