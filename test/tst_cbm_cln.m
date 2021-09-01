% compute the palosi for the BNS EEG with clean windows applied

clean;
initpalos;
prj = 'cbm_cln_'; % change this with automagic project name
ckfd = [prj,'ck']; crtfd(ckfd);

nw = 3; fs = 200; fmax = 30; fmin=0.99; % paras fpr spt

dircln = dir(fullfile('cuba04','**','C*.mat'));

nsbj = length(dircln);
pro = zeros(nsbj,1);
sbjnm = cell(nsbj,1);

H = Hsc(58,57);% Hsc(19,18)
chanlocs = readlocs('cuba58.sfp');

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
