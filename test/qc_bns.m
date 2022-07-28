% output a group of qc spectral metrics by using qcsm

clean;
datdir = 'D:/CCLAB/bbds18';
datstr = dir(fullfile(datdir,'**','Raw.mat'));
regnm = {'Raw','Clean'};

ele = readlocs('19Cuba10-20.locs');
nbsbj = length(datstr);
sm = zeros(7,nbsbj,2);

for j=1:nbsbj
    disp(['-------------current processing------------:' blanks(10) num2str(j) '/' num2str(nbsbj)])
    
    for k = 1:2
        try
            EEG = pop_loadset(regnm{k},datstr(j).folder);
        catch
            continue;
        end
        if isempty(EEG.chanlocs), EEG.chanlocs = ele; end
        EEG.data = reref(EEG.data,[]);
        EEG.ref = 'AR';
        EEG = pop_runica(EEG,'icatype','runica');
        EEG = iclabel(EEG);
        EEG = eeg_checkset(EEG);
        sm(:,j,k) = qcsm(EEG);
    end
end

mnm = {'palos', 'power similarity', 'coh similarity', 'rank deficency', 'pvaf\_nbic', 'pn\_nbic', 'colinear test'};
figure,
for i=1:7
    subplot(2,4,i);
    plot(squeeze(sm(i,:,:)),'linewidth',2), legend({'Raw','Clean'});
    title(mnm{i});     xlabel('Subjects'); ylim([0 1]);
end
set(findall(gcf,'-property','FontSize'),'FontSize',12);

save('bbds_sm','sm','datstr');