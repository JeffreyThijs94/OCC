%Modulate the current bit with binairy dpsk
%0 = no phase shift
%1 = pi phase shift
function [ outputBrightness, phase] = modDPSK( currentBit, phase, freq, t, noise)

    omega = 2*pi*freq;
    amplitude = 50;
    height = 150;    
    
    if(currentBit == 1)
        phase = phase+pi;
    end

    outputBrightness = floor(amplitude*cos(omega*t+phase)+height);
end

