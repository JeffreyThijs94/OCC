function [ output_bsequence ] = RegisterBit( input_bsequence, occurance,nLeds,modulation,varargin )

    global prevSample
    
    if(strcmp(modulation,'OOK'))
        for i=1:nLeds
            if(occurance(i) == 1)
                input_bsequence = [input_bsequence 1];
            else
                input_bsequence = [input_bsequence 0];
            end
        end
    elseif(strcmp(modulation,'DPSK'))
        if(~isempty(varargin))  
            if(occurance == 1)
                [bit, prevSample] = demodDPSK(varargin{1},prevSample,varargin{2},varargin{3});
                input_bsequence = [input_bsequence bit];
            else
                error('no occurance of marker, so invalid read');
                %output_bsequence = [input_bsequence 0];
            end
        end
    elseif(strcmp(modulation,'MDPSK'))
        if(~isempty(varargin))  
            if(occurance == 1)
                [bit, prevSample] = demodMDPSK(varargin{1},prevSample,varargin{2},varargin{3},varargin{4});
                input_bsequence = [input_bsequence bit];
            else
                error('no occurance of marker, so invalid read');
                %output_bsequence = [input_bsequence 0];
            end
        end
    else
        error('invalid modulation scheme');
    end

    output_bsequence = input_bsequence;

end

