function [ bits, currentBrightness ] = demodMDPSK(I,prevBrightness,f,cooXY,levels)
    
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
        
        predictedTime = [];
        predictedBrightness = [];
       
        if(prevBrightness ~= 0 || currentBrigtness ~=0)
            prevTime = acos((prevBrightness-height)/amplitude)/omega;
            for i=1:levels
                tmp_predictedTime = (prevTime + Tperiod/2 + ((i-1)*Tperiod/levels));
                tmp_predictedBrightness = amplitude*cos(omega*tmp_predictedTime)+height;
                predictedTime = [predictedTime tmp_predictedTime];
                predictedBrightness = [predictedBrightness tmp_predictedBrightness];
                %fprintf('i: %d cB: %.2f, pB: %.2f\n',i,currentBrightness,tmp_predictedBrightness);
            end
            
            %false mod
            tmp_bits = 2*ones(1,log2(levels));
            symbol = -1;
               
            for i=1:levels
                if(currentBrightness >= ((1-deviation)*predictedBrightness(i)) && currentBrightness <= ((1+deviation)*predictedBrightness(i)))
                    symbol = i-1;
                end
            end
            
            if(symbol >= 0)
                tmp_bits = de2bi(symbol,'left-msb');

                %pad vector to desired code length
                if(length(tmp_bits) ~= log2(levels))
                    tmp_bits = [zeros(1,log2(levels)-length(tmp_bits)) tmp_bits];
                end
                
                %fprintf('sym: %d, tmp: %s, tmp2: %s\n',symbol,num2str(de2bi(symbol,'left-msb')),num2str(tmp_bits))
            end
            
            
            bits = tmp_bits;
        else
            	%error('no marker');
        end
        
        %y = height+amplitude*cos(omega*t(100*i)+phase)
        %(y - height)/(amplitude) = cos(omega*t(100*i)+phase;
        %t = (acos((y/amplitude - 3))-phase)/omega;
end

