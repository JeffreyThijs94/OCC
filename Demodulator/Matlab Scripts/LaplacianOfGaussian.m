function [ img ] = LaplacianOfGaussian( input, sigma)

n = 2*(3*sigma)+1;
G = fspecial('gaussian',n);
g = conv2(input,G);
L = fspecial('laplacian');
newImage = conv2(g,L);

img = newImage;

end

