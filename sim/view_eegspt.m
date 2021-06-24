function [spt,f] = view_eegspt(EEG,varargin)
% CHKEEGSPT check the plot of EEG waveforms and spectra
% Usage: view_eegspt(EEG,'w'); % only plot full screen EEG waveform
%            view_eegspt(EEG,'e'); % only plot default EEG window
%            view_eegspt(EEG,'s'); % only display the power spectra
%            view_eegspt(EEG); % default plot EEG and power spectra
%

% Input
%         EEG --- EEG eeglab structure
% Output
%         spt --- spactral
%            f --- frequency bins

% Shiang Hu, Jan. 15, 2020


nm = EEG.setname;
psdnm = [nm,'_PSD'];
V = EEG.data;
fs = EEG.srate;
elc = EEG.chanlocs;
frg = 2:2:30;

% plot EEG waveforms
if nargin==1||strcmpi(varargin{1},'e')
    eegplot(V,'title',nm,'plottitle',nm,'srate',fs,'winlength',20,'eloc_file',elc);
elseif strcmpi(varargin{1},'w')
    eegplot_w(V,'title',nm,'plottitle',nm,'srate',fs,'winlength',20,'eloc_file',elc);
elseif strcmpi(varargin{1},'s')
    disp('eeg undisplayed');
end

% plot spectral topographies
if nargin==1||(~strcmpi(varargin{1},'e')&&~strcmpi(varargin{1},'w')&&strcmpi(varargin{1},'s'))
    figure('name',psdnm,'numbertitle','off'),
    [spt,f] = spectopo(V,0,fs,'percent',15,'freq',frg,'title',psdnm,'chanlocs',elc,'electrodes','off');
else
    [spt,f] = spectopo(V,0,fs,'percent',15,'freq',frg,'chanlocs',elc,'plot','off');
end

end