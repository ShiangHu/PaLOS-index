qeegstart;
addpath(genpath(cd));

results = dir(fullfile(cd,'Automagic','**','allSteps*.mat'));
mnuck = fullfile(cd,'Automagic','mnuck');
pidx = zeros(6,size(results,1)); % PaLOS index

nw = 3;
fs = 500; % sampling rate
fm = 30;
idx = 1:40;
% load('G_cmi.mat');
sbjnm = cell(1,length(idx));
ext = {'_o','_p','_f','_r','_m','_i'};
ns = 6;
stepnm = {'EEGOrig','EEGprep','EEGfiltered','EEGRegressed','EEGMARA','EEGip'};

for i= idx
    disp(i);
    path = results(i).folder;
    filename = results(i).name;
    allStep = load(fullfile(path,filename));
    
    sbj = path(end-7:end-3);
    sbjnm{i-idx(1)+1} = sbj;
    goal = fullfile(mnuck,sbj);
    if ~isfolder(goal), mkdir(goal); end
    
    for j=1:6 
        data = getfield(allStep,stepnm{j},'data');
        pidx(j,i) = qcspectra(Har(data),nw,fs,fm);
        %         chanlocs = getfield(allStep,stepnm{j},'chanlocs');
        %         Gs = G([chanlocs.urchan] - 3,:);
        %         save(fullfile(goal,[sbj,ext{j}]),'data','chanlocs');
    end
end

save pidxcmi40ar pidx ns sbjnm idx;