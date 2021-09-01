% compute the palosi for the BNS EEG with clean windows applied


% Batch calculating the CPC
clean;
initpalos;
prj = 'bns_cln_'; % change this with automagic project name
ckfd = [prj,'ck']; crtfd(ckfd);

nw = 3; fs = 200; fmax = 30; fmin=0.99; % paras fpr spt

dircln = dir(fullfile('bbds18','**','C*.mat'));

nsbj = length(dircln);
pro = zeros(nsbj,1);
sbjnm = cell(nsbj,1);

H = Hsc(19,18);% Hsc(19,18)
chanlocs = readlocs('19Cuba10-20.locs');

tic;
for i=1:nsbj
    disp(['>>>>-------------------preprocessing sbj:',blanks(10),num2str(i)]);
    clnm = dircln(i).name;
    clpath = dircln(i).folder;
    load(fullfile(clpath,clnm));
    
    [~,sbjnm{i}] = fileparts(clpath);
    svfd=fullfile(ckfd,sbjnm{i});
    
    data = H*EEG.data;
    pro(i) = qcspectra(data,nw,fs,fmax,fmin,chanlocs,svfd);
    
    toc;
end

save(['pro',prj],'pro','sbjnm');
