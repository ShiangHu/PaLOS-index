
% eeglabstart(''); BSTstart('');
clean; eeglab;
addpath('/OneDrive - CCLAB/Scripting/iEEG study/mat/');
elc = '/media/shu/hdd/toolbox/lossless/fixlsls/cuba58/cuba58.sfp';
fs = 200; % Hz
fm = 50; % maximum frequency
nw = 3;
% ndv = unique(round(logspace(0,log10(1772),20))); %nd vector
ndv = [100];
nm = 'Simulation from iEEG';

pro = zeros(length(ndv),1);
rkr = zeros(length(ndv),4);

for di = 1:length(ndv)
    
    % qc clean EEG
    [V0, K, J, dipinfo] = kjconfig(ndv(di));
    [proV0,rkrV0,EEG_V0] = var2qc(V0,elc,fs,nw,fm,'');
    
    % add noise and qc
    noise = recoartifacts(selectics,2);
    V = V0 + 100*noise;
    [proV,rkrV,EEG] = var2qc(V,elc,fs,nw,fm);
    nic = size(EEG.icaact,1);
    varegg = zeros(nic,1);
    
    % ICLABEL denoise
    EEG = iclabel(EEG);
    EEG = pop_icflag(EEG);
    
    % reject components and reconstruct data
    [idx_pva,idx_apv,idx_mpv] = view_icsort(EEG);
    view_ictypes(EEG);
    
    
    % heterogeneity measures
    [pro(di), rkr(di,:)] = qcspectra(V,nw,fs,fm);
    
    disp([di ndv(di), pro(di), rkr(di,:)]);
    
    close all;
end

figure, semilogx(ndv,pro),xlim([min(ndv) max(ndv)]);

% K = importdata('G_cmi.mat');
% J = importdata('data/MC0000001_A.mat');