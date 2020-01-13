
% eeglabstart; BSTstart('');
addpath(genpath(cd),genpath('/media/shu/hdd/iEEG study'));
clean; eeglab;
elc = 'bst63.xyz';
fs = 200; % Hz
fm = 50; % maximum frequency
nw = 3;
% ndv = unique(round(logspace(0,log10(1772),20))); %nd vector
ndv = [100];
pro = zeros(length(ndv),1);
rkr = zeros(length(ndv),4);

for di = 1:length(ndv)
    
    nd = ndv(di);
    [K, J, dipinfo] = kjconfig(nd);
    % forward
    V = K*J;
    
    % check the spectopo
    nm = 'Simulation from iEEG';    psdnm = [nm,'_PSD'];
    eegplot(V,'title',nm,'plottitle',nm,'srate',200,'winlength',20,'eloc_file',elc);
    figure('name',psdnm,'NumberTitle','off'),
    [spectra,freqs] = spectopo(V,0,200,'percent',15,'freq',2:2:30,'title',psdnm,'chanlocs',elc,'electrodes','off');
    
    % convert .set and runica
    EEG = pop_loadset(var2set(V,elc,fs)); eeglab redraw
    EEG = iclabel(EEG);
    EEG = pop_icflag(EEG);
    
    % reject components and reconstruct data
    
    % heterogeneity measures
    [pro(di), rkr(di,:)] = qcspectra(V,nw,fs,fm); 
    
    disp([di nd, pro(di), rkr(di,:)]);
    
    close all;
end

figure, semilogx(ndv,pro),xlim([min(ndv) max(ndv)]);

% K = importdata('G_cmi.mat');
% J = importdata('data/MC0000001_A.mat');