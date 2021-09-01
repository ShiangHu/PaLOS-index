function plt_stepidx(prosnm,varargin)
% prosnm is the name of the structure that contains pro, sbjnm, stpnm
%
%
%

pros = load(prosnm);
subid = 1:length(pros.sbjnm);

% define which subject and which fgis to plot on
switch nargin
    case 1,  fg = figure; ax = gca(fg);
    case 2
        if isnumeric(varargin{1})
            subid = varargin{1};   fg = figure; ax = gca(fg);
            fg.Position = [58         496        1400         422];
        else
            ax = varargin{1};
        end
    case 3,    subid = varargin{1}; ax = varargin{2};
end

% stepnm = initpalos;
sbjnm = pros.sbjnm;
if isfield(pros,'stpnm')
    stpnm = pros.stpnm;
elseif size(pros.pro,1)==4
    stpnm = {'NC=129','NC=69','NC=31','NC=21'};
else
    stpnm = initpalos;
end

bar(ax,categorical(sbjnm(subid)), pros.pro(:,subid)');
legend(stpnm,'orientation','horizontal');

colormap('parula'), ylim([0 1.2]); set(gca,'fontsize',12);
xlabel('Subject ID'), ylabel('PaLoSi (r)');
end