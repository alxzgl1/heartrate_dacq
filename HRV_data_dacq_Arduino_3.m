%-------------------------------------------------------------------------------
% https://uk.mathworks.com/help/supportpkg/arduinoio/examples/getting-started-with-matlab-support-package-for-arduino-hardware.html
% Alexander Zhigalov | a.zhigalov@gmail.com
%-------------------------------------------------------------------------------
function HRV_data_dacq_Arduino_3()

clc;

bOffline = 1;

% raw data
pX = zeros(100000, 1); % ~12 hours | hours, min, !!!!!!!!!!!!!!!!!!!!!!
iX = 1;

% minimum and maximum interbeat interval (IBI)
nMinIBI = 0.3; % seconds
nMaxIBI = 2.0; % seconds

% init
fs = 1000; 
dt = 1 / fs;
nIBI = 30; % beats
pIBI = zeros(nIBI, 1);
W = hann(nIBI);

% check
if bOffline == 0
  a = arduino(); % create session
else
  % load('data_sample.txt');
  pX_Offline = rand(100000, 1) * 0.25 + 0.5;
  iIBI_Offline = 1; % counter
  cIBI_Offline = 0; % countdown
end

% open udp
u = udp('127.0.0.1', 7400);  
fopen(u);

% init
fBL1 = 0.01; fBL2 = 0.05; 
fBM1 = 0.05; fBM2 = 0.10; 
fBH1 = 0.10; fBH2 = 0.20; 

% loop
tic;
iIBI = 0;
f = linspace(0, 1, nIBI);
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
		% add ibi to buffer
		pIBI = [pIBI(2:end); tIBI];
		% process buffer
		pIBI_FFT = abs(fft((pIBI - mean(pIBI)) .* W)) .^ 2;
    % plot
    subplot(2, 1, 1); plot(pIBI); xlim([1, nIBI]); ylim([0.5, 1.5]); box off;
    subplot(2, 1, 2); plot(f, pIBI_FFT);
    xlim([0, 0.5]); box off;
    drawnow;
		% send control parameter via UDP
		oscsend(u, '', 'f', tIBI);
  end
  % idle
  pause(dt); % should be 0.001 s
end

end % end

%-------------------------------------------------------------------------------

