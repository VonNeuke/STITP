function varargout = Postage_Classfing_Platform(varargin)
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
% --- Executes just before Postage_Classfing_Platform is made visible.
function Postage_Classfing_Platform_OpeningFcn(hObject, eventdata, handles, varargin)
handles.flags = [0,0,0,0];
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Postage_Classfing_Platform_OutputFcn(hObject, eventdata, handles) 
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
    if (isfield(handles,'temp_result'))
%         Img_data=handles.temp_result;
        show_2(handles,i)
    end
end
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)

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
if(isfield(handles,'temp_result'))
    show_2(handles,i)
end



function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function slider2_Callback(hObject, eventdata, handles)
set(handles.edit2,'string',num2str(floor(get(hObject,'value'))));
Iter=get(hObject,'value');
handles.Iter=floor(Iter);
guidata(hObject,handles);

function slider2_CreateFcn(hObject, eventdata, handles)
handles.Iter=get(hObject,'value');
guidata(hObject,handles);

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function edit2_Callback(hObject, eventdata, handles)
set(handles.slider2,'value',str2num(get(hObject,'string')));

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function slider3_Callback(hObject, eventdata, handles)
set(handles.edit3,'string',num2str(floor(get(hObject,'value'))));
TreeNum=get(hObject,'value');
handles.TreeNum=floor(TreeNum);
guidata(hObject,handles);

function slider3_CreateFcn(hObject, eventdata, handles)
handles.TreeNum=get(hObject,'value');
guidata(hObject,handles);

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit3_Callback(hObject, eventdata, handles)
set(handles.slider3,'value',str2num(get(hObject,'string')));

function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function slider4_Callback(hObject, eventdata, handles)
set(handles.edit4,'string',num2str(floor(get(hObject,'value'))));
MaxDepth=get(hObject,'value');
handles.MaxDepth=floor(MaxDepth);
guidata(hObject,handles);

function slider4_CreateFcn(hObject, eventdata, handles)
handles.MaxDepth=get(hObject,'value');
guidata(hObject,handles);

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit4_Callback(hObject, eventdata, handles)
set(handles.slider4,'value',str2num(get(hObject,'string')));

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function slider5_Callback(hObject, eventdata, handles)
set(handles.edit5,'string',num2str(floor(get(hObject,'value'))));
Sample=floor(get(hObject,'value'));
handles.Sample=Sample;
guidata(hObject,handles);

function slider5_CreateFcn(hObject, eventdata, handles)
handles.Sample=get(hObject,'value');
guidata(hObject,handles);

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function edit5_Callback(hObject, eventdata, handles)
set(handles.slider5,'value',str2num(get(hObject,'string')));

function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton1_Callback(hObject, eventdata, handles)
extra_options_path=handles.extra_options_path;
path_result=handles.path_result;
model=handles.model;
segsize=handles.segsize;


disp('beginning treament...');
disp(['prostate segmentation ,beginning...'])

image =  handles.image;%load image

% image  = imresize(image , segsize);


%prepare for segmentation

%segmentation and predict
disp('beginning...')


[result, temp_haar_feature, temp_context_feature] = predict_auto_context(image,model);
clear temp_haar_feature temp_context_feature 

temp_result = result;
% temp_result = level_set_3D(temp_result,100);
% handles.temp_result=temp_result;
handles.temp_result = handles.image_pro;
guidata(hObject,handles);
clear model temp_result result

%提取采样点和标签
%update features and labels
clear  temp_pos temp_label
 disp('分割结束');

function pushbutton2_Callback(hObject, eventdata, handles)
path='E:\STITP\平台界面\vision 2.0\'
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


%     model = class_auto_context(path_haar_features,path_context_features,path_label,path_position,n_iter,n_size_image,extra_options);
    if ~exist([path_model,'model.mat'],'file')
        model = class_auto_context(path_haar_features,path_context_features,path_label,path_position,n_iter,n_size_image,extra_options);
        save([path_model,'model.mat'],'model');
    else
        load([path_model,'model.mat'],'model');
    end
   
    disp  'training model,over...'
    clear image label_image temp_feature temp_label
    
    
    handles.extra_options_path=extra_options_path;
    handles.path_result=path_result;
    handles.model=model;
    handles.segsize=segsize;
    guidata(hObject,handles);
%%
disp(['结束训练......'])
%     rmdir(extra_options_path.path_context_features, 's')
%     rmdir(extra_options_path.path_haar_features, 's')
%     rmdir(extra_options_path.path_position, 's')
%     rmdir(extra_options_path.path_label, 's')
%     rmdir(extra_options_path.path_tempdata, 's')
%     
%     mkdir(extra_options_path.path_context_features)
%     mkdir(extra_options_path.path_haar_features)
%     mkdir(extra_options_path.path_position)
%     mkdir(extra_options_path.path_label)
%     mkdir(extra_options_path.path_tempdata)

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

function pushbutton4_Callback(hObject, eventdata, handles)
close(handles.figure1)

function radiobutton1_Callback(hObject, eventdata, handles)

function edit6_Callback(hObject, eventdata, handles)

function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_Callback(hObject, eventdata, handles)

function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit8_Callback(hObject, eventdata, handles)

function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit9_Callback(hObject, eventdata, handles)
function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function Image_Callback(hObject, eventdata, handles)
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

function slider4_DeleteFcn(hObject, eventdata, handles)

function show2_CreateFcn(hObject, eventdata, handles)

