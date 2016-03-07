function [ output_data] = MarkerDetection( input_data, method, Threshold)
    
    tmp_data = input_data;
    
    %Blob detection
    if(strcmp(method,'DoG'))
        tmp_data = DoG(tmp_data,7);
    elseif(strcmp(method,'LoG'))
        tmp_data = LaplacianOfGaussian(tmp_data, 0.5);
    elseif(strcmp(method,'custom'))
        %Threshold
        tmp_data = tmp_data > Threshold;

        %delete noise
        tmp_data = bwareaopen(tmp_data,5);

        %dilation to increase the size of the led, so it can be detected more
        %easily
        SE = strel('disk', 5, 0);
        tmp_data = imdilate(tmp_data,SE);
        
    elseif(~strcmp(method,'LoG') && ~strcmp(method,'DoG'))
        error('Invalid method');
    end
    
    if(strcmp(method,'DoG') || strcmp(method,'LoG'))
        
        %fill holes
        tmp_data = imfill(tmp_data,'holes');

        %Generate binairy image with certain Threshold
        tmp_data = tmp_data > Threshold;

        %Close operation
        SE = strel('disk', 2, 0);
        tmp_data = imclose(tmp_data, SE);

        %delete noise
        tmp_data = bwareaopen(tmp_data,5);
    end
    
    %Return detected frame
    output_data = tmp_data;
end

