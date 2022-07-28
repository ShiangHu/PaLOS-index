% Batch calculating the palosi
initpalos

clean;
prj = 'Ger'; % change this with automagic project name
ckfd = [prj,'ck']; 
crtfd(ckfd);

rawpath = 'D:\CCLAB\Germany\EEG_Raw_eyesclosed';
atmgpath = 'D:\CCLAB\Germany\EEG_Raw_eyesclosed_Ger_results';
GerRaw = dir(fullfile(rawpath,'**','*.set'));
atmg = dir(fullfile(atmgpath,'**','*p_*.mat'));


ext = {'_1O','_2E'};

nw = 3; fs = 200; fmax = 30; fmin=0.39; % paras fpr spt
chan = readlocs('Ger61.loc');
nsbj = length(GerRaw);

sbjnm = cell(1,nsbj);
Pro = zeros(nsbj,2);

for i=1:nsbj
    disp(['>>>>-------------------preprocessing sbj:',blanks(10),num2str(i)]);
    [~,sbj] = fileparts(GerRaw(i).folder);
    goal = fullfile(ckfd,sbj);
    mkdir(goal);
    
    EEG = pop_loadset(fullfile(GerRaw(i).folder,[sbj '.set']));
    svfd = fullfile(goal,[sbj,ext{1}]);
    Pro(i,1) = qcspectra(EEG.data,nw,fs,fmax,fmin,chan,svfd);
    
    if ismember(i,195), continue; end
    p_mat = dir(fullfile(atmgpath,sbj,['*p_' sbj '.mat']));
    load(fullfile(p_mat.folder,p_mat.name),'EEG');
    svfd = fullfile(goal,[sbj,ext{2}]);
    Pro(i,2) = qcspectra(EEG.data(1:61,:),nw,fs,fmax,fmin,chan,svfd);
end

save(['Pro_Ger',prj],'Pro','sbjnm');