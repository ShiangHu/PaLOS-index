% Batch calculating the CPC
eeglabstart;
clc; clear; close all;
addpath(genpath(cd));
% cmipath = 'E:\E-disk\CMI_HBN_EEG_rest';
cmipath = 'Automagic\CMI';
svpath = 'Result\CMI61\';
% dataset = dir(fullfile(cmipath,'**','raw','**','RestingState.mat')); % raw/preprocesed
dataset = dir(fullfile(cmipath,'**','*Raw.mat'));
nw = 3.5;
fm = 25;
% ckset = [723 504 43 643 1195 594 722];
ckset=1:size(dataset,1);
nd = length(ckset);
pro = zeros(nd,1);
 tic;
for i=1:nd
    if i==536
        continue;
    else
    j = ckset(i); disp(i)
    load([dataset(j).folder,'\RestRaw.mat'],'EEG'); % EEG/result
    name = dataset(j).folder(end-11:end);
        eegplot(EEG.data,'title',name,'plottitle',name);
    
        psdnm = strcat(name,'_PSD');
        figure('name',psdnm,'NumberTitle','off'),
        spectopo(EEG.data,0,500,'percent',15,'freq',2:2:20,'title',strcat('PSD_',name),'chanlocs',readlocs('GSN129.sfp'));
        saveas(gcf,strcat(svpath,psdnm,'.bmp'));
%     pro(i) = qcspectra(EEG.data,nw,EEG.srate,fm);
    end
end

% figure, plot(pro,'.','markersize',10); xlabel('Data Samples'); ylabel('Proportion of 1st component')
[~,imi] = min(pro); [~,ima] = max(pro);
save pro_raw pro dataset imi ima;
toc;