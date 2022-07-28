clean;

datdir = '/CCLAB/CMI_EEG1306/';
datstr = dir(fullfile(datdir,'**','RestRaw.mat'));

ele = readlocs('hbn129.sfp');
nbsbj = length(datstr);

sm = zeros(7,nbsbj,2);

regnm = {'RestRaw','RestPrep'};

for j=1:nbsbj
    disp(['-------------current processing------------:' blanks(10) num2str(j) '/' num2str(nbsbj)])
    
    for k=1:2
        try
            EEG = loadnm(fullfile(datstr(j).folder, regnm{k}));
        catch
            continue;
        end
        
        if isempty(EEG.chanlocs), EEG.chanlocs = ele; end
        
        EEG = pop_runica(EEG,'pca',EEG.nbchan-1,'icatype','runica','extended',1);
        
        sm(:,j,k) = qcsm(EEG);
    end
end

save hbn_sm sm datstr;