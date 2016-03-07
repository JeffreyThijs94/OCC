function [ dsssStream, varargout ] = modDSSS( bitstream, rate, varargin )

    polyn = [4 1 0];                %polynom
    spf = length(bitstream)*rate;   %samples per frame
    
    if(isempty(varargin))
        seed = [0 0 0 1];           %seed
    end
    
    %interpolate bitstream with constant interpolation data
    bitstream = ZHInterp(bitstream, rate);

    %generate pn generator
    pn = comm.PNSequence('Polynomial',polyn,'SamplesPerFrame',spf,'InitialConditions',seed);
    
    %generate pn-stream
    pn_stream = step(pn)';
    
    %determine output seed
    nSeed = nextSeed(seed, spf);
    varargout = nSeed; 
    
    %XOR the dsss stream with the interpolated bitstream
    dsssStream = xor(bitstream, pn_stream(1:length(bitstream)));
    
end

