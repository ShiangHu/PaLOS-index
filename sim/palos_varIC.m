function [pro,rkr]= palos_varIC(EEG,nw,fm) 
% check how palos changes with number of ICs retained
% Input
%        EEG --- EEGLAB structure with ica weights
%          nw --- time-bandwidth product
%           fm --- cutting off maximum frequency



nic = size(EEG.icaact,1);
pro = zeros(nic,1);
rkr = zeros(nic,4);
fs = EEG.srate;

for n=1:nic
V = EEG.icawinv(:,1:n)*EEG.icaact(1:n,:);

[pro(n), rkr(n,:)] = qcspectra(V,nw,fs,fm);
disp([n pro(n), rkr(n,:)]);

end

figure,
subplot(121), 
plot(pro,'linewidth',2), xlim([1 58]),ylim([0 1]), axis square;
xlabel('# of  ICs retained'),  ylabel('PaLOS index');set(gca,'fontsize',12);
subplot(122),
plot(rkr(:,1),'linewidth',2),xlim([1 58]); ylim([1 58]); axis square;
xlabel('# of  ICs retained'), ylabel('Rank of EEG');set(gca,'fontsize',12);
end