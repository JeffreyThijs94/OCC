function [ outputBrightness, phase ] = modMDPSK( currentBits, phase, freq, t, noise )
    
    omega = 2*pi*freq;
    amplitude = 50;
    height = 150;
    symbols = length(currentBits);
    levels = 2^symbols;
    
    currentLevel = bi2de(currentBits,'left-msb');
    
    phase = phase + ((2*pi/levels)*currentLevel);
    
    outputBrightness = floor(amplitude*cos(omega*t+phase)+height);
end

