function [fStream,effectiveBits] = formatStream(stream,codeLength,varargin)
    
    fStream = [];

    if(~isempty(varargin))
        syncCode = varargin{1};
        lengthSCode = length(syncCode);
    else
        syncCode = 'none';
    end

    %remove all spaces
    stream =  regexprep(num2str(stream),'[^\w'']','');
    
    %outdated
    %[validation, offset] = checkValidityCode(stream, code);
    
    %if(offset ~= 0) 
     %   stream = stream(offset:end);
    %end
    
    i = 1;
    tmp = '';
    start = 0;
    
    if(~strcmp('none',syncCode))       
        while(i<=length(stream))
            if(i<length(stream)-(lengthSCode-1))
                if(stream(i:i+lengthSCode-1) == syncCode)
                    i = i + lengthSCode;
                    if(start == 0)
                        start = i;
                    end
                else
                    tmp(i) = stream(i);
                    i = i + 1;
                end
            else
                tmp(i) = stream(i);
                i = i + 1;
            end
        end
        stream = tmp(start:end);
        
        %remove all spaces
        stream =  regexprep(num2str(stream),'[^\w'']','');
    end
    
    effectiveBits = length(stream);
    
    for i=1:floor(length(stream)/codeLength)
        fStream = [fStream strcat(stream(1+(i-1)*codeLength:codeLength*i),'.')];
    end
    
    fStream = fStream(1:end-1);

end