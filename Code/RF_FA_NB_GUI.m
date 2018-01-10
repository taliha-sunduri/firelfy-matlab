function varargout = RF_FA_NB_GUI(varargin)
% RF_FA_NB_GUI MATLAB code for RF_FA_NB_GUI.fig
%      RF_FA_NB_GUI, by itself, creates a new RF_FA_NB_GUI or raises the existing
%      singleton*.
%
%      H = RF_FA_NB_GUI returns the handle to a new RF_FA_NB_GUI or the handle to
%      the existing singleton*.
%
%      RF_FA_NB_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RF_FA_NB_GUI.M with the given input arguments.
%
%      RF_FA_NB_GUI('Property','Value',...) creates a new RF_FA_NB_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RF_FA_NB_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RF_FA_NB_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RF_FA_NB_GUI

% Last Modified by GUIDE v2.5 09-Jan-2017 01:01:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RF_FA_NB_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @RF_FA_NB_GUI_OutputFcn, ...
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


% --- Executes just before RF_FA_NB_GUI is made visible.
function RF_FA_NB_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RF_FA_NB_GUI (see VARARGIN)

% Choose default command line output for RF_FA_NB_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RF_FA_NB_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RF_FA_NB_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in runButton.
function runButton_Callback(hObject, eventdata, handles)
% hObject    handle to runButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.out=MyCode_BinaryFireflyGUI(handles.params);
guidata(hObject,handles);
selectedGenesEdit_Callback(hObject, eventdata, handles);
accuracyEdit_Callback(hObject, eventdata, handles);
bestAccEdit_Callback(hObject, eventdata, handles);
plot(handles.out.graph,'LineWidth',2);
% semilogy(bfitFunc,'LineWidth',2);
xlabel('Iteration');
ylabel('Error Rate');
grid on;

function selectedGenesEdit_Callback(hObject, eventdata, handles)
% hObject    handle to selectedGenesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of selectedGenesEdit as text
%        str2double(get(hObject,'String')) returns contents of selectedGenesEdit as a double
string1=handles.out.selectedGenes;
set(handles.selectedGenesEdit, 'Max', 2);
set(handles.selectedGenesEdit,'String',num2str(string1),'FontSize',10);

% --- Executes during object creation, after setting all properties.
function selectedGenesEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectedGenesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function accuracyEdit_Callback(hObject, eventdata, handles)
% hObject    handle to accuracyEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accuracyEdit as text
%        str2double(get(hObject,'String')) returns contents of accuracyEdit as a double
string2=handles.out.Accuracy;
set(handles.accuracyEdit, 'Max', 2);
set(handles.accuracyEdit,'String',num2str(string2),'FontSize',10);

% --- Executes during object creation, after setting all properties.
function accuracyEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accuracyEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gammaEdit_Callback(hObject, eventdata, handles)
% hObject    handle to gammaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gammaEdit as text
%        str2double(get(hObject,'String')) returns contents of gammaEdit as a double
 handles.params.gamma= str2double(get(hObject,'String'));
 if isnan(handles.params.gamma)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
%  else
%     display(handles.params.gamma);
 end
 guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function gammaEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gammaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alphaEdit_Callback(hObject, eventdata, handles)
% hObject    handle to alphaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alphaEdit as text
%        str2double(get(hObject,'String')) returns contents of alphaEdit as a double
handles.params.alpha= str2double(get(hObject,'String'));
 if isnan(handles.params.alpha)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
%  else
%     display(handles.params.alpha);
 end
 guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function alphaEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alphaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alphaDampEdit_Callback(hObject, eventdata, handles)
% hObject    handle to alphaDampEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alphaDampEdit as text
%        str2double(get(hObject,'String')) returns contents of alphaDampEdit as a double
handles.params.alphaCh= str2double(get(hObject,'String'));
 if isnan(handles.params.alphaCh)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
%  else
%     display(handles.params.alphaCh);
 end
 guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function alphaDampEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alphaDampEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function beta0Edit_Callback(hObject, eventdata, handles)
% hObject    handle to beta0Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beta0Edit as text
%        str2double(get(hObject,'String')) returns contents of beta0Edit as a double
handles.params.beta0= str2double(get(hObject,'String'));
 if isnan(handles.params.beta0)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
%  else
%     display(handles.params.beta0);
 end
 guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function beta0Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta0Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function fireflyNoEdit_Callback(hObject, eventdata, handles)
% hObject    handle to fireflyNoEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fireflyNoEdit as text
%        str2double(get(hObject,'String')) returns contents of fireflyNoEdit as a double
handles.params.nF= str2double(get(hObject,'String'));
 if isnan(handles.params.nF)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
%  else
%     display(handles.params.nF);
 end
 guidata(hObject,handles);
 
% --- Executes during object creation, after setting all properties.
function fireflyNoEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fireflyNoEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function iterationNoEdit_Callback(hObject, eventdata, handles)
% hObject    handle to iterationNoEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterationNoEdit as text
%        str2double(get(hObject,'String')) returns contents of iterationNoEdit as a double
handles.params.nItr= str2double(get(hObject,'String'));
 if isnan(handles.params.nItr)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
%  else
%     display(handles.params.nItr);
 end
 guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function iterationNoEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterationNoEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function datasetEdit_Callback(hObject, eventdata, handles)
% hObject    handle to datasetEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of datasetEdit as text
%        str2double(get(hObject,'String')) returns contents of datasetEdit as a double
handles.params.infile = get(hObject,'String');
guidata(hObject,handles);
% if  ~isstring(f1)
%     % Disable the Plot button and change its string to say why
%     set(handles.runButton,'String','Cannot plot f1');
%     set(handles.runButton,'Enable','off');
%     % Give the edit text box focus so user can correct the error
%     uicontrol(hObject);
% else 
%     % Enable the Plot button with its original name
%     set(handles.runButton,'String','Plot');
%     set(handles.runButton,'Enable','on');
% end

% --- Executes during object creation, after setting all properties.
function datasetEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to datasetEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function seedEdit_Callback(hObject, eventdata, handles)
% hObject    handle to seedEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seedEdit as text
%        str2double(get(hObject,'String')) returns contents of seedEdit as a double
 handles.params.rNo= str2double(get(hObject,'String'));
 if isnan(handles.params.rNo)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
%  else
%     display(handles.params.rNo);
 end
 guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function seedEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seedEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function treeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to treeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of treeEdit as text
%        str2double(get(hObject,'String')) returns contents of treeEdit as a double
handles.params.treeNo= str2double(get(hObject,'String'));
 if isnan(handles.params.treeNo)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
%  else
%     display(handles.params.treeNo);
 end
 guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function treeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to treeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function impGenes_Callback(hObject, eventdata, handles)
% hObject    handle to impGenes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of impGenes as text
%        str2double(get(hObject,'String')) returns contents of impGenes as a double
handles.params.jNo= str2double(get(hObject,'String'));
 if isnan(handles.params.jNo)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
%  else
%     display(handles.params.jNo);
 end
 guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function impGenes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to impGenes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function omegaEdit_Callback(hObject, eventdata, handles)
% hObject    handle to omegaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of omegaEdit as text
%        str2double(get(hObject,'String')) returns contents of omegaEdit as a double
handles.params.omega = str2double(get(hObject,'String'));
 if isnan(handles.params.omega)
    errordlg('You must enter a numeric value','Invalid Input','modal')
    uicontrol(hObject)
    return
%  else
%     display(handles.params.omega);
 end
 guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function omegaEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to omegaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bestAccEdit_Callback(hObject, eventdata, handles)
% hObject    handle to bestAccEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bestAccEdit as text
%        str2double(get(hObject,'String')) returns contents of bestAccEdit as a double
string4=handles.out.best;
set(handles.bestAccEdit, 'Max', 2);
set(handles.bestAccEdit,'String',string4,'FontSize',10);

% --- Executes during object creation, after setting all properties.
function bestAccEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bestAccEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkBox.
function checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkBox
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.params.showItr=true;
    guidata(hObject,handles);
% else
% 	display('Not selected');
end
