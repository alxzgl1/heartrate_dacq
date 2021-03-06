%-------------------------------------------------------------------------------
% Function
%-------------------------------------------------------------------------------
function gui_handler(action)

% Edit
global h_EditLoadData;
global h_EditSaveData;
global h_EditBufLen;
% Buttons
global h_ButtonStart;
global h_ButtonStop;
global h_ButtonUpdate;
% Popupmenu
global h_PopupmenuAcquisition;

% Global variables
global g_ButtonStart;
global g_ButtonStop;
global g_ButtonUpdate;

% Action
switch action
	% Button 'Start'
  case 'ButtonStart'
    % enable 
    set(h_ButtonStop, 'Enable', 'on');
    set(h_ButtonUpdate, 'Enable', 'on');
		% disable
		set(h_ButtonStart, 'Enable', 'off');
    set(h_PopupmenuAcquisition, 'Enable', 'off');
    set(h_EditLoadData, 'Enable', 'off');
    set(h_EditSaveData, 'Enable', 'off');
    set(h_EditBufLen, 'Enable', 'off');
		% set
    g_ButtonStart = 1;
		
	% Button 'Stop'
  case 'ButtonStop'
		g_ButtonStop = 1;
    
  % Button 'Update'
  case 'ButtonUpdate'
		g_ButtonUpdate = 1;
		
end % switch
  