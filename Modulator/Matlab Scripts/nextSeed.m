%determines nextseed for pn sequence with polynomal x^4 + x + 1
function [ nextSeed ] = nextSeed( initSeed, NOS )

    if(x == 1)
        nextSeed = [0 1 0 0];
    elseif(x == 2)
        nextSeed = [0 0 1 0];
    elseif(x == 3)
        nextSeed = [1 0 0 1];
    elseif(x == 4)
        nextSeed = [1 1 0 0];
    elseif(x == 5)
        nextSeed = [0 1 1 0];
    elseif(x == 6)
        nextSeed = [1 0 1 1];
    elseif(x == 7)
        nextSeed = [0 1 0 1];
    elseif(x == 8)
        nextSeed = [1 0 1 0];
    elseif(x == 9)
        nextSeed = [1 1 0 1];
    elseif(x == 10)
        nextSeed = [1 1 1 0];
    elseif(x == 11)
        nextSeed = [1 1 1 1];
    elseif(x == 12)
        nextSeed = [0 1 1 1];
    elseif(x == 13)
        nextSeed = [0 0 1 1];
    elseif(x == 14)
        nextSeed = [0 0 0 1];
    elseif(x == 15)
        nextSeed = [1 0 0 0];
    end
end

