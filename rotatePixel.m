function [ rPixel ] = rotatePixel(pixel,angle)

    radians = pi*angle/180;

    rMatrix = [cos(radians) -sin(radians); sin(radians) cos(radians)];
    
    tmp = rMatrix*[pixel(1);pixel(2)]

    rPixel = [tmp(1) tmp(2)];
end

