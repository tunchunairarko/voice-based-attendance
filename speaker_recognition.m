function varargout = speaker_recognition(varargin)
% SPEAKER_RECOGNITION MATLAB code for speaker_recognition.fig
%      SPEAKER_RECOGNITION, by itself, creates a new SPEAKER_RECOGNITION or raises the existing
%      singleton*.
%
%      H = SPEAKER_RECOGNITION returns the handle to a new SPEAKER_RECOGNITION or the handle to
%      the existing singleton*.
%
%      SPEAKER_RECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPEAKER_RECOGNITION.M with the given input arguments.
%
%      SPEAKER_RECOGNITION('Property','Value',...) creates a new SPEAKER_RECOGNITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before speaker_recognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to speaker_recognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help speaker_recognition

% Last Modified by GUIDE v2.5 22-Jan-2017 12:26:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @speaker_recognition_OpeningFcn, ...
                   'gui_OutputFcn',  @speaker_recognition_OutputFcn, ...
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


% --- Executes just before speaker_recognition is made visible.
function speaker_recognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to speaker_recognition (see VARARGIN)

% Choose default command line output for speaker_recognition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
 
% UIWAIT makes speaker_recognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = speaker_recognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global todayPresent;
global presentTodayData;
todayPresent=0;
presentTodayData=datetime('today');
presentTodayData=strcat(datestr(presentTodayData),'.csv');

% --- Executes on button press in helpButton.
function helpButton_Callback(hObject, eventdata, handles)
% hObject    handle to helpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Help.docx');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('about.txt');

% --- Executes on button press in recogRun.
function recogRun_Callback(hObject, eventdata, handles)
% hObject    handle to recogRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.stReg, 'Visible', 'Off');
set(handles.stRegOutput, 'Visible', 'Off', 'String', 'YES', 'ForegroundColor', 'green');
set(handles.stID, 'Visible', 'On');
set(handles.stIDOutput, 'Visible', 'Off', 'String', '', 'ForegroundColor', 'green');
set(handles.recogRun, 'string', 'Run again', 'ForegroundColor', 'blue', 'enable', 'on');
set(handles.clAtt, 'Visible', 'Off');
set(handles.clAttTot, 'Visible', 'Off', 'String', '', 'ForegroundColor', 'green');

set(handles.recogRun, 'string', 'running', 'enable', 'off');
set(handles.stopRec, 'string', 'Stop', 'enable', 'on');
global recObj;
recObj=audiorecorder(44100, 8, 2);
record(recObj);


% --- Executes on button press in trainButton.
function trainButton_Callback(hObject, eventdata, handles)
% hObject    handle to trainButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
k = 16;                         % number of centroids required
global code;
global n;
global folder_name;
%tDir='C:/Users/tunch/Documents/MATLAB Projects/Speaker Recognition/data/train/'; %Change it according to your wish
tDir=folder_name;
%n=8;
for i = 1:n                     % train a VQ codebook for each speaker
    file = sprintf('%ss%d.wav', tDir, i);           
    fprintf(file);
   
    [s, fs] = audioread(file);
    
    v = mfcc(s, fs);            % Compute MFCC's
   
    code{i} = vqlbg(v, k);      % Train VQ codebook
end
set(handles.statusText, 'String', 'Training Complete', 'ForegroundColor', 'green');


% --- Executes on button press in databaseButton.
function databaseButton_Callback(hObject, eventdata, handles)
% hObject    handle to databaseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('database.txt');

% --- Executes on button press in exitButton.
function exitButton_Callback(hObject, eventdata, handles)
% hObject    handle to exitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


function folderAddress_Callback(hObject, eventdata, handles)
% hObject    handle to folderAddress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of folderAddress as text
%        str2double(get(hObject,'String')) returns contents of folderAddress as a double


% --- Executes during object creation, after setting all properties.
function folderAddress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to folderAddress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveLoc.
function saveLoc_Callback(hObject, eventdata, handles)
% hObject    handle to saveLoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global folder_name;
set(handles.folderAddress, 'String', folder_name);
set(handles.statusText, 'String', 'Train location saved', 'ForegroundColor', 'red');


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global folder_name;
folder_name = uigetdir;
folder_name=strrep(folder_name, '\', '/');
folder_name=strcat(folder_name,'/');



function noStudentsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to noStudentsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noStudentsEdit as text
%        str2double(get(hObject,'String')) returns contents of noStudentsEdit as a double


% --- Executes during object creation, after setting all properties.
function noStudentsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noStudentsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in noOfStudents.
function noOfStudents_Callback(hObject, eventdata, handles)
% hObject    handle to noOfStudents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global n;
n=str2num(get(handles.noStudentsEdit, 'String'));
set(handles.statusText, 'String', 'Student no. saved', 'ForegroundColor', 'blue');


% --- Executes on button press in stopRec.
function stopRec_Callback(hObject, eventdata, handles)
% hObject    handle to stopRec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.recogRun, 'string', 'Recorded', 'ForegroundColor', 'blue', 'enable', 'on');
set(handles.stopRec, 'string', 'Stop', 'enable', 'off');

global recObj;
global fname;
global todayPresent;
global presentTodayData;
fname='record.wav';
stop(recObj);
[y, fs]=audioread(fname);
y=y(:,1);
dt=1/fs;
t=0:dt:(length(y)*dt)-dt;
figure;
plot(t,y);
title('Audio sample of student in time domain');
xlabel('Seconds');
ylabel('Amplitude');
figure;
plot(psd(spectrum.periodogram,y,'Fs',fs,'NFFT',length(y)));
myRecMat=getaudiodata(recObj);
%sound(myRecMat, 44100);
audiowrite(fname, myRecMat, 44100);
global code;
file = sprintf(fname);
[s, fs] = audioread(file);      
v = mfcc(s, fs);            % Compute MFCC's
distmin = inf;
k1 = 0;
for l = 1:length(code)      % each trained codebook, compute distortion
    d = disteu(v, code{l}); 
    dist = sum(min(d,[],2)) / size(d,1);
    if dist < distmin
        distmin = dist;
        k1 = l;
    end      
end
if(k1==0)
    set(handles.stReg, 'Visible', 'On');
    set(handles.stRegOutput, 'Visible', 'On', 'String', 'NO', 'ForegroundColor', 'red');
    set(handles.stID, 'Visible', 'On');
    set(handles.stIDOutput, 'Visible', 'On', 'String', 'NOT FOUND', 'ForegroundColor', 'red');

else
    T=csvread('database.csv');
    IDNo=T(k1,2);
    if(length(todayPresent)==1)
        todayPresent(end+1)=IDNo;
        CLAttended=T(k1,3)+1;
        T(k1,3) = CLAttended;
        %T = readtable('database.txt', 'Delimiter', ' ', 'ReadVariableNames', false);
        %IDNo=T{k1,2}; %needs change for attendance count
        %fileID=fopen('database.txt');
        %A=fread(fileID);
        set(handles.stReg, 'Visible', 'On');
        set(handles.stRegOutput, 'Visible', 'On', 'String', 'YES', 'ForegroundColor', 'green');
        set(handles.stID, 'Visible', 'On');
        set(handles.stIDOutput, 'Visible', 'On', 'String', num2str(IDNo), 'ForegroundColor', 'green');
        set(handles.recogRun, 'string', 'Run again', 'ForegroundColor', 'blue', 'enable', 'on');
        set(handles.clAtt, 'Visible', 'On');
        set(handles.clAttTot, 'Visible', 'On', 'String', num2str(CLAttended), 'ForegroundColor', 'green');
        dlmwrite('database.csv',T,'precision',10);
        dlmwrite(presentTodayData,todayPresent,'precision',10);
    else
        chProxy=ismember(IDNo, todayPresent);
        if(chProxy==1)
            set(handles.statusText, 'String', 'PROXY ALERT!!', 'ForegroundColor', 'red');
            set(handles.clAttTot, 'Visible', 'On', 'String', 'PROXY ALERT!!', 'ForegroundColor', 'red');
            set(handles.stRegOutput, 'Visible', 'On', 'String', 'PROXY ALERT!!', 'ForegroundColor', 'red');            
            set(handles.stIDOutput, 'Visible', 'On', 'String', 'PROXY ALERT!!', 'ForegroundColor', 'red');
        else
            todayPresent(end+1)=IDNo;       
            CLAttended=T(k1,3)+1;
            T(k1,3) = CLAttended;
            %T = readtable('database.txt', 'Delimiter', ' ', 'ReadVariableNames', false);
            %IDNo=T{k1,2}; %needs change for attendance count
            %fileID=fopen('database.txt');
            %A=fread(fileID);
            set(handles.stReg, 'Visible', 'On');
            set(handles.stRegOutput, 'Visible', 'On', 'String', 'YES', 'ForegroundColor', 'green');
            set(handles.stID, 'Visible', 'On');
            set(handles.stIDOutput, 'Visible', 'On', 'String', num2str(IDNo), 'ForegroundColor', 'green');
            set(handles.recogRun, 'string', 'Run again', 'ForegroundColor', 'blue', 'enable', 'on');
            set(handles.clAtt, 'Visible', 'On');
            set(handles.clAttTot, 'Visible', 'On', 'String', num2str(CLAttended), 'ForegroundColor', 'green');
            dlmwrite('database.csv',T,'precision',10);
            dlmwrite(presentTodayData,todayPresent,'precision',10);
        end
    end
end
clear recObj myRecMat;
