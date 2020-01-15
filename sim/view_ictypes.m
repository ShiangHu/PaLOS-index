function view_ictypes(EEG)
% VIEWICTYPES view the ratios of the IC types after ICLABEL is done
% stacked barplot horizatally


bfh=figure;
bar(EEG.etc.ic_classification.ICLabel.classifications,'stacked','Horizontal','on');
legend({'brain','muscle','eye','heart','line_noise','chan_noise','other'});
set(gca,'ytick',1:min(size(EEG.icasphere))), set(bfh,'Position',[1986 1 348 973]);
colormap(jet); axis 'tight'; view(180,90); title(EEG.filename);
end