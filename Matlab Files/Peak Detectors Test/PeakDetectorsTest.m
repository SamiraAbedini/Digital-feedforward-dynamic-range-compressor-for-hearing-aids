% Detectors Test
% comparing the outputs of different peak detectors in order to find the
% best peak detector to apply in our main compressor
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
[x,fs]=audioread('noisy.wav'); %defining input audio wav. File
a=AnalogPeakDetector(x, fs, 0.02, 0.02); %calling Analog peak detector function
b=BranchingPeakDetector(x, fs, 0.02, 0.02); %calling Branching peak detector function
c=BranchingSmoothPeakDetector(x, fs, 0.02, 0.02); %calling Branching smooth peak detector function
d=DecoupledPeakDetector(x, fs, 0.02, 0.02); %calling Decoupled peak detector function
f=DecoupledSmoothPeakDetector(x, fs, 0.02, 0.02); %calling Decoupled smooth peak detector function
% plotting the input signal and different Peak detectors output
% -------------------------------------------------------------------------
subplot(5,1,1)  % plotting the input signal and Analog peak detector output
t = linspace(0,length(x)/fs,length(x));
y1 = x;
plot(t,y1,'B',t,a,'R')
title('Subplot 1: Analog Peak Detector')

subplot(5,1,2)  % plotting the input signal and Branching peak detector output
plot(t,y1,'B',t,b,'R')
title('Subplot 2: Branching Peak Detector')

subplot(5,1,3)  % plotting the input signal and Branching smooth peak detector output
plot(t,y1,'B',t,c,'R')
title('Subplot 3: Branching Smooth Peak Detector')

subplot(5,1,4)  % plotting the input signal and Decoupled peak detector output
plot(t,y1,'B',t,d,'R')
title('Subplot 4: Decoupled Peak Detector ')

subplot(5,1,5)  % plotting the input signal and Decoupled smooth peak detector output
plot(t,y1,'B',t,f,'R')
title('Subplot 5: Decoupled Smooth Peak Detector')