function [b] = modOOK( currentBits, noiseMinMax,application )

    ON = 255;
    OFF = 0;
    nLeds = length(currentBits);
    %noise = 0;
    
    
    %OUTDATED, FIX LATER
    if(strcmp(application,'Arduino'))
        %Send PWM-signal to LED
        if(currentBit == 1)
            writePWMDutyCycle(a, pin, ON);
        elseif(currentBit == 0)
            writePWMDutyCycle(a, pin, OFF);
        else
            error('invalid code');
        end
    elseif(strcmp(application,'Theoretical'))
        %Couple bit level to brightness level
        noise = randi(noiseMinMax,1,nLeds);
        b=[];
        
        for i=1:nLeds
            if(currentBits(i) == 1)
                b = [b ON+noise(i)];
            elseif(currentBits(i) == 0)
                b = [b OFF];
            else
                error('invalid code');
            end
        end
    else
        error('Application not defined.');
    end
end

