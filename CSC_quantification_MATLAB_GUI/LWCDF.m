
%----- Locacal Weighting Cumulative PDF (LWCDF) -----
function [lwcdf,gamma]=LWCDF(I,M,N)
[counts,binLocations] = imhist(I);
[kopt,lwpdf] = LWPDF(I,M,N);
L=length(binLocations);
lwcdf=zeros(1,L);
gamma=zeros(1,L);
for l=1:L
    lwcdf(1,l)=0;
    for j=1:l
        lwcdf(1,l)=lwcdf(1,l)+lwpdf(j)/sum(lwpdf);
    end
    gamma(1,l)=1-lwcdf(1,l);
end
end
