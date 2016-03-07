%Draws LED (regular circle in this case) on the desired point in the
%current image with a specified radius and brightness level (uint8)
function [ Iout, varargout ] = drawLED( Iin, centerPoint, radius,currentBits,noise,modScheme,modeLED,varargin) 

    cY = floor(centerPoint(:,1));
    cX = floor(centerPoint(:,2));
    Iout = Iin;
    nLeds = size(centerPoint,1);
    
    if(isempty(currentBits))
        currentBits = zeros(1,nLeds);
    end
    
    if(strcmp(modScheme,'OOK'))
        brightness = modOOK(currentBits,noise,'Theoretical');
    elseif(strcmp(modScheme,'DPSK'))
        if(length(varargin)==3)   
            [brightness, phase] = modDPSK(currentBits,varargin{1},varargin{2},varargin{3},noise);
            varargout{1} = phase;
        end
    elseif(strcmp(modScheme,'MDPSK'))
        if(length(varargin)==3)
            [brightness, phase] = modMDPSK(currentBits,varargin{1},varargin{2},varargin{3},noise);
            varargout{1} = phase;
        end  
    elseif(strcmp(modScheme,'cON'))
        brightness = 255;
    else
        error('Unknown modulation scheme');
    end
    
    %disp(brightness)
    
    if(strcmp(modeLED,'clear'))
        for k=1:nLeds
            for i=cX(k)-radius:cX(k)+radius
                for j=cY(k)-radius:cY(k)+radius
                    tmpRadius = sqrt((i - cX(k))^2 + (j - cY(k))^2);
                    if(tmpRadius <= radius)
                        Iout(i,j) = brightness(k);
                    end
                end
            end
        end
    elseif(strcmp(modeLED,'faded'))
        
        fadeLevels = 5; %different brightness gradations
        baseB = 0.3;
        
        for k=1:size(centerPoint,1)
            for i=cX(k)-radius:cX(k)+radius
                for j=cY(k)-radius:cY(k)+radius
                    tmpRadius = sqrt((i - cX(k))^2 + (j - cY(k))^2);
                    for l=1:1:fadeLevels
                        if(tmpRadius < (1/l)*radius)
                            fadeFactor = baseB+l*((1-baseB)/fadeLevels);
                            Iout(i,j) = fadeFactor*brightness(k);
                        end
                    end
                end
            end
        end
    elseif(strcmp(modeLED,'rotated'))
    end
        
end

