%%Init
%Calculate polynomial

m =4 ;

mat_poly = [ 1 1;
    1 2;
    1 4;
    1 8;
    1 3;
    1 6];

[rows,cols] = size(mat_poly);

poly = gf(mat_poly(1:1,1:2),m);

for i = 2:rows
    
    temp_p = gf(mat_poly(i:i,1:2),m);
    poly = conv(poly,temp_p);
    
end

display(poly);