function varargout = SC_Quantification(varargin)
% SC_QUANTIFICATION MATLAB code for sc_quantification.fig
%      SC_QUANTIFICATION, by itself, creates a new SC_QUANTIFICATION or raises the existing
%      singleton*.
%
%      H = SC_QUANTIFICATION returns the handle to a new SC_QUANTIFICATION or the handle to
%      the existing singleton*.
%
%      SC_QUANTIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SC_QUANTIFICATION.M with the given input arguments.
%
%      SC_QUANTIFICATION('Property','Value',...) creates a new SC_QUANTIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sc_quantification_openingfcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sc_quantification_openingfcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sc_quantification

% Last Modified by GUIDE v2.5 07-Dec-2023 11:54:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SC_Quantification_OpeningFcn, ...
    'gui_OutputFcn',  @SC_Quantification_OutputFcn, ...
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

% --- Executes just before sc_quantification is made visible.
function SC_Quantification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sc_quantification (see VARARGIN)

% Choose default command line output for sc_quantification
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = SC_Quantification_OutputFcn(hObject, eventdata, handles)
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

% --- Executes on button press in Upper_diameter.
function Upper_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to Upper_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global labeledImage;
global blobArea;
global blobVolume;
global MinorAxisLength;
global MajorAxisLength;
global numberOfBlobs;
global slice_thickness;
global voxel_heigth;
global voxel_width;


[blobArea,blobECD,MinorAxisLength,MajorAxisLength, blobVolume,blobVolume1,numberOfBlobs]=measures(labeledImage,slice_thickness,voxel_heigth,voxel_width);
set(handles.diameter,'string',MinorAxisLength);

% --- Executes on button press in length_display.
function Length_Callback(hObject, eventdata, handles)
% hObject    handle to length_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global labeledImage;
global blobArea;
global blobVolume;
global MinorAxisLength;
global MajorAxisLength;
global numberOfBlobs;
global slice_thickness;
global voxel_heigth;
global voxel_width;

[blobArea,blobECD,MinorAxisLength,MajorAxisLength, blobVolume,blobVolume1,numberOfBlobs]=measures(labeledImage,slice_thickness,voxel_heigth,voxel_width);
set(handles.length_display,'string',MajorAxisLength);


% --- Executes on button press in Regions_number.
function Regions_number_Callback(hObject, eventdata, handles)
% hObject    handle to Regions_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global labeledImage;
global blobArea;
global blobECD;
global blobVolume;
global blobVolume1;
global MinorAxisLength;
global MajorAxisLength;
global numberOfBlobs;
global slice_thickness;
global voxel_heigth;
global voxel_width;

[blobArea,blobECD,MinorAxisLength,MajorAxisLength, blobVolume,blobVolume1,numberOfBlobs]=measures(labeledImage,slice_thickness,voxel_heigth,voxel_width);
set(handles.blobs,'string',1:numberOfBlobs);


% --- Executes on button press in Save_SC_measures.
function Save_SC_measures_Callback(hObject, eventdata, handles)
% hObject    handle to Save_SC_measures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global blobECD;
% global blobVolume1;
% global MinorAxisLength;
% global MajorAxisLength;
% global numberOfBlobs;
% global i;
% global fullFileName;
% global totalVolume_cone;
% global total_length,


load('File.mat');
load('File1.mat');
load('Measures.mat');

blobArea=struct_measures.strings(1);
blobArea = [blobArea{:}];

blobECD=struct_measures.strings(2);
blobECD = [blobECD{:}];

MinorAxisLength=struct_measures.strings(3);
MinorAxisLength = [MinorAxisLength{:}];

MajorAxisLength=struct_measures.strings(4);
MajorAxisLength = [MajorAxisLength{:}];

blobVolume=struct_measures.strings(5);
blobVolume = [blobVolume{:}];

blobVolume1=struct_measures.strings(6);
blobVolume1 = [blobVolume1{:}];

totalVolume_cone=struct_measures.strings(7);
totalVolume_cone = [totalVolume_cone{:}];

total_length=struct_measures.strings(8);
total_length = [total_length{:}];

numberOfBlobs=struct_measures.strings(9);
numberOfBlobs = [numberOfBlobs{:}];


totalVolume_cone=[totalVolume_cone, zeros(1,numberOfBlobs-1)];
total_length=[total_length, zeros(1,numberOfBlobs-1)];

pp = {'C1/C2', 'C3' ,'C4', 'C5', 'C6', 'C7','T1', 'T2', 'T3', 'T4' ,'T5', 'T6', 'T7','CSC Volume'};
Vertebral_level=[pp(1:numberOfBlobs)];


NomEmp = structFile1.strings(2);
Segment=1:1:numberOfBlobs;
Names={'Segment N','Vertebral level','Lower Diameter','Upper Diameter','Length','Volume','Total_CSC_length','Total_CSC_volume'};
T = table(Segment',Vertebral_level',blobECD',MinorAxisLength',MajorAxisLength',blobVolume1',total_length',totalVolume_cone','VariableNames',Names);

fullFileName = fullfile(NomEmp, structFile.strings(2));
fullFileName = strcat(fullFileName,'.xlsx');
fullFileName=char(fullFileName);

C=zeros(5,5);
writematrix(C,fullFileName,'Sheet',1,'Range','D2');
writetable(T,fullFileName,'Sheet',char(structFile.strings(1)),'WriteVariableNames',true);
xlswrite(fullFileName, cell(29, 1), char(structFile.strings(1)), 'G3:H20');


j=1;
[~,sheet_name]=xlsfinfo(fullFileName);
for k=2:numel(sheet_name)
    sheetname(j)=sheet_name(k);
    data{k}=xlsread(fullFileName,sheet_name{k});
    j=j+1;
end

LL=length(data);
for ff=1:LL
    NBLOB(1,ff)=size((data{1,ff}),1);
end

numberOfBlob=min(NBLOB(1,2:length(NBLOB)));

i=2;
for j=1:numel(sheet_name)-1
    Lower_Diameter(:,j)=data{1,i}(1:numberOfBlob,3);
    Upper_Diameter(:,j)=data{1,i}(1:numberOfBlob,4);
    Length(:,j)=data{1,i}(1:numberOfBlob,5);
    Volume(:,j)=data{1,i}(1:numberOfBlob,6);
    CSC_length(:,j)=data{1,i}(1:numberOfBlob,7);
    CSC_volume(:,j)=data{1,i}(1:numberOfBlob,8);
    i=i+1;
end

x=1:numberOfBlob+1;
w1 = 0.5;

figure
colororder("reef")
for j=1:numel(sheet_name)-1
    Volumes=[Volume' CSC_volume(j,:)'];
    hold on
    bar(x,Volumes);
    ax = gca;
       
    ax.XTick = x;
    ax.XTickLabels=[pp(1:numberOfBlob) pp(14)];
    ax.XTickLabelRotation = 45;
end

grid on
xlabel('Vertebral levels')
ylabel('Volume of SC segments (mm^3)')
hLg=legend(sheetname,'Location','northwest');
hold off 

e = actxserver('Excel.Application'); % # open Activex server
ewb = e.Workbooks.Open(fullFileName); % # open file (enter full path!)
ewb.Worksheets.Item(1).Name = 'Volume Display'; % # rename 1st sheet
ewb.Save % # save to the same file
ewb.Close(false)
e.Quit

xlswrite(fullFileName, cell(29, 1), 'Volume Display', 'D2:H6');
xlswritefig(gcf, fullFileName, 'Volume Display', 'D2');
% message = sprintf('Excel file is generated');
% uiwait(warndlg(message));

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set(handles.area,'string',' ')
set(handles.diameter,'string',' ');
set(handles.ecd,'string',' ');
set(handles.length_display,'string',' ');
%set(handles.volumeCylindre,'string',' ');
set(handles.blobs,'string',' ');
set(handles.VolumeCone,'string',' ');
set(handles.val_volume,'string',' ');
set(handles.val_length,'string',' ');


% --- Executes on button press in Lower_diameter.
function Lower_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to Lower_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global labeledImage;
global blobArea;
global blobECD;
global blobVolume;
global MinorAxisLength;
global MajorAxisLength;
global slice_thickness;
global voxel_heigth;
global voxel_width;


[blobArea,blobECD,MinorAxisLength,MajorAxisLength, blobVolume,blobVolume1,numberOfBlobs]=measures(labeledImage,slice_thickness,voxel_heigth,voxel_width);
set(handles.ecd,'string',blobECD);


% --- Executes on button press in Volume.
function Volume_Callback(hObject, eventdata, handles)
% hObject    handle to Volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global labeledImage;
global blobArea;
global blobVolume;
global blobVolume1;
global numberOfBlobs;
global MinorAxisLength;
global MajorAxisLength;
global slice_thickness;
global voxel_heigth;
global voxel_width;


[blobArea,blobECD,MinorAxisLength,MajorAxisLength, blobVolume,blobVolume1,numberOfBlobs]=measures(labeledImage,slice_thickness,voxel_heigth,voxel_width);
set(handles.VolumeCone,'string',blobVolume1);


% --- Executes during object creation, after setting all properties.
function blobs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blobs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in calculateVolumeCylindre.
function calculateVolumeCylindre_Callback(hObject, eventdata, handles)
% hObject    handle to calculateVolumeCylindre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global labeledImage;
global blobArea;
global blobVolume;
global blobVolume1;
global numberOfBlobs;
global MinorAxisLength;
global MajorAxisLength;
global slice_thickness;
global voxel_heigth;
global voxel_width;


[blobArea,blobECD,MinorAxisLength,MajorAxisLength, blobVolume,blobVolume1,numberOfBlobs]=measures(labeledImage,slice_thickness,voxel_heigth,voxel_width);
set(handles.volumeCylindre,'string',blobVolume);


% --- Executes on button press in Open_SC_file.
function Open_SC_file_Callback(hObject, eventdata, handles)
% hObject    handle to Open_SC_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load('File1.mat');
load('File.mat');
NomEmp = structFile1.strings(2);

fullFileName = fullfile(NomEmp, structFile.strings(2));
fullFileName = strcat(fullFileName,'.xlsx');
fullFileName=char(fullFileName);
winopen(fullFileName)



% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();


% --- Executes on button press in CSC_volume.
function CSC_volume_Callback(hObject, eventdata, handles)
% hObject    handle to CSC_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global labeledImage;
global blobArea;
global blobECD;
global blobVolume;
global MinorAxisLength;
global MajorAxisLength;
global numberOfBlobs;
global totalVolume_cone;
global slice_thickness;
global voxel_heigth;
global voxel_width;

[blobArea,blobECD,MinorAxisLength,MajorAxisLength, blobVolume,blobVolume1,numberOfBlobs,totalVolume_cone]=measures(labeledImage,slice_thickness,voxel_heigth,voxel_width);
set(handles.val_volume,'string',totalVolume_cone);

% --- Executes on button press in CSC_length.
function CSC_length_Callback(hObject, eventdata, handles)
% hObject    handle to CSC_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global labeledImage;
global blobArea;
global blobECD;
global blobVolume;
global MinorAxisLength;
global MajorAxisLength;
global numberOfBlobs;
global totalVolume_cone;
global total_length;
global slice_thickness;
global voxel_heigth;
global voxel_width;

[blobArea,blobECD,MinorAxisLength,MajorAxisLength, blobVolume,blobVolume1,numberOfBlobs,totalVolume_cone,total_length]=measures(labeledImage,slice_thickness,voxel_heigth,voxel_width);
set(handles.val_length,'string',total_length);

struct_measures = struct('strings',{{blobArea,blobECD,MinorAxisLength,MajorAxisLength,blobVolume,blobVolume1,totalVolume_cone,total_length,numberOfBlobs}});
save ('Measures.mat', 'struct_measures');


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function val_volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over val_volume.
function val_volume_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to val_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
