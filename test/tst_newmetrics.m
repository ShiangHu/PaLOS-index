% this is to test the new metrics additional to palos
% The new metrics include:
%       1. qc_rd: channel rank deficency of the multichannel EEG
%       2. qc_pvaf_nbic: percentage of scalp data the non-brain IC variance accounted for
%       3. qc_pnbic: percentage of non-brain ICs among all the ICs
%       4. qc_clt: extent of collinear test of the spectral curves
%       5. qc_rou: similarity of the spectral topographies across frequencies
%       6. PaLoSi.

clean;
EEG = loadnm('allSteps_EGI_EOG_midtown_Lei_Rest_run01_CMI_20190322_165','EEGMARA');

% default by EEGLAB
% psdnm='Lei mara'; figure('name',psdnm,'NumberTitle','off'),
% [spectra,freqs] = spectopo(EEG.data,0,500,'percent',15,'freq',...
%     2:2:20,'title',psdnm,'chanlocs',EEG.chanlocs);


% multitaper
nw = 3;
fs = EEG.srate;
fmax = 30;
fmin = 0;

[cs, fbins] = xspt(EEG.data,nw,fs,fmax,fmin);

qc_palos = qcspectra(EEG.data,nw,fs,fmax,fmin);

% power and coherence
ps = tdiag(cs);
figure, subplot(121), title('Natural Power'), plot(fbins,ps);
subplot(122), title('Log Power'), semilogy(fbins,ps);

coh = cs2coh(cs);
rk_coh = trank(coh);

dist_c = pdist(vect_tria(coh)','cosine');
qc_dcoh = sum(dist_c<0.15)/length(dist_c);
figure, histogram(dist_c,3, 'normalization','probability');

% similarity of spectral topographies
rou = corr(ps);
rouh = vect_tria(rou);
qc_dps = sum(rouh>=0.9)/length(rouh);

figure,
subplot(121), histogram(rouh,2,'normalization','probability');
xlabel('qc_rou: spectral similarity'); ylabel('Probability');set(gca,'fontsize', 14);
subplot(122),imagesc(rou); caxis([0 1]); axis square;
xlabel('Freq'), ylabel('Freq'), title('similarity of spectral topos'), set(gca,'fontsize', 14);

% ICLABEL
EEG = eeg_checkset(EEG);
EEG = iclabel(EEG);

[~,~,classid,pvaf_bic,pbic] = sort_ic(EEG);
qc_pnbic = 1 - pbic;
qc_pvaf_nbic = 1 - pvaf_bic;

% EEG rank deficency
qc_rd = 1 - rank(EEG.data)/size(EEG.data,1);

% collinear test
ps_log = log10(ps);
ps_log = ps_log - repmat(sum(ps_log,2),[1,size(ps_log,2)]);         % relative power

ps_dem = ps_log - repmat(median(ps_log),[size(ps_log,1), 1]); % de-median across channels

figure, plot(fbins, ps_dem);
xlabel('Freqs'), title('dist to median across channels'), set(gca,'fontsize', 14);
ps_std = var(ps_dem,[],2);

qc_clt = 1 - mean(ps_std)./mean(abs(ps_dem(:)));

% check the rou, pvaf_bic, p_bic, cr, ps_std
