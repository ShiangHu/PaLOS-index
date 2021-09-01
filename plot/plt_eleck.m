clean;

svfd =  'E:\CCLAB\ash - qceeg\4 HPD_atmg_rest\figure';

hbn3=load('pro_eleckhbn3.mat');
sbjnm = hbn3.sbjnm;
for i=1:length(sbjnm)
    tmp = sbjnm{i};
    sbjnm{i} = tmp(end-7:end-3);
end

% remove the subject 6
subid = [1:5,7:10]; 

% orig step
pro=hbn3.pro(:,:,1)';
save('pro_eleraw.mat','pro','sbjnm')

% end step (interpolation)
pro=hbn3.pro(:,:,2)';
save('pro_eleend.mat','pro','sbjnm')

fg=figure;
ax=subplot(211);
plt_stepidx('pro_eleraw',subid,ax);

ax=subplot(212);
plt_stepidx('pro_eleend',subid,ax);
fg.Position = [70  269 1037 706];
saveas(fg,fullfile(svfd,'fig_ele'),'svg');
