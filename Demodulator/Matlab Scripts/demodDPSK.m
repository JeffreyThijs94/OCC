%demodulates the image with dpsk modulated signals, assuming the leds are
%in in the image. The working of the algorithm is as follows:
% 1) get the intensity of the current bit at coordinates XY
% 2) predict the current intensity with the information of the intensity of
% the previous bit, using the same carrier as the modulator. There are two
% possible values (using the binaire scheme), so predict the value with
% 0/180° phase shift
% 3) compare the predicted value with the actual value
% 4) if the current value matches with the value of the predicted intensity
% level without phase shift (not an exact match within a margin (e.g. ~5%
% deviation) = 0 bit, if the value matches the other prediction = 1 bit.
% Otherwise a bit error occured or ...
function [ bit, currentBrightness ] = demodDPSK(I,prevBrightness,f,cooXY)

    omega = 2*pi*f;
    Tperiod = 1/f;
    deviation = 0.05;
    amplitude = 50;
    height = 150;

    if(~isempty(cooXY))
        cX = cooXY(2);
        cY = cooXY(1); 
    else
        cX = 1;
        cY = 1;
    end
    
        %formula y = amplitudecos(omega*t) + height
        %so y1 = amplitudecos(omega*t1) + height
        %so y2 = amplitudecos(omega*(t1+delta)) + height
        %if ~= y2 then y2 = amplitudecos(omega*(t1+delta)+pi) + height
        
        currentBrightness = double(I(floor(cX),floor(cY)));
        prevBrightness = double(prevBrightness);
       
        if(prevBrightness ~= 0 || currentBrigtness ~=0)
            prevTime = acos((prevBrightness-height)/amplitude)/omega;
            predictedTime = prevTime + Tperiod/2;
            predictedTime2 = prevTime + Tperiod;
            predictedBrightness = amplitude*cos(omega*predictedTime)+height;
            predictedBrightness2 = amplitude*cos(omega*predictedTime2)+height;
            
            %fprintf('cB: %.2f, pB: %.2f, pB2: %.2f\n',currentBrightness,predictedBrightness,predictedBrightness2);
            
            if(currentBrightness >= ((1-deviation)*predictedBrightness) && currentBrightness <= ((1+deviation)*predictedBrightness))
                bit = 0;
                %fprintf('no phase shift\n');
            elseif(currentBrightness >= ((1-deviation)*predictedBrightness2) && currentBrightness <= ((1+deviation)*predictedBrightness2))
                bit = 1;
                %fprintf('phase shift\n');
            else
                bit = 2;
                %error('false mod');
            end
        else
            	%error('no marker');
        end
        
        %y = height+amplitude*cos(omega*t(100*i)+phase)
        %(y - height)/(amplitude) = cos(omega*t(100*i)+phase;
        %t = (acos((y/amplitude - 3))-phase)/omega;
    
end

