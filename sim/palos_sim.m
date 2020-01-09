
% eeglabstart; BSTstart('');
addpath(genpath(cd),genpath('/media/shu/hdd/iEEG study'));
clean;
fs = 200; % Hz
fm = 50; % maximum frequency
nw = 3;
% ndv = unique(round(logspace(0,log10(1772),20))); %nd vector
ndv = [2 3];
pro = zeros(length(ndv),1);
rkr = zeros(length(ndv),4);

for di = 1:length(ndv)
    
    nd = ndv(di);
    [K, J, dipinfo] = kjconfig(nd);
    % forward
    V = K*J;
    
    % check the spectopo
    nm = 'Simulation from iEEG';
    psdnm = [nm,'_PSD'];
    elc = 'bst63.xyz';
    eegplot(V,'title',nm,'plottitle',nm,'srate',200,'winlength',20,'eloc_file',elc);
    figure('name',psdnm,'NumberTitle','off'),
    [spectra,freqs] = spectopo(V,0,200,'percent',15,'freq',2:2:30,'title',psdnm,'chanlocs',elc,'electrodes','off');
    
    
    
    % heterogeneity measures
    
    [pro(di), rkr(di,:)] = qcspectra(V,nw,fs,fm);
    
    [di nd, pro(di), rkr(di,:)]
     close all;
     
%      disp(di); 
end

figure, semilogx(ndv,pro),xlim([min(ndv) max(ndv)]);

% K = importdata('G_cmi.mat');
% J = importdata('data/MC0000001_A.mat');