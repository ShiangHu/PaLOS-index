function [idx,pvaf_desc,meanvar,maxvar] = view_icsort(EEG)
% VIEW_ICSORT sort the ICs by its variances in 3 ways
%

% Read Also ICAVAR, VARSORT, COMPVAR, COMPDSP, COMPMAP, COMPPLOT, COMPSORT
%                 COMPHEADS, COMPONENT_PROPERTIES, POP_SUBCOMP,
%                 POP_SELECTCOMPS, POP_SELECTCOMPS_ADJ, POP_SELECTCOMPS_MARA


%---------------Independent component analysis-----------------------------
%                 RUNICA, ICADEFS, ICACT, ICAPROJ, ICAPLOT, ZICA,  FPICA,
%                 SASICA, BINICA, REGICA, TESTICA, FASTICA, POP_ICATHRESH,
%                 EEG_ICALABELSTAT, EEG_GETICA, POP_EXPICA, LMS_REGICA
%                 POP_RUNAMICA,
%---------------------------------------------------------------------------------------

% Shiang Hu, Jan. 15, 2020

nic = size(EEG.icaact,1);
pvaf = zeros(nic,1);

X = EEG.data;
S = EEG.icaact;
A = EEG.icawinv;
W = EEG.icaweights;
M = EEG.icasphere;

% projected variance accounted for by eeg data
for i=1:nic
    [~, pvaf(i)] = compvar(X, S, A, i);
end
[pvaf_desc,idx.pva] = sort(pvaf,'descend');

% AVERAGED projected variance across time
[idx.apv,meanvar] = varsort(S,W,M);

% MAX projected variance across time
[idx.mpv,maxvar] = compsort(X,W,M);

% view
nm = {'PVA','APV','MPV'};
figure, plot([idx.pva,idx.apv,idx.mpv],'linewidth',2);
legend(nm); xlabel('# of ICs');
set(gca,'fontsize',12); axis square; xlim([1 nic]);

tmp = EEG;
nm = lower(nm);
figure,
for i=1:3
    h = subplot(1,3,i);
    id = getfield(idx,nm{i},{1:nic});
    tmp.filename = ['ICs resorted', ' ', nm{i}];
    view_ictypes(tmp,h,id);
end
set(gcf,'Position',[1793 1 853 960]);
end