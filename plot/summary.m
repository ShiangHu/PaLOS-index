clean;
initpalos;
% Bar plot for stepwise PaLOS index and reference applized
% figure,
% ax1=subplot(131); plotsteppidx('pidxcmi40cz.mat',ax1); title('Cz');
% ax1=subplot(132); plotsteppidx('pidxcmi40ar.mat',ax1); title('AR');
% ax1=subplot(133); plotsteppidx('pidxcmi40rt.mat',ax1); title('REST');

% Histogram for raw and prep by automagic or clean windows for barbados and
% Cuba 2004
HBNraw = load('pro_cmi_raw');            HBNatm = load('pro_cmi_prep');
CBMraw = load('pro_c04_raw_cz');     CBMcln = load('pro_c04_cln_cz');
BNSraw = load('pro_bbds_raw_cz');   BNScln = load('pro_bbds_cln_cz');

result = struct('HBNraw',HBNraw,'HBNatm',HBNatm,'CBMraw',CBMraw,'CBMcln',CBMcln,'BNSraw',BNSraw,'BNScln',BNScln);

pro = [HBNraw.pro;HBNatm.pro;CBMraw.pro;CBMcln.pro;BNSraw.pro;BNScln.pro];
step = [repmat('HBNraw',size(HBNraw.pro)); repmat('HBNatm',size(HBNatm.pro));...
    repmat('CBMraw',size(CBMraw.pro)); repmat('CBMcln',size(CBMcln.pro));...
    repmat('BNSraw',size(BNSraw.pro)); repmat('BNScln',size(BNScln.pro))];

figure,
fieldnm = {'HBNraw','HBNatm','CBMraw','CBMcln','BNSraw','BNScln'};
m=3;n=4; q = {[1,2,5,6,9,10],3,4,7,8,11,12};
for i=1:length(fieldnm)+1
    subplot(m,n,q{i});
    if i==1
        boxplot(pro,step); xlabel(''), ylabel('PaLoSi (r)'), set(gca,'fontsize',12)
    else
        tt = fieldnm{i-1}; histogram(getfield(result,tt,'pro'),'normalization','probability','binwidth',0.05);
        title(tt), xlim([0 1]);  set(gca,'fontsize',12)
%         xlabel('QC metric');
if i>2, ylim([0 0.3]); end
    end
end

fig=gcf; fig.Position=[423         276        1188         542];
saveas(fig,fullfile(outputfig,'figure2'),'svg');