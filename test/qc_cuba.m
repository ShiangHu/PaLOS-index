% clean;
datdir = '\CCLAB\ash - qceeg\1 Raw and processing\Cuba2004\cuba04\';
datstr = dir(fullfile(datdir,'**','Clean.mat'));
ele = readlocs('cuba58.sfp');

regnm = {'Raw','Clean'};

nbsbj = length(datstr);
sm = zeros(7,nbsbj,2);

nc = zeros(nbsbj,2);
for j=1:nbsbj
    disp(['-------------current processing------------:' blanks(10) num2str(j) '/' num2str(nbsbj)])
    
    for k=1:2
        EEG = pop_loadset(regnm{k},datstr(j).folder);
        
        EEG.data = reref(EEG.data,[]);
        EEG.ref = 'AR';
        if isempty(EEG.chanlocs), EEG.chanlocs = ele; end
        
        EEG = eeg_checkset(EEG);
        EEG = pop_runica(EEG,'icatype','runica');
        EEG = iclabel(EEG);
        
        sm(:,j,k) = qcsm(EEG);
    end
end

save cuba_sm sm datstr;