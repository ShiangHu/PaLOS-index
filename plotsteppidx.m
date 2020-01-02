function plotsteppidx(pidx,varargin)
% pidx contains ns, pidx and sbjnm

switch nargin
    case 1
        subidx = 1:10;                      ax = figure;
    case 2
        if isnumeric(varargin{1})
            subidx = varargin{1};         ax = figure;
        else
            subidx = 1:10;                    ax = varargin{1};
        end
    case 3
        subidx = varargin{1};               ax = varargin{2};
end

load(pidx);
stepnm = {'Orig','Prep','Filt','Reg','Mara','Itpl'};

% figure,
% m = 2; n = 3;
% subplot(m,n,[1:2,4:5]),
bar(ax,categorical(sbjnm(subidx)), pidx(:,subidx)');
legend(stepnm,'orientation','horizontal');
colormap('parula'), ylim([0 1.2]); set(gca,'fontsize',12);
xlabel('Subject ID'), ylabel('PaLOS index (r)');

% subplot(m,n,3)
% plot(pidx(:,subidx),'-^'); xlim([0.85 ns+0.15]), ylim([0 1]);
% set(gca,'xtick',1:ns,'xticklabel',stepnm,'fontsize',14);
% ylabel('PaLOS index')

% subplot(m,n,6),
% imagesc(pidx(:,subidx)'); caxis([0 1]);
% xlabel('Step of processing'), ylabel('Subject ID')
% set(gca,'xtick',1:ns,'xticklabel',stepnm,'ytick',1:length(subidx),'yticklabel',sbjnm(subidx),'fontsize',14);
end