% plot the results of 10 EGI cases of Human phantom data

clean;

svfd = 'D:\CCLAB\ash - qceeg\4 HPD_atmg_rest\figure';


plt_stepidx('proegi.mat',1:10)

saveas(gcf,fullfile(svfd,'fg4_hpd'),'svg');