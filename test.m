function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 03-May-2021 21:26:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @test_OpeningFcn, ...
    'gui_OutputFcn',  @test_OutputFcn, ...
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


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Choose default command line output for test
handles.output = hObject;
set(hObject,'toolbar','figure') % 在菜单栏显示figure工具条的内容
%openslide=opensldie();
% %获得程序所在的路径，名字，文件种类（图像文件此时与程序文件在同一文件夹）
% p=mfilename('fullpath');[filepath,name,ext]=fileparts(p);
% picture=[filepath,filesep,'picture',filesep,'CMU-1.tiff'];
%设置像素起点
global x y pos1 pos2 down motionspeed chioce picopen;
x=0;y=0;pos1=[];pos2=[];down=0;chioce=0;motionspeed=5;
picopen=0;

%设置平移后图像反应的速度
set(handles.edit15,'string',num2str(motionspeed));
try
    delete(allchild(handles.axes1));
    delete(allchild(handles.edit1));
    delete(allchild(handles.edit2));
end
set(handles.togglebutton2,'string','切换/平移');
set(handles.edit1,'string','openslide库加载情况');
set(handles.edit2,'string','0');
set(handles.edit3,'string','0');
set(handles.edit7,'string','0');
set(handles.edit4,'string','0');
set(handles.edit10,'string','0');
set(handles.edit11,'string','0');
set(handles.edit12,'string','0');
set(handles.text2,'string','0');
set(handles.text5,'string','0');
set(handles.text3,'string','0');
set(handles.text4,'string','0');


%%
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

%查看C库的状况
function edit1_Callback(hObject, eventdata, handles)
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


%查看样本数
function edit2_Callback(hObject, eventdata, handles)
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


%查看样本长度
function edit3_Callback(hObject, eventdata, handles)
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


%查看放大倍数
function edit4_Callback(hObject, eventdata, handles)
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


%查看样本宽度
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


%显示当前样本层
function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double
% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%x的值
function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double
% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%y的值
function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double
% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes during object deletion, before destroying properties.
global pos1 x1 y1 down x y w h picopen picwidth picheight;
if strcmp(get(gcf,'SelectionType'),'normal')
    down=1;
    if picopen==2
        pos1=get(gca,'CurrentPoint');
        x1=pos1(1,1);y1=pos1(1,2);xx=x1;yy=y1;
    if (x1>w+x)||(y1>h+y)||(x1<x)||(y1<y)
        x1=xx;y1=yy;
    end
    elseif picopen==1
        pos1=get(gca,'CurrentPoint');
        x1=pos1(1,2);y1=pos1(1,1);xx=x1;yy=y1;
        if (x1>picwidth+x)||(y1>picheight+y)||(x1<x)||(y1<y)
            x1=xx;y1=yy;
        end
    end
    set(handles.edit11,'string',num2str(x1));
    set(handles.edit12,'string',num2str(y1));
end

function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(hObject,eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click
% handles    structure with handles and user data (see GUIDATA)
global x y pointer level width height factor w h x1 y1 pic numoflevels;
global picwidth picheight class picopen finalpic picturepath ratio;
if eventdata.VerticalScrollCount==1
    try
        delete(allchild(handles.axes1));
    end
    if picopen==2
        fakelevel2=level+1;
        if ((numoflevels-1)>=fakelevel2)&&(fakelevel2>=0)
            level=fakelevel2;x=(x+x1)/ratio-x1;y=(y+y1)/ratio-y1;
        end
        [ARGB]=openslide_motionregion(pointer,x,y,level,w,h);
        axis(handles.axes1);
        pic=imshow(ARGB(:,:,2:4));
        set(handles.edit10,'string',num2str(level));
        [width,height]=openslide_getleveldimensions(pointer,level);
        set(handles.edit3,'string',num2str(width));
        set(handles.edit7,'string',num2str(height));
        [factor]=openslide_getleveldownsample(pointer,level);
        set(handles.edit4,'string',num2str(factor));     
        if x+w>width
            x=width-w;
        end
        if y+h>height
            y=height-h;
        end
        if x<0
            x=0;
        end
        if y<0
            y=0;
        end
        set(handles.text2,'string',num2str(x));
        set(handles.text5,'string',num2str(x+w));
        set(handles.text3,'string',num2str(y));
        set(handles.text4,'string',num2str(y+h));
    elseif picopen==1
        fakelevel2=level+1;
        if ((numoflevels-1)>=fakelevel2)&&(fakelevel2>=0)
            level=fakelevel2;x=(x+x1)/ratio-x1;y=(y+y1)/ratio-y1;
        end
        [finalpic]=picture_read(picturepath,x,y,level,picwidth,picheight,class);
        axis(handles.axes1);
%         set(handles.axes1,'Position',[x,y,picwidth,picheight]);
        imshow(finalpic);
        [width,height]=picture_getleveldimension(picturepath,level);
        set(handles.edit2,'string',num2str(numoflevels));
        set(handles.edit3,'string',num2str(width));
        set(handles.edit7,'string',num2str(height));
        set(handles.edit4,'string',num2str(ratio^level));
        set(handles.edit10,'string',num2str(level));   
        if x+picwidth>width
            x=width-picwidth;
        end
        if y+picheight>height
            y=height-picheight;
        end
        if x<1
            x=1;
        end
        if y<1
            y=1;
        end
        set(handles.text2,'string',num2str(x));
        set(handles.text5,'string',num2str(x+picwidth));
        set(handles.text3,'string',num2str(y));
        set(handles.text4,'string',num2str(y+picheight));
    end
    
elseif eventdata.VerticalScrollCount==-1
    try
        delete(allchild(handles.axes1));
    end
    if picopen==2
        fakelevel1=level-1;
        if ((numoflevels-1)>=fakelevel1)&&(fakelevel1>=0)
            level=fakelevel1;x=(x+x1)*ratio-x1;y=(y+y1)*ratio-y1;
        end
        [ARGB]=openslide_motionregion(pointer,x,y,level,w,h);
        axis(handles.axes1);
        pic=imshow(ARGB(:,:,2:4));
        set(handles.edit10,'string',num2str(level));
        [width,height]=openslide_getleveldimensions(pointer,level);
        set(handles.edit3,'string',num2str(width));
        set(handles.edit7,'string',num2str(height));
        [factor]=openslide_getleveldownsample(pointer,level);
        set(handles.edit4,'string',num2str(factor));
        if x+w>width
            x=width-w;
        end
        if y+h>height
            y=height-h;
        end
        if x<0
            x=0;
        end
        if y<0
            y=0;
        end
        set(handles.text2,'string',num2str(x));
        set(handles.text5,'string',num2str(x+w));
        set(handles.text3,'string',num2str(y));
        set(handles.text4,'string',num2str(y+h));
    elseif picopen==1
        fakelevel1=level-1;
        if ((numoflevels-1)>=fakelevel1)&&(fakelevel1>=0)
            level=fakelevel1;x=(x+x1)*ratio-x1;y=(y+y1)*ratio-y1;
        end
        [finalpic]=picture_read(picturepath,x,y,level,picwidth,picheight,class);
        axis(handles.axes1);
%         set(handles.axes1,'Position',[x,y,picwidth,picheight]);
        imshow(finalpic);
        [width,height]=picture_getleveldimension(picturepath,level);
        set(handles.edit2,'string',num2str(numoflevels));
        set(handles.edit3,'string',num2str(width));
        set(handles.edit7,'string',num2str(height));
        set(handles.edit4,'string',num2str(ratio^level));
        set(handles.edit10,'string',num2str(level));       
        if x+picwidth>width
            x=width-picwidth;
        end
        if y+picheight>height
            y=height-picheight;
        end
        if x<1
            x=1;
        end
        if y<1
            y=1;
        end
        set(handles.text2,'string',num2str(x));
        set(handles.text5,'string',num2str(x+picwidth));
        set(handles.text3,'string',num2str(y));
        set(handles.text4,'string',num2str(y+picheight));
    end
end


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pos1 pos2 down x2 y2 x1 y1 x0 y0 x y pointer level w picturepath;
global h motionspeed width height chioce picopen picwidth picheight class finalpic;
if down==1
    if chioce==0
        if picopen==2
            pos2=get(gca,'CurrentPoint');
            x2=pos2(1,1);y2=pos2(1,2);
            x0=x2-x1;y0=y2-y1;
            try
                delete(allchild(handles.axes1));
            end
            x=x-x0/motionspeed;y=y-y0/motionspeed;
            [ARGB]=openslide_motionregion(pointer,x,y,level,w,h);
            axis(handles.axes1);
            imshow(ARGB(:,:,2:4));
            if x+w>width
                x=width-w;
            end
            if y+h>height
                y=height-h;
            end
            if x<0
                x=0;
            end
            if y<0
                y=0;
            end
            set(handles.text2,'string',num2str(x));
            set(handles.text5,'string',num2str(x+w));
            set(handles.text3,'string',num2str(y));
            set(handles.text4,'string',num2str(y+h));
        elseif picopen==1
            pos2=get(gca,'CurrentPoint');
            x2=pos2(1,2);y2=pos2(1,1);
            x0=x2-x1;y0=y2-y1;
            try
                delete(allchild(handles.axes1));
            end
            x=x-x0/motionspeed;y=y-y0/motionspeed;
            [finalpic]=picture_read(picturepath,x,y,level,picwidth,picheight,class);
            axis(handles.axes1);
            %             set(handles.axes1,'Position',[x,y,picwidth,picheight]);
            imshow(finalpic);
            [width,height]=picture_getleveldimension(picturepath,level);
            if x+picwidth>width
                x=width-picwidth;
            end
            if y+picheight>height
                y=height-picheight;
            end
            if x<1
                x=1;
            end
            if y<1
                y=1;
            end
            set(handles.text2,'string',num2str(x));
            set(handles.text5,'string',num2str(x+picwidth));
            set(handles.text3,'string',num2str(y));
            set(handles.text4,'string',num2str(y+picheight));
        end
        
    else
        if picopen==2
            pos2=get(handles.axes1,'CurrentPoint');
            line([pos1(1,1) pos2(1,1)],[pos1(1,2) pos2(1,2)],'LineWidth',4);
            pos1=pos2;
        elseif picopen==1
            pos2=get(handles.axes1,'CurrentPoint');
            line([pos1(1,1) pos2(1,1)],[pos1(1,2) pos2(1,2)],'LineWidth',4);
            pos1=pos2;
        end
    end
end


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global down
down=0;

function text3_CreateFcn(hObject, eventdata, handles)
function text2_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global motionspeed
if rem(motionspeed,5)==0
    motionspeed=motionspeed+5;
else
    motionspeed=motionspeed+4;
end
set(handles.edit15,'string',num2str(motionspeed));


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global motionspeed;
if motionspeed-5<=0
    motionspeed=1;
else
    motionspeed=motionspeed-5;
end
set(handles.edit15,'string',num2str(motionspeed));



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


% 选择openslide文件类型
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Sel liststring picopen;
picopen=2;
[Sel, OK] = listdlg(...
    'ListString', {'svs', 'tif', 'vms', 'vmu','ndpi','scn','mrxs','tiff','svslide','bif'}, ...
    'OKString', '确定','CancelString','取消','Name', '选择','SelectionMode', 'single');
if OK==1
    switch Sel
        case 1
            liststring='.svs';
        case 2
            liststring='.tif';
        case 3
            liststring='.vms';
        case 4
            liststring='.vmu';
        case 5
            liststring='.ndpi';
        case 6
            liststring='.scn';
        case 7
            liststring='.mrxs';
        case 8
            liststring='.tiff';
        case 9
            liststring='.svslide';
        case 10
            liststring='.bif';
    end
else
    return
end


% 选择文件
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global path liststring name picture;
[name,path]=uigetfile(liststring);
picture=[path,name];


% 显示openslide文件
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x y  picture pointer picopen;
try
    delete(allchild(handles.axes1));
end
picopen=2;set(handles.axes1,'Units','pixels');x=0;y=0;
%%
load=openslide_loadlibrary();
if load==0
    set(handles.edit1,'string','openslide库加载成功');
elseif load==1
    set(handles.edit1,'string','openslide库加载失败');
elseif load==2
    set(handles.edit1,'string','出现错误，该头文件不存在');
elseif load==3
    set(handles.edit1,'string','出现错误，该库不存在');
end

%打开图像文件，创建图像指针
pointer=openslide_open(picture);
%%
global level numoflevels;
%确定文件存在的样本数
[numoflevels]=openslide_getlevelcount(pointer);
disp(['文件所含的样本数:',num2str(numoflevels)]);level=numoflevels-1;
set(handles.edit2,'string',num2str(numoflevels));
%%
global width height;
[width,height]=openslide_getleveldimensions(pointer,level);
disp(['第',num2str(level),'样本层的长: ',num2str(width),' 宽:',num2str(height)]);
set(handles.edit3,'string',num2str(width));
set(handles.edit7,'string',num2str(height));
%%
global x y pointer level factor;
[factor]=openslide_getleveldownsample(pointer,level);
x=x/factor;y=y/factor;
disp(['第',num2str(level),'样本层的采样因子： ',num2str(factor)]);
set(handles.edit4,'string',num2str(factor));
%%
global x y pointer level numoflevels w h pic;
[w,h]=openslide_getleveldimensions(pointer,numoflevels-1);
[ARGB]=openslide_readregion(pointer,x,y,level,w,h);
axis(handles.axes1);
set(handles.axes1,'Position',[x,y+300,w,h]);
pic=imshow(ARGB(:,:,2:4));
%显示各个数据
set(handles.edit10,'string',num2str(level));
set(handles.text2,'string',num2str(x));
set(handles.text5,'string',num2str(x+w));
set(handles.text3,'string',num2str(y));
set(handles.text4,'string',num2str(y+h));


% 画图和平移进行切换
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of togglebutton2
global chioce;
chioce=get(handles.togglebutton2,'Value');
if chioce==0
    set(handles.togglebutton2,'string','切换/平移');
else
    set(handles.togglebutton2,'string','切换/画图');
end


% 选择picture文件类型
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Se2 class picopen;
picopen=1;
[Se2, OK] = listdlg(...
    'ListString', {'jpg','bmp' , 'png', 'psd','webp'}, ...
    'OKString', '确定','CancelString','取消','Name', '选择','SelectionMode', 'single');
if OK==1
    switch Se2
        case 1
            class='.jpg';
        case 2
            class='.bmp';
        case 3
            class='.png';
        case 4
            class='.psd';
        case 5
            class='.webp';
    end
else
    return
end


% 选择待处理文件
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global class picturename whichpic;
[name,path]=uigetfile(class);whichpic=1;
picturename=[path,filesep,name];


% 选择文件夹
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global picturepath;
[path]=uigetdir();
picturepath=[path,'\'];


% 处理picture文件
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wid hei ratio picturename picturepath class whichpic numx numy kind;
word=inputdlg({'最低采样层的界限长','最低采样层的界限宽','采样比例'},'选择参数',1,{'wid','hei','ratio'},'on');
wid=str2double(word(1,1));hei=str2double(word(2,1));ratio=str2double(word(3,1));
if whichpic==1
    picture_creat(picturename,picturepath,wid,hei,ratio,class);
elseif whichpic==2
    picture_creat_2(picturename,picturepath,numx,numy,wid,hei,ratio,class,kind);
end



% 显示picture文件
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global picturepath class level x y picwidth picheight numoflevels ratio picopen;
global levelwidth levelheight;
try
    delete(allchild(handles.axes1));
end
set(handles.axes1,'Units','characters');x=1;y=1;
picopen=1;
[picwidth,picheight,numoflevels,ratio]=picture_getproperty(picturepath);level=numoflevels-1;
[levelwidth,levelheight]=picture_getleveldimension(picturepath,level);
set(handles.edit1,'string','现在显示的是picture文件');
set(handles.edit2,'string',num2str(numoflevels));
set(handles.edit3,'string',num2str(levelwidth));
set(handles.edit7,'string',num2str(levelheight));
set(handles.edit4,'string',num2str(ratio^level));
set(handles.edit10,'string',num2str(level));
[finalpic]=picture_read(picturepath,x,y,level,picwidth,picheight,class);
axis(handles.axes1);
% set(handles.axes1,'Position',[x,y,picwidth,picheight]);
imshow(finalpic);
set(handles.text2,'string',num2str(x));
set(handles.text5,'string',num2str(x+picwidth));
set(handles.text3,'string',num2str(y));
set(handles.text4,'string',num2str(y+picheight));


% --- Executes during object creation, after setting all properties.
function pushbutton19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global picturename whichpic numx numy kind;
[name]=uigetdir();whichpic=2;
picturename=[name,'\'];
word=inputdlg({'横向图片数','纵向图片数','图片命名种类'},'选择参数',1,{'numx','numy','数字选1，坐标选2'},'on');
numx=str2double(word(1,1));numy=str2double(word(2,1));kind=str2double(word(3,1));
