function [V, K, J, dipinfo] = kjconfig(nd)
% KJCONFIG configure sEEG2scalp lead field and iEEG time series
% Input
%        nd --- # of dipoles to choose
% Output
%         V --- simulated EEG
%         K --- lead field
%         J --- dipolar time series
% dipinfo --- [didx: dipole index from iEEG, vidx: index for vertices that
%                   are closet to dipoles (sEEG), region: names from atlas]

% Read also PLOTMESH
% Shiang Hu, Jan. 8, 2020

% compute lead field for ICBM152 chn65 and MNI iEEG cortex (see plotmesh.m)
% K_srf = load('/home/shu/brainstorm_db/Protocol01/data/Subject01/@intra/headmodel_surf_openmeeg.mat');
K_srf = load('/home/shu/brainstorm_db/Protocol01/data/Subject02/@intra/headmodel_surf_openmeeg.mat');
% K_vol = load('/home/shu/brainstorm_db/Protocol01/data/Subject01/@intra/headmodel_vol_openmeeg.mat');
% K_vol = load('/home/shu/brainstorm_db/Protocol01/data/Subject02/@intra/headmodel_vol_openmeeg.mat');
% K_srf.Gainfix = bst_gain_orient(K_srf.Gain([1:18,21:end],:), K_srf.GridOrient); % remove 19 20 NaNs
K_srf.Gainfix = bst_gain_orient(K_srf.Gain, K_srf.GridOrient); 
% K_vol.Gain = K_vol.Gain([1:18,21:end],:);

% pick surface/volume lead field for use
K = K_srf.Gainfix;
ngrid = size(K_srf.GridLoc,1);

% read sEEG electrodes and pick source time series
ele = load('/home/shu/brainstorm_db/Protocol01/data/Subject01/@rawPrecentral_gyrus/channel.mat');
ele = [ele.Channel.Loc]';
didx = dipole_pick(ele,nd);

% find the closet vertices as the dipolar sources
vidx = zeros(nd,1);
for i = 1:nd
dst = K_srf.GridLoc - repmat(ele(didx(i),:),[ngrid,1]);
[~,vidx(i)] = min(sum(dst.^2,2));
end

% read region
iEEGmat = load('WakefulnessMatlabFile.mat');
region = iEEGmat.RegionName(iEEGmat.ChannelRegion(didx));

% output 
K = K(:,vidx);
J = iEEGmat.Data(1:end-800,didx)'; % trim the nearly flat tail
J = zscore(J')';
dipinfo = struct('channels',didx,'vertices',vidx,'region',{region});
V = K*J;
end