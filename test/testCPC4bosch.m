clc;clear;close all;
addpath(genpath(cd));
addpath(genpath('E:\OneDrive - Neuroinformatics Collaboratory\Scripting\Toolbox\qeeg (andy version)\qeegp'))
addpath 'E:\Neuroinformatics Collaboratory\BrainWorks - Ref utilities';
% basename = ['MC0000045' filesep 'MC0000045'];
% % eegdata = 'MC0000001_A.txt';
% state = 'A';
% lwin = 2.56; %length of analysis window in seconds
% fmin = 0.390625;
% freqres = fmin;
% fmax=19.11;
% wbands='1.56 3.51; 3.9 7.41; 7.8 12.48; 12.87 19.11; 1.56 30';
% brain=1;
% pg_apply=1;
% flags='1 1 1 0 1 1 1 1 1 1 1 1';
% [data, montage, age, SAMPLING_FREQ, epoch_size, wins, msg] = read_plgwindows(basename, state, lwin);
% txt = cell(7+size(montage,1), 1);
% txt{1,1} = 'NAME=Jane Doe';
% txt{2,1} = 'SEX=F';
% txt{3,1} = ['AGE=' num2str(age, '%.2f')];
% txt{4,1} = ['SAMPLING_FREQ=' num2str(SAMPLING_FREQ, '%f')];
% nit = round(lwin*SAMPLING_FREQ);
% nvt = size(data,2) ./ nit;
% % epochs = nit .* ones(1, nvt);
% epochs = nit;
% txt{5,1} = ['EPOCH_SIZE=' num2str(epochs, '%d ')];
% txt{6,1} = ['NCHANNELS=' num2str(size(data,1), '%d')];
% txt{7,1} = 'MONTAGE=';
% for k=1:size(montage,1)
%     txt{7+k,1} = montage(k,:);
% end
% dlmwrite('MC0000045\MC0000045.txt', char(txt), 'newline', 'pc', 'delimiter', '');
% dlmwrite('MC0000045\MC0000045.txt', data', 'newline', 'pc', 'delimiter', '\t', '-append');
% eegdata = 'MC0000045\MC0000045.txt';
% qeegt(eegdata, state, lwin, fmin, freqres, fmax, wbands, brain, pg_apply, flags,cd)
% % qeegt(eegdata, state, lwin, fmin, freqres, fmax, wbands, brain, pg_apply, flags, cd)

clear; 
% Svv_ar = getdatamod('MC0000045-cross-A-1.mod');
addpath('E:\OneDrive - Neuroinformatics Collaboratory\Scripting\QEEG\Riemannian-qEEG')
addpath('E:\OneDrive - Neuroinformatics Collaboratory\Scripting\Toolbox\eeglab');
addpath('E:\OneDrive - Neuroinformatics Collaboratory\Scripting\iEEG study\spt_est');
addpath('E:\OneDrive - Neuroinformatics Collaboratory\Scripting\QEEG\higgs_ridge')
load MC0000045;
% load MC0000001_A;
load G4cuba19;
nw = 3.5;
fs = 200;
fmax = 49/2.56;
% H = Hsc(19);
% H = eye(19) - ones(19)/19;
H = G*pinv(Hsc(19)*G,0.05)*Hsc(19);
[Svv_ar , f] = xspt(reshape(H*data(1:19,:),[19 512 80]),nw,fs,fmax);

% Svv_ar = real2hmt(Svv_ar);
S = Svv_ar;
ns = 80;
n = ns*(2*nw-1)*ones(1,size(S,3));
pmax =19;
lmax = 100;
tic;
[Lambda,Q] = CPCstepwise1(S(1:19,1:19,:),n,pmax,lmax);
toc;

figure, plot(real(Lambda'));
figure, imagesc(abs(Q));
% t = cumsum(sum(abs(Lambda),2))/sum(abs(Lambda(:))); figure, plot(t,'.')
% t = (sum(abs(Lambda),2))./sum(abs(Lambda(:))); figure, plot(t,'.')
figure, pareto(sum(abs(Lambda),2)./sum(abs(Lambda(:))));

figure, 
for i=1:19
    subplot(4,5,i)
    topoplot(abs(Q(:,i)),'19Cuba10-20.locs'), title(num2str(i))
end