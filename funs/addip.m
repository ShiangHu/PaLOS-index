% Since the interpolation is manual started at the final step after mara
% This is to contain the EEG after interpolation into the allStep*mat to
% calculate all the index

% Confirmed with Nic that: Orgin=CRD, HighVar=Final
% see https://github.com/methlabUZH/automagic/wiki/Quality-Assessment-and-Rating#combination-of-file-prefixes

clean;
preres  = dir(fullfile('*bns1*','**','*p_*.mat'));
for i=1:length(preres)
    disp(i)
    sbjpath = preres(i).folder;

    load(fullfile(sbjpath,preres(i).name),'EEG');
    EEGItpl = EEG;
    
    save(fullfile(sbjpath,'allSteps_Raw.mat'),'EEGItpl','-append');
end


% for old version
%save(fullfile(sbjpath,sbjname),...
%        'EEGOrig','EEGprep','EEGfiltered','EEGRegressed',...
%        'EEGMARA','EEGdetrended','EEGitpl')