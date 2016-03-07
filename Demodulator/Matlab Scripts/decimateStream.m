function [ dStream ] = decimateStream( stream, rate, nLeds )

    dStream = [];

    for i=1:rate*nLeds:length(stream)
        for j=1:nLeds
            if(i+j-1 <= length(stream))
                dStream = [dStream stream(i+j-1)];
            end
        end
    end


end

