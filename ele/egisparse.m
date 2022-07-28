function [idx, Val12] = egisparse(locpath)
% To match the subsample of 10-20, 10-10 from EGI129
% Input
%             locpath: path to egi 129  channel location
% Output
%               idx116  10-10 69 channels
%               idx12    10-20 21 channels
%               idx113  10-10 31 channels
% Note the appended three Fiducials at the first three lines
% See also systemDpendentParse from Automagic
% Shiang Hu, Aug 5, 2021


% CMI_EGI129.sfp
loc129 = readlocs(locpath);
loc129nm={loc129.labels};

% 10-20
Set12 = {'E22', 'E9', 'E11', 'E24', 'E124', 'E33', 'E122', ...
    'Cz', 'E36', 'E104', 'E45', 'E108', 'E52', 'E92' ...
    'E58', 'E96', 'E70', 'E75', 'E83', 'E62', 'E15'};
Val12 =   {'Fp1', 'Fp2', 'Fz', 'F3', 'F4', 'F7', 'F8', 'Cz', ...
    'C3', 'C4', 'T7', 'T8', 'P3', 'P4', 'P7', 'P8', 'O1', ...
    'Oz', 'O2', 'Pz', 'FPZ'};

% 10-10 32 channels
addpath('D:\OneDrive - CCLAB\Scripting\Toolbox\eeglab\sample_locs\')
% ls('E:\OneDrive - CCLAB\Scripting\Toolbox\eeglab\sample_locs\')
bv32 = readlocs('Standard-10-10-Cap33.locs');
bvnm = {bv32.labels};

% 10-10 69 channels
Set11 = {'E36', 'E104', 'Cz', 'E24', 'E124', 'E33', 'E122', 'E22', 'E9', ...
    'E15', 'E11', 'E70', 'E83', 'E52', 'E92', 'E58', 'E96',  ...
    'E23', 'E3', 'E26', 'E2', 'E16', 'E30', 'E105', 'E41', 'E103', 'E37', ...
    'E87', 'E42', 'E93', 'E47', 'E98', 'E55', 'E19', 'E1', 'E4', 'E27', ...
    'E123', 'E32', 'E13', 'E112', 'E29', 'E111', 'E28', 'E117', 'E6', ...
    'E12', 'E34', 'E116', 'E38', 'E75', 'E60', 'E64', 'E95', 'E85', ...
    'E51', 'E97', 'E67', 'E77', 'E65', 'E90', 'E72', 'E62', ...
    'E114', 'E44', 'E100', 'E46', 'E102', 'E57'};
Val11 =   {'C3', 'C4', 'Cz', 'F3', 'F4', 'F7', 'F8', 'FP1', 'FP2', ...
    'FPZ', 'Fz', 'O1', 'O2', 'P3', 'P4', 'P7', 'P8', 'AF3',...
    'AF4', 'AF7', 'AF8', 'Afz', 'C1', 'C2', 'C5', 'C6', 'CP1', 'Cp2', ...
    'CP3', 'CP4', 'Cp5', 'CP6', 'CpZ', 'F1', 'F10', 'F2', 'F5', 'F6', ...
    'F9', 'FC1', 'FC2', 'FC3', 'FC4', 'FC5', 'FC6', 'Fcz', 'Ft10', ...
    'FT7', 'FT8', 'Ft9', 'Oz', 'P1', 'P9', 'P10', 'P2', 'P5', 'P6', ...
    'PO3', 'PO4', 'PO7', 'PO8', 'Poz', 'Pz', 'T10',...
    'T9', 'TP10', 'Tp7', 'TP8', 'TP9'};

idx12 = zeros(length(Set12),1);
for i=1:length(Set12)
    idx12(i) = find(strcmp(loc129nm,Set12{i})==1);
end

idx113 =  zeros(length(bvnm),1);  % 10-10 32chans
for i=1:length(bvnm)
    temp=(find(strcmpi(Val11,bvnm{i})==1));
    if ~isempty(temp),     idx113(i) =temp; end
end

idx116 = zeros(length(Set11),1);  % 10-10 69chans
for i=1:length(Set11)
    idx116(i) = find(strcmp(loc129nm,Set11{i})==1);
end

idx113(idx113==0)=[]; idx113 = idx116(idx113);

% figure,subplot(141), topoplot([], locpath,'electrodes','pts','plotchans',idx12,'headrad',0.45); title('NC=21')
% subplot(142),topoplot([], locpath,'electrodes','pts','plotchans',idx113); title('NC=31')
% subplot(143),topoplot([], locpath,'electrodes','pts','plotchans',idx116); title('NC=69')
% subplot(144),topoplot([], locpath,'electrodes','pts'); title('NC=129');
% fg=gcf;fg.Position=[ 538         240        1017         393];
idx.id1=1:129;
idx.id2 = idx116;
idx.id3 = idx113;
idx.id4 = idx12;
end
