function varargout = interfaceSC(varargin)
%INTERFACESC MATLAB code file for interfaceSC.fig
%      INTERFACESC, by itself, creates a new INTERFACESC or raises the existing
%      singleton*.
%
%      H = INTERFACESC returns the handle to a new INTERFACESC or the handle to
%      the existing singleton*.
%
%      INTERFACESC('Property','Value',...) creates a new INTERFACESC using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to interfaceSC_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      INTERFACESC('CALLBACK') and INTERFACESC('CALLBACK',hObject,...) call the
%      local function named CALLBACK in INTERFACESC.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above volumeCylindre to modify the response to help interfaceSC

% Last Modified by GUIDE v2.5 28-Sep-2023 13:41:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @interfaceSC_OpeningFcn, ...
    'gui_OutputFcn',  @interfaceSC_OutputFcn, ...
    'gui_LayoutFcn',  [], ...
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


% --- Executes just before interfaceSC is made visible.
function interfaceSC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for interfaceSC
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
clear all;
clc;
global NomFich
NomFich='a';

% UIWAIT makes interfaceSC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interfaceSC_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function exam_n_Callback(hObject, eventdata, handles)
% hObject    handle to exam_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exam_n as text
%        str2double(get(hObject,'String')) returns contents of exam_n as a double

% --- Executes on button press in lecture_orig.
function lecture_orig_Callback(hObject, eventdata, handles)
% hObject    handle to lecture_orig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global orig;
global NomFich;
global NomEmp;

% exam= str2num(get(handles.exam_n,'String'));
[NomFich,NomEmp] = uigetfile({'*.nii';'*.img';'*.dcm'},'File Selector');
% Choisir une image
if isequal(NomFich,0)
    disp('Image non acquise') ;
else
    disp(['Image acquise ', fullfile(NomEmp,NomFich)]);
end
structFile1 = struct('strings',{{NomFich,NomEmp}});
save ('File1.mat', 'structFile1');

Vregs  =spm_vol(NomFich);
[orig xyz]=spm_read_vols(Vregs);
[a,b,c]=size(orig);

te=[{'Select Slice Number'},1:c-1];
set(handles.selectNslice, 'String', te);
handles.selectNslice.Value = 1;


% --- Executes on selection change in selectNslice.
function selectNslice_Callback(hObject, eventdata, handles)
% hObject    handle to selectNslice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectNslice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectNslice
% val=get(handles.selectNslice,'Value')
global orig;
global val;
global NomFich;
global orig1;

val= get(handles.selectNslice,'Value');
val=val;
x=val;

structDATAA = struct('strings',{x});
save ('xvalue.mat', 'structDATAA');

switch (val)
    
    case 1
        cla(handles.axes1,'reset');
    otherwise
        if NomFich=='a'
            message = sprintf('Warning: Select the Spinal Cord MRI Image');
            uiwait(warndlg(message));
        else
            orig1=(orig(:,:,val));
            orig1=imrotate(orig1,90);
            axes(handles.axes1);
            imshow(orig1,[]);
        end
end


% --- Executes during object creation, after setting all properties.
function selectNslice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectNslice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
selectNslice = cellstr(get(hObject,'String'));


% --- Executes on button press in display_enhancement.
function display_enhancement_Callback(hObject, eventdata, handles)
% hObject    handle to display_enhancement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global output;
global NomFich;
global orig1;

if NomFich=='a'
    message = sprintf('Warning: Select the Spinal Cord MRI Image');
    uiwait(warndlg(message));
else
    output=enhancement(orig1);
    axes(handles.axes6);
    imshow(output,[]);
end


% --- Executes on button press in roi.
function roi_Callback(hObject, eventdata, handles)
% hObject    handle to roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global output;
global cropped;
global rect;
global NomFich

if NomFich=='a'
    message = sprintf('Warning: Select the Spinal Cord MRI Image');
    uiwait(warndlg(message));
else
    axes(handles.axes2);
    imshow(output,[]);
    
    promptMessage = sprintf('Select a rectangular ROI starting from the superior limit of C1 until C7 (Please take the full width of the image). Then, right-click inside the ROI and select Crop Image from the context menu');
    titleBarCaption = 'Continue?';
    buttonText = questdlg(promptMessage, titleBarCaption, 'OK', 'Quit', 'OK');
    if strcmpi(buttonText, 'Quit')
        return;
    end
    
    [cropped,rect]=imcrop();
    axes(handles.axes2);
    imshow(cropped,[]);
end

% --- Executes on button press in btnGo.
function btnGo_Callback(hObject, eventdata, handles)
% hObject    handle to btnGo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
global cropped;
global seg;
global num_it;
num_it=3000;
structDATA = struct('strings',{{'no','yes',}}); %#ok<NASGU>
save ('stopp.mat', 'structDATA');
% x= str2num(get(handles.orig_sliceN,'String'));

global NomFich

if NomFich=='a'
    message = sprintf('Warning: Select the Spinal Cord MRI Image');
    uiwait(warndlg(message));
else
    set(handles.btnStop, 'userdata', 0);
    axes(handles.axes3);
    imshow(cropped,[]);
    seg=Localized_Active_Contour(num_it, cropped,x);
end


% --- Executes on button press in save_segmentation.
function save_segmentation_Callback(hObject, eventdata, handles)
% hObject    handle to save_segmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global seg;
global NomFich

if NomFich=='a'
    message = sprintf('Warning: Select the Spinal Cord MRI Image');
    uiwait(warndlg(message));
else
axes(handles.axes4);
imshow(seg,[]);
end

% K = getframe;
%imwrite(K.cdata,'C:\Users\asus\Desktop\SEP\segmentation code\interface clinique\interface_mouna\SC_segmentation_results\SC_Segmentation.tiff');
% baseFileName = sprintf('ResultSC_Seg_Slice%03d.tiff', x);
% fullFileName = fullfile(NomEmp, baseFileName);
% imwrite(K.cdata, fullFileName);

% --- Executes on button press in orig_sliceN.
function orig_slice_Callback(hObject, eventdata, handles)
% hObject    handle to orig_sliceN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function orig_sliceN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in orig_sliceN.
function orig_sliceN_Callback(hObject, eventdata, handles)
% hObject    handle to orig_sliceN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when IRM is resized.
function IRM_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to IRM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in btnStop.
function btnStop_Callback(hObject, eventdata, handles)
% hObject    handle to btnStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global NomFich

if NomFich=='a'
    message = sprintf('Warning: Select the Spinal Cord MRI Image');
    uiwait(warndlg(message));
else
set(handles.btnStop,'userdata',1);
structDATA = struct('strings',{{'yes','no'}});
save ('stopp.mat', 'structDATA');
end
%

% --- Executes on button press in Data_patient.
function StartSpinalCordPartition_Callback(hObject, eventdata, handles)
% hObject    handle to Data_patient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hf=findobj('Name','interfaceSC');
% close(hf)
global NomFich

if NomFich=='a'
    message = sprintf('Warning: Select the Spinal Cord MRI Image');
    uiwait(warndlg(message));
else
SpinalCordSegmentation;
end


% --- Executes during object creation, after setting all properties.
function btnStop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btnStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global NomFich
NomFich='a';
cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
cla(handles.axes3,'reset');
cla(handles.axes4,'reset');
cla(handles.axes6,'reset');
set(handles.selectNslice, 'String', char('Select Slice Number'));
handles.selectNslice.Value = 1;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over orig_sliceN.
function orig_sliceN_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to orig_sliceN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over selectNslice.
function selectNslice_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to selectNslice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on lecture_orig and none of its controls.
function lecture_orig_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lecture_orig (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function lecture_orig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lecture_orig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
