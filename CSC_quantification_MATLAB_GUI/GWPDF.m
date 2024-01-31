%----- Global Weighting PDF (GWPDF) -----
function gwpdf=GWPDF(I,M,N)
pdf=PDF(I,M,N);
pdfmax=max(pdf);
pdfmin=min(pdf);
L=size(pdf);
cdf=CDF(I,M,N);
for l=1:L
    alpha=cdf(l);
    gwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha);
end
end
