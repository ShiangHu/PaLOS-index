
% eeglabstart(''); BSTstart('');
clean; eeglab;
addpath('/media/shu/hdd/iEEG study/mat');
elc = '/media/shu/hdd/toolbox/lossless/fixlsls/cuba58/cuba58.sfp';
fs = 200; % Hz
fm = 50; % maximum frequency
nw = 3;
% ndv = unique(round(logspace(0,log10(1772),20))); %nd vector
ndv = [100];
nm = 'Simulation from iEEG';
viewsptopt = {'freqrange',[0.39 50]};
pro = zeros(length(ndv),1);
rkr = zeros(length(ndv),4);

for di = 1:length(ndv)
    
    % qc clean EEG
    [V0, K, J, dipinfo] = kjconfig(ndv(di));
    [proV0,rkrV0,EEG_V0] = var2qc(V0,elc,fs,nw,fm,'');
    
    % add noise and qc
    noise = recoartifacts(selectics);
    V = V0 + 100*noise;
    [proV,rkrV,EEG] = var2qc(V,elc,fs,nw,fm);     
    
    % ICLABEL denoise
    EEG = iclabel(EEG);
    EEG = pop_icflag(EEG);
    
    pop_viewprops(EEG,0,1:size(EEG.icaact,1),viewsptopt,[],0);
    
    % reject components and reconstruct data
    
    % heterogeneity measures
    [pro(di), rkr(di,:)] = qcspectra(V,nw,fs,fm);
    
    disp([di ndv(di), pro(di), rkr(di,:)]);
    
    close all;
end

figure, semilogx(ndv,pro),xlim([min(ndv) max(ndv)]);

% K = importdata('G_cmi.mat');
% J = importdata('data/MC0000001_A.mat');