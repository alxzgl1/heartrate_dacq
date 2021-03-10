%-------------------------------------------------------------------------------
% Function
%-------------------------------------------------------------------------------
function gui_handler(action)

% Edit
global h_EditLoadData;
global h_EditSaveData;
global h_EditBufLen;
global h_EditBandLow;
global h_EditBandMid;
global h_EditBandHigh;
% Buttons
global h_ButtonStart;
global h_ButtonStop;
global h_ButtonUpdate;
% Popupmenu
global h_PopupmenuAcquisition;
global h_PopupmenuAnalysis;

% Global variables
global g_ButtonStart;
global g_ButtonStop;
global g_ButtonUpdate;
global g_PopupmenuAnalysis;

% Strings
c_EditBandLow_S = '0.05-0.08';
c_EditBandMid_S = '0.08-0.12';
c_EditBandHigh_S = '0.12-0.20';
c_EditBandLow_H = '1.2-2.0';
c_EditBandMid_H = '0.8-1.2';
c_EditBandHigh_H = '0.3-0.8';

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
    set(h_PopupmenuAnalysis, 'Enable', 'off');
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
    
  % Button 'PopupmenuAnalysis'
  case 'PopupmenuAnalysis'
    g_PopupmenuAnalysis = get(h_PopupmenuAnalysis, 'Value');
    if g_PopupmenuAnalysis == 1
      set(h_EditBandLow, 'String', c_EditBandLow_S);
      set(h_EditBandMid, 'String', c_EditBandMid_S);
      set(h_EditBandHigh, 'String', c_EditBandHigh_S);
    else
      set(h_EditBandLow, 'String', c_EditBandLow_H);
      set(h_EditBandMid, 'String', c_EditBandMid_H);
      set(h_EditBandHigh, 'String', c_EditBandHigh_H);
    end
    
end % switch
  