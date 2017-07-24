function varargout = Postage_Classfing_Platform(varargin)
% POSTAGE_CLASSFING_PLATFORM MATLAB code for Postage_Classfing_Platform.fig
%      POSTAGE_CLASSFING_PLATFORM, by itself, creates a new POSTAGE_CLASSFING_PLATFORM or raises the existing
%      singleton*.
%
%      H = POSTAGE_CLASSFING_PLATFORM returns the handle to a new POSTAGE_CLASSFING_PLATFORM or the handle to
%      the existing singleton*.
%
%      POSTAGE_CLASSFING_PLATFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POSTAGE_CLASSFING_PLATFORM.M with the given input arguments.
%
%      POSTAGE_CLASSFING_PLATFORM('Property','Value',...) creates a new POSTAGE_CLASSFING_PLATFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Postage_Classfing_Platform_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Postage_Classfing_Platform_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Postage_Classfing_Platform

% Last Modified by GUIDE v2.5 03-Dec-2016 15:00:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Postage_Classfing_Platform_OpeningFcn, ...
                   'gui_OutputFcn',  @Postage_Classfing_Platform_OutputFcn, ...
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


% --- Executes just before Postage_Classfing_Platform is made visible.
function Postage_Classfing_Platform_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Postage_Classfing_Platform (see VARARGIN)

% Choose default command line output for Postage_Classfing_Platform
% 定义标志位
handles.flags = [0,0,0,0];
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Postage_Classfing_Platform wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Postage_Classfing_Platform_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
set(handles.edit1,'string',num2str(floor(get(hObject,'value'))));
% disp(handles.flags(1))
if (handles.flags(1) ==1)
    i = floor(get(hObject,'value'));
    show_1(handles,i)
    show_3(handles,i)
end
% disp(handles.Image)
% imshow(Img_data.temp_data(:,:,i),'Parent',handles.show1);
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
set(handles.slider1,'value',str2num(get(hObject,'string')));
i = str2num(get(hObject,'string'));
% global Img_data
% imshow(Img_data.temp_data(:,:,i),'Parent',handles.show1);
show_1(handles,i)
show_3(handles,i)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
set(handles.edit2,'string',num2str(floor(get(hObject,'value'))));
Iter=get(hObject,'value');
handles.Iter=floor(Iter);
guidata(hObject,handles);
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
handles.Iter=get(hObject,'value');
guidata(hObject,handles);
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit2_Callback(hObject, eventdata, handles)
set(handles.slider2,'value',str2num(get(hObject,'string')));
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
set(handles.edit3,'string',num2str(floor(get(hObject,'value'))));
TreeNum=get(hObject,'value');
handles.TreeNum=floor(TreeNum);
guidata(hObject,handles);
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
handles.TreeNum=get(hObject,'value');
guidata(hObject,handles);
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit3_Callback(hObject, eventdata, handles)
set(handles.slider3,'value',str2num(get(hObject,'string')));
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
set(handles.edit4,'string',num2str(floor(get(hObject,'value'))));
MaxDepth=get(hObject,'value');
handles.MaxDepth=floor(MaxDepth);
guidata(hObject,handles);
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
handles.MaxDepth=get(hObject,'value');
guidata(hObject,handles);
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit4_Callback(hObject, eventdata, handles)
set(handles.slider4,'value',str2num(get(hObject,'string')));
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
set(handles.edit5,'string',num2str(floor(get(hObject,'value'))));
Sample=get(hObject,'value');
handles.Sample=floor(Sample);
guidata(hObject,handles);
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
handles.Sample=get(hObject,'value');
guidata(hObject,handles);
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit5_Callback(hObject, eventdata, handles)
set(handles.slider5,'value',str2num(get(hObject,'string')));
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

    extra_options_path=handles.extra_options_path;
    path_result=handles.path_result;
    model=handles.model;
    segsize=handles.segsize;
    
    disp('beginning treament...');
    disp 'prostate segmentation ,beginning...'
    
      image =  handles.image;%load image
      image  = imresize(image , segsize);
       
    if ~exist([path_result,'result_pro.mat'],'file')&&~exist([path_result,'result_bla.mat'],'file')
        %prepare for segmentation
       
        %segmentation and predict 
        disp('beginning...')
        
            
            [result, temp_haar_feature, temp_context_feature] = predict_auto_context(image,model);
            save_data(extra_options_path.path_haar_features,temp_haar_feature,i);
            save_data(extra_options_path.path_context_features,temp_context_feature,i);
            clear temp_haar_feature temp_context_feature 
            
%             temp_result = result.bla;
%             save([path_result,'result_Day',num2str(i-n_inti),'_bla.mat'],'temp_result');
%             temp_result = level_set_3D(temp_result,100);
%             save([path_result,'result_Day_levset_',num2str(i-n_inti),'_bla.mat'],'temp_result');
            
            temp_result = result;
            save([path_result,'result_pro.mat'],'temp_result');
            %save result of segmentation
            temp_result = level_set_3D(temp_result,100);
            save([path_result,'result_levset_pro.mat'],'temp_result');

            
        clear model temp_result result
    end
    
    disp('update result of segmentation...')
    %label_image = load_image([path_image,'img',num2str(i),'_pro','.mat']);%load model 
	%label_image  = imresize(label_image , segsize);

    %提取采样点和标签
    [temp_pos,temp_label] = sample_pos(label_image,image,n_sample,'index');
 
    %save features and labels
    save_data(path_position,temp_pos,i);
    save_data(path_label,temp_label,i);
    %update features and labels
    clear label_image temp_pos temp_label
    
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path='E:\STITP\平台界面\vision 1.4\'
% path_image = [path,'seg_data\'];
path_result = [path,'result\'];
handles.path_result=path_result;
path_model = [path,'model\'];
handles.path_model=path_model;
% global extra_options_path
extra_options_path.path_context_features = [path,'tempdata\context\'];
extra_options_path.path_haar_features = [path,'tempdata\haar\'];
extra_options_path.path_position = [path,'tempdata\position\'];
extra_options_path.path_label = [path,'tempdata\label\'];
extra_options_path.path_tempdata = [path,'tempdata\tempdata\'];

mkdir(path_result)
mkdir(path_model)
mkdir(extra_options_path.path_context_features)
mkdir(extra_options_path.path_haar_features)
mkdir(extra_options_path.path_position)
mkdir(extra_options_path.path_label)
mkdir(extra_options_path.path_tempdata)

% name = dir(path_image); %part_1
% 
% len = length(name);
% for i =1:len

% temp = name(i).name;
% extra_options_path.path_image = [path_image,temp,'\'];

% mkdir([path_result,'result_',temp,'\'])
% extra_options_path.path_result =[path_result,'result_',temp,'\'];
% 
% mkdir([path_model,'model_',temp,'\'])
% extra_options_path.path_model = [path_model,'model_',temp,'\'];
disp(['开始训练......'])


n_sample=handles.Sample;
extra_options.num_tree=handles.TreeNum;
n_iter=handles.Iter;
segsize=[64 64];


if isfield(extra_options_path,'path_context_features')
    path_context_features = extra_options_path.path_context_features;
end
if isfield(extra_options_path,'path_haar_features')
    path_haar_features = extra_options_path.path_haar_features;
end
if isfield(extra_options_path,'path_position')
    path_position = extra_options_path.path_position;
end
if isfield(extra_options_path,'path_label')
    path_label = extra_options_path.path_label;
end
if isfield(extra_options_path,'path_model')
    path_model = extra_options_path.path_model;
end
if isfield(extra_options_path,'path_result')
    path_result = extra_options_path.path_result;
end
if isfield(extra_options_path,'path_tempdata')
    extra_options.path_tempdata = extra_options_path.path_tempdata;
end

% n_traindays = 6;%number of treatment days
n_traindays = 1;
extra_options.max_tree_depth = 15;
extra_options.num_tresholds = 100;
extra_options.num_weaklearners = 1000;
extra_options.min_leafnum = 8;
extra_options.min_infogain = 0;

n_inti = handles.fnum; %number of image will be load before treament

% trainmain(extra_options_path);


%%
disp('计算初始特征，开始...')
for i= 1:n_inti
    
    image = handles.loadTdata(i).temp_data;
    label_image = handles.loadTdata_pro(i).temp_data;
    %图像导入
%     label_image.bla = load_image([path_image,'img',num2str(i),'_bla.mat']);
    
    
     image  = imresize(image , segsize);
	 label_image  = imresize(label_image , segsize);
     
%     label_image.pro = imresize(label_image.pro, [64 64]);
%     label_image.bla  = imresize(label_image.bla , [64 64]);
%     
    [all_pos,n_size_image] = get_allpos(image);
    
    %计算随机采样点和标签
    if ~exist([path_label,num2str(i),'.mat'],'file')  %&&~exit(path_position,'file')
        
    [ temp_pos , temp_label] = sample_pos(label_image,image,n_sample,'index');
    save_data(path_label,temp_label,i);
    save_data(path_position,temp_pos,i);
    end
    
    %计算haar feature 
    if ~exist([path_haar_features,num2str(i),'.mat'],'file')
    temp_haar_feature = cal_haar_features_3D( image , all_pos );
    save_data(path_haar_features,temp_haar_feature,i);
    end
    clear temp_haar_feature
    
    %计算context_feature
    if ~exist([path_context_features,num2str(i),'.mat'],'file')
%         tic
    temp_context_feature = cal_context_features( image , all_pos );
%     toc
    save_data(path_context_features,temp_context_feature,i);
    end
    clear temp_context_feature  temp_label temp_pos
end

disp('计算初始特征，结束...')
%%
    disp(['training model,beginning...'])

    if ~exist([path_model,'model.mat'],'file')
        model = class_auto_context(path_haar_features,path_context_features,path_label,path_position,n_iter,n_size_image,extra_options);
        save([path_model,'model.mat'],'model');
    else
        load([path_model,'model.mat'],'model');
    end
   
    disp([' training model,over...'])
    clear image label_image temp_feature temp_label
    
    
    handles.extra_options_path=extra_options_path;
    handles.path_result=path_result;
    handles.model=model;
    handles.segsize=segsize;
    guidata(hObject,handles);
%%
disp(['结束训练......'])
rmdir(extra_options_path.path_context_features, 's')
    rmdir(extra_options_path.path_haar_features, 's')
    rmdir(extra_options_path.path_position, 's')
    rmdir(extra_options_path.path_label, 's')
    rmdir(extra_options_path.path_tempdata, 's')
    
    mkdir(extra_options_path.path_context_features)
    mkdir(extra_options_path.path_haar_features)
    mkdir(extra_options_path.path_position)
    mkdir(extra_options_path.path_label)
    mkdir(extra_options_path.path_tempdata)

%  end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
[name , path] = uigetfile({'*.mat'},'打开图像','MultiSelect','on');
handles.loadTdata = [];
handles.loadTdata_pro = [];
handles=rmfield(handles,'loadTdata');
handles=rmfield(handles,'loadTdata_pro');
if (iscell(name))
    fnum=size(name,2);
    set(handles.edit9,'max',2*fnum);
    for i=1:fnum
%       handles.load_Tdata(i) = load([path,char(name(i))]);
%         handles.load_Tdata(i) = load(cell2mat(strcat(path,name(i))));
%       set(handles.edit9,'value',i);
        pname = char(name(i));
%         temp(2*i-1)=strcat(path,name(2*i-1));
        temp(2*i-1)=strcat(path,name(i));
        temp(2*i)=cellstr(strcat(path,pname(1:strfind(pname,'.')-1),'_pro.mat'));
        handles.loadTdata(i) = load(cell2mat(strcat(path,name(i))));
        handles.loadTdata_pro(i) = load(strcat(path,pname(1:strfind(pname,'.')-1),'_pro.mat'));
%       set(handles.edit9,'string',cell2mat(strcat(path,name(i))));
    end
else
    fnum=1;
    set(handles.edit9,'max',2);
    handles.loadTdata = load(strcat(path,name));
    handles.loadTdata_pro = load(strcat(path,name(1:strfind(name,'.')-1),'_pro.mat'));
    temp(1)=cellstr(strcat(path,name));
    temp(2)=cellstr(strcat(path,name(1:strfind(name,'.')-1),'_pro.mat'));
end
set(handles.edit9,'string',temp);
handles.fnum=fnum;
% disp(handles.loadTdata(1))
guidata(hObject,handles)
% disp(handles.load_Tdata)
% disp (Load_data);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Image_Callback(hObject, eventdata, handles)
% hObject    handle to Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name , path] = uigetfile({'*.mat'},'打开图像');
% 如果成功打开文件进行下一步
if (name ~= 0)
%     成功打开文件标志
    handles.flags(1) = 1;
    if (isempty(strfind(name,'_')))
%       载入原始图像
        Img_data = load([path,name]);
        Max = max(max(max(Img_data.temp_data)));
        Img_data.temp_data = Img_data.temp_data/Max;
%       载入专业图像
        Img_data_pro = load([path,name(1:strfind(name,'.')-1),'_pro.mat']);
        Max = max(max(max(Img_data_pro.temp_data)));
        Img_data_pro.temp_data = Img_data_pro.temp_data/Max;
    else
%       载入原始图像        
        Img_data = load([path,name(1:strfind(name,'_')-1),'.mat']);
        Max = max(max(max(Img_data.temp_data)));
        Img_data.temp_data = Img_data.temp_data/Max;
%       载入专业图像        
        Img_data_pro = load([path,name]);
        Max = max(max(max(Img_data_pro.temp_data)));
        Img_data_pro.temp_data = Img_data_pro.temp_data/Max;
    end
%     UPDATE handles
    handles.image = Img_data.temp_data;
    handles.image_pro = Img_data_pro.temp_data;
    guidata(hObject, handles);
%     显示图像
    show_1(handles,1)
    show_3(handles,1)
%     显示图像大小
    [x,y,z]=size(Img_data.temp_data);
    set(handles.edit6,'string',x);
    set(handles.edit7,'string',y);
    set(handles.edit8,'string',z);
%     根据图像大小设置slider1
    set(handles.slider1,'max',z);
    set(handles.slider1,'sliderstep',[1/(z-1),1/(z-1)]);
end


% --- Executes during object deletion, before destroying properties.
function slider4_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
