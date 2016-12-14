function psnr = PSNR(rband,fband,row,column,band)


            X= multibandread(fband, [row column 4], ...
                   'uint16', 0, 'bsq', 'ieee-le', ...
                   {'Band', 'Range', [1 band]} );
            X = double(X);
            
             Q= multibandread(rband, [row column 1], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} ); 
                Q = double(Q);
                

            [M N] = size(X);
            error = X - Q;
            MSE = sum(sum(error .* error)) / (M * N);

            if(MSE > 0)
            psnr = 10*log(255*255/MSE) / log(10);
            else
            psnr = 99;
            end 

        end

