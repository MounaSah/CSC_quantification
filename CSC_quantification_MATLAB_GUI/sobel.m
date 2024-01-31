function [ lenaOutput] = sobel(X)
%X input color image
X= double(X); height = size(X, 1); width = size(X, 2); channel = size(X, 3);
lenaOutput = X;
%  Gx = [1 +2 +1; 0 0 0; -1 -2 -1]; Gy = Gx';
 Gx = [-1 0 1;-2 0 2; -1 0 1]; Gy = -Gx';
for i = 2 : height-1 %512
   for j = 2 : width-1  %512
       for k = 1 : channel %1
           tempLena = X(i - 1 : i + 1, j - 1 : j + 1, k);
           a=(sum(Gx.* tempLena));
           x = sum(a);
           b= (sum(Gy.* tempLena));
            y = sum(b);
           pixValue =sqrt(x.^2+ y.^2);
          % pixValue =(x-y);
           lenaOutput(i, j, k) = (pixValue);
       end 
   end
end
lenaOutput = uint8(lenaOutput); 
figure; imshow(abs(lenaOutput),[]); title(' Sobel Edge Detection');

