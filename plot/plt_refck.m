clean;

svfd =  'E:\CCLAB\ash - qceeg\4 HPD_atmg_rest\figure';

load('pro_ref_hbn3.mat');

% remove the subject 6
subid = [1:5,7:10]; 

% Cz
procz.pro=pro(:,:,1);
procz.sbjnm=sbjnm;
procz.stepnm=stepnm;
save procz;
% AR
proar.pro=pro(:,:,2);
proar.sbjnm=sbjnm;
proar.stepnm=stepnm;
save proar;
% REST
prort.pro=pro(:,:,3);
prort.sbjnm=sbjnm;
prort.stepnm=stepnm;
save prort;

fg = figure; fg.Position = [276 116 1231 865];
ax1 = subplot(311);
plt_stepidx('procz',subid,ax1); title('Cz'); 
legend(ax1,'location','best');

ax2 = subplot(312);
plt_stepidx('procz',subid,ax2); title('AR');  legend('hide');

ax3 = subplot(313);
plt_stepidx('procz',subid,ax3); title('REST'); legend('hide');


saveas(fg,fullfile(svfd,'fig_ref'),'svg');
