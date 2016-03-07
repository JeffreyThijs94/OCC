%test data generator
%variables
    %general settings
    global width height FPS sizeLED prevSample positionLeds
    
    width = 320;                            %in pixels
    height = 240;                            %in pixels
    FPS = 30;
    samplePeriod = 1/FPS;   
    runTime = 5;                           %in seconds
    FTC = runTime*FPS;
    
    % 01 01 10 10 00 00 11 11 01/11 01 01 11 10 10 10
    
    %LED settings
    sizeLED = 4;                          %in pixels
    %centerPositionLeds = [1*width/4 1*height/4;3*width/4 1*height/4;1*width/4 3*height/4;3*width/4  3*height/4];  
    %centerPositionLeds = [1*width/3 1*height/3;2*width/3 1*height/3;width/2 2*height/3];
    %centerPositionLeds = [width/4 height/2; 3*width/4 height/2];
    centerPositionLeds = [width/2 height/2];     %(x,y)-coordinates
    nLeds = size(centerPositionLeds,1);
    ledMode = 'clear';                  %clear/faded (brightness) leds 
    
    %noise
    noise = [-60 -5];
                                   
    %Code
    syncEn = 0;
    syncCode = '1111';
    code = '101100111100';
    codeLength = length(code);
    offset = 0;         %offset of acquiring data in nFrames as capturing not always start at the begin of the code
    if(syncEn == 1)
        code = strcat(syncCode,code);
    end
    
    %modulation settings
    phase = 0;
    modulation = 'MDPSK';
    levels = 4;
    
    %inits
    nFrames = offset;
    codeIndex = 1;
    t_tmp = 1/60;
    bit_sequence = [];
    currentBits = [];
    positionLeds = [];
    prevSample = 200;

%Setup video player to display streamed images at real time
hVideoIn = vision.VideoPlayer;
hVideoIn.Name  = 'Test Data';

start = tic;
while(nFrames<FTC+offset)
    %start of frame
    SOF = tic;
    
    %Generate black Image
    I = uint8(zeros(height, width));
    
    %Get current bits
    if(~mod(nFrames,2))
        if(strcmp(modulation,'MDPSK'))
            nBits = nLeds*log2(levels);
        else
            nBits = nLeds;
        end
        [currentBits, codeIndex] = getCurrentBits(code,nBits,codeIndex);
    end
    
    %Draw led(s)
    if(strcmp(modulation,'OOK'))
        I = drawLED(I,centerPositionLeds,sizeLED,currentBits,noise,modulation,ledMode);
    elseif(strcmp(modulation,'DPSK'))
        [I,phase] = drawLED(I,centerPositionLeds,sizeLED,currentBits,noise,modulation,ledMode,phase,FPS/2,t_tmp);
    elseif(strcmp(modulation,'MDPSK'))
        [I,phase] = drawLED(I,centerPositionLeds,sizeLED,currentBits,noise,modulation,ledMode,phase,FPS/2,t_tmp);
    else
        error('Unknown modulation scheme');
    end
    
    %get time
    t_tmp = toc(start);
    
    %blob/marker detection (in case of noise environment)
    %I = MarkerDetection( I, 'DoG', 45, []);
    %I,bit_sequence = MarkerDetection( I, 'LoG', 50, []);
    %I,bit_sequence = MarkerDetection( I, 'custom', 70, []);
        
    %check if the frame contains blinking leds (with circular Hough
    %transform), so relies on circular objects
    [occurance] = CheckMarkerOccurance(I,[sizeLED-3 sizeLED+5],nLeds,'nenablePlot',syncEn);
    
    %translate led occurances to array of bits (in case of OOK)
    %translates intensity levels of occurances into array of bits (in case
    %of DPSK)
    bit_sequence = RegisterBit(bit_sequence, occurance, nLeds,modulation,I,FPS/2,centerPositionLeds,levels);
    
    %show frame on videoplayer
    %step(hVideoIn, I);
    
    %next frame
    nFrames = nFrames+1;
    
    %delay to achieve desired framerate
    delay(samplePeriod-toc(SOF));
end
t = toc(start);

%decimate stream by factor 2 (sending frequency is half of receiving frequence)
%related to # leds
os = bit_sequence;
bit_sequence = decimateStream(bit_sequence,2,nBits);

%format stream and validate the stream
if(syncEn == 1)
    [bitstream,effectiveBits] = formatStream(bit_sequence,codeLength,syncCode);
else
    [bitstream,effectiveBits] = formatStream(bit_sequence,codeLength);
end


% 2 2 3 3 1 1 4 4 2/4 2 2 4 3 3 3

%Print details
fprintf('--------------------------------------------------------------------------------------------\n');
fprintf('Modulation scheme: %s with %d LED(s).\n',modulation,nLeds);
fprintf('The average framerate was: %.2f FPS.\n', (nFrames-offset)/t);
fprintf('The average bitrate of the received data was: %.2f bit/s.\n',length(bit_sequence)/t);
fprintf('The average effective bitrate of the received data was: %.2f bit/s.\n',effectiveBits/t);
fprintf('The received code was: %s\n',bitstream(1:codeLength));
fprintf('The received bitstream was:  \n%s.\n',bitstream);