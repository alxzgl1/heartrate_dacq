%-------------------------------------------------------------------------------
% Function
%-------------------------------------------------------------------------------
function gui_handler(action)

% Global handles
% Main 
global h_Main;  
% Edit
global h_EditLoadData;
global h_EditSaveData;
global h_EditBandLow;
global h_EditBandMid;
global h_EditBandHigh;
% Buttons
global h_ButtonStart;
global h_ButtonStop;
% Popupmenu
global h_PopupmenuAcquisition;
% Check
global h_CheckTimeDomain;
global h_CheckFreqDomain;

% Global strings
global g_EditLoadData;
global g_EditSaveData;
global g_EditBandLow;
global g_EditBandMid;
global g_EditBandHigh;
global g_EditBufLen;

% Global variables
global g_PopupmenuAcquisition;
global g_CheckTimeDomain;
global g_CheckFreqDomain;
global g_ButtonStart;
global g_ButtonStop;

% Action
switch action
	% Button 'Start'
  case 'ButtonStart'
    % init
    g_EditBandLow = get(h_EditBandLow, 'Value');
    g_EditBandMid = get(h_EditBandMid, 'Value');
    g_EditBandHigh = get(h_EditBandHigh, 'Value');
    g_EditLoadData = get(h_EditLoadData, 'Value');
    g_EditSaveData = get(h_EditSaveData, 'Value');
    g_PopupmenuAcquisition = get(h_PopupmenuAcquisition, 'Value');
    % enable 
    set(h_ButtonStop, 'Enable', 'on');
		% disable
		set(h_ButtonStart, 'Enable', 'off');
    set(h_PopupmenuAcquisition, 'Enable', 'off');
    set(h_EditBandLow, 'Enable', 'off');
    set(h_EditBandMid, 'Enable', 'off');
    set(h_EditBandHigh, 'Enable', 'off');
    set(h_EditLoadData, 'Enable', 'off');
    set(h_EditSaveData, 'Enable', 'off');
		% set
    g_ButtonStart = 1;
		
	% Button 'Stop'
  case 'ButtonStop'
		g_ButtonStop = 1;
		
	% Popupmenu 'Acquisition'
	case 'PopupmenuAcquisition'
		g_PopupmenuAcquisition = get(h_PopupmenuAcquisition, 'Value');	
		
	% Check 'TimeDomain'	
	case 'CheckTimeDomain'
		g_CheckTimeDomain = get(h_CheckTimeDomain, 'Value');
    
  % Check 'FreqDomain'	
	case 'CheckFreqDomain'
		g_CheckFreqDomain = get(h_CheckFreqDomain, 'Value');
		
  % Close main figure
  case 'CloseMainFigure'
		% Edits
		% delete(h_EditOutFile);
		% Buttons
		% delete(h_ButtonOpenFiles);
		% delete(h_ButtonRunGroup);
		% Popupmenus
		% delete(h_PopupmenuAcquisition);
    % Figure
    % delete(h_Main);
  
end % switch
  