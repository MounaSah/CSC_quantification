%----- Local Weighting PDF (GWPDF) -----
function [kopt,lwpdf] = LWPDF(I,M,N)
[Nb,lmin,lmax] = getGlobalx;
pdf=PDF(I,M,N);
pdfmax=max(pdf);
pdfmin=min(pdf);
L=size(pdf);

if Nb==1
    alpha=0;
    for j=lmin:lmax
        alpha = alpha+pdf(j);
    end
    for l=lmin:lmax
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha);
    end
    kopt=[];
    
elseif Nb==2
    kopt1=Histogramdivision(I,M,N,lmin,lmax);
    alpha1=0;
    alpha2=0;
    for j=lmin:kopt1
        alpha1 = alpha1+pdf(j);
    end
    for l=lmin:kopt1
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha1);
    end
    
    for j=kopt1:lmax
        alpha2 = alpha2+pdf(j);
    end
    for l=kopt1:lmax
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha2);
    end
    kopt=[kopt1];
    
elseif Nb==4
    kopt1=Histogramdivision(I,M,N,lmin,lmax);
    kopt2=Histogramdivision(I,M,N,lmin,kopt1);
    kopt3=Histogramdivision(I,M,N,kopt1,lmax);
    kopt=[kopt1,kopt2,kopt3];
    alpha1=0;
    alpha2=0;
    alpha3=0;
    alpha4=0;
    
    for j=lmin:kopt2
        alpha1 = alpha1+pdf(j);
    end
    for l=lmin:kopt2
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha1);
    end
    
    for j=kopt2:kopt1
        alpha2 = alpha2+pdf(j);
    end
    for l=kopt2:kopt1
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha2);
    end
    
    for j=kopt1:kopt3
        alpha3 = alpha3+pdf(j);
    end
    for l=kopt1:kopt3
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha3);
    end
    
    for j=kopt3:lmax
        alpha4 = alpha4+pdf(j);
    end
    for l=kopt3:lmax
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha4);
    end
    kopt=[kopt1,kopt2,kopt3];
    
elseif Nb==8
    kopt1 = Histogramdivision(I,M,N,lmin,lmax);
    kopt2=Histogramdivision(I,M,N,lmin,kopt1);
    kopt3=Histogramdivision(I,M,N,kopt1,lmax);
    kopt4=Histogramdivision(I,M,N,lmin,kopt2);
    kopt5=Histogramdivision(I,M,N,kopt2,kopt1);
    kopt6=Histogramdivision(I,M,N,kopt1,kopt3);
    kopt7=Histogramdivision(I,M,N,kopt3,lmax);
    
    alpha1=0;
    alpha2=0;
    alpha3=0;
    alpha4=0;
    alpha5=0;
    alpha6=0;
    alpha7=0;
    alpha8=0;
    
    for j=lmin:kopt4
        alpha1 = alpha1+pdf(j);
    end
    for l=lmin:kopt4
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha1);
    end
    
    for j=kopt4:kopt2
        alpha2 = alpha2+pdf(j);
    end
    for l=kopt4:kopt2
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha2);
    end
    
    for j=kopt2:kopt5
        alpha3 = alpha3+pdf(j);
    end
    for l=kopt2:kopt5
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha3);
    end
    
    for j=kopt5:kopt1
        alpha4 = alpha4+pdf(j);
    end
    for l=kopt5:kopt1
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha4);
    end
    
    for j=kopt1:kopt6
        alpha5 = alpha1+pdf(j);
    end
    for l=kopt1:kopt6
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha5);
    end
    
    for j=kopt6:kopt3
        alpha6 = alpha2+pdf(j);
    end
    for l=kopt6:kopt3
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha6);
    end
    
    for j=kopt3:kopt7
        alpha7 = alpha3+pdf(j);
    end
    for l=kopt3:kopt7
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha7);
    end
    
    for j=kopt7:lmax
        alpha8 = alpha4+pdf(j);
    end
    for l=kopt7:lmax
        lwpdf(l)=pdfmax*(((pdf(l)-pdfmin)./(pdfmax-pdfmin)).^alpha8);
    end
    kopt=[kopt1,kopt2,kopt3,kopt4,kopt5,kopt6,kopt7];
    
end
end