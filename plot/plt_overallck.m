clean;
initpalos;
svfd = 'E:\CCLAB\ash - qceeg\4 HPD_atmg_rest\figure';
% load results
addpath('E:\Dropbox\CMI_PaLoSi\1 HBN_allsubjects');
load('PaLoSi_HBN_all_RAW.mat');
HBNrr = pro';
load('PaLoSi_HBN_all_final.mat');
HBNap = pro';

addpath('E:\CCLAB\ash - qceeg\1 Raw and processing\Cuba2004');
load('procbm1.mat','pro');
CBMrr = pro(1,:)';
CBMap = pro(6,:)';
load('procbm_cln_.mat','pro');
CBMmc = pro;

addpath('E:\CCLAB\ash - qceeg\1 Raw and processing\Barbados2018');
load('probns1.mat','pro');
BNSrr = pro(1,:)';
BNSap = pro(6,:)';
load('probns_cln_.mat','pro');
BNSmc = pro;

prov = [HBNrr;HBNap;CBMrr;CBMmc;CBMap;BNSrr;BNSmc;BNSap;];

gnm = [repmat('HBNrr',size(HBNrr)); repmat('HBNap',size(HBNap));...
    repmat('CBMrr',size(CBMrr));repmat('CBMmc',size(CBMmc));repmat('CBMap',size(CBMap));...
    repmat('BNSrr',size(BNSrr));repmat('BNSmc',size(BNSmc)); repmat('BNSap',size(BNSap))];

figure,boxplot(prov,gnm), xlabel(''), ylabel('PaLoSi (r)'), set(gca,'fontsize',12);
fg1 = gcf; fg1.Position = [152   385   749   562];

figure,
pronm = {'HBNrr',[],'HBNap','CBMrr','CBMmc','CBMap','BNSrr','BNSmc','CBMap'};
m=3;n=3;
for i=1:m*n
    if i==1
    subplot(m,n,1); bw=0.05;
    elseif i==2
        continue;
    else
        subplot(m,n,i),bw=0.05;
    end
    
    data = eval(pronm{i});
    histogram(data,'normalization','probability','binwidth',bw);
    title(pronm{i}), xlim([0 1]);  set(gca,'fontsize',12)
    ylim([0 0.625]);
end

fg2 = gcf; fg2.Position = [854   385   677   563];
saveas(fg1,fullfile(svfd,'fig2_1'),'svg');
saveas(fg2,fullfile(svfd,'fig2_2'),'svg');