function angolo_SAM = sam_Qb(rband,fband,row,column,band)

msoriginal= multibandread(rband, [row column band], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );
   


msfusa = multibandread(fband, [row column band], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );

[M,N,L] = size(msfusa);
prod_scal = dot(msoriginal,msfusa,3); 
norm_orig = dot(msoriginal,msoriginal,3);
norm_fusa = dot(msfusa,msfusa,3); 
prod_norm = sqrt(norm_orig.*norm_fusa);
prod_map = prod_norm;
prod_map(find(prod_map==0))=eps;
mappa = acos(prod_scal./prod_map);

prod_scal = reshape(prod_scal,M*N,1);
prod_norm = reshape(prod_norm, M*N,1);
z=find(prod_norm==0);
prod_scal(z)=[];prod_norm(z)=[];
angolo = sum(sum(acos(prod_scal./prod_norm)))/(size(prod_norm,1));
angolo_SAM = angolo*180/pi;
