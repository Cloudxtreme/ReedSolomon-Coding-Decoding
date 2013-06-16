%
function [out,nerr] = gf_bsc(data,galois_size,prob,state)

[rows,cols] = size(data.x); 

%# create binary string - the 4 forces at least 4 bits
bstr = dec2bin(data.x,galois_size);

%# convert back to numbers (reshape so that zeros are preserved)
temp = str2num(reshape(bstr',[],1))';

%# send through bsc
[temp,errvect] = bsc(temp,prob,state);

%% Conversion bin to dec
temp2 = [];
cols = cols-1;

for i = 0:cols
    
    ris = 0;
    
    for j = 1:galois_size
        %Sum all values
        ris = ris*2 + temp(i*galois_size+j);
        
    end
    temp2 = [temp2 ris];
    
end

%% Output

temp2 = gf(temp2,data.m,data.prim_poly);
out = temp2;
nerr = sum(errvect(:));


end

