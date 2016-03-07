function [] = modLED(a, pin, code, sampleRate, repetitions)

    %Settings
    samplePeriod = 1/sampleRate;
    
    %init
    it = 0;

    %Modulation
    while(it < repetitions)
        for i=1:length(code)
            SOF = tic;
            
            %Get current bit
            currentBit = str2num(code(i));
            
            %modulation scheme
            modOOK(currentBit);
            
            %Keep value for a sample period
            delay(samplePeriod-toc(SOF));
        end
        it = it+1;
    end
end

