function EEG = var2set(datvarfile,chanvarfile,fs,varargin)
% translate simulated data matrix into .set
% prepare EEG .set and do ICA
% Iuput
%       datvarfile --- EEG data variable name in matlab workspace or file path
%       chanvarfile --- chanlocs variable name in matlab workspace or file path
%       fs      --- sampling rate
% Output
%    EEGLAB .set format

% Shiang Hu, 10. Jan, 2020
% Help eeg_checkset, pop_mergeset, pop_saveset, pop_resample, pop_chanedit
%         pop_delset, pop_newset, pop_copyset, eeg_emptyset

if isempty(varargin)
    setnm = 'Simulated EEG';
end

% no gui pops
EEG = pop_importdata('data',datvarfile,'chanlocs',chanvarfile,'srate',fs,'setname',setnm);

% pop_saveset(EEG,'filename',svfile);
end
