function varargout = SC_Preprocessing_Segmentation(varargin)
%SC_PREPROCESSING_SEGMENTATION MATLAB code file for SC_Preprocessing_Segmentation.fig
%      SC_PREPROCESSING_SEGMENTATION, by itself, creates a new SC_PREPROCESSING_SEGMENTATION or raises the existing
%      singleton*.
%
%      H = SC_PREPROCESSING_SEGMENTATION returns the handle to a new SC_PREPROCESSING_SEGMENTATION or the handle to
%      the existing singleton*.
%
%      SC_PREPROCESSING_SEGMllENTATION('Property','Value',...) creates a new SC_PREPROCESSING_SEGMENTATION using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to SC_Preprocessing_Segmentation_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SC_PREPROCESSING_SEGMENTATION('CALLBACK') and SC_PREPROCESSING_SEGMENTATION('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SC_PREPROCESSING_SEGMENTATION.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above volumeCylindre to modify the response to help SC_Preprocessing_Segmentation

% Last Modified by GUIDE v2.5 07-Dec-2023 10:04:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SC_Preprocessing_Segmentation_OpeningFcn, ...
    'gui_OutputFcn',  @SC_Preprocessing_Segmentation_OutputFcn, ...
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


% --- Executes just before SC_Preprocessing_Segmentation is made visible.
function SC_Preprocessing_Segmentation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for SC_Preprocessing_Segmentation
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
clear all;
clc;
global NomFich
NomFich='a';


% --- Outputs from this function are returned to the command line.
function varargout = SC_Preprocessing_Segmentation_OutputFcn(hObject, eventdata, handles)
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

% --- Executes on button press in Load_MRI.
function Load_MRI_Callback(hObject, eventdata, handles)
% hObject    handle to Load_MRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global orig;
global NomFich;
global NomEmp;
global slice_thickness;
global voxel_heigth;
global voxel_width;

[NomFich,NomEmp] = uigetfile({'*.nii';'*.img';'*.dcm'},'File Selector');
if isequal(NomFich,0)
    disp('Image not displayed') ;
else
    disp(['Image displayed ', fullfile(NomEmp,NomFich)]);
end
structFile1 = struct('strings',{{NomFich,NomEmp}});
save ('File1.mat', 'structFile1');

Vregs  =spm_vol(NomFich);
[orig xyz]=spm_read_vols(Vregs);
[a,b,c]=size(orig);

	%		pixdim[] specifies the voxel dimensions:
	%		pixdim[1] - voxel width, mm
	%		pixdim[2] - voxel height, mm
	%		pixdim[3] - slice thickness, mm
    
[hdr, filetype, fileprefix, machine] = load_nii_hdr(NomFich);

voxel_width=hdr.dime.pixdim(2);
voxel_heigth=hdr.dime.pixdim(3);
slice_thickness=hdr.dime.pixdim(4);

te=[{'Select Slice Number'},1:c-1];
set(handles.Select_slice, 'String', te);
handles.Select_slice.Value = 1;


% --- Executes on selection change in Select_slice.
function Select_slice_Callback(hObject, eventdata, handles)
% hObject    handle to Select_slice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Select_slice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Select_slice
% val=get(handles.Select_slice,'Value')
global orig;
global val;
global NomFich;
global orig1;

val= get(handles.Select_slice,'Value');
val=val;
x=val;

structDATAA = struct('strings',{x});
save ('xvalue.mat', 'structDATAA');

switch (val)
    
    case 1
        cla(handles.axes1,'reset');
    otherwise
        if NomFich=='a'
            message = sprintf('Warning: Select the T2-w SC MR Image');
            uiwait(warndlg(message));
        else
            orig1=(orig(:,:,val));
            orig1=imrotate(orig1,90);
            axes(handles.axes1);
            imshow(orig1,[]);
        end
end


% --- Executes during object creation, after setting all properties.
function Select_slice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Select_slice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
selectNslice = cellstr(get(hObject,'String'));


% --- Executes on button press in Display_enhancement.
function Display_enhancement_Callback(hObject, eventdata, handles)
% hObject    handle to Display_enhancement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global output;
global NomFich;
global orig1;

if NomFich=='a'
    message = sprintf('Warning: Select the T2-w SC MR Image');
    uiwait(warndlg(message));
else
    output=enhancement(orig1);
    axes(handles.axes6);
    imshow(output,[]);
end


% --- Executes on button press in ROI.
function ROI_Callback(hObject, eventdata, handles)
% hObject    handle to ROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global output;
global cropped;
global rect;
global NomFich

if NomFich=='a'
    message = sprintf('Warning: Select the T2-w SC MR Image');
    uiwait(warndlg(message));
else
    axes(handles.axes2);
%     figure
    imshow(output,[]);
    
    promptMessage = sprintf('Select a rectangular ROI starting from the superior limit of C1 until the inferior limit of C6 (Please take the full width of the image). Then, right-click inside the ROI and select Crop Image from the context menu');
    titleBarCaption = 'Continue?';
    buttonText = questdlg(promptMessage, titleBarCaption, 'OK', 'Quit', 'OK');
    if strcmpi(buttonText, 'Quit')
        return;
    end
    
    [cropped,rect]=imcrop();
    axes(handles.axes2);
    imshow(cropped,[]);
end

% --- Executes on button press in Start_segmentation.
function Start_segmentation_Callback(hObject, eventdata, handles)
% hObject    handle to Start_segmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
global cropped;
global seg;
global num_it;
global NomFich

num_it=10000;
structDATA = struct('strings',{{'no','yes',}}); %#ok<NASGU>
save ('stopp.mat', 'structDATA');

if NomFich=='a'
    message = sprintf('Warning: Select the T2-w SC MR Image');
    uiwait(warndlg(message));
else
    
    set(handles.Stop_segmentation, 'userdata', 0);
    axes(handles.axes3);
    promptMessage = sprintf(' Please point the cursor inside the SC and press the right bottom');
    titleBarCaption = 'Continue?';
    buttonText = questdlg(promptMessage, titleBarCaption, 'OK', 'Quit', 'OK');
    if strcmpi(buttonText, 'Quit')
        return;
    end
    seg=Localized_Active_Contour(num_it, cropped,x);
end


% --- Executes on button press in Display_segmentation.
function Display_segmentation_Callback(hObject, eventdata, handles)
% hObject    handle to Display_segmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global seg;
global NomFich

if NomFich=='a'
    message = sprintf('Warning: Select the T2-w SC MR Image');
    uiwait(warndlg(message));
else
axes(handles.axes4);
imshow(seg,[]);
end


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

% --- Executes on button press in Stop_segmentation.
function Stop_segmentation_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_segmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global NomFich

if NomFich=='a'
    message = sprintf('Warning: Select the T2-w SC MR Image');
    uiwait(warndlg(message));
else
set(handles.Stop_segmentation,'userdata',1);
structDATA = struct('strings',{{'yes','no'}});
save ('stopp.mat', 'structDATA');
end
%

% --- Executes on button press in Data_patient.
function Start_SC_partition_Callback(hObject, eventdata, handles)
% hObject    handle to Data_patient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hf=findobj('Name','SC_Preprocessing_Segmentation');
% close(hf)
global NomFich

if NomFich=='a'
    message = sprintf('Warning: Select the T2-w SC MR Image');
    uiwait(warndlg(message));
else
SC_Partition;
end


% --- Executes during object creation, after setting all properties.
function Stop_segmentation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stop_segmentation (see GCBO)
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
set(handles.Select_slice, 'String', char('Select Slice Number'));
handles.Select_slice.Value = 1;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over orig_sliceN.
function orig_sliceN_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to orig_sliceN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Select_slice.
function Select_slice_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Select_slice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on Load_MRI and none of its controls.
function Load_MRI_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Load_MRI (see GCBO)
% eventdata  structure with the fllowing fields (see MATLAB.UI.CONTROL.UICONTROL)
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
function Load_MRI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Load_MRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
