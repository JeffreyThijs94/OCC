%Changes the location of the centerpoint with a random amount related to the
%amount of the specified spread. Resembles some human interaction
function [ randomPoint ] = randomPositioner( centerPoint, spread )

    mDivi = spread;
    rDiviX = floor((-mDivi/2 + mDivi*rand(1)));
    rDiviY = floor((-mDivi/2 + mDivi*rand(1)));


    randomPoint(1) = centerPoint(1)+rDiviX;
    randomPoint(2) = centerPoint(2)+rDiviY;
    
end

