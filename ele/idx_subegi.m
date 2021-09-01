function idx = idx_subegi(chanlocs)
% pick the idx that matchs with the EGI129 system
% th idx is used to extract the gain matrix, etc.

% load orig
egiloc = readlocs('hbn129.sfp');
ele129 = {egiloc.labels};

%
ele = {chanlocs.labels};
idx = zeros(size(ele));

for i=1:length(ele)
idx(i) = find(strcmp(ele129,ele{i})==1);
end