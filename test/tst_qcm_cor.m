% Test the correlations of QC metrics

clean;
svfd = 'E:\CCLAB\ash - qceeg\4 HPD_atmg_rest\figure';
resdir =  'E:\Dropbox\CMI_PaLoSi\1 HBN_allsubjects';

addpath(resdir);

atmm = load('quality_metrics_all_HBN.mat');

palos = load('PaLoSi_HBN_all_final.mat');

if isequaln(atmm.results,palos.results)
    disp('subjects in the same order!')
end

pro = palos.pro';

atm = [atmm.CHV_all;atmm.MAV_all;atmm.OHA_all;atmm.RBC_all]';

[rou,pval] = corr(atm,pro);

[rou2,pval2] = corr(atm);

fgs = figure; fgs.Position = [263.5   298   1424    660.5];
subplot(1,2,1), [S,AX,BigAx,H,HAx] = plotmatrix(pro,atm);
for i=1:4
S(i).MarkerSize = 5;
end
title(BigAx,'Automagic measures VS. PaLoSi'), set(BigAx,'fontsize',12);
subplot(1,2,2), [S,AX,BigAx,H,HAx] = plotmatrix(atm);
for i=1:4
H(i).BinWidth  = 0.075*max(atm(:,i));
end
title(BigAx,'Automagic quality measures'), set(BigAx,'fontsize',12);
for i=1:4*4
    if mod(i,5)==1
        continue;
    end
    S(i).MarkerSize = 5;
end
saveas(fgs,fullfile(svfd,'fig3_qcm_catter'),'svg');

fg = figure; fg.Position = [480         395        1484         482];
subplot(121),
plot([rou,pval],'-o','markersize',10,'linewidth',2),
legend({'Rou', 'Pval'})
set(gca,'xtick',1:4,'xticklabel',{'CHV','MAV','OHA','RBC'},'fontsize',12),
title('Corr between AtmM and PaLoSi')

subplot(122),  imagesc(rou2), colormap(hot),colorbar;
set(gca,'xtick',1:4,'xticklabel',{'CHV','MAV','OHA','RBC'},'ytick',1:4,'yticklabel',{'CHV','MAV','OHA','RBC'},'fontsize',12)
title('Intercorr of AtmMs')

saveas(fg,fullfile(svfd,'fig3_qcm_cor'),'svg');