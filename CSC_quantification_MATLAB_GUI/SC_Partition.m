function varargout = SC_Partition(varargin)
% SC_PARTITION MATLAB code for SC_Partition.fig
%      SC_PARTITION, by itself, creates a new SC_PARTITION or raises the existing
%      singleton*.
%
%      H = SC_PARTITION returns the handle to a new SC_PARTITION or the handle to
%      the existing singleton*.
%
%      SC_PARTITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SC_PARTITION.M with the given input arguments.
%
%      SC_PARTITION('Property','Value',...) creates a new SC_PARTITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SC_Partition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SC_Partition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SC_Partition

% Last Modified by GUIDE v2.5 07-Dec-2023 11:36:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SC_Partition_OpeningFcn, ...
    'gui_OutputFcn',  @SC_Partition_OutputFcn, ...
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

 
% --- Executes just before SC_Partition is made visible.
function SC_Partition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SC_Partition (see VARARGIN)

% Choose default command line output for SC_Partition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SC_Partition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SC_Partition_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global cropped;
global seg;
global labeledImage;
global rgbImage;
global coloredLabels;

finalimage=SC_quantific1(cropped,seg,1);
axes(handles.axes4);
imshow(finalimage ,[]);
% -------------------------------------------------
try
    [coloredLabels,labeledImage] = SC_quantific0(cropped,seg,1);
    axes(handles.axes7);
    imshow(coloredLabels,[]);
catch
    ErrorMessage=lasterr;
    disp(ErrorMessage);
    f = errordlg('Shifting Value is not appropriate! Please choose another one.','Shifting Error');
end

function SCmeasures_Callback(hObject, eventdata, handles)
% hObject    handle to SCmeasures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SC_Quantification;
% --- Executes on button press in CalculateSpinalCordMeasures.


% --- Executes on button press in Fragmented_SC.
function Fragmented_SC_Callback(hObject, eventdata, handles)
% hObject    handle to Fragmented_SC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global labeled_regions;
global seg;
global orig;
global vect;
global val;
global cropped;
global recap_image;
global labeledImage;
global coloredLabels;
global labeled_regions;

[a,b,c]=size(orig);
[a1,b1,c1]=size(seg);

if c~=1
    orig=orig(1:a1,1:b1,val);
else
    orig=orig(1:a1,1:b1,:);
end

vect=get(handles.Shifting,'value');
vect=round(vect)+1

try
    [coloredLabels,labeled_regions,labeledImage,rgbImage, recap_image] = SC_fragment(cropped,seg,vect);
    axes(handles.axes7);
    imshow(labeled_regions,[]);
catch
    ErrorMessage=lasterr;
    disp(ErrorMessage);
    f = errordlg('Shifting Value is not appropriate! Please choose another one.','Shifting Error');
end


% --- Executes on slider movement.
function Shifting_Callback(hObject, eventdata, handles)
% hObject    handle to Shifting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global vect;
global cropped;
global seg;
global vect;

vect=get(handles.Shifting,'value');
vect=round(vect)+1;
set(handles.val_trans,'string',vect);

finalimage=RedLine_shift(cropped,seg,vect);
axes(handles.axes4);
imshow(finalimage ,[]);
load('pqfile.mat');


% --- Executes during object creation, after setting all properties.
function Shifting_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Shifting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function val_trans_Callback(hObject, eventdata, handles)
% hObject    handle to val_trans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_trans as text
%        str2double(get(hObject,'String')) returns contents of val_trans as a double


% --- Executes during object creation, after setting all properties.
function val_trans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_trans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset2.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global NomFich
NomFich='a';
cla(handles.axes10,'reset');
cla(handles.axes4,'reset');
cla(handles.axes7,'reset');
% cla(handles.Shifting,'reset');
set(handles.val_trans, 'String', char(' '));
handles.Shifting.Value = 0;


% --- Executes on button press in Labeled_SC.
function Labeled_SC_Callback(hObject, eventdata, handles)
% hObject    handle to Labeled_SC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global recap_image;
global orig;
global vect,
global seg;
global spinal;
global cropped;

% [coloredLabels,labeled_regions,labeledImage,rgbImage,finalimage ] = SC_quantific(orig,seg,vect)
axes(handles.axes10);
imshow(recap_image,[]);
% --- Executes on button press in pushbutton3.
