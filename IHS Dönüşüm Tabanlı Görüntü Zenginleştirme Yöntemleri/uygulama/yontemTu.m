function MSF = yontemTu(pathms,pathpan,row,column,band)

PAN= multibandread(pathpan, [row column 1], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 1]} );
                                 

MS= multibandread(pathms, [row column band], ...
                     'uint16', 0, 'bsq', 'ieee-le', ...
                     {'Band', 'Range', [1 band]} );

t=40;  % parametre              
                
for i=1:row
    for j=1:column
        I(i,j)=(MS(i,j,1)+MS(i,j,2)+MS(i,j,3)+MS(i,j,4))/band;
        
        a1=(PAN(i,j)/(((t-1)/t)*PAN(i,j)+(I(i,j)/t)));
        a2=(((t-1)/t)*(PAN(i,j)-I(i,j)));
        
        MSF(i,j,1)=a1*(MS(i,j,1)+a2);
        MSF(i,j,2)=a1*(MS(i,j,2)+a2);
        MSF(i,j,3)=a1*(MS(i,j,3)+a2);
        MSF(i,j,4)=a1*(MS(i,j,4)+a2);
        
    end
end