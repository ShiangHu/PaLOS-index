
%
% eeglabstart;
% brainstormstart('');
clean;
addpath(genpath(cd));
addpath(genpath('/media/shu/hdd/iEEG study'));
nd = 500; % 1 - 1772

% compute lead field for ICBM152 chn65 and MNI iEEG cortex (see plotmesh.m)
K_srf = load('/home/shu/brainstorm_db/Protocol01/data/Subject01/@intra/headmodel_surf_openmeeg.mat');
K_vol = load('/home/shu/brainstorm_db/Protocol01/data/Subject01/@intra/headmodel_vol_openmeeg.mat');
K_srf.Gainfix = bst_gain_orient(K_srf.Gain([1:18,21:end],:), K_srf.GridOrient); % remove 19 20 NaNs
K_vol.Gain = K_vol.Gain([1:18,21:end],:);
d = dipole_pick(K_srf.GridLoc,nd);

% read sEEG electrodes
ele = load('/home/shu/brainstorm_db/Protocol01/data/Subject01/@rawPrecentral_gyrus/channel.mat');
ele = [ele.Channel.Loc]';
nele = size(ele,1);
chnidx = zeros(nd,1);
for i = 1:nd
dst = ele - repmat(K_srf.GridLoc(d(i),:),[nele,1]);
[~,chnidx(i)] = min(sum(dst.^2,2));
end

% read region
iEEGmat = load('WakefulnessMatlabFile.mat');
region = iEEGmat.RegionName(iEEGmat.ChannelRegion(chnidx));

% forward
V = K_srf.Gainfix(:,d)*iEEGmat.Data(1:end-800,chnidx)';
V = 25*zscore(V')';


% check the spectopo
nm = 'Simulation from iEEG';
eegplot(V,'title',nm,'plottitle',nm,'srate',200);

psdnm = [nm,'_PSD'];
figure('name',psdnm,'NumberTitle','off'),
spectopo(V,0,200,'percent',15,'freq',2:2:30,'title',psdnm,'chanlocs',readlocs('bst63.xyz'),'electrodes','off');


% eeglabstart('');
% K = importdata('G_cmi.mat');
% J = importdata('data/MC0000001_A.mat');
% eegplot(J,'eloc_file','58.xyz')
