%Modulator script for controlling the LED

%Settings
arduinoType = 'uno';
port = 'COM11';
pin = 'D11';
code = '101010';
sampleRate = 2;
runTime = 12; %in seconds

%calculation number of repititions (= full code emission, exact runTime
%might vary
repetitions = ceil(runTime/(length(code)/sampleRate));

%Define Arduino object
%a = arduino(port, arduinoType);

%LED control
modLED('a', pin, code, sampleRate, repetitions);

%Clear Arduino object
%clear a;