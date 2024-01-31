function Output_LL_SVD_GAGC=enhancement(inputImage)

[siz]= size(inputImage);
OriginalDataArray= uint8(double(inputImage .* (255/max(max(inputImage)))));

[counts,binLocations] = imhist(OriginalDataArray);

%% SVD OF ORIGINAL IMAGE

        orig_image=OriginalDataArray;
        [LL1,LH1,HL1,HH1]=dwt2(orig_image,'haar');
        [u1 s1 v1]=svd(LL1);
        
        [siz]= size(orig_image);
        %------------------------------Histogram Equalisation using GHE
        GHE_image=histeq(orig_image,1024);
        
        %------------------------------dwt2 of equalized image using GHE
        [LL2,LH2,HL2,HH2]=dwt2(GHE_image,'haar');
        [u2 s2 v2]=svd(LL2);
        
        ksi_S=max(s2)/max(s1); 
        s_gamma_atta=0.5*((ksi_S*s1)+((1/ksi_S)*s2));      
        new_LL = u1*s_gamma_atta*v1';


%%  HUANG OF LL subband
OriginalDataArray3= uint8(double(new_LL .* (255/max(max(new_LL)))));

[counts,binLocations3] = imhist(OriginalDataArray3);
        
lmin=1;
lmax3=length(binLocations3);
Nb=4;
[M,N]=size(OriginalDataArray3);
setGlobalx(Nb,lmin,lmax3);
[LL_gwcdf3,LL_gamma_L3]=GWCDF(OriginalDataArray3,M,N);
[LL_lwcdf3,LL_gamma_G3]=LWCDF(OriginalDataArray3,M,N);
binLocations_n3=(binLocations3)./lmax3;
L3=length(binLocations3);
pc3=zeros(L3,1);
pc_nL3=zeros(L3,1);
pc_nG3=zeros(L3,1);
LL_outputImage_nL3=zeros(M,N);
LL_outputImage_L3=zeros(M,N);
LL_outputImage_nG3=zeros(M,N);
LL_outputImage_G3=zeros(M,N);
LL_gamma_L3=LL_gamma_L3';
LL_gamma_G3=LL_gamma_G3';

for l=1:L3
    LL_pc_nL3(l,1)=binLocations_n3(l,1).^LL_gamma_L3(l,1);
    LL_pc_nG3(l,1)=binLocations_n3(l,1).^LL_gamma_G3(l,1);
end
for l=1:L3
    for i=1:M
        for j=1:N
            if OriginalDataArray3(i,j)== binLocations(l,1)
                LL_outputImage_nL3(i,j) = LL_pc_nL3(l,1);
                LL_outputImage_nG3(i,j) = LL_pc_nG3(l,1);
            end
        end
    end
end
   
new_LL_outputImage_L3=uint8(lmax3*LL_outputImage_nL3);
new_LL_outputImage_G3=uint8(lmax3*LL_outputImage_nG3);
        
new_outputImage_L3 = idwt2(new_LL_outputImage_L3,LH1,HL1,HH1,'haar',siz);
new_outputImage_G3 = idwt2(new_LL_outputImage_G3,LH1,HL1,HH1,'haar',siz);

LL_outputImage_L3= uint8(double(new_outputImage_L3 .* (255/max(max(new_outputImage_L3)))));
LL_outputImage_G3= uint8(double(new_outputImage_G3 .* (255/max(max(new_outputImage_G3)))));

%%
Output_LL_SVD_GAGC =double(LL_outputImage_G3);
% figure 
% imshow(Output_LL_SVD_GAGC,[]);


