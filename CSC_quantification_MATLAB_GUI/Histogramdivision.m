function kopt=Histogramdivision(I,M,N,lmin,lmax)
pdf=PDF(I,M,N);
w0=zeros(lmax,1);
w1=zeros(lmax,1);
mu0=zeros(lmax,1);
mu1=zeros(lmax,1);

for i=lmin:lmax
    k=i;
  
    for j=lmin:k
        w0(i,1)=w0(i,1)+pdf(j);
    end
    
    for j=lmin:k
        mu0(i,1)=mu0(i,1)+j*pdf(j,1)./w0(i,1);
    end
    
    for j=k+1:lmax
        w1(i,1)=w1(i,1)+pdf(j);
    end
    
    for j=k+1:lmax
        mu1(i,1)= mu1(i,1)+j*pdf(j,1)./w1(i,1);
    end
    
    mu(i,1) = mu0(i,1).*w0(i,1)+mu1(i,1).*w1(i,1);
    
    var(i,1) = w0(i,1).*((mu0(i,1)-mu(i,1)).^2)+w1(i,1).*((mu1(i,1)-mu(i,1)).^2);
end

varmax=max(var);
kopt=find(var==varmax); 
end