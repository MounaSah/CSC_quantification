
function varargout = Patient_Information(varargin)
% PATIENT_INFORMATION MATLAB code for Patient_Information.fig
%      PATIENT_INFORMATION, by itself, creates a new PATIENT_INFORMATION or raises the existing
%      singleton*.
%      H = PATIENT_INFORMATION returns the handle to a new PATIENT_INFORMATION or the handle to the existing singleton*.
%
%      PATIENT_INFORMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PATIENT_INFORMATION.M with the given input arguments.
%
%      PATIENT_INFORMATION('Property','Value',...) creates a new PATIENT_INFORMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Patient_Information_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Patient_Information_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Patient_Information

% Last Modified by GUIDE v2.5 12-Jan-2024 15:41:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Patient_Information_OpeningFcn, ...
    'gui_OutputFcn',  @Patient_Information_OutputFcn, ...
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


% --- Executes just before Patient_Information is made visible.
function Patient_Information_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Patient_Information (see VARARGIN)

% Choose default command line output for Patient_Information
handles.output = hObject;
global DB;
clc;
delete *.mat
% Update handles structure
guidata(hObject, handles);
set(handles.Date,'String',cellstr(datestr(date, 'dd-mm-yyyy')));
DB=get(handles.Select_date_study,'string');
% UIWAIT makes Patient_Information wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Patient_Information_OutputFcn(~, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in BirthDay.
function BirthDay_Callback(hObject, eventdata, handles)
% hObject    handle to BirthDay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns BirthDay contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BirthDay

% --- Executes during object creation, after setting all properties.
function BirthDay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BirthDay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function First_name_Callback(hObject, eventdata, handles)
% hObject    handle to First_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function First_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to First_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NID_Callback(hObject, eventdata, handles)
% hObject    handle to NID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function NID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SCinterface.
function SCinterface_Callback(hObject, eventdata, handles)
% hObject    handle to SCinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DB;
global Name;
global FName;
global ID;
global datestudy;

t1 = datetime('now');
[y,m,d] = ymd(t1);
ExamDATE = strcat(num2str(y),'-',num2str(m),'-',num2str(d));

Name=get(handles.First_name,'String');
FName=get(handles.Last_name,'String');
ID=get(handles.NID,'String');
datestudy=get(handles.Select_date_study,'String');


AA1 = isstrprop(Name, 'alpha');
ii1=length(AA1);

AA2 = isstrprop(FName, 'alpha')
ii2=length(AA2);

AA3 = isstrprop(ID, 'digit')
ii3=length(AA3);

C1=0;
C2=0;
C3=0;

for i=1:ii2
    if AA2(i)==1
        C2=C2+1;
    end
end


for i=1:ii1
    if AA1(i)==1
        C1=C1+1;
    end
end

for i=1:ii3
    if AA3(i)==1
        C3=C3+1;
    end
end

% BDate=get(handles.BirthDay,'String');
FileName=strcat(Name,FName,num2str(ID));

structFile = struct('strings',{{datestudy,FileName}});
save ('File.mat', 'structFile');

A1=strcmp(ID,'');
A2=strcmp(Name,'');
A3=strcmp(FName,'');
A4=strcmp(get(handles.Select_date_study,'string'),DB);

if (A2==1)
    message = sprintf('Warning: Name is not allowed to be empty!');
    uiwait(warndlg(message));
    
elseif C1~=ii1
    message = sprintf('Warning: Name should include only letters!');
    uiwait(warndlg(message));
    
elseif (A3==1)
        message = sprintf('Warning: Family Name is not allowed to be empty!');
        uiwait(warndlg(message));
        
elseif C2~=ii2
    message = sprintf('Warning: Family Name should include only letters!');
    uiwait(warndlg(message));
    
elseif (A4==1)
            message = sprintf('Warning: Date of Study is not allowed to be empty!');
            uiwait(warndlg(message));
            
elseif (A1==1)
                message = sprintf('Warning: National ID is not allowed to be empty!');
                uiwait(warndlg(message));
                
%  elseif C3~=ii3 || C3~=8
%     message = sprintf('Warning: National ID should include 8 digits!');
%     uiwait(warndlg(message));

else
    SC_Preprocessing_Segmentation;
    hf=findobj('Name','Main');
    close(hf);
end
        
% --- Executes on button press in Select_date_study.
function Select_date_study_Callback(hObject, eventdata, handles)
% hObject    handle to Select_date_study (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uicalendar('Weekend', [1 0 0 0 0 0 1],...
    'SelectionType', 1,...
    'DestinationUI',handles.Select_date_study,...
    'OutputDateFormat','dd-mm-yyyy');


function Date_Callback(hObject, eventdata, handles)

% hObject    handle to Date (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Date as text
%        str2double(get(hObject,'String')) returns contents of Date as a double
t = datestr(date, 'dd / mm /yyyy');


% --- Executes during object creation, after setting all properties.
function Date_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Date (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Last_name_Callback(hObject, eventdata, handles)
% hObject    handle to Last_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function Last_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Last_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and use
r data (see GUIDATA)
set(handles.First_name,'string',' ')
set(handles.Last_name,'string',' ')
set(handles.Select_date_study,'string','Select Date')
set(handles.NID,'string',' ')

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq();
