%-------------------------------------------------------------------------------
% Function
% Alexander Zhigalov | a.zhigalov@bham.ac.uk
%-------------------------------------------------------------------------------
function gui_main()

% parameters
nMinIBI = 0.3; % seconds
nMaxIBI = 2.0; % seconds
nBinIBI = 0.01; % seconds

fs = 1000; % sampling rate

% default settings
c_EditLoadData = 'data_sample.txt';
c_EditSaveData = get_filename();
c_EditBandLow_S = '0.05-0.08';
c_EditBandMid_S = '0.08-0.12';
c_EditBandHigh_S = '0.12-0.20';
c_EditBandLow_H = '1.2-2.0';
c_EditBandMid_H = '0.8-1.2';
c_EditBandHigh_H = '0.3-0.8';
c_EditBufLen = '30';
c_EditTYLim = '0-1.5';
c_EditFYLim = '0-1.0';

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
global h_EditTYLim;
global h_EditFYLim;
% Buttons
global h_ButtonStart;
global h_ButtonStop;
global h_ButtonUpdate;
% Popupmenu
global h_PopupmenuAcquisition;
global h_PopupmenuAnalysis;

% Global variables
global g_PopupmenuAcquisition;
global g_PopupmenuAnalysis;
global g_ButtonStart;
global g_ButtonStop;
global g_ButtonUpdate;
g_PopupmenuAcquisition = 2; % offline (default)
g_PopupmenuAnalysis = 1; % spectra (default)
g_ButtonStart = 0;
g_ButtonStop = 0;
g_ButtonUpdate = 0;

% Global strings
c_PopupmenuAcquisition = 'Online|Offline';
c_PopupmenuAnalysis = 'Spectra|Histogram';

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
	'String', c_EditBandLow_S, ...
  'Style', 'edit');
% Edit 'BandMid'
pos_l_edit = pos_frame(1) + 40;
pos_t_edit = pos_frame(4) - 175; 
h_EditBandMid = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', c_EditBandMid_S, ...
  'Style', 'edit');
% Edit 'BandHigh'
pos_l_edit = pos_frame(1) + 40;
pos_t_edit = pos_frame(4) - 200; 
h_EditBandHigh = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', c_EditBandHigh_S, ...
  'Style', 'edit');
% Edit 'BufLen'
pos_w_edit = 25;
pos_l_edit = pos_frame(1) + 180;
pos_t_edit = pos_frame(4) - 200; 
h_EditBufLen = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', c_EditBufLen, ...
  'Style', 'edit');
% Edit 'TYLim'
pos_w_edit = 50;
pos_l_edit = pos_frame(1) + 290 + 1;
pos_t_edit = pos_frame(4) - 20 - 3; 
h_EditTYLim = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', c_EditTYLim, ...
  'Style', 'edit');
% Edit 'FYLim'
pos_w_edit = 50;
pos_l_edit = pos_frame(1) + 400;
pos_t_edit = pos_frame(4) - 20 - 3; 
h_EditFYLim = uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_edit pos_t_edit pos_w_edit pos_h_edit], ...
	'String', c_EditFYLim, ...
  'Style', 'edit', ...
  'Enable', 'off');

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
pos_w_popmenu = 55;
pos_l_popmenu = pos_frame(1) + 210;
h_PopupmenuAcquisition = uicontrol('Parent', h_Main, ...
  'Callback', 'gui_handler PopupmenuAcquisition', ...
  'Position', [pos_l_popmenu pos_t_popmenu pos_w_popmenu pos_h_popmenu], ...
  'String', c_PopupmenuAcquisition, ...
  'Style', 'popupmenu', ...
  'Value', g_PopupmenuAcquisition);  
% Popupmenu 'Analysis'
pos_h_popmenu = 23;
pos_t_popmenu = pos_frame(4) - 200 - 2;
pos_w_popmenu = 70;
pos_l_popmenu = pos_frame(1) + 270;
h_PopupmenuAnalysis = uicontrol('Parent', h_Main, ...
  'Callback', 'gui_handler PopupmenuAnalysis', ...
  'Position', [pos_l_popmenu pos_t_popmenu pos_w_popmenu pos_h_popmenu], ...
  'String', c_PopupmenuAnalysis, ...
  'Style', 'popupmenu', ...
  'Value', g_PopupmenuAnalysis); 

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
pos_l_text = pos_frame(1) + 135;
uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_text pos_t_text pos_w_text pos_h_text], ...
	'FontWeight', 'bold', ...
  'String', 'BufLen', ...
  'Style', 'text');
% Text 'TYLim'
pos_h_text = 13;
pos_w_text = 30;
pos_t_text = pos_frame(4) - 20 + 1; 
pos_l_text = pos_frame(1) + 260;
uicontrol('Parent', h_Main, ...
  'BackgroundColor', get(h_Main, 'Color'), ...
  'HorizontalAlignment', 'left', ...
  'Position', [pos_l_text pos_t_text pos_w_text pos_h_text], ...
	'FontWeight', 'bold', ...
  'String', 'YLim', ...
  'Style', 'text');
% Text 'FYLim'
pos_h_text = 13;
pos_w_text = 30;
pos_t_text = pos_frame(4) - 20 + 1; 
pos_l_text = pos_frame(1) + 370;
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
[pBands, pTYLim, pFYLim] = update_parameters(get(h_EditBandLow, 'String'), ...
  get(h_EditBandMid, 'String'), get(h_EditBandHigh, 'String'), ...
  get(h_EditTYLim, 'String'), get(h_EditFYLim, 'String'));
    
% init buffer length
nBufLen = str2double(get(h_EditBufLen, 'String')); 

% raw data
pSamples = zeros(100000, 12); % ~12 hours
iSamples = 1;

% init
dt = 1 / fs;
pBufIBI = zeros(nBufLen, 1);

% check
if bOffline == 0
  a = arduino(); % create session
else
  if ~isempty(aLoadData)
  	x = load(aLoadData); pSamples_Offline = x(:, 1);
  else
    % random
    % pSamples_Offline = rand(100000, 1) * 0.25 + 0.5;
    % sin
    f0 = 0.1;
    pSamples_Offline = 0.5 * sin(2 * pi * f0 * (1:100000))' + 0.8;
  end
  iIBI_Offline = 1; % counter
  cIBI_Offline = 0; % countdown
end

% open udp
u = udp('127.0.0.1', 7400);  
fopen(u);

% histogram parameters
pBins = nMinIBI:nBinIBI:nMaxIBI;
nBins = length(pBins);
BL = repmat(pBins(1:(end - 1))', 1, nBufLen);
BH = repmat(pBins(2:end)', 1, nBufLen);

% loop
tic;
iIBI = 0;
while 1
  % update parameters
  if g_ButtonUpdate == 1
    g_ButtonUpdate = 0;
    [pBands, pTYLim, pFYLim] = update_parameters(get(h_EditBandLow, 'String'), ...
      get(h_EditBandMid, 'String'), get(h_EditBandHigh, 'String'), ...
      get(h_EditTYLim, 'String'), get(h_EditFYLim, 'String'));
  end
  % data acquisition
  if bOffline == 1
    % generate IBI
    if cIBI_Offline == 0
      tIBI_Offline = pSamples_Offline(iIBI_Offline); 
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
		% add IBI to buffer
		pBufIBI = [pBufIBI(2:end); tIBI];
		% analysis
    if g_PopupmenuAnalysis == 1 % spectra
      f = linspace(0, 1, sum(pBufIBI(pBufIBI ~= 0)));
      fRangeL = f >= pBands(1, 1) & f < pBands(1, 2); 
      fRangeM = f >= pBands(2, 1) & f < pBands(2, 2); 
      fRangeH = f >= pBands(3, 1) & f < pBands(3, 2); 
      pX_IBI = abs(fft(pBufIBI - mean(pBufIBI), length(f))) .^ 2;
      pFXLim = [0.01, 0.25];
    else % histogram 
      f = pBins(1:(end - 1));
      fRangeL = f >= pBands(1, 1) & f < pBands(1, 2); 
      fRangeM = f >= pBands(2, 1) & f < pBands(2, 2); 
      fRangeH = f >= pBands(3, 1) & f < pBands(3, 2); 
      pX_IBI = get_histogram(pBufIBI, BL, BH, nBins); 
      pFXLim = [nMinIBI, nMaxIBI];
    end
    % init bands
    yX_L = mean(pX_IBI(fRangeL));
    yX_M = mean(pX_IBI(fRangeM)); 
    yX_H = mean(pX_IBI(fRangeH)); 
    fX_L = mean(f(fRangeL)); 
    fX_M = mean(f(fRangeM)); 
    fX_H = mean(f(fRangeH)); 
    % init output
    pSamples(iSamples, 1) = tIBI;
    pSamples(iSamples, 2) = yX_L; 
    pSamples(iSamples, 3) = yX_M; 
    pSamples(iSamples, 4) = yX_H; 
    pSamples(iSamples, 5) = pBands(1, 1);
    pSamples(iSamples, 6) = pBands(1, 2);
    pSamples(iSamples, 7) = pBands(2, 1);
    pSamples(iSamples, 8) = pBands(2, 2);
    pSamples(iSamples, 9) = pBands(3, 1);
    pSamples(iSamples, 10) = pBands(3, 2);
    pSamples(iSamples, 11) = nBufLen;
    pSamples(iSamples, 12) = g_PopupmenuAnalysis;
    iSamples = iSamples + 1;
    % plot
    plot(h_AxesTimeDomain, pBufIBI, 'Color', 'k', 'LineWidth', 1, 'Marker', 'o', 'LineStyle', '-.'); set(h_AxesTimeDomain, 'XLim', [1, nBufLen], 'YLim', pTYLim);
    plot(h_AxesFreqDomain, f, pX_IBI, 'Color', [0.75, 0.75, 0.75], 'LineWidth', 1); set(h_AxesFreqDomain, 'XLim', pFXLim); 
    hold on;
    plot(h_AxesFreqDomain, fX_L, yX_L, 'Marker', 'o', 'LineWidth', 2, 'Color', [1.0, 0.5, 0.0]); 
    plot(h_AxesFreqDomain, fX_M, yX_M, 'Marker', 'o', 'LineWidth', 2, 'Color', [0.0, 0.5, 0.0]); 
    plot(h_AxesFreqDomain, fX_H, yX_H, 'Marker', 'o', 'LineWidth', 2, 'Color', [0.0, 0.5, 1.0]); 
    hold off;
    drawnow;
		% send control parameter via UDP
		oscsend(u, '', 'fff', yX_L, yX_M, yX_H);
  end
  % idle
  pause(dt); % should be 0.001 s
  
  % stop
  if g_ButtonStop == 1
    % save data
    pSamples = pSamples(1:iSamples, :);
    save_data(aSaveData, pSamples);
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
for i = 1:size(X, 1)
  for j = 1:size(X, 2)
    fprintf(hFile, '%1.4f\t', X(i, j));
  end
  fprintf(hFile, '\n');
end
fclose(hFile);

end % end

%-------------------------------------------------------------------------------
% Function
%-------------------------------------------------------------------------------
function [pBands, pTYLim, pFYLim] = update_parameters(aBandLow, aBandMid, aBandHigh, aTYLim, aFYLim)

x = aBandLow; i = strfind(x, '-'); pBL = [str2double(x(1:(i - 1))), str2double(x((i + 1):end))];
x = aBandMid; i = strfind(x, '-'); pBM = [str2double(x(1:(i - 1))), str2double(x((i + 1):end))];
x = aBandHigh; i = strfind(x, '-'); pBH = [str2double(x(1:(i - 1))), str2double(x((i + 1):end))];
pBands = [pBL; pBM; pBH];
x = aTYLim; i = strfind(x, '-'); pTYLim = [str2double(x(1:(i - 1))), str2double(x((i + 1):end))];
x = aFYLim; i = strfind(x, '-'); pFYLim = [str2double(x(1:(i - 1))), str2double(x((i + 1):end))];

end % end

%-------------------------------------------------------------------------------
% Function
%-------------------------------------------------------------------------------
function H = get_histogram(pBufIBI, BL, BH, nBins)

% reshape data
Y = repmat(pBufIBI', nBins - 1, 1);

% get histogram
H = sum(Y >= BL & Y < BH, 2);

end % end

%--------------------------------------------------------------------------