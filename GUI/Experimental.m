function varargout = Experimental(varargin)
% EXPERIMENTAL MATLAB code for Experimental.fig
%      EXPERIMENTAL, by itself, creates a new EXPERIMENTAL or raises the existing
%      singleton*.
%
%      H = EXPERIMENTAL returns the handle to a new EXPERIMENTAL or the handle to
%      the existing singleton*.
%
%      EXPERIMENTAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENTAL.M with the given input arguments.
%
%      EXPERIMENTAL('Property','Value',...) creates a new EXPERIMENTAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Experimental_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Experimental_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Experimental

% Last Modified by GUIDE v2.5 20-Nov-2015 16:48:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Experimental_OpeningFcn, ...
                   'gui_OutputFcn',  @Experimental_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before Experimental is made visible.
function Experimental_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Experimental (see VARARGIN)

% Choose default command line output for Experimental
handles.image = [];
handles.sinooimage = [];
handles.fbp_image = [];
handles.es_sino = [];
handles.recon = [];
handles.order = 1;
handles.angle = 25;
handles.output = hObject;
%添加图标
h = handles.figure1; %创建一个Figure，并返回其句柄
newIcon = javax.swing.ImageIcon('medic.jpg');
figFrame = get(h,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Experimental wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Experimental_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(hObject,'value');
val = val + 5;
handles.order = val;
set(handles.edit1,'string',num2str(val));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'value',0);
set(hObject,'Min',0);
set(hObject,'Max',20);
set(hObject,'SliderStep',[0.25 0.5]);



% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(hObject,'value');
val = val + 5 ; 
handles.angle = val;
set(handles.edit2,'string',num2str(val));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',0);
set(hObject,'Max',25);
set(hObject,'SliderStep',[0.2 0.4]);
set(hObject,'value',0);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.image) 
    Image_data = handles.image;
    index = handles.angle;
    order = handles.order;
    imag_size = size(Image_data,1);
    [sinoo_image,fbp_image] = recon_fbp(Image_data,index);
    handles.sinooimage = sinoo_image;
    handles.fbp_image = fbp_image;
    imshow(sinoo_image,[],'Parent',handles.show2);
    imshow(fbp_image,[],'Parent',handles.show4);
    
    [es_sino,recon] = recon_kmoment(sinoo_image,order,index,imag_size);
    handles.es_sino = es_sino;
    handles.recon = recon;
    imshow(es_sino,[],'Parent',handles.show3);
    imshow(recon,[],'Parent',handles.show5);
else
    errordlg('请载入图像','重建图像Error');
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg('version 2.0','Help');

% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name , path] = uigetfile({'*.jpg';'*.png';'*.bmp'},'打开图像');
Img_data = imread([path,name]);
imshow(Img_data,'Parent',handles.show1);
handles.image = Img_data;
guidata(hObject, handles);


% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.sinooimage) ...
    ||~isempty(handles.fbp_image)...
    ||~isempty(handles.es_sino)...
    ||~isempty(handles.recon) 
    [name , path] = uiputfile({'*.jpg';'*.png';'*.bmp'},'保存图像');
    savemodel = get(handles.popupmenu1,'value');
    switch savemodel
        case 1
          temp_max = max(max(handles.sinooimage));
          imwrite(handles.sinooimage/temp_max,[path,'截断投影',name]); 
          temp_max = max(max(handles.fbp_image));
          imwrite(handles.fbp_image/temp_max,[path,'截断投影重建图像',name]);
          temp_max = max(max(handles.es_sino));
          imwrite(handles.es_sino/temp_max,[path,'估计投影',name]);  
          temp_max = max(max(handles.recon));
          imwrite(handles.recon/temp_max,[path,'估计投影重建图像',name]);
        case 2
            temp_max = max(max(handles.sinooimage));
            imwrite(handles.sinooimage/temp_max ,[path,name]);
        case 3
            temp_max = max(max(handles.fbp_image));
            imwrite(handles.fbp_image/temp_max,[path,name]); 
        case 4
            temp_max = max(max(handles.es_sino));
            imwrite(handles.es_sino/temp_max,[path,name]); 
        case 5
            temp_max = max(max(handles.recon));
            imwrite(handles.recon/temp_max,[path,name]);
    end
else
   errordlg('没有图像可以保存','保存错误');
end

% --- Executes during object creation, after setting all properties.
function text6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'string',num2str(1));


% --- Executes during object creation, after setting all properties.
function text7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'string',num2str(25));


% --------------------------------------------------------------------
function open_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name , path] = uigetfile({'*.jpg';'*.png';'*.bmp'},'打开图像');
Img_data = imread([path,name]);
imshow(Img_data,'Parent',handles.show1);
handles.image = Img_data;
guidata(hObject, handles);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function save_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.sinooimage) ...
    ||~isempty(handles.fbp_image)...
    ||~isempty(handles.es_sino)...
    ||~isempty(handles.recon) 
    [name , path] = uiputfile({'*.jpg';'*.png';'*.bmp'},'保存图像');
    savemodel = get(handles.popupmenu1,'value');
    switch savemodel
        case 1
          temp_max = max(max(handles.sinooimage));
          imwrite(handles.sinooimage/temp_max,[path,'截断投影',name]); 
          temp_max = max(max(handles.fbp_image));
          imwrite(handles.fbp_image/temp_max,[path,'截断投影重建图像',name]);
          temp_max = max(max(handles.es_sino));
          imwrite(handles.es_sino/temp_max,[path,'估计投影',name]);  
          temp_max = max(max(handles.recon));
          imwrite(handles.recon/temp_max,[path,'估计投影重建图像',name]);
        case 2
            temp_max = max(max(handles.sinooimage));
            imwrite(handles.sinooimage/temp_max ,[path,name]);
        case 3
            temp_max = max(max(handles.fbp_image));
            imwrite(handles.fbp_image/temp_max,[path,name]); 
        case 4
            temp_max = max(max(handles.es_sino));
            imwrite(handles.es_sino/temp_max,[path,name]); 
        case 5
            temp_max = max(max(handles.recon));
            imwrite(handles.recon/temp_max,[path,name]);
    end
else
   errordlg('没有图像可以保存','保存错误');
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
val = get(hObject,'string');
val = str2num(val);
if ~isempty(val)&& val >= 5 && val <= 25
   set(handles.slider1,'value',val);
else
    errordlg('设置有误','设置Error');
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string',num2str(5));


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
val = get(hObject,'string');
val = str2num(val);
if ~isempty(val)&& val >= 5 && val <= 30
   set(handles.slider2,'value',val);
else
    errordlg('设置有误','设置Error');
end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string',num2str(5));
