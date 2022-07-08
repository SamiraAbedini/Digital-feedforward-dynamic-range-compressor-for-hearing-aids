function y = AnalogPeakDetector(x, fs, AttackTime, ReleaseTime)
% =========================================================================
%              Analog Peak Detector  
% =========================================================================
%
% This program contains one main stage of Analog Peak detection
% Analog peak detection Procedure:
% -------------------------------------------------------------------------
%   Usage:  
%      y = AnalogPeakDetector(x, fs, AttackTime, ReleaseTime)
% -------------------------------------------------------------------------
%   Inputs:
%      x                   : input audio signal
%      fs                  : sample rate
%      AttackTime          : attack time constant
%      ReleaseTime         : release time constant
% -------------------------------------------------------------------------
%   Output:
%     Y                    : Detector output   
% -------------------------------------------------------------------------
%   Example call:
%      [x,fs]=audioread('noisy.wav');
%      y = AnalogPeakDetector(x, fs, 0.02, 0.02)
% -------------------------------------------------------------------------
%   References:
%      [1]	 Giannoulis, Dimitrios & Massberg, Michael & Reiss, Joshua.
%            (2012). Digital Dynamic Range Compressor Design�A Tutorial 
%            and Analysis. AES: Journal of the Audio Engineering Society. 60.
%      [2]	 U. Zoelzer, "Dynamic Range Control," Digital Audio Signal 
%            Processing. 2nd ed. Chichester, UK: Wiley, 2008.
% -------------------------------------------------------------------------
%   Author:
%      Samira Abedini (September 14, 2021)
% -------------------------------------------------------------------------
%% ========================================================================
%                    Analog Peak detection Procedure:
% ========================================================================= 
taufs = AttackTime * fs;
if AttackTime > 0
    alphaAtt = exp(-1 / taufs);
else
    alphaAtt = 0;
end
taufs = ReleaseTime * fs;
if ReleaseTime > 0
    alphaRel = exp(-1 / taufs);
else
    alphaRel = 0;
end

y = x;
state = 0;

for i=1:length(x)
    state = alphaRel*state + (1-alphaAtt) * max(y(i) - state, 0);
    y(i) = state;
end
% -------------------------------------------------------------------------
subplot(2,1,1)   %plotting the input signal
t = linspace(0,length(y)/fs,length(y));
y1 = x;
plot(t,y1)
title('Subplot 1: Input Signal')

subplot(2,1,2)   %plotting the analog peak detector output
y2 = y;
plot(t,y2,'R')
title('Subplot 2: Analog Peak Detector')
