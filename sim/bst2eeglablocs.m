% build the eeglab locs in matching with the ICBM152 chn65 from brainstorm
clean;

% load bst
bst = load('/home/shu/brainstorm_db/Protocol01/data/Subject01/@intra/channel_10-10_65.mat');
bst = {bst.Channel.Name};
bst([19 20]) = [];
bst(13:16) = {'T8','T7','P8','P7'};
bst = upper(char(bst));

% load EEGLAB
std = readlocs('/media/shu/hdd/toolbox/eeglab14_1_2b/sample_locs/Standard-10-20-Cap81.ced');
stdnm = upper(char({std.labels}));
[~,idx] = ismember(bst,stdnm,'rows');

strcmp(bst,stdnm(idx,:))

std = std(idx);

writelocs(std,'bst63.xyz','filetype','xyz');

