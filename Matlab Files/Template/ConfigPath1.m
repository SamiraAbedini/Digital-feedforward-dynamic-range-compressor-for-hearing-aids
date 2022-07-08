function ConfigPath
% =========================================================================
%              Adding the Paths of Matlab Files 
% =========================================================================
% In this function the paths of all folders and subfolders in the 'Library' 
% and 'Databases' are added to the current path of Matlab workspace.
% -------------------------------------------------------------------------
%   Usage:
%      ConfigPath
% -------------------------------------------------------------------------
%   Outputs:
%      As output, the required paths for running the desired algorithm 
%      are added to the current path of Matlab workspace.
% -------------------------------------------------------------------------
%   Example call:
%      ConfigPath;
% -------------------------------------------------------------------------
%   Author:
%      Firstname Lastname (June 14, 2021)

%% ------------------------------------------------------------------------
% ------------ Paths Configuration ----------------------------------------
% -------------------------------------------------------------------------
% In this function the paths of all folders and subfolders in the 'Library' 
% and 'Databases' are added to the current path of Matlab workspace.

currentfolder = which('ConfigPath.m');
oldDir = '../../../B.Sc. Simulations';
newDir = strrep(currentfolder,oldDir,'Library\AMT_toolbox');
addpath(genpath(newDir));

newDir = strrep(currentfolder,oldDir,'Library\voicebox');
addpath(genpath(newDir));

newDir = strrep(currentfolder,oldDir,'Library\k-Wave Toolbox');
addpath(genpath(newDir));

newDir = strrep(currentfolder,oldDir,'Databases');
addpath(genpath(newDir));


% Notifying the user for a successful addition of paths:
 disp('ConfigPath: Paths added');
end