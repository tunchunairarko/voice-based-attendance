function varargout = Record_Audio(varargin)
% RECORD_AUDIO MATLAB code for Record_Audio.fig
%      RECORD_AUDIO, by itself, creates a new RECORD_AUDIO or raises the existing
%      singleton*.
%
%      H = RECORD_AUDIO returns the handle to a new RECORD_AUDIO or the handle to
%      the existing singleton*.
%
%      RECORD_AUDIO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECORD_AUDIO.M with the given input arguments.
%
%      RECORD_AUDIO('Property','Value',...) creates a new RECORD_AUDIO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Record_Audio_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Record_Audio_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Record_Audio

% Last Modified by GUIDE v2.5 18-Jan-2017 12:24:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Record_Audio_OpeningFcn, ...
                   'gui_OutputFcn',  @Record_Audio_OutputFcn, ...
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


% --- Executes just before Record_Audio is made visible.
function Record_Audio_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Record_Audio (see VARARGIN)

% Choose default command line output for Record_Audio
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Record_Audio wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Record_Audio_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function fileName_Callback(hObject, eventdata, handles)
% hObject    handle to fileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileName as text
%        str2double(get(hObject,'String')) returns contents of fileName as a double
global fname;
fname=get(hObject, 'String');
fname=strcat(fname,'.wav');

% --- Executes during object creation, after setting all properties.
function fileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
% hObject    handle to startButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stopButton.
set(handles.recordStatus, 'string', '....');
set(handles.startButton, 'string', 'running', 'ForegroundColor', 'blue', 'enable', 'off');
global recObj;
recObj=audiorecorder(44100, 8, 2);
%record(recObj, 1);
recordblocking(recObj, 1);
set(handles.startButton, 'string', 'Start', 'ForegroundColor', 'blue', 'enable', 'on');
global fname;
%stop(recObj);
myRecMat=getaudiodata(recObj);
sound(myRecMat, 44100);
figure;
plot(myRecMat);
audiowrite(fname, myRecMat, 44100);
set(handles.recordStatus, 'string', strcat('Recorded successfully in: ',fname));
clear recObj myRecMat;
%----THE FOLLOWING LINES ARE STORED FOR FURTHER REFERENCE---- 
%set(handles.startButton, 'string', 'Recorded', 'ForegroundColor', 'blue', 'enable', 'on');
%global recObj;
%global fname;
%stop(recObj);
%myRecMat=getaudiodata(recObj);
%sound(myRecMat, 44100);
%figure;
%plot(myRecMat);
%audiowrite(fname, myRecMat, 44100);
%clear recObj myRecMat;


function stopButton_Callback(hObject, eventdata, handles)
% hObject    handle to stopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over startButton.


% --- Executes on key press with focus on startButton and none of its controls.
%set(handles.startButton, 'string', 'Recorded', 'ForegroundColor', 'blue', 'enable', 'on');
%global recObj;
%global fname;
%stop(recObj);
%myRecMat=getaudiodata(recObj);
%sound(myRecMat, 44100);
%figure;
%plot(myRecMat);
%audiowrite(fname, myRecMat, 44100);
%clear recObj myRecMat;
