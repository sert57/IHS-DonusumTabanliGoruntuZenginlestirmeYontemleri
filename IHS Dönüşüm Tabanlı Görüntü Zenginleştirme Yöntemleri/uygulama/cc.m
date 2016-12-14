function c = cc(rband,fband,row,column,band)

msoriginal= multibandread(rband, [row column band], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );
   


msfusa = multibandread(fband, [row column band], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );
                
for i=1:band
    c(i)=corr2(msoriginal(:,:,i),msfusa(:,:,i));
end