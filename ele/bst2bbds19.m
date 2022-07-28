% match the ele order from the BST ICBM152 aligned 10-20 cap with bbds19

sptkit = 'D:/OneDrive - CCLAB/Scripting/Toolbox/sptkit/';
addpath(sptkit);
% eeglabstart(''); clean;

bbds19 = readlocs('19Cuba10-20.locs');

lb = {bbds19.labels}';

BSTdir = 'D:\OneDrive - CCLAB\Scripting\Toolbox\brainstorm\brainstorm3';
icbm19 = load(fullfile(BSTdir,'defaults\eeg\ICBM152\channel_10-20_19.mat'));

lb_icbm = {icbm19.Channel.Name}';

idx = zeros(19,1);

for i=1:19
    tmp = lb{i};
    if strcmp(tmp,'T7')
        tmp = 'T3';
    elseif strcmp(tmp,'T8')
        tmp = 'T4';
    elseif strcmp(tmp,'P7')
        tmp = 'T5';
    elseif strcmp(tmp,'P8')
        tmp = 'T6';
    end
    
idx(i) = find(strcmpi(lb_icbm, tmp)==1);
end

save idx2bbds idx;
