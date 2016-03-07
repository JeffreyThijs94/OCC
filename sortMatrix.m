function [ out ] = sortMatrix( in, mode )

    out = in;

    if(strcmp(mode,'Horizontal'))
       for j=1:size(in,1)
           tmp = in(j,:);
           tmp2 = j;
           for i=j:size(in,1)
                local = in(i,:);
                if(local(2) < tmp(2))
                    tmp2 = i;
                end
           end 
           out(j,:) = in(tmp2,:);
           out(tmp2,:) = in(j,:);
           in = out;
       end
    elseif(strcmp(mode,'Vertical'))
        for j=1:size(in,1)
           tmp = in(j,:);
           tmp2 = j;
           for i=j:size(in,1)
                local = in(i,:);
                if(local(1) < tmp(1))
                    tmp2 = i;
                end
           end 
           out(j,:) = in(tmp2,:);
           out(tmp2,:) = in(j,:);
           in = out;
        end
    elseif(strcmp(mode,'Square'))
        tmp = in;
        tmp = [tmp(:,1)-height/2 tmp(:,2)-width/2];
        
        
    else
        error('invalid mode');
    end


end

