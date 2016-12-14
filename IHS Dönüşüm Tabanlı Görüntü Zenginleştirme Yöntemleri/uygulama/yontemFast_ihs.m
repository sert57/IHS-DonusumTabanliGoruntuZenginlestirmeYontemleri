function im6 = yontemFast_ihs(pathms,pathpan,row,column,band)

im = multibandread(pathms, [row column band], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );
blue=1/3;
green=1/4;
red=1/12;
nir=1/3;

pan= multibandread(pathpan, [row column 1], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 1]} );

teta=pan-(blue.*im(:,:,1)+green.*im(:,:,2)+red.*im(:,:,3)+nir.*im(:,:,4));

im6(:,:,1)=im(:,:,1)+teta;
im6(:,:,2)=im(:,:,2)+teta;
im6(:,:,3)=im(:,:,3)+teta;
im6(:,:,4)=im(:,:,4)+teta;