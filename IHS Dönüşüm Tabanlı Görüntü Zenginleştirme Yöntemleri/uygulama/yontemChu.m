function MSF = yontemChu(pathms,pathpan,row,column,band)
MS= multibandread(pathms,  [row column band], ...
                    'uint16', 0, 'bsq', 'ieee-le');

PAN= multibandread(pathpan, [row column 1], ...
                    'uint16', 0, 'bsq', 'ieee-le'); %input 2
        
for i=1:row
    for j=1:column
        I(i,j)=(MS(i,j,1)+MS(i,j,2)+MS(i,j,3)+MS(i,j,4))/band;
             
    end
end

n=2;
H = ones(n);
EI=conv2(I,H)/(n*n);
EPAN=conv2(PAN,H)/(n*n);

for i=1:row
    for j=1:column
        Inew(i,j)=EI(i,j)+(PAN(i,j)-EPAN(i,j));
        
        if Inew(i,j)<=PAN(i,j)
         
            MSF(i,j,1)=MS(i,j,1)+Inew(i,j)-I(i,j);
            MSF(i,j,2)=MS(i,j,2)+Inew(i,j)-I(i,j);
            MSF(i,j,3)=MS(i,j,3)+Inew(i,j)-I(i,j);
            MSF(i,j,4)=MS(i,j,4)+Inew(i,j)-I(i,j);
            
        else
            MSF(i,j,1)=MS(i,j,1)+PAN(i,j)-I(i,j);
            MSF(i,j,2)=MS(i,j,2)+PAN(i,j)-I(i,j);
            MSF(i,j,3)=MS(i,j,3)+PAN(i,j)-I(i,j);
            MSF(i,j,4)=MS(i,j,4)+PAN(i,j)-I(i,j);
        end            
    end
end