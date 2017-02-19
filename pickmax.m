% Function: pick the index of local maxima

function [Y, I] = pickmax(y)  

Y = zeros(5,1);                                                             % pick the first 5 picks 
I = zeros(5,1);  

xd = diff(y);                                                               % get the difference 

index = 1;                                                                  % pick the index where the difference goes from + to - % this is the local maxima
pos = 0;

for i=1:length(xd)  
    
    if xd(i)>0    
        pos = 1; 
    
    else
        if pos==1     
            pos = 0;    
            Y(index) = xd(i);     
            I(index) = i-1;       
            index = index + 1;    
            
            if index>5       
                return     
            end
        end
    end
end