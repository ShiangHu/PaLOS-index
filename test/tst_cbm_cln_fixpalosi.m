% test palosi with cbm_raw, cbm_clean windows applied, cbm_automagic

initpalos; clean;

datafd = 'D:\CCLAB\ash - qceeg\1 Raw and processing\Cuba2004';
data_rr = dir(fullfile(datafd,'cuba04','**','Raw.mat'));
nsbj = length(data_rr);

nw = 3; fs = 200; fmax = 30; fmin=0.3906; % paras fpr spt

H = Hsc(58,57);
pro_all = zeros(nsbj,3);
sbjall = cell(nsbj,1);

for i=1:nsbj
    disp(['>>>>-------------------preprocessing sbj:',blanks(10),num2str(i), '/', num2str(nsbj)]);
    
    try
        rr = pop_loadset(fullfile(data_rr(i).folder,data_rr(i).name));
        [~,sbjnm] = fileparts(data_rr(i).folder);
        mc = pop_loadset(fullfile(datafd,'cuba04',sbjnm,'Clean.mat'));
        ap = load(fullfile(datafd,'cuba04_cbm1_results',sbjnm,'allSteps_Raw.mat'),'EEGFinal');
        
    catch
        continue;
    end
    
    sbjall{i} = sbjnm;
    eeg_rr = Har(size(rr.data,1))*rr.data;
    eeg_mc = Har(size(mc.data,1))*mc.data;
    eeg_ap = ap.EEGFinal.data;
    eeg_ap(isnan(eeg_ap(:,1)),:) = [];
    eeg_ap = Har(size(eeg_ap,1))*eeg_ap;
    
    [pro_all(i,2),~,~,ssd] = qcspectra(eeg_mc,nw,fs,fmax,fmin);
    pro_all(i,1) = qcspectra_f(eeg_rr,nw,fs,fmax,fmin,ssd);
    pro_all(i,3) = qcspectra_f(eeg_ap,nw,fs,fmax,fmin,ssd);
    
end

pro_all(pro_all(:,1)==0,:) = [];
sbjall(cellfun(@isempty,sbjall)) = [];
