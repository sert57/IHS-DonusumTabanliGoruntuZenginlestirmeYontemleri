function MSF = yontemChoi(pathms,pathpan,row,column,band)

PAN = multibandread(pathpan, [row column 1], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 1]} );

                                 

MS= multibandread(pathms, [row column band], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );

t=10;  % parametre              
                
for i=1:row
    for j=1:column
        I(i,j)=(MS(i,j,1)+MS(i,j,2)+MS(i,j,3)+MS(i,j,4))/band;
        MSF(i,j,1)=PAN(i,j)-((PAN(i,j)-I(i,j))/t)+MS(i,j,1)-I(i,j);
        MSF(i,j,2)=PAN(i,j)-((PAN(i,j)-I(i,j))/t)+MS(i,j,2)-I(i,j);
        MSF(i,j,3)=PAN(i,j)-((PAN(i,j)-I(i,j))/t)+MS(i,j,3)-I(i,j);
        MSF(i,j,4)=PAN(i,j)-((PAN(i,j)-I(i,j))/t)+MS(i,j,4)-I(i,j);
    end
end

