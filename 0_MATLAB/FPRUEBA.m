function varargout = FPRUEBA(varargin)
% FPRUEBA MATLAB code for FPRUEBA.fig
%      FPRUEBA, by itself, creates a new FPRUEBA or raises the existing
%      singleton*.
%
%      H = FPRUEBA returns the handle to a new FPRUEBA or the handle to
%      the existing singleton*.
%
%      FPRUEBA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FPRUEBA.M with the given input arguments.
%
%      FPRUEBA('Property','Value',...) creates a new FPRUEBA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FPRUEBA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FPRUEBA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FPRUEBA

% Last Modified by GUIDE v2.5 09-Aug-2024 17:55:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FPRUEBA_OpeningFcn, ...
                   'gui_OutputFcn',  @FPRUEBA_OutputFcn, ...
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


% --- Executes just before FPRUEBA is made visible.
function FPRUEBA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FPRUEBA (see VARARGIN)

% Choose default command line output for FPRUEBA
handles.output = hObject;

% Initialize the global variables
global puerto baudios_srt;
puerto = '';
baudios_srt = '';

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FPRUEBA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FPRUEBA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
    



% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end


function pushbutton1_Callback(hObject, eventdata, handles)
    % Verificar si los valores seleccionados en los menús desplegables son válidos
    %global puerto baudios_srt;
    popup2_value = get(handles.popupmenu2, 'Value');
    popup2_string = get(handles.popupmenu2, 'String');
    baudios_srt = popup2_string{popup2_value};
    
    popup1_value = get(handles.popupmenu1, 'Value');
    popup1_string = get(handles.popupmenu1, 'String');
    puerto = popup1_string{popup1_value}; 

    if ~isempty(puerto) && ~isempty(baudios_srt)
        % Abrir el puerto serial
        clc
        
        if ~isempty(instrfind)
            fclose(instrfind);
            delete(instrfind);
        end
        
        data = serial(puerto);
        set(data, 'DataBits', 8);
        set(data, 'StopBits', 1);
        set(data, 'BaudRate', str2double(baudios_srt));
        set(data, 'Parity', 'none');
        fopen(data);
        
        % Mostrar los valores seleccionados
        disp(['CONEXIÓN EXITOSA']);
        disp(['PUERTO: ', puerto]);
        disp(['BAUDIOS: ', baudios_srt]);
        
        fwrite(data, ['Conexón exitosa  ---  ' ' Puerto: ' puerto ' Baudios: ' baudios_srt]);
        fwrite(data, '\n');
    else
        % Mostrar mensaje de error si no se han seleccionado opciones
        errordlg('Please select both a port and a baud rate.', 'Selection Error');
    end


