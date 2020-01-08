
%
% eeglabstart;
% brainstormstart('');
clean;
addpath(genpath(cd));
addpath(genpath('/media/shu/hdd/iEEG study'));
nd = 1; % 1 - 1772

[K, J, dipinfo] = kjconfig(nd);
% forward
V = K*J;

% check the spectopo
nm = 'Simulation from iEEG';
psdnm = [nm,'_PSD'];
elc = 'bst63.xyz';
eegplot(V,'title',nm,'plottitle',nm,'srate',200,'winlength',20,'eloc_file',elc);
figure('name',psdnm,'NumberTitle','off'),
spectopo(V,0,200,'percent',15,'freq',2:2:30,'title',psdnm,'chanlocs',elc,'electrodes','off');


fs = 200; % Hz
fm = 77/2.56; % maximum frequency
nw = 3;
pro = qcspectra(V,nw,fs,fm)

% K = importdata('G_cmi.mat');
% J = importdata('data/MC0000001_A.mat');