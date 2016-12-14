function im6 = yontemRahmani(pathms,pathpan,row,column,band)

Y= multibandread(pathpan, [row column 1], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 1]} );

X = multibandread(pathms, [row column band], ...
                    'uint16', 0, 'bsq', 'ieee-le', ...
                    {'Band', 'Range', [1 band]} );

y=Y(:);

X1=X(:,:,1);
X1=X1(:);

X2=X(:,:,2);
X2=X2(:);

X3=X(:,:,3);
X3=X3(:);

X4=X(:,:,4);
X4=X4(:);

XX = [ones(size(X1)) X1 X2 X3 X4];

beta=regress(y,XX)

a=beta(2,1);
b=beta(3,1);
c=beta(4,1);
d=beta(5,1);
e=beta(1,1);

%new Intensity
y1=(a.*X(:,:,1)+ b.*X (:,:,2)+ c.*X (:,:,3)+ d.*X (:,:,4)+e);

%histogram matching between PAN and Intensity 
I=y1;
st=std2(I)/std2(Y);
up=mean2(Y);
ul=mean2(I);
P=st*(Y-up)+ul;
pan=P;
teta1=pan-y1;

%edge detection function
[GmagPAN, GdirPAN] = imgradient(Y,'prewitt');
figure; imshowpair(GmagPAN, GdirPAN, 'montage');
title('Gradient Magnitude, Gmag (left), and Gradient Direction, Gdir (right), using Prewitt method');
axis off;
figure;hist(GmagPAN);
title('GmagPAN histogram');
xlabel('GmagPAN (gradient magnitude)');
ylabel('number of pixel');
 
lamda=10^-10;
ep=1;

for i=1:1000;
    for j=1:1000;
h(i,j)=ep*exp((GmagPAN(i,j)*lamda)^2);
    end
end

yatay=GmagPAN(:); 
dikey=h(:);

figure;scatter(yatay,dikey,'o');
title('GmagPAN (gradient magnitude) &  h(weight parameter)');
xlabel('GmagPAN (gradient magnitude)');
ylabel('h (weight parameter)');

teta2=h.*teta1;

im6(:,:,1)=X(:,:,1)+teta2;
im6(:,:,2)=X(:,:,2)+teta2;
im6(:,:,3)=X(:,:,3)+teta2;
im6(:,:,4)=X(:,:,4)+teta2;
                
      



