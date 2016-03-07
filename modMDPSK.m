function [ output_args ] = modMDPSK( currentBits, phase, freq, t, noise )
    
    omega = 2*pi*freq;
    amplitude = 50;
    height = 150;
    symbols = length(currentBits);
    levels = log2(symbols);
    
    if(currentBit == 1)
        phase = phase+pi;
    end

    outputBrightness = floor(amplitude*cos(omega*t+phase)+height);


end

