function cv = GainComputer(lg,Threshold, ratio,Knee)
% =========================================================================
%              Compressor gain computer  
% =========================================================================
%
% This program contains one main stage of Gain Compution 
% 
% Gain compution Procedure:
%-----------------------------------------------------------------
%   Usage:  
%      cv = gaincomputer(lg,Threshold, ratio,Knee)
% -------------------------------------------------------------------------
%   Inputs:
%      lg                  : logarithmic input level
%      Threshold           : logarithmic threshold
%      ratio               : compression ratio
%      Knee                : logarithmic width of the knee transistion
% -------------------------------------------------------------------------
%   Output:
%      cv                  : logarithmic control voltage
% -------------------------------------------------------------------------
%   Example call:
%      (lg should be defined as logarimic value of signal for example if
%      the output of peak detector is yp, then:
%       lg = 20*log10(max(yp, 1e-6));
%       cv = gaincomputerFF(lg,-15, 50,0)
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
%% ========================================================================
%                          Gain Compution Procedure:
% =========================================================================
slope = 1 / ratio - 1;% Feed-forward topology

overshoot = lg - Threshold; % Subtract Threshold from log-encoded input to
                            % get the amount ofovershoot
if Knee > 0% Soft half-wave rectifier    
    w2 = Knee / 2;
    a = w2 / (Knee * Knee);
    inTransition = ((overshoot > -w2) & (overshoot < w2));
    rect = inTransition .* (a * (overshoot + w2) .^ 2) + (1 - inTransition) .* max(overshoot, 0);
else        % Hard half-wave rectifier    
    rect = max(overshoot, 0);    
end
cv =rect * slope;% Multiply rectified overshoot with slope
