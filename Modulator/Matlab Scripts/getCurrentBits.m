function [ currentBits, codeIndex ] = getCurrentBits( code, nBits, codeIndex)

    currentBits = [];
    
    for i=codeIndex:codeIndex+nBits-1
        if(i <= length(code))
            j = i;
        else
            j = i-length(code);
        end
        currentBits = [currentBits str2num(code(j))];
    end
    
    if(codeIndex+nBits <= length(code))
        codeIndex = codeIndex + nBits;
    else
        codeIndex = codeIndex + nBits - length(code);
    end
end

