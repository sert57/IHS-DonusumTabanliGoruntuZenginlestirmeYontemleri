function c = CC_PAN(rband,fband,row,column,band)

X= multibandread(rband, [row column band], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );

Q= multibandread(fband, [row column 1], ...
                   'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );

                

                
                
for i=1:band
    c(i)=corr2(Q(:,:,1),X(:,:,i));
end

 cc=c';%korelasyon PAN ve MS arasýnda