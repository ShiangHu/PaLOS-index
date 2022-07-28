function plt_paramap(lmd,Q,procd,fbd,pmax,svfd,nm,chanlocs,hr)
% plot the CPC parameters figure and topomaps
% plot the eigenvalues and eigenvectors
%
% See also qcspectra


    figure
    % eigenvalues
    subplot(231), plot(lmd(:,1)./sum(lmd(:,1)),'-o','linewidth',1,'MarkerFaceColor','b','markersize',2.5),
    xlim(fbd); xlabel('Freq'); title('Frequency-wise PaLoSi');
    
    subplot(234), semilogy(lmd),
    xlim(fbd); xlabel('Freq'); title('Engergy of CPCs');
    
    % proportion of components
    subplot(232), pareto(procd);
    title('Proportion of cumulated > 95% variance');
    
    subplot(235),
    plot(1:pmax,cumsum(procd),'.',1:pmax,procd,'^');
    legend({'CumPro','VarPro'}); xlim([1 pmax]); xlabel('Ordered CPC');
    title('Proportion of each CPC');
    
    % components
    subplot(233), imagesc(real(Q)), colorbar;
    xlabel('Ordered CPC'), ylabel('Channels'); title('CPC patterns');
    
    subplot(236),
    topoplot(real(Q(:,1)),chanlocs,'style','map','headrad',hr); 
    title('Channel-wise PaLoSi');
    fg=gcf; fg.Position = [24 317 1105 585];
    saveas(gcf,fullfile(svfd,['par_',nm]),'svg');
    
    
    
    
    figure,
    for i=1:8
        subplot(4,2,i)
        topoplot(real(Q(:,i)),chanlocs,'style','map','headrad',hr); 
        title(['CPC:',num2str(i)]);
    end
    fg=gcf; fg.Position = [1135 206 380 771];
    saveas(gcf,fullfile(svfd,['map_',nm]),'svg');
end