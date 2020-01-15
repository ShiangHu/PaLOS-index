function noise = recoartifacts(ic,k)
% emperically select the typical mulse/channel/eye/line/other artifacts
% first review the IC type ratios of not a few cases after amica and iclabel
% Input
%        ic --- struct 
%                 ic.folder, ic.name, ic.idx, ic.type
%        k --- the kth group of different types of actifact ICs

% Read Also viewictypes, selectics


datapath = '/media/shu/hdd/Quality check/lslsres';
noise = zeros(58,12800); % size depends on V
sptopt = {'freqrange', [0.5 50]};
ictypes = fieldnames(ic);

for i=1:length(ictypes)
    tp = getfield(ic, ictypes{i},{k});   % the kth combination
    nm = [datapath,filesep,tp.name,'.set'];
    icidx = tp.idx;
    EEG = pop_loadset(nm);
    
    if nargin>1, cab; pop_prop_extended(EEG,0,icidx,nan,sptopt,{},0); end
    
    chnid = EEG.icachansind;
    tid = 1:size(EEG.data,2);
    if length(tid)>12800, tid = 1:12800; end
    noise(chnid,tid) = noise(chnid,tid) + EEG.icawinv(:,icidx)*EEG.icaact(icidx,tid);
    
end