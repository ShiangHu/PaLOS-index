% This is to check why high pass 1hz filtering increases palosi

% Batch calculating the CPC
clean;
initpalos;
prj = 'cbm1'; % change this with automagic project name
ckfd = [prj,'ck'];crtfd(ckfd);

atmgres = dir(fullfile(['*',prj,'*'],'**','all*.mat'));
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
    allnm = atmgres(i).name;
    allStep = load(fullfile(allpath,allnm));
    
    % fix bad channls
    badchn = allStep.EEGFinal.automagic.autoBadChans;
    allStep.EEGcrd.data(badchn,:)=NaN;
    allStep.EEGfiltered.data(badchn,:)=NaN;
    
    [~,sbj] = fileparts(allpath);
    goal = fullfile(ckfd,sbj);
    mkdir(goal);
    
    for j=1:nstp
        data = getfield(allStep,stepnm{j},'data');
        chanlocs = getfield(allStep,stepnm{j},'chanlocs');
        
        rmid = data(:,1)==0|isnan(data(:,1));
        data(rmid,:)=[];
        chanlocs(rmid)=[];
        
        svfd = fullfile(goal,[sbj,ext{j}]);
        pro(j,i) = qcspectra(data,nw,fs,fmax,fmin,chanlocs,svfd);
        
    end
    sbjnm{i} = sbj;
    toc;
end

% save(['pro',prj],'pro','sbjnm');