function [ I_output ] = DoG( I_input, kernel_size )

img = I_input;
k = 10;
sigma1 =  0.5;
sigma2 = sigma1*k;

hsize = [kernel_size, kernel_size];

h1 = fspecial('gaussian', hsize, sigma1);
h2 = fspecial('gaussian', hsize, sigma2);

gauss1 = imfilter(img,h1,'replicate');
gauss2 = imfilter(img,h2,'replicate');

I_output = gauss1 - gauss2;

end

