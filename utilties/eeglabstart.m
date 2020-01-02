function eeglabstart(varargin)
% add the essential EEGLAB paths
% Examples: 1. eeglabstart
%                    2. eeglabstart(''), eeglabstart(1), eeglabstart('nogui')
%
% Help eeglab

% Shiang Hu, Oct. 7, 2019

addpath('E:\OneDrive - Neuroinformatics Collaboratory\Scripting\Toolbox\eeglab');
addpath('E:\OneDrive - Neuroinformatics Collaboratory\Scripting\Toolbox\eeglab\sample_locs')

% add the starting path of eeglab
if nargin == 0
eeglab;
else % no gui pops up
end

% add spectra estimation and QC codes
addpath('E:\OneDrive - Neuroinformatics Collaboratory\Scripting\iEEG study\spt_est');

% add referecing toolbox
addpath('E:\Neuroinformatics Collaboratory\BrainWorks - Ref utilities');

clc;
end
