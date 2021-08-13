% Since the interpolation is manual started at the final step after mara
% This is to contain the EEG after interpolation into the allStep*mat to
% calculate all the index

% Confirmed with Nic that: Orgin=CRD, HighVar=Final

clean;
ipres  = dir(fullfile('*hbn1*','**','*ip*.mat'));
allres = dir(fullfile('*hbn1*','**','all*.mat'));
for i=1:length(ipres)
    disp(i)
    sbjpath = ipres(i).folder;

    load(fullfile(sbjpath,ipres(i).name),'EEG');
    EEGItpl = EEG;
    
    save(fullfile(sbjpath,allres(i).name),'EEGItpl','-append');
end


% for old version
%save(fullfile(sbjpath,sbjname),...
%        'EEGOrig','EEGprep','EEGfiltered','EEGRegressed',...
%        'EEGMARA','EEGdetrended','EEGitpl')