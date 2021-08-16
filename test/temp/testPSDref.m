
% idx_new = zeros(105,1);
% for i=1:105
%     idx_new(i) = idx(i).urchan - 3;
% end
% 
% load G129;
% G = G(idx_new,:);
% 
% Har = eye(105) - ones(105)/105;
% 
% EEG.data = G*pinv(Har*G)*Har*EEG.data;
% 
addpath('E:\OneDrive - Neuroinformatics Collaboratory\Scripting\Toolbox\eeglab');
eeglab; clean;

load EEG_ref;
fs = 500;
fm = 50;
fr = 0.3906;
frame = size(EEGcz,2);
nbin = 129;
frange = 0.3906*(0:nbin-1);

% plot the spectrum estimated by the multitaper
[~,~,~,PSDcz] = xspectrum(EEGcz,fs,fm,fr);
[~,~,~,PSDar] = xspectrum(EEGar,fs,fm,fr);
[~,~,~,PSDrest] = xspectrum(EEGrest,fs,fm,fr);
figure('name','multitaper'),
subplot(311), plot(frange,10*log10(PSDcz')); title('PSDcz'); xlim([0 fm]); xlabel('Freq'), ylabel('PSD');
subplot(312), plot(frange,10*log10(PSDar')); title('PSDar'); xlim([0 fm]); xlabel('Freq'), ylabel('PSD');
subplot(313), plot(frange,10*log10(PSDrest')); title('PSDrest'); xlim([0 fm]); xlabel('Freq'), ylabel('PSD');
% save PSD_ref_taper PSDcz PSDar PSDrest;

% plot the spectrum estimated by EEGlab
[PSDcz,freqs] = spectopo(EEGcz, frame, fs,'nfft',fs*2.56,'plot','off');
PSDar = spectopo(EEGar, frame, fs,'nfft',fs*2.56,'plot','off');
PSDrest = spectopo(EEGrest, frame, fs,'nfft',fs*2.56,'plot','off');
figure('name','EEGLAB'),
subplot(311), plot(frange,PSDcz(:,1:nbin)'); title('PSDcz'); xlim([0 fm]); xlabel('Freq'), ylabel('PSD');
subplot(312), plot(frange,PSDar(:,1:nbin)'); title('PSDar'); xlim([0 fm]); xlabel('Freq'), ylabel('PSD');
subplot(313), plot(frange,PSDrest(:,1:nbin)'); title('PSDrest'); xlim([0 fm]); xlabel('Freq'), ylabel('PSD');
% save PSD_ref_eeglab PSDcz PSDar PSDrest;

% load PSD_ref_eeglab.mat
% k = 20;
% [coeff_cz,score_cz,pcvar_cz] = ppca(10*log10(PSDcz(:,1:65)),k);
% [coeff_ar,score_ar,pcvar_ar] = ppca(10*log10(PSDar(:,1:65)),k);
% [coeff_rest,score_rest,pcvar_rest] = ppca(10*log10(PSDar(:,1:65)),k);
% 
% m = 3;
% [lambda, psi, T, stats, F] = factoran(10*log10(PSDcz(:,1:65)),m);
