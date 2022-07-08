function [y, gain] = FeedForwardDRC_Giannoulis2012(detector,x, fs, Threshold, ratio, AttackTime, ReleaseTime, Knee)

% =========================================================================
%              Digital Feed-Forwrad Compressor  
% =========================================================================
%
% This program contains one main stage of compression and it is divided
% into the following steps:
% 
% Compression Procedure:
% ----------------
% Stage 1: ABS (Absolute value),dB (Decibel converter),Level detection (Peak detection)
% Stage 2: Gain Computer
% Stage 3: Lin (Linear Domain)
% Stage 4: Plotting the outputs
% Stage 5: Creating the compressed signal File
% -------------------------------------------------------------------------
%   Usage:  
%      [y, gain] = FeedForwardDRC_Giannoulis2012(detector,x, fs, Threshold, ratio, AttackTime, ReleaseTime, Knee)
% -------------------------------------------------------------------------
%   Inputs:
%      detector            : Peak detector:
%                           ('B' :Branching Peak detector
%                            'BS':Branching smooth Peak detector
%                            'D' :Decoupled Peak detector
%                            'DS':Decoupled smooth Peak detector)
%      x                   : input audio signal
%      fs                  : sample rate
%      Threshold           : threshold in dB
%      ratio               : compression ratio
%      AttackTime          : attack time constant
%      ReleaseTime         : release time constant
%      Knee                : knee width in dB
% -------------------------------------------------------------------------
%   Output:
%     Y                    : output signal   
%     gain                 : gain applied to signal
%     CompressedSignal.wav : output audio signal(compressed) wav File
% -------------------------------------------------------------------------
%   Example call:
%   FeedForwardDRC_Giannoulis2012('DS', 'noisy.wav', 16000, -15, 50, 0.02, 0.02, 0)
% -------------------------------------------------------------------------
%   References:
%      [1]	 Giannoulis, Dimitrios & Massberg, Michael & Reiss, Joshua.
%            (2012). Digital Dynamic Range Compressor Design—A Tutorial 
%            and Analysis. AES: Journal of the Audio Engineering Society. 60.
%      [2]	 U. Zoelzer, "Dynamic Range Control," Digital Audio Signal 
%            Processing. 2nd ed. Chichester, UK: Wiley, 2008.
% -------------------------------------------------------------------------
%   Author:
%      Samira Abedini (September 14, 2021)
% -------------------------------------------------------------------------
%% ------------------------------------------------------------------------
% ------------ Paths Configuration ----------------------------------------
% -------------------------------------------------------------------------
% Here, the paths of all subfolders for generating the ... are added to the
% Workspace of MATLAB.
close all         % Closing previous figures.
clc               % Clean parameteres from command window
%
% ConfigPath1;      % Configuring the paths (first version)
 ConfigPath2;    % Configuring the paths (second version)
%

%% ========================================================================
%                          Compression Procedure:
% ========================================================================= 
% -------------------------------------------------------------------------
% ------------ Stage 1: ABS, dB and Peak Detection ------------------------
% -------------------------------------------------------------------------
% in this stage the absolute value of the input signal is calculated in dB,
% then the Peak detection method is selected and applied to the signal.
[x,fs]=audioread(x); % reading input signal and its sample rate
switch detector
    case 'B'    %if the selected peak detection method is Branching peak detection
        yp=BranchingPeakDetector(abs(x), fs, AttackTime, ReleaseTime);
    case 'BS'   %if the selected peak detection method is Branching Smooth peak detection
        yp=BranchingSmoothPeakDetector(abs(x), fs, AttackTime, ReleaseTime);
    case 'D'    %if the selected peak detection method is Decoupled peak detection
        yp=DecoupledPeakDetector(abs(x), fs, AttackTime, ReleaseTime);
    case {'DS'} %if the selected peak detection method is Decoupled Smooth peak detection
        yp=DecoupledSmoothPeakDetector(abs(x), fs, AttackTime, ReleaseTime);
    otherwise   %if none of the valid peak detection methods were selected 
        warning('Unexpected peak detector type. No plot created.');
end
%% ------------------------------------------------------------------------
% ------------ Stage 2: Gain Computer -------------------------------------
% -------------------------------------------------------------------------
lg = 20*log10(max(yp, 1e-6)); %logarithmic input level
cv=GainComputer(lg, Threshold, ratio, Knee);%calling the gain computer function
%% ------------------------------------------------------------------------
% ------------ Stage 3: Linear Domain -------------------------------------
% -------------------------------------------------------------------------
gain = 10.^(cv./20);
y = x .* gain;
%% ------------------------------------------------------------------------
% ------------ Stage 4: Plotting the outputs --------------------------------------
% -------------------------------------------------------------------------
subplot(3,2,1)      %plotting the input signal
t = linspace(0,length(y)/fs,length(y));
y1 = x;
plot(t,y1) 
title('Subplot 1: Input Signal')

subplot(3,2,2)     %plotting the compressed Output signal
y2 = y;    
plot(t,y2,'R')
title('Subplot 2: Compressed Signal')

subplot(3,2,3)    %plotting the Peak Detection Output 
y3 = yp;
plot(t,y3,'K')
title('Subplot 3: Peak Detector')

subplot(3,2,4)    %plotting the Gain applied to signal
y4 = gain;
plot(t,y4,'G')
title('Subplot 4: Gain ')

subplot(3,2,[5,6])%plotting both input and output signals in order to compare
plot(t,y1,'B',t,y2,'R')
title('Subplot 5: input signal vs. compressed signal')
%% ------------------------------------------------------------------------
% ------------ Stage 5: Creating the compressed signal File ---------------
% -------------------------------------------------------------------------
audiowrite('Results\Compressed Signal\CompressedSignal1.wav',y,fs); % the 'CompressedSignal1.wav' File
                                   %(which is the compressed output signal)
                                   % will be saved in 'Implementing Different parts of DRC\Matlab Files\Results\Compressed Signal'. 
sound(y,fs);

