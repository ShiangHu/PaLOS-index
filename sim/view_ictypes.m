function icscore = view_ictypes(EEG,varargin)
% VIEWICTYPES view the ratios of the IC types after ICLABEL is done
% stacked barplot horizatally

idx=1:size(EEG.icaact,1);

if nargin==1
    bfh=gca(figure);
elseif nargin==2
    bfh=varargin{1}; % ax
end
if nargin==3
    idx=varargin{2};
end

icscore = EEG.etc.ic_classification.ICLabel.classifications(idx,:);
bar(bfh,icscore,'stacked','Horizontal','on');
legend({'brain','muscle','eye','heart','line noise','chan noise','other'});
set(bfh,'ytick',1:size(EEG.icaweights,1),'xlim',[0 1]);
% if nargin==1
%     set(bfh,'Position',[1986 1 348 973]);
% end
colormap(jet); axis 'tight'; view(0,90); title(EEG.filename);
end
