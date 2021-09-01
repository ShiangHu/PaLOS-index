% Test the effect of palosi against channel number

% Batch calculating the CPC
clean;
initpalos;
prj = 'hbn3'; % change this with automagic project name
ckfd = [prj,'eleck']; crtfd(ckfd);
idx = egisparse('hbn129.sfp');
ext = {'_1O','_6E'};
stepnm = {'EEGOrig','EEGItpl'};

atmgres = dir(fullfile(['*',prj,'*'],'**','all*.mat'));
nstp = length(stepnm);
nsbj = length(atmgres);
nele = length(fieldnames(idx));
pro = zeros(nsbj,nele,nstp); % PaLOS index

nw = 3; fs = 500; fmax = 30; fmin=0.99; % paras fpr spt

sbjnm = cell(1,nsbj);
idnm = fieldnames(idx);

chanlocs = readlocs('hbn129.sfp');


tic;
for i= 1:nsbj
    disp(['>>>>-------------------preprocessing sbj:',blanks(10),num2str(i)]);
    allpath = atmgres(i).folder; allnm = atmgres(i).name;
    allStep = load(fullfile(allpath,allnm));
    
    [~,sbj] = fileparts(allpath); goal = fullfile(ckfd,sbj); crtfd(goal);
    
    for j=1:nstp
        data = getfield(allStep,stepnm{j},'data');
        data(129,:) = 0;                                         % recover the Cz reference
        data = Har(129)*data;
        
        if isnan(data(:,1)), warning('nan found!'); end
        
        for k=1:nele
            eleid = getfield(idx,idnm{k});
            eledata = data(eleid,:);
            elelocs = chanlocs(eleid);
            ne = length(eleid);
            
            svfd = fullfile(goal,[sbj,ext{j},'_',num2str(ne)]);
            pro(i,k,j) = qcspectra(eledata,nw,fs,fmax,fmin,elelocs,svfd);
        end
    end
    sbjnm{i} = sbj;
    toc;
end

save(['pro_eleck',prj],'pro','sbjnm');