function im6 =yontemIhs(pathms,pathpan,row,column,band)

im = multibandread(pathms, [row column band], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );

c=1/band;
pan= multibandread(pathpan, [row column 1], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 1]} );              
sum =0;
for i=1:band
     sum =sum+ c.*im(:,:,i);     
end
     teta = pan-sum;
     
      for i=1:band
        im6(:,:,i)=im(:,:,i)+teta;
    end









