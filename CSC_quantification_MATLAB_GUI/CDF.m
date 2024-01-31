%-----Cumulative Distribution Function (CDF)-----
function cdf=CDF(I,M,N)
pdf=PDF(I,M,N);
L=size(pdf);
cdf=zeros();
for l=1:L
    cdf(l)=0;
    for j=1:l
    cdf(l)=cdf(l)+pdf(j);
    end
end
end