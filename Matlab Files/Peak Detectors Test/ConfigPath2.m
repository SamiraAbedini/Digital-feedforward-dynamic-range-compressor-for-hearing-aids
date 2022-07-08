function ConfigPath
% =========================================================================
%              Adding the Paths of Matlab Files 
% =========================================================================
% In this function the paths of all subfolders for the Test system are
% added to the current path of Matlab workspace.
% -------------------------------------------------------------------------
%   Usage:
%      ConfigPath
% -------------------------------------------------------------------------
%   Outputs:
%      As output, subroot of program are added.
% -------------------------------------------------------------------------
%   Example call:
%      ConfigPath;
% -------------------------------------------------------------------------
%   Author:
%      Samira Abedini (October 14, 2021)

%% ------------------------------------------------------------------------
% ------------ Paths Configuration ----------------------------------------
% -------------------------------------------------------------------------
% Here, the paths of all subfolders for generating the ... are added to the
% Workspace of MATLAB.


% Adding paths 
addpath('../../../../Databases')
addpath('../Abs,dB,Peak Detector');
addpath('../Gain Computer');
addpath('../Results');
addpath('../Peak Detectors Test');


% Notifying the user for a successful addition of paths.
clc;
disp('ConfigPath: Paths added');
end