function view_ictypes(EEG,varargin)
% VIEWICTYPES view the ratios of the IC types after ICLABEL is done
% stacked barplot horizatally


if nargin==1
    bfh=figure;
    idx=1:size(EEG.icaact,1);
else
    bfh=varargin{1}; % figure handle
    idx=varargin{2};
end

bar(bfh,EEG.etc.ic_classification.ICLabel.classifications(idx,:),'stacked','Horizontal','on');
legend({'brain','muscle','eye','heart','line_noise','chan_noise','other'});
set(gca,'ytick',1:min(size(EEG.icasphere))), 
if nargin==1
    set(bfh,'Position',[1986 1 348 973]);
end
colormap(jet); axis 'tight'; view(180,90); title(EEG.filename);
end
