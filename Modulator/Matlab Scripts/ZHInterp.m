%Constant interpolation
function [ outputstream ] = zeroholdInterp( bitstream, rate )

    if(rate < 1)
        error('invalid interpolation rate');
    end

    outputstream = [];
    for i=1:length(bitstream)
        interpData = [];
        for j=1:rate
            interpData = [interpData bitstream(i)];
        end
        outputstream = [outputstream interpData];
    end
end

