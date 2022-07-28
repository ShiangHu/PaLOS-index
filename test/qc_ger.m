clean;

datdir = 'D:\CCLAB\Germany\GerRestEO';
datstr = dir(fullfile(datdir,'**','Raw.mat'));

ele = readlocs('D:\CCLAB\Germany\Ger61.loc');
nbsbj = length(datstr);

sm = zeros(7,nbsbj,2);

regnm = {'Raw','Prep'};

for j=1:nbsbj
    disp(['-------------current processing------------:' blanks(10) num2str(j) '/' num2str(nbsbj)])
    
    for k=1:2
        EEG = loadnm(fullfile(datstr(j).folder, regnm{k}));
        
        if isempty(EEG.chanlocs), EEG.chanlocs = ele; end
        EEG.data = reref(EEG.data,[]);
        EEG.ref = 'AR';
        
        if isempty(EEG.icawinv)
            EEG = pop_runica(EEG,'icatype','runica');
        end
        
        sm(:,j,k) = qcsm(EEG);
    end
end

save Ger_sm sm datstr;