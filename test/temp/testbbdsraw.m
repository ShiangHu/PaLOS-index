% Batch calculating the CPC
eeglabstart;
clc; clear; close all;
addpath(genpath(cd));
datapath = 'E:\Neuroinformatics Collaboratory\QMEEG - Barbados2018\bbds18';
svpath = 'Result\';
dataset = dir(fullfile(datapath,'**','Raw.mat'));
nw = 3.5;
fm = 25;
fs = 200;
% ckset = [233 110];
ckset = 1:size(dataset,1);
nd = length(ckset);
pro = zeros(nd,1);
H = Har(19);% Hsc(19,18)
tic;
for i=1:nd
    j = ckset(i); disp(i)
    name = dataset(j).name;
    EEG = importdata(fullfile(dataset(j).folder,name)); % EEG
    
    %     eegplot(EEG.data,'title',name,'plottitle',name);
    %
    %     psdnm = strcat(name,'_PSD');
    %     figure('name',psdnm,'NumberTitle','off'),
    %     spectopo(EEG.data,0,500,'percent',15,'freq',2:2:20,'title',strcat('PSD_',name),'chanlocs',readlocs('58.xyz'));
    %     saveas(gcf,strcat(svpath,psdnm,'.bmp'))
    
    
    pro(i) = qcspectra(H*EEG.data,nw,fs,fm);
    
end

%  figure, plot(pro,'.','markersize',10); xlabel('Data Samples'); ylabel('Proportion of 1st component')
[~,imi] = min(pro); [~,ima] = max(pro);
save pro_bbds_raw_ar pro dataset imi ima;
toc;