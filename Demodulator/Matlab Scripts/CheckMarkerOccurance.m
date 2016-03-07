%Function based on Circular Hough transform to detect markers

function [ occurance ] = CheckMarkerOccurance(img, radii,nLeds,plot,varargin)

    global positionLeds
    threshold = 50;
    deviation = 5;
    if(~isempty(varargin))
        syncEn = varargin{1};
    else
        syncEn = 0;
        
    end
    
    width = 320;
    height = 240;
   
    I = img > threshold;

    %Enlarge the current picture to increase the effectivity of the
    %algorithm (not effective for circles of small radii)
    %img = imresize(img,4);
    
    %Find circles in the current image
    [centers, radii] = imfindcircles(I,radii);
    
    %sort centers horizontal first
    centers = sortMatrix(centers,'Horizontal');
    
%     %plot
    if(strcmp(plot,'enablePlot'))
        
        subplot(1,2,1)
        imshow(img)
        title('Processed Frame');

        subplot(1,2,2)
        imshow(img)
        viscircles(centers, radii,'EdgeColor','b');
        title('Detected LEDS')
        
    end
    
        %sync frame
        if(length(radii) == nLeds && syncEn == 1)
            if(isempty(positionLeds))
                for i=1:nLeds
                    positionLeds = [positionLeds; centers(i,:)];
                end
            else
                if(~all(all(positionLeds == centers)))
                    positionLeds = [];
                     for i=1:nLeds
                        positionLeds = [positionLeds; centers(i,:)];
                    end
                end
            end
        elseif(syncEn == 0)
            positionLeds = [ width/2 height/2]; 
        end
           
       occurance = [];
       
        if(syncEn == 0)
            %Check if circles were detected
            if(isempty(radii))
                occurance = zeros(1,nLeds);
                %disp('No markers were detected!');
            else
                for i=1:nLeds
                    ledFound = 0;
                    hT = positionLeds(i,:)+deviation;
                    lT = positionLeds(i,:)-deviation;
                    for j=1:size(centers,1)
                        if(all(lT<centers(j,:)) && all(hT>centers(j,:)))
                            ledFound = 1;
                        end
                    end
                    if(ledFound == 1)
                        occurance = [occurance 1];
                    else
                        occurance = [occurance 0];
                    end
                end        
            end
        else
            %Check if circles were detected
            if(isempty(positionLeds))
                occurance = zeros(1,nLeds);
                %disp('No markers were detected!');
            else
                for i=1:nLeds
                    ledFound = 0;
                    hT = positionLeds(i,:)+deviation;
                    lT = positionLeds(i,:)-deviation;
                    for j=1:size(centers,1)
                        if(all(lT<centers(j,:)) && all(hT>centers(j,:)))
                            ledFound = 1;
                        end
                    end
                    if(ledFound == 1)
                        occurance = [occurance 1];
                    else
                        occurance = [occurance 0];
                    end
                end        
            end
        end
end

