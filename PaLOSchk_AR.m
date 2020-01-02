qeegstart;
svpath = 'Result\CMI\';
datbs = dir(fullfile('Automagic','**','allStep*.mat'));

nw = 3;
fs = 500;
fm = 25;
ext = {'_Orig','_Prep','_Filt','_Regr','_Mara','_Itpl'};
stepnm = {'EEGOrig','EEGprep','EEGfiltered','EEGRegressed','EEGMARA','EEGip'};

tic;
for i=1:10
    disp(i);
    path = datbs(i).folder;
    filename = datbs(i).name;
    allStep = load(fullfile(path,filename));
    
    sbj = path(end-7:end-3);
    goal = fullfile(svpath,sbj);
    if ~isdir(goal), mkdir(goal); end
    
    for j=1:6
        nm = [sbj,ext{j},'_AR'];
        EEG = allStep.(stepnm{j});
        data = Har(EEG.data);
        close all; eegplot(data,'title',nm,'plottitle',nm);
        saveas(gcf,strcat(svpath,sbj,filesep,nm,'.fig'));
        
        figure('name',['spt_',nm],'numbertitle','off'),
        pro= qcspectra(data,nw,fs,fm);
        tt = ['spt_',nm,'__||PaLOS = ',num2str(pro)];
        spectopo(data,0,fs,'percent',15,'freq',2:2:20,'title',tt,'chanlocs',EEG.chanlocs);
        saveas(gcf,strcat(svpath,sbj,filesep,['spt_',nm],'.fig'));
    end
end