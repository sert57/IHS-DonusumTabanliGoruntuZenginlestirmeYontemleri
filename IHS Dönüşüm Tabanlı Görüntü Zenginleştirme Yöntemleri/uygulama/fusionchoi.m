function varargout = fusionchoi(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fusionchoi_OpeningFcn, ...
                   'gui_OutputFcn',  @fusionchoi_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% --- Executes just before fusionchoi is made visible.
function fusionchoi_OpeningFcn(hObject, eventdata, handles, varargin)
set(gcf,'numbertitle','off','name','IHS Tabanlý Görüntü Zenginleþtirme ve Kalite Analizi') ;
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fusionchoi (see VARARGIN)

% Choose default command line output for fusionchoi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes fusionchoi wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Outputs from this function are returned to the command line.
function varargout = fusionchoi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in btn_fusion.
function btn_fusion_Callback(hObject, eventdata, handles)
ppath = get(handles.txt_yolPan,'String');
path = get(handles.txt_yolMs,'String');
hdrfile=[deblank(path),'.hdr'];
info = read_envihdr(hdrfile);
row = info.lines;
column = info.samples;
band = info.bands;
filename1=strcat(path,'_choi');
filename2=strcat(path,'_chu');
filename3=strcat(path,'_tu');
filename4=strcat(path,'_rahmani');
filename5=strcat(path,'_gihsa');
filename6=strcat(path,'_fihs');
filename7=strcat(path,'_ihs');

        fused_im = yontemChoi(path,ppath,row,column,band);   
        save fused_im;
        ds1 = uint16(fused_im);
        multibandwrite(ds1,filename1,'bsq');
        
        fused_im = yontemChu(path,ppath,row,column,band);  
        save fused_im;
        ds2 = uint16(fused_im);
        multibandwrite(ds2,filename2,'bsq');
      
        fused_im = yontemTu(path,ppath,row,column,band);  
        save fused_im;
        ds3 = uint16(fused_im);
        multibandwrite(ds3,filename3,'bsq');
             
        fused_im = yontemRahmani(path,ppath,row,column,band);  
        save fused_im;
        ds4 = uint16(fused_im);
        multibandwrite(ds4,filename4,'bsq');
       
        fused_im = yontemGihsa(path,ppath,row,column,band);  
        save fused_im;
        ds5 = uint16(fused_im);
        multibandwrite(ds5,filename5,'bsq');
       
        fused_im = yontemFast_ihs(path,ppath,row,column,band);  
        save fused_im;
        ds6 = uint16(fused_im);
        multibandwrite(ds6,filename6,'bsq');
       
        fused_im = yontemIhs(path,ppath,row,column,band);  
        save fused_im;
        ds7 = uint16(fused_im);
        multibandwrite(ds7,filename7,'bsq');
        msgbox('tamamlandý');
    
function txt_yolPan_Callback(hObject, eventdata, handles)
% hObject    handle to txt_yolPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of txt_yolPan as text
%        str2double(get(hObject,'String')) returns contents of txt_yolPan as a double

% --- Executes during object creation, after setting all properties.
function txt_yolPan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_yolPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btn_panShow.
function btn_panShow_Callback(hObject, eventdata, handles)
ppath = get(handles.txt_yolPan,'String');
hdrfile=[deblank(ppath),'.hdr'];
info = read_envihdr(hdrfile);
row = info.lines;
column = info.samples;    
im = panshow(ppath,row,column);
 max1 = max(max(im));
 pan=double(im)/(max1);
 pan2= imadjust(pan,stretchlim(pan),[]);
 imwrite(pan2,'b.jpg');
 figure;
 imshow('b.jpg');
 
% --- Executes on button press in btn_panGetFile.
function btn_panGetFile_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile( ...
{'*.*',  'All Files (*.*)';
   '*.m',  'Code files (*.m)'; ...
   '*.fig','Figures (*.fig)'; ...
   '*.mat','MAT-files (*.mat)'; ...
   '*.mdl','Models (*.mdl)'; ...
  '*.m;*.fig;*.mat;*.mdl','MATLAB Files (*.m,*.fig,*.mat,*.mdl)'}, ...
   'Pick a file');
fullname=[pathname,'\',filename];
set(handles.txt_yolPan,'string',fullname);
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function txt_yolMs_Callback(hObject, eventdata, handles)
% hObject    handle to txt_yolMs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of txt_yolMs as text
%        str2double(get(hObject,'String')) returns contents of txt_yolMs as a double


% --- Executes during object creation, after setting all properties.
function txt_yolMs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_yolMs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btn_msGetFile.
function btn_msGetFile_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile( ...
{'*.*',  'All Files (*.*)';
   '*.m',  'Code files (*.m)'; ...
   '*.fig','Figures (*.fig)'; ...
   '*.mat','MAT-files (*.mat)'; ...
   '*.mdl','Models (*.mdl)'; ...
  '*.m;*.fig;*.mat;*.mdl','MATLAB Files (*.m,*.fig,*.mat,*.mdl)'}, ...
   'Pick a file');
fullname=[pathname,'\',filename];
set(handles.txt_yolMs,'string',fullname);
goruntu=imread(fullname);
h=handles.axes1;
axes(h);
imshow(goruntu);

% --- Executes on button press in btn_msShow.
function btn_msShow_Callback(hObject, eventdata, handles)
path = get(handles.txt_yolMs,'String');
hdrfile=[deblank(path),'.hdr'];
info = read_envihdr(hdrfile);
row = info.lines;
column = info.samples;
band = info.bands;
im = goruntuleme(path,row,column,band);
imwrite(im,'a.jpg');
figure;
imshow('a.jpg');

% --- Executes on button press in kalite_btn.
function kalite_btn_Callback(hObject, eventdata, handles)
mpath   = get(handles.txt_yolMs,'String');
r1path=strcat(mpath,'_choi');
r2path=strcat(mpath,'_chu');
r3path=strcat(mpath,'_tu');
r4path=strcat(mpath,'_rahmani');
r5path=strcat(mpath,'_gihsa');
r6path=strcat(mpath,'_fihs');
r7path=strcat(mpath,'_ihs');


hdrfile=[deblank(mpath),'.hdr'];
info = read_envihdr(hdrfile);
row = info.lines;
column = info.samples;
band = info.bands;


f = figure('Position',[50 500 550 250]);
set(gcf,'numbertitle','off','name','Füzyonlanmýþ Resimlerin Kalite Analiz Tablosu') ;
colNames = {'Choi','Chu','Tu','Rahmani','Gihsa','Fihs','Ihs'};
rowNames = {'Ergas(min)',...
    'Sam(min)',...
    'Ssim(max)',...
    'CC(max)',...
    'CCPan(max)',...
    'Psnr(max)',...
    };
t = uitable('Parent',f,'ColumnName',colNames,'RowName',rowNames,...
    'ColumnWidth',{50},'Position',[45 45 480 180]);


a1 = ergas_Qb(mpath,r1path,row,column,band);
     handles.a1 =a1;
a2 = sam_Qb(mpath,r1path,row,column,band);
     handles.a2=a2;
a3 = ssim(mpath,r1path,row,column,band);
     handles.a3=a3;
a4 = mean(cc(mpath,r1path,row,column,band));
    handles.a4=a4;
a5 = mean(CC_PAN(mpath,r1path,row,column,band));
    handles.a5=a5;
a6 = mean(PSNR(mpath,r1path,row,column,band));
    handles.a6=a6;
    
    
b1 = ergas_Qb(mpath,r2path,row,column,band);
    handles.b1 =b1;
b2 = sam_Qb(mpath,r2path,row,column,band);
    handles.b2=b2;
b3 = ssim(mpath,r2path,row,column,band);
    handles.b3=b3;
b4 = mean(cc(mpath,r2path,row,column,band));
    handles.b4=b4;
b5 = mean(CC_PAN(mpath,r2path,row,column,band));
    handles.b5=b5;
b6 = mean(PSNR(mpath,r2path,row,column,band));
    handles.b6=b6;
    
    
c1 = ergas_Qb(mpath,r3path,row,column,band);
   handles.c1 =c1;
c2 = sam_Qb(mpath,r3path,row,column,band);
    handles.c2=c2;
c3 = ssim(mpath,r3path,row,column,band);
    handles.c3=c3;
c4 = mean(cc(mpath,r3path,row,column,band));
    handles.c4=c4;
c5 = mean(CC_PAN(mpath,r3path,row,column,band));
    handles.c5=c5;
c6 = mean(PSNR(mpath,r3path,row,column,band));
    handles.c6=c6;
    
    
d1 = ergas_Qb(mpath,r4path,row,column,band);
    handles.d1 =d1;
d2 = sam_Qb(mpath,r4path,row,column,band);
    handles.d2=d2;
d3 = ssim(mpath,r4path,row,column,band);
    handles.d3=d3;
d4 = mean(cc(mpath,r4path,row,column,band));
    handles.d4=d4;
d5 = mean(CC_PAN(mpath,r4path,row,column,band));
    handles.d5=d5;
d6 = mean(PSNR(mpath,r4path,row,column,band));
    handles.d6=d6;
   
    
e1 = ergas_Qb(mpath,r5path,row,column,band);
    handles.e1=e1;
e2 = sam_Qb(mpath,r5path,row,column,band);
    handles.e2=e2;
e3 = ssim(mpath,r5path,row,column,band);
    handles.e3=e3;
e4 = mean(cc(mpath,r5path,row,column,band));
    handles.e4=e4;
e5 = mean(CC_PAN(mpath,r5path,row,column,band));
    handles.e5=e5;
e6 = mean(PSNR(mpath,r5path,row,column,band));
    handles.e6=e6;
    
    
f1 = ergas_Qb(mpath,r6path,row,column,band);
    handles.f1 =f1;
f2 = sam_Qb(mpath,r6path,row,column,band);
    handles.f2=f2;
f3 = ssim(mpath,r6path,row,column,band);
    handles.f3=f3;
f4 = mean(cc(mpath,r6path,row,column,band));
    handles.f4=f4;
f5 = mean(CC_PAN(mpath,r6path,row,column,band));
    handles.f5=f5;
f6 = mean(PSNR(mpath,r6path,row,column,band));
    handles.f6=f6;
    
    
g1 = ergas_Qb(mpath,r7path,row,column,band);
    handles.g1 =g1;
g2 = sam_Qb(mpath,r7path,row,column,band);
    handles.g2=g2;
g3 = ssim(mpath,r7path,row,column,band);
    handles.g3=g3;
g4 = mean(cc(mpath,r7path,row,column,band));
    handles.g4=g4;
g5 = mean(CC_PAN(mpath,r7path,row,column,band));
    handles.g5=g5;
g6 = mean(PSNR(mpath,r7path,row,column,band));
    handles.g6=g6;
  
  veriler={a1,b1,c1,d1,e1,f1,g1;...
      a2,b2,c2,d2,e2,f2,g2;...
      a3,b3,c3,d3,e3,f3,g3;...
      a4,b4,c4,d4,e4,f4,g4;...
      a5,b5,c5,d5,e5,f5,g5;...
      a6,b6,c6,d6,e6,f6,g6;...
};
  set(t,'data',veriler);

% --- Executes on button press in btn_fusionShow.
function btn_fusionShow_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = get(handles.txt_yolMs,'String');
pathchoi=[deblank(path),'_choi'];
pathchu=strcat(path,'_chu');
pathtu=strcat(path,'_tu');
pathrahmani=strcat(path,'_rahmani');
pathgihsa=strcat(path,'_gihsa');
pathfihs=strcat(path,'_fihs');
pathihs=strcat(path,'_ihs');

hdrfile=[deblank(path),'.hdr'];
info = read_envihdr(hdrfile);
row = info.lines;
column = info.samples;
band = info.bands;

imchoi = goruntuleme(pathchoi,row,column,band);
imchu = goruntuleme(pathchu,row,column,band);
imtu = goruntuleme(pathtu,row,column,band);
imrahmani = goruntuleme(pathrahmani,row,column,band);
imgihsa = goruntuleme(pathgihsa,row,column,band);
imfihs = goruntuleme(pathfihs,row,column,band);
imihs = goruntuleme(pathihs,row,column,band);

imwrite(imchoi,[deblank(pathchoi),'.jpg']);
imwrite(imchu,[deblank(pathchu),'.jpg']);
imwrite(imtu,[deblank(pathtu),'.jpg']);
imwrite(imrahmani,[deblank(pathrahmani),'.jpg']);
imwrite(imgihsa,[deblank(pathgihsa),'.jpg']);
imwrite(imfihs,[deblank(pathfihs),'.jpg']);
imwrite(imihs,[deblank(pathihs),'.jpg']);
figure;
set(gcf,'numbertitle','off','name','Füzyonlanmýþ Görüntüler') ;
subplot(2,4,1), imshow([deblank(pathchoi),'.jpg']), title('Choi');
subplot(2,4,2), imshow([deblank(pathchu),'.jpg']), title('Chu');
subplot(2,4,3), imshow([deblank(pathtu),'.jpg']), title('Tu');
subplot(2,4,4), imshow([deblank(pathrahmani),'.jpg']), title('Rahmani');
subplot(2,4,5), imshow([deblank(pathgihsa),'.jpg']), title('Gihsa');
subplot(2,4,6), imshow([deblank(pathfihs),'.jpg']), title('Fast Ihs');
subplot(2,4,7), imshow([deblank(pathihs),'.jpg']), title('Ihs');
