% pick the 58 channels from bst ICBM152>Generic>ASA 1020 94 pos

clc; 
tmp = load('/media/shu/hdd/toolbox/brainstorm3/defaults/eeg/ICBM152/channel_ASA_10-20_94.mat');
bst94 = upper(char({tmp.Channel.Name}));

EEG = pop_loadset('../lslsres/MC01.set');
chn58 = char({EEG.chanlocs.labels}');
chn58 = upper(chn58(:,1:end-4)); % remove '-ref'

[~,idx] = ismember(chn58,bst94,'rows');
strcmpi(chn58,bst94(idx,1:3))

tmp.Channel = tmp.Channel(idx);
tmp.Comment = 'ASA 10-20 (Cuba58)';
save('/home/shu/brainstorm_db/Protocol01/data/Subject02/@intra/channel_ASA_10-20_cuba58.mat','-struct','tmp');