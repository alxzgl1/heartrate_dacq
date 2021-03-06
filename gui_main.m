%-------------------------------------------------------------------------------
% Function
% Alexander Zhigalov | a.zhigalov@gmail.com
%-------------------------------------------------------------------------------
function gui_main()

% parameters
nMinIBI = 0.3; % seconds
nMaxIBI = 2.0; % seconds

fs = 1000; % sampling rate

% Version
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
% Buttons
global h_ButtonStart;
global h_ButtonStop;
% Popupmenu
global h_PopupmenuAcquisition;
% Check
global h_CheckTimeDomain;
global h_CheckFreqDomain;

% Global variables
global g_PopupmenuAcquisition;
global g_CheckTimeDomain;
global g_CheckFreqDomain;
global g_ButtonStart;
global g_ButtonStop;
g_PopupmenuAcquisition = 2; % offline (default)
g_CheckTimeDomain = 1;
g_CheckFreqDomain = 1;
g_ButtonStart = 0;
g_ButtonStop = 0;

% Global strings
c_PopupmenuAcquisition = 'Online|Offline';
g_EditLoadData = 'data_sample.txt';
g_EditSaveData = get_filename();
g_EditBandLow = '0.01-0.05';
g_EditBandMid = '0.05-0.08';
g_EditBandHigh = '0.08-0.12';
g_EditBufLen = '30';

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
% set(h_Main, 'CloseRequestFcn', 'gui_handler(''CloseMainFigure'')');

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
pos_w_edit = 220;
pos_h_edit = 21;
pos_l_edit = pos_frame(1) + 120;
% Edit 'LoadData'
pos_t_edit = pos_frame(4) - 150; 
h_EditLoadData = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', g_EditLoadData, ...
  'Style', 'edit');
% Edit 'SaveData'
pos_t_edit = pos_frame(4) - 200;
pos_l_edit = pos_frame(1) + 120;
h_EditSaveData = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', g_EditSaveData, ...
  'Style', 'edit');
% Edit 'BandLow'
pos_w_edit = 70;
pos_l_edit = pos_frame(1) + 40;
pos_t_edit = pos_frame(4) - 150; 
h_EditBandLow = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', g_EditBandLow, ...
  'Style', 'edit');
% Edit 'BandMid'
pos_l_edit = pos_frame(1) + 40;
pos_t_edit = pos_frame(4) - 175; 
h_EditBandMid = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', g_EditBandMid, ...
  'Style', 'edit');
% Edit 'BandHigh'
pos_l_edit = pos_frame(1) + 40;
pos_t_edit = pos_frame(4) - 200; 
h_EditBandHigh = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', g_EditBandHigh, ...
  'Style', 'edit');
% Edit 'BufLen'
pos_w_edit = 40;
pos_l_edit = pos_frame(1) + 410;
pos_t_edit = pos_frame(4) - 200; 
h_EditBufLen = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', g_EditBufLen, ...
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

% Popupmenu Objects
% Popupmenu 'Acquisition'
pos_h_popmenu = 23;
pos_t_popmenu = pos_frame(4) - 175 - 2;
pos_w_popmenu = 220;
pos_l_popmenu = pos_frame(1) + 120;
h_PopupmenuAcquisition = uicontrol('Parent', h_Main, ...
  'Callback', 'gui_handler PopupmenuAcquisition', ...
  'Position', [pos_l_popmenu pos_t_popmenu pos_w_popmenu pos_h_popmenu], ...
  'String', c_PopupmenuAcquisition, ...
  'Style', 'popupmenu', ...
  'Value', g_PopupmenuAcquisition);  

% Check Objects
pos_h_check = 14;
pos_w_check = 14;
pos_t_check = pos_frame(4) - 20;
% Check 'TimeDomain'
pos_l_check = pos_frame(1) + 40;
h_CheckTimeDomain = uicontrol('Parent', h_Main, ...
  'Callback', 'gui_handler CheckTimeDomain', ...
  'Position', [pos_l_check pos_t_check pos_w_check pos_h_check], ...
  'Style', 'checkbox', ...
  'Enable', 'off', ...
  'Value', g_CheckTimeDomain); 
% Check 'FreqDomain'
pos_l_check = pos_frame(1) + 370;
h_CheckFreqDomain = uicontrol('Parent', h_Main, ...
  'Callback', 'gui_handler CheckFreqDomain', ...
  'Position', [pos_l_check pos_t_check pos_w_check pos_h_check], ...
  'Style', 'checkbox', ...
  'Enable', 'off', ...
  'Value', g_CheckFreqDomain); 

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
pos_l_text = pos_frame(1) + 370;
uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_text pos_t_text pos_w_text pos_h_text], ...
	'FontWeight', 'bold', ...
  'String', 'BufLen', ...
  'Style', 'text');

% start acquisition
while g_ButtonStart == 0
  pause(0.001);
end

% ibit offline
bOffline = g_PopupmenuAcquisition == 2;

% init bands
x = g_EditBandLow; i = strfind(x, '-');  fBL1 = str2double(x(1:(i - 1))); fBL2 = str2double(x((i + 1):end));
x = g_EditBandMid; i = strfind(x, '-');  fBM1 = str2double(x(1:(i - 1))); fBM2 = str2double(x((i + 1):end));
x = g_EditBandHigh; i = strfind(x, '-'); fBH1 = str2double(x(1:(i - 1))); fBH2 = str2double(x((i + 1):end));

% init buffer length
nBufLen = str2double(g_EditBufLen); 

% init filenames
aLoadData = g_EditLoadData;
aSaveData = g_EditSaveData;

% raw data
pX = zeros(100000, 1); % ~12 hours
iX = 1;

% init
dt = 1 / fs;
pBufIBI = zeros(nBufLen, 1);
W = hann(nBufLen);

% check
if bOffline == 0
  a = arduino(); % create session
else
  % load(aLoadData); % FIXME
  pX_Offline = rand(100000, 1) * 0.25 + 0.5;
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
  if bOffline == 1
    % simulate IBI
    if cIBI_Offline == 0
      tIBI_Offline = pX_Offline(iIBI_Offline); 
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
    % guard intreval
    iIBI = nMinIBI;
    % add IBI to raw
    pX(iX) = tIBI;
    iX = iX + 1;
		% add IBI to buffer
		pBufIBI = [pBufIBI(2:end); tIBI];
		% PSD buffer
		pPsdIBI = abs(fft((pBufIBI - mean(pBufIBI)) .* W)) .^ 2;
    % plot
    plot(h_AxesTimeDomain, pBufIBI); set(h_AxesTimeDomain, 'XLim', [1, nBufLen], 'YLim', [0.0, 1.5]);
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
    pX = pX(iX);
    save(aSaveData, 'pX');
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

%--------------------------------------------------------------------------