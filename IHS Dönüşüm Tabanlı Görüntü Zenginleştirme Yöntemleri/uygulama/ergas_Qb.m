function ergas_v = ergas_Qb(rband,fband,row,column,band)



    reference = multibandread(rband, [row column band], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );
   
   
  
    fusa = multibandread(fband, [row column band], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );

    br1=squeeze(reference(:,:,1));
    br2=squeeze(reference(:,:,2));
    br3=squeeze(reference(:,:,3));
    br4=squeeze(reference(:,:,4));

    bf1=squeeze(fusa(:,:,1));
    bf2=squeeze(fusa(:,:,2));
    bf3=squeeze(fusa(:,:,3));
    bf4=squeeze(fusa(:,:,4));

    [N1,N2]=size(br1);

    errore_1=(br1-bf1).^2;
    rmse_1=sqrt(1/N1/N2*sum(sum(errore_1)));

    errore_2=(br2-bf2).^2;
    rmse_2=sqrt(1/N1/N2*sum(sum(errore_2)));

    errore_3=(br3-bf3).^2;
    rmse_3=sqrt(1/N1/N2*sum(sum(errore_3)));

    errore_4=(br4-bf4).^2;
    rmse_4=sqrt(1/N1/N2*sum(sum(errore_4)));


    coef_1=((rmse_1)^2)/(mean2(br1)^2);
    coef_2=((rmse_2)^2)/(mean2(br2)^2);
    coef_3=((rmse_3)^2)/(mean2(br3)^2);
    coef_4=((rmse_4)^2)/(mean2(br4)^2);

    rapp=4;


    ergas_v=100/rapp*(sqrt(1/band*(coef_1+coef_2+coef_3+coef_4)));
