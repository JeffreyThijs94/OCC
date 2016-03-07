%Retrieve camera object with appropriate settings
%cam = imaq.VideoDevice('winvideo', 1, 'RGB24_320x240');
cam = imaq.VideoDevice('winvideo', 1, 'YUY2_160x120');

%Set datatype to uint8 (all used algorithms expect uint8 images)
cam.ReturnedDataType = 'uint8';

%Set to grayscale spectrum as color are irrelevant for this application
cam.ReturnedColorSpace = 'grayscale';

%Setup video player to display streamed images at real time
hVideoIn = vision.VideoPlayer;
hVideoIn.Name  = 'Stream';

%Capture settings
runTime = 10; %in seconds
FPS = 10;
samplePeriod = 1/FPS;
FTC = runTime*FPS;
%Threshold = 1;
Threshold = 50;

%Initialize empty bit_sequence
bit_sequence = [];

%Initialize frame number
nFrames = 0;

%Define start of stream
start = tic;
while (nFrames<FTC)
    
    %Define start of frame
    SOF = tic;
    
    %Retrieve original frame
    original_frame = step(cam);
    
    %Marker Detection
    [detected_frame, bit_sequence] = MarkerDetection(original_frame, 'DoG', Threshold, bit_sequence);
    
    clear original_frame;
    
    %Stream detected frame
    step(hVideoIn, detected_frame);
    
    %Next iteration
    nFrames = nFrames+1;
    
    %Delay to acquire fixed frame rate
    dTime = samplePeriod - toc(SOF);
    if(dTime > 0)
        delay(dTime);
    end
end


%Display avarage frame rate during run time
disp(FTC/toc(start))

%convert array of bits to bitstream in string format
bitstream =  regexprep(num2str(bit_sequence),'[^\w'']','');

%Display bit level data
disp(bitstream)

%Release camera object
release(cam);