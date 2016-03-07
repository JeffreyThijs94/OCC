

hight = 240;
width = 320;
currentBit = 1;
centerPosition = [hight/2 width/2];

I = uint8(zeros(hight, width));

%I = drawLED(I,centerPosition,sizeLED,modOOK(currentBit,'Theoretical'));
I = drawLED(I,centerPosition,sizeLED,255);

%I = I > 5;

[occurance] = CheckMarkerOccurance(I,I>100,[2 10],'enablePlot');