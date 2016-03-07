function [ validity, offset ] = checkValidityCode( bitstream, code)

    bitstream = regexprep(num2str(bitstream),'[^\w'']','');  
    codeLength = length(code);
    streamLength = length(bitstream);
    
    i=1;
    validity = 'false';
    offset = 0;
    
    while(i<=streamLength)
        tmpValidity = [];
        for j=1:codeLength
            if(i+j-1 < streamLength)
                if(bitstream(i+j-1) == code(j))
                    tmpValidity = [tmpValidity 1];
                else
                    tmpValidity = [tmpValidity 0];
                end
            end
        end
        if(length(tmpValidity) == codeLength && all(tmpValidity))
            validity = 'true';
            if(offset == 0)
                offset = i;
            end
        end
        i = i+1;
    end
        
    
%     for i=1:floor(length(bitstream)/codeLength)
%         if(code == bitstream(1+(i-1)*codeLength:codeLength*i))
%             %nothing
%         else
%             validity = 'false';
%         end
%     end
end

