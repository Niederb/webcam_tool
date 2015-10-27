function varargout = webcam_tool(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @webcam_tool_OpeningFcn, ...
                   'gui_OutputFcn',  @webcam_tool_OutputFcn, ...
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

function webcam_tool_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
handles.callback_function = varargin{1};
if (size(varargin, 2) == 2) && ischar(varargin{2}) && strcmp(varargin{2}, 'camera')
    handles.image_mode = 0;
    handles.webcam_mode = 0;
    handles.camera_mode = 1;
elseif (size(varargin, 2) == 2) && ischar(varargin{2}) && strcmp(varargin{2}, 'webcam')
    handles.image_mode = 0;
    handles.webcam_mode = 1;
    handles.camera_mode = 0;
    %handles.webcam = webcam();
    %handles.timer = timer('StartDelay', .1, 'Period', 0.1, 'TimerFcn', {@next_image, handles},...
    %  'ExecutionMode', 'fixedRate');
    %start(handles.timer);
elseif (size(varargin, 2) == 2)
    handles.image = varargin{2};
    handles.image_mode = 1;
    handles.webcam_mode = 0;
    handles.camera_mode = 0;
    set(handles.startbutton, 'visible', 'off');
    set(handles.n_frames, 'visible', 'off');
    set(handles.label_n_frames, 'visible', 'off');
    update_image(handles.image, handles)

end

% Update handles structure
guidata(hObject, handles);

function varargout = webcam_tool_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function cb1_Callback(hObject, eventdata, handles)
if (handles.image_mode == 1)
   update_image(handles.image, handles);
end

function cb2_Callback(hObject, eventdata, handles)
if (handles.image_mode == 1)
   update_image(handles.image, handles);
end

function p1_Callback(hObject, eventdata, handles)
if (handles.image_mode == 1)
   update_image(handles.image, handles);
end

function p1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function p2_Callback(hObject, eventdata, handles)
if (handles.image_mode == 1)
   update_image(handles.image, handles);
end

function p2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function p3_Callback(hObject, eventdata, handles)
if (handles.image_mode == 1)
   update_image(handles.image, handles);
end

function p3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function startbutton_Callback(hObject, eventdata, handles)
if (handles.camera_mode == 1)
    cam = get_camera_object();
elseif (handles.webcam_mode == 1)
    cam = webcam();
end
n_images = round(get(handles.n_frames, 'value'));
%try
    for i=1:n_images
        if (handles.camera_mode == 1)
            rgbImage = peekdata(cam,1);
        elseif (handles.webcam_mode == 1) 
            rgbImage = snapshot(cam);
        end
        update_image(rgbImage, handles);
    end
%catch e; end
if (handles.camera_mode == 1)
    stop(cam);
end

function vid = get_camera_object()
if ~exist('vid')
	vid = videoinput('gentl', 1);
%     vid = videoinput('winvideo', 1);
end
stop(vid);
triggerconfig(vid, 'manual');

src = getselectedsource(vid);
% src.BacklightCompensation = 'off';
% src.ExposureMode = 'manual';
% src.Exposure = -6;
% src.FocusMode = 'manual';
% src.Focus = 50;
% src.WhiteBalanceMode = 'manual';
% src.WhiteBalance = 4000;
start(vid);
pause(0.2)

function update_image(image, handles)
   % Acquire a single image.   
   p1_val = get(handles.p1,'value');
   p2_val = get(handles.p2,'value');
   p3_val = get(handles.p3,'value');
   set(handles.labelp1, 'string', p1_val);
   set(handles.labelp2, 'string', p2_val);
   set(handles.labelp3, 'string', p3_val);
   cb1_val = get(handles.cb1,'value');
   cb2_val = get(handles.cb2,'value');
   
   %axes(handles.output_axes);
   handles.callback_function(image, cb1_val, cb2_val, p1_val, p2_val, p3_val);

   % Display the image.

   drawnow


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)

delete(hObject);

% --- Executes on slider movement.
function n_frames_Callback(hObject, eventdata, handles)
%# frames: 50
val = get(handles.n_frames, 'value');
set(handles.label_n_frames, 'string', ['# frames: ' int2str(val)]);


% --- Executes during object creation, after setting all properties.
function n_frames_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
