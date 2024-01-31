%----- Global Weighting CDF (GWCDF) -----
function [gwcdf,gamma]=GWCDF(I,M,N)
gwpdf=GWPDF(I,M,N);
L=length(gwpdf);
gwcdf=zeros(1,L);
gamma=zeros(1,L);
for l=1:L
    gwcdf(1,l)=0;
    for j=1:l  
        gwcdf(1,l)=gwcdf(1,l)+gwpdf(j)./sum(gwpdf);
    end
    gamma(1,l)=1-gwcdf(1,l);
end
end