clean;

% Bar plot for stepwise PaLOS index and reference applized
figure,
ax1=subplot(131); plotsteppidx('pidxcmi40cz.mat',ax1); title('Cz');
ax1=subplot(132); plotsteppidx('pidxcmi40ar.mat',ax1); title('AR');
ax1=subplot(133); plotsteppidx('pidxcmi40rt.mat',ax1); title('REST');

% Histogram for raw and prep by automagic or clean windows for barbados and
% Cuba 2004
cmiraw = load('pro_cmi_raw');            cmiatmg = load('pro_cmi_prep');
cubaraw = load('pro_c04_raw_cz');    cubacln = load('pro_c04_cln_cz');
bbdsraw = load('pro_bbds_raw_cz'); bbdscln = load('pro_bbds_cln_cz');
result = struct('cmiraw',cmiraw,'cmiatmg',cmiatmg,'cubaraw',cubaraw,'cubacln',...
    cubacln,'bbdsraw',bbdsraw,'bbdscln',bbdscln);
pro = [cmiraw.pro;cmiatmg.pro;cubaraw.pro;cubacln.pro;bbdsraw.pro;bbdscln.pro];
step = [repmat('CMI-raw ',size(cmiraw.pro)); repmat('CMI-atmg',size(cmiatmg.pro));...
    repmat('Cuba-raw',size(cubaraw.pro)); repmat('Cuba-cln',size(cubacln.pro));...
    repmat('Bbds-raw',size(bbdsraw.pro)); repmat('Bbds-cln',size(bbdscln.pro))];

figure,
fieldnm = {'cmiraw','cmiatmg','cubaraw','cubacln','bbdsraw','bbdscln'};
m=3;n=4; q = {[1,2,5,6,9,10],3,4,7,8,11,12};
for i=1:length(fieldnm)+1
    subplot(m,n,q{i});
    if i==1
        boxplot(pro,step); xlabel(''), ylabel('PaLOS index (r)'), set(gca,'fontsize',12)
    else
        tt = fieldnm{i-1}; histogram(getfield(result,tt,'pro'),'normalization','count');
        title(tt), xlim([0 1]); xlabel('QC metric'), set(gca,'fontsize',12)
    end
end