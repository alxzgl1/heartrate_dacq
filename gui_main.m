%-------------------------------------------------------------------------------
% Function
% Alexander Zhigalov | a.zhigalov@gmail.com
%-------------------------------------------------------------------------------
function gui_main()

% parameters
nMinIBI = 0.3; % seconds
nMaxIBI = 2.0; % seconds

fs = 1000; % sampling rate

% Title
global g_SSCCaption;
g_SSCCaption = 'Dacq HR';
% Main 
global h_Main;  
% Axes
global h_AxesTimeDomain;
global h_AxesFreqDomain;
% Edit
global h_EditLoadData;
global h_EditSaveData;
global h_EditBandLow;
global h_EditBandMid;
global h_EditBandHigh;
global h_EditBufLen;
global h_EditYLim;
% Buttons
global h_ButtonStart;
global h_ButtonStop;
global h_ButtonUpdate;
% Popupmenu
global h_PopupmenuAcquisition;

% Global variables
global g_PopupmenuAcquisition;
global g_ButtonStart;
global g_ButtonStop;
global g_ButtonUpdate;
g_PopupmenuAcquisition = 2; % offline (default)
g_ButtonStart = 0;
g_ButtonStop = 0;
g_ButtonUpdate = 0;

% Global strings
c_PopupmenuAcquisition = 'Online|Offline';
c_EditLoadData = 'data_sample.txt';
c_EditSaveData = get_filename();
c_EditBandLow = '0.01-0.05';
c_EditBandMid = '0.05-0.08';
c_EditBandHigh = '0.08-0.12';
c_EditBufLen = '30';
c_EditYLim = '0-1.5';

% Configuration options
SCREENSIZE = get(0, 'ScreenSize');
WIDTH = 480;
HEIGHT = 220;
FIGURESIZE = [floor(SCREENSIZE(3) - WIDTH) / 2 ...
  floor(SCREENSIZE(4) - HEIGHT) / 2 ... 
  WIDTH ...
  HEIGHT];

% Main figure
h_Main = figure('PaperType', 'a4letter', ...
  'Name', g_SSCCaption, ...
  'Color', [0.875 0.875 0.875], ...
  'NumberTitle', 'off', ...
  'Position', FIGURESIZE, ...
  'MenuBar', 'none');
set(h_Main, 'Resize', 'off'); 

% Main window frame 
pos_frame = [0 0 WIDTH HEIGHT];

% Axes 
pos_h_axes = 80;
pos_t_axes = pos_frame(4) - 105; 
% Time domain 
pos_w_axes = 300;
pos_l_axes = pos_frame(1) + 40;
h_AxesTimeDomain = axes('Parent', h_Main, ...
  'Box', 'on', ...
  'Color', [1 1 1], ...
  'Units', 'pixels', ...
  'Position', [pos_l_axes pos_t_axes pos_w_axes pos_h_axes], ...
  'FontSize', 8);
% Freq domain 
pos_w_axes = 80;
pos_l_axes = pos_frame(1) + 370;
h_AxesFreqDomain = axes('Parent', h_Main, ...
  'Box', 'on', ...
  'Color', [1 1 1], ...
  'Units', 'pixels', ...
  'Position', [pos_l_axes pos_t_axes pos_w_axes pos_h_axes], ...
  'FontSize', 8);

% Edits Object
pos_w_edit = 160;
pos_h_edit = 21;
pos_l_edit = pos_frame(1) + 180;
% Edit 'LoadData'
pos_t_edit = pos_frame(4) - 150; 
h_EditLoadData = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', c_EditLoadData, ...
  'Style', 'edit');
% Edit 'SaveData'
pos_t_edit = pos_frame(4) - 175;
h_EditSaveData = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', c_EditSaveData, ...
  'Style', 'edit');
% Edit 'BandLow'
pos_w_edit = 70;
pos_l_edit = pos_frame(1) + 40;
pos_t_edit = pos_frame(4) - 150; 
h_EditBandLow = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', c_EditBandLow, ...
  'Style', 'edit');
% Edit 'BandMid'
pos_l_edit = pos_frame(1) + 40;
pos_t_edit = pos_frame(4) - 175; 
h_EditBandMid = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', c_EditBandMid, ...
  'Style', 'edit');
% Edit 'BandHigh'
pos_l_edit = pos_frame(1) + 40;
pos_t_edit = pos_frame(4) - 200; 
h_EditBandHigh = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', c_EditBandHigh, ...
  'Style', 'edit');
% Edit 'BufLen'
pos_w_edit = 25;
pos_l_edit = pos_frame(1) + 165;
pos_t_edit = pos_frame(4) - 200; 
h_EditBufLen = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', c_EditBufLen, ...
  'Style', 'edit');
% Edit 'YLim'
pos_w_edit = 45;
pos_l_edit = pos_frame(1) + 230;
pos_t_edit = pos_frame(4) - 200; 
h_EditYLim = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', c_EditYLim, ...
  'Style', 'edit');

% Buttons Objects
pos_w_button = 80;
pos_h_button = 23;
pos_l_button = pos_frame(1) + 370;
% Button 'OpenFiles'
pos_t_button = pos_frame(4) - 150;
h_ButtonStart = uicontrol('Parent', h_Main, ...
  'Callback', 'gui_handler ButtonStart', ...
  'Position', [pos_l_button pos_t_button pos_w_button pos_h_button], ...
  'String', 'Start');
% Button 'Stop'
pos_t_button = pos_frame(4) - 175;
h_ButtonStop = uicontrol('Parent', h_Main, ...
  'Callback', 'gui_handler ButtonStop', ...
  'Position', [pos_l_button pos_t_button pos_w_button pos_h_button], ...
  'String', 'Stop', ...
  'Enable', 'off');
% Button 'Update'
pos_t_button = pos_frame(4) - 200;
h_ButtonUpdate = uicontrol('Parent', h_Main, ...
  'Callback', 'gui_handler ButtonUpdate', ...
  'Position', [pos_l_button pos_t_button pos_w_button pos_h_button], ...
  'String', 'Update', ...
  'Enable', 'off');

% Popupmenu Objects
% Popupmenu 'Acquisition'
pos_h_popmenu = 23;
pos_t_popmenu = pos_frame(4) - 200 - 2;
pos_w_popmenu = 60;
pos_l_popmenu = pos_frame(1) + 280;
h_PopupmenuAcquisition = uicontrol('Parent', h_Main, ...
  'Callback', 'gui_handler PopupmenuAcquisition', ...
  'Position', [pos_l_popmenu pos_t_popmenu pos_w_popmenu pos_h_popmenu], ...
  'String', c_PopupmenuAcquisition, ...
  'Style', 'popupmenu', ...
  'Value', g_PopupmenuAcquisition);  

% Text Objects
% Text 'BandLow'
pos_h_text = 13;
pos_w_text = 18;
pos_t_text = pos_frame(4) - 150 + 4;
pos_l_text = pos_frame(1) + 20 - 2;
uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_text pos_t_text pos_w_text pos_h_text], ...
	'FontWeight', 'bold', ...
  'String', 'LF', ...
  'Style', 'text');
% Text 'BandMid'
pos_h_text = 13;
pos_w_text = 18;
pos_t_text = pos_frame(4) - 175 + 4;
pos_l_text = pos_frame(1) + 20 - 2;
uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_text pos_t_text pos_w_text pos_h_text], ...
	'FontWeight', 'bold', ...
  'String', 'MF', ...
  'Style', 'text');
% Text 'BandHigh'
pos_h_text = 13;
pos_w_text = 18;
pos_t_text = pos_frame(4) - 200 + 4;
pos_l_text = pos_frame(1) + 20 - 2;
uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_text pos_t_text pos_w_text pos_h_text], ...
	'FontWeight', 'bold', ...
  'String', 'HF', ...
  'Style', 'text');
% Text 'BufLen'
pos_h_text = 13;
pos_w_text = 40;
pos_t_text = pos_frame(4) - 200 + 4;
pos_l_text = pos_frame(1) + 120;
uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_text pos_t_text pos_w_text pos_h_text], ...
	'FontWeight', 'bold', ...
  'String', 'BufLen', ...
  'Style', 'text');
% Text 'YLim'
pos_h_text = 13;
pos_w_text = 35;
pos_t_text = pos_frame(4) - 200 + 4;
pos_l_text = pos_frame(1) + 195;
uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_text pos_t_text pos_w_text pos_h_text], ...
	'FontWeight', 'bold', ...
  'String', 'YLim', ...
  'Style', 'text');

% Text 'LoadData'
pos_h_text = 13;
pos_w_text = 55;
pos_t_text = pos_frame(4) - 150 + 4;
pos_l_text = pos_frame(1) + 120;
uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_text pos_t_text pos_w_text pos_h_text], ...
	'FontWeight', 'bold', ...
  'String', 'Load data', ...
  'Style', 'text');
% Text 'SaveData'
pos_h_text = 13;
pos_w_text = 55;
pos_t_text = pos_frame(4) - 175 + 4;
pos_l_text = pos_frame(1) + 120;
uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_text pos_t_text pos_w_text pos_h_text], ...
	'FontWeight', 'bold', ...
  'String', 'Save data', ...
  'Style', 'text');


% start acquisition
while g_ButtonStart == 0
  pause(0.001);
end

% get parameters
iAcquisition = get(h_PopupmenuAcquisition, 'Value');
aLoadData = get(h_EditLoadData, 'String');
aSaveData = get(h_EditSaveData, 'String');

% init online/offline
bOffline = iAcquisition == 2;

% update parameters
[pBands, pYLim] = update_parameters(get(h_EditBandLow, 'String'), ...
  get(h_EditBandMid, 'String'), get(h_EditBandHigh, 'String'), get(h_EditYLim, 'String'));

% init buffer length
nBufLen = str2double(get(h_EditBufLen, 'String')); 

% raw data
pRawIBI = zeros(100000, 1); % ~12 hours
iRawIBI = 1;

% init
dt = 1 / fs;
pBufIBI = zeros(nBufLen, 1);
W = hann(nBufLen);

% check
if bOffline == 0
  a = arduino(); % create session
else
  % load(aLoadData); % FIXME
  pRawIBI_Offline = rand(100000, 1) * 0.25 + 0.5;
  iIBI_Offline = 1; % counter
  cIBI_Offline = 0; % countdown
end

% open udp
u = udp('127.0.0.1', 7400);  
fopen(u);

% loop
tic;
iIBI = 0;
f = linspace(0, 1, nBufLen);
while 1
  % update parameters
  if g_ButtonUpdate == 1
    g_ButtonUpdate = 0;
    [pBands, pYLim] = update_parameters(get(h_EditBandLow, 'String'), ...
      get(h_EditBandMid, 'String'), get(h_EditBandHigh, 'String'), get(h_EditYLim, 'String'));
  end
  % data acquisition
  if bOffline == 1
    % generate IBI
    if cIBI_Offline == 0
      tIBI_Offline = pRawIBI_Offline(iIBI_Offline); 
      cIBI_Offline = tIBI_Offline;
    end
    cIBI_Offline = cIBI_Offline - dt;
    % get data
    data = 0; if cIBI_Offline < 0, data = 1; cIBI_Offline = 0; iIBI_Offline = iIBI_Offline + 1; end
  else
    % read
    if iIBI > 0 % min IBI
      iIBI = iIBI - dt; 
      data = 0;
    else
      data = readDigitalPin(a, 'D10'); % scan input 'D10'
    end
  end
  % add beat to buffer and process
	if data == 1 % beat received
    tIBI = toc;
    tic;
    % guard interval
    iIBI = nMinIBI;
    % add IBI to raw
    pRawIBI(iRawIBI) = tIBI;
    iRawIBI = iRawIBI + 1;
		% add IBI to buffer
		pBufIBI = [pBufIBI(2:end); tIBI];
		% PSD buffer
		pPsdIBI = abs(fft((pBufIBI - mean(pBufIBI)) .* W)) .^ 2;
    % plot
    plot(h_AxesTimeDomain, pBufIBI); set(h_AxesTimeDomain, 'XLim', [1, nBufLen], 'YLim', pYLim);
    plot(h_AxesFreqDomain, f, pPsdIBI); set(h_AxesFreqDomain, 'XLim', [0, 0.5]);
    drawnow;
		% send control parameter via UDP
		oscsend(u, '', 'f', tIBI);
  end
  % idle
  pause(dt); % should be 0.001 s
  
  % stop
  if g_ButtonStop == 1
    % save data
    pRawIBI = pRawIBI(1:iRawIBI);
    save_data(aSaveData, pRawIBI);
    % close
    close all;
    return
  end
end

end % end

%-------------------------------------------------------------------------------
% Function
%-------------------------------------------------------------------------------
function aFilename = get_filename()

t = datetime(); 
aFilename = sprintf('R_%02d%02d%02d%02d.txt', month(t), day(t), hour(t), minute(t));

end % end

%-------------------------------------------------------------------------------
% Function
%-------------------------------------------------------------------------------
function save_data(aFilename, X)

hFile = fopen(aFilename, 'w');
for i = 1:length(X)
  fprintf(hFile, '%1.4f\n', X(i));
end
fclose(hFile);

end % end

%-------------------------------------------------------------------------------
% Function
%-------------------------------------------------------------------------------
function [pBands, pYLim] = update_parameters(aBandLow, aBandMid, aBandHigh, aYLim)

x = aBandLow; i = strfind(x, '-'); pBL = [str2double(x(1:(i - 1))), str2double(x((i + 1):end))];
x = aBandMid; i = strfind(x, '-'); pBM = [str2double(x(1:(i - 1))), str2double(x((i + 1):end))];
x = aBandHigh; i = strfind(x, '-'); pBH = [str2double(x(1:(i - 1))), str2double(x((i + 1):end))];
pBands = [pBL; pBM; pBH];
x = aYLim; i = strfind(x, '-'); pYLim = [str2double(x(1:(i - 1))), str2double(x((i + 1):end))];

end % end

%--------------------------------------------------------------------------