function RGB3= goruntuleme(path,row,col,band)
  im = multibandread(path, [row col band], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );
  
     if band >3
         RGB(:,:,1)= im(:,:,4);
  RGB(:,:,2)=im(:,:,3);
  RGB(:,:,3)=im(:,:,2);
     else if band <= 3
            RGB(:,:,1)= im(:,:,1);
  RGB(:,:,2)=im(:,:,2);
  RGB(:,:,3)=im(:,:,3); 
         end
     end
         
   max1 = max(max(RGB(:,:,1)));
 
   max2 = max(max(RGB(:,:,2)));
 
   max3 = max(max(RGB(:,:,3)));
 
  RGB2(:,:,1)=double(RGB(:,:,1))/(max1);
  RGB2(:,:,2)=double(RGB(:,:,2))/(max2);
  RGB2(:,:,3)=double(RGB(:,:,3))/(max3);
  
 RGB3(:,:,1)= imadjust(RGB2(:,:,1),stretchlim((RGB2(:,:,1))),[]);
 RGB3(:,:,2)= imadjust(RGB2(:,:,2),stretchlim((RGB2(:,:,2))),[]);
 RGB3(:,:,3)=  imadjust(RGB2(:,:,3),stretchlim((RGB2(:,:,3))),[]);

   