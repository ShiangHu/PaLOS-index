% Batch calculating the CPC 
eeglabstart; 
clc; clear; close all;
addpath(genpath(cd));
cmipath = 'E:\E-disk\CMI_HBN_EEG_rest';
svpath = 'Result\CMI61\';
dataset = dir(fullfile(cmipath,'**','preprocessed','**','RestingState.mat'));
nw = 3.5;
fm = 25;
ckset = [224];
% ckset = 1:size(dataset,1);
nd = length(ckset);
pro = zeros(nd,1);
tic;
for i=1:nd
    j = ckset(i); disp(i)
    load([dataset(j).folder,'\RestingState.mat'],'result'); % EEG/result
    name = dataset(j).folder(28:39);
    eegplot(result.data,'title',name,'plottitle',name); 
    
    psdnm = strcat(name,'_PSD');
    figure('name',psdnm,'NumberTitle','off'), 
    spectopo(result.data,0,500,'percent',15,'freq',2:2:20,'title',strcat('PSD_',name),'chanlocs',readlocs('CMI_EGI129.sfp'));
    saveas(gcf,strcat(svpath,psdnm,'.bmp'))
    
    pro(i) = qcspectra(result.data,nw,result.srate,fm);
    
end

%  figure, plot(pro,'.','markersize',10); xlabel('Data Samples'); ylabel('Proportion of 1st component')
 [~,imi] = min(pro); [~,ima] = max(pro);
 save pro_atmg pro dataset imi ima;
 toc;