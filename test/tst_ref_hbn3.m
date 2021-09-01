% This is to calculate the palosi at each step for HBN2

% Batch calculating the CPC
clean;
initpalos;
prj = 'hbn3'; % change this with automagic project name
atmgres = dir(fullfile(['*',prj,'*'],'**','all*.mat'));
stepnm = {'EEGOrig','EEGcrd','EEGfiltered','EEGICLabel','EEGHighvarred','EEGItpl'};

nstp = length(stepnm);
nsbj = length(atmgres);
pro = zeros(nstp,nsbj); % PaLOS index

nw = 3; fs = 500; fmax = 30; fmin=0.99; % paras fpr spt

sbjnm = cell(1,nsbj);
ext = {'_1O','_2C','_3F','_4L','_5H','_6E'};
G = importdata('G_cmi.mat');

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
    sbj = allpath(end-7:end-3);
    
    for j=1:nstp
        data = getfield(allStep,stepnm{j},'data');
        chanlocs = getfield(allStep,stepnm{j},'chanlocs');
        
        rmid = data(:,1)==0|isnan(data(:,1));
        data(rmid,:)=[];
        chanlocs(rmid)=[];
        
        % check for referencing effect
        for k=1:3
            switch k
                case 1,     H = eye(size(data,1));
                case 2,     H = Har(size(data,1));
                case 3
                    Gs = G(idx_subegi(chanlocs),:);
                    H = Gs*pinv(Gs,0.05)*Hsc(size(Gs,1));
            end
            
            pro(j,i,k) = qcspectra(H*data,nw,fs,fmax,fmin);
            
        end
        sbjnm{i} = sbj;
        toc;
    end
end

save(['pro_ref_',prj],'pro','sbjnm','stepnm');