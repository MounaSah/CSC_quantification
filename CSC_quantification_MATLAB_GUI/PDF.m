%-----probability density function-----
function pdf=PDF(I,M,N)
[counts,binLocations] = imhist(I);
pdf =counts/(M*N);
% pdf =cumsum(counts)./sum(counts) % mouna
end