% This is to check why high pass 1hz filtering increases palosi

% Batch calculating the CPC 
initpalos;
clean;
rmdir('hbn3ck','s'), mkdir('hbn3ck');

atmgres = dir(fullfile('*hbn1*','**','all*.mat'));
stepnm = {'EEGOrig','EEGcrd','EEGfiltered','EEGICLabel','EEGHighvarred','EEGItpl'};

nstp = length(stepnm);
nsbj = length(atmgres);
pro = zeros(nstp,nsbj); % PaLOS index

nw = 3; fs = 500; fmax = 30; fmin=0.99; % paras fpr spt

sbjnm = cell(1,nsbj);
ext = {'_1O','_2C','_3F','_4L','_5H','_6E'};

tic;
for i= 1:nsbj
    disp(['>>>>-------------------preprocessing sbj:',blanks(10),num2str(i)]);
    allpath = atmgres(i).folder;
    filename = atmgres(i).name;
    allStep = load(fullfile(allpath,filename));
    badchn = allStep.EEGFinal.automagic.autoBadChans;
    allStep.EEGcrd.data(badchn,:)=NaN;
    allStep.EEGfiltered.data(badchn,:)=NaN;
    
    sbj = allpath(end-7:end-3);
    sbjnm{i} = sbj;
    goal = fullfile('hbn3ck',sbj);
    mkdir(goal);
    
    for j=1:nstp 
        data = getfield(allStep,stepnm{j},'data');
        chanlocs = getfield(allStep,stepnm{j},'chanlocs');

        eleid = data(:,1)~=0&~isnan(data(:,1));
        data = data(eleid,:);     
        chanlocs = chanlocs(eleid);
        
        svfd = fullfile(goal,[sbj,ext{j}]);
        pro(j,i) = qcspectra(data,nw,fs,fmax,fmin,chanlocs,svfd);
        
    end
    toc;
end

save prohbn1 pro sbjnm;