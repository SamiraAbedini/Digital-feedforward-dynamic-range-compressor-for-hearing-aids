function ConfigPath
% =========================================================================
%              Adding the Paths of Matlab Files 
% =========================================================================
% In this function the paths of all subfolders for the compressor system are
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

% Geting root path
pathstr = pwd;

% Adding paths
addpath('../../../Databases')
path(path,[pathstr,'\Abs,dB,Peak Detector']);
path(path,[pathstr,'\Gain Computer']);
path(path,[pathstr,'\Results']);
path(path,[pathstr,'\Peak Detectors Test']);


% Notifying the user for a successful addition of paths.
clc;
disp('ConfigPath: Paths added');
end