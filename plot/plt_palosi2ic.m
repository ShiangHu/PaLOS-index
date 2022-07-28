clean;
%% barbados
ttl1 = 'bbdssim_18raw';
ttl2 = 'bbdssim_18cln';
raw = load(ttl1);
cln = load(ttl2);

[~,id_raw] = fileparts({raw.datstr.folder});

figure,
for i=1:50
    subplot(5,10,i),
    [~,id_cln] = fileparts(cln.datstr(i).folder);
    j = find(strcmp(id_cln,id_raw)==1);
    disp(j)
    
    plot([raw.pro(:,j) cln.pro(:,i)],'linewidth',2);
    xlabel('# of ICs retained'); ylabel('PaLoSi'); title(id_cln);
    %     set(gca,'xtick',1:size(pro,1),'xticklabel',num2str(class_id(:,i)))
end

legend({'raw','clean windows'});

%% Cuba
ttl1 = 'palos_sim_cuba_raw';
ttl2 = 'palos_sim_cuba_cln';
raw = load(ttl1);
cln = load(ttl2);

[~,id_raw] = fileparts({raw.datstr.folder});

figure,
for i=1:50
    subplot(5,10,i),
    [~,id_cln] = fileparts(cln.datstr(i).folder);
    j = find(strcmp(id_cln,id_raw)==1);
    disp(j)
    
    plot([raw.pro(:,j) cln.pro(:,i)],'linewidth',2);
    xlabel('# of ICs retained'); ylabel('PaLoSi'); title(id_cln);
    %     set(gca,'xtick',1:size(pro,1),'xticklabel',num2str(class_id(:,i)))
end

legend({'raw','clean windows'});

%% Ger
ttl1 = 'gersim_ec_raw';
ttl2 = 'gersim_ec_cln';
raw = load(ttl1);
cln = load(ttl2);

% removing the zeros
cln.datstr(cln.pro(1,:)==0) = [];
cln.pro(:, cln.pro(1,:)==0) = [];
cln.class_id(:, cln.pro(1,:)==0) = [];

id_raw = {raw.datstr.name};

figure,
for i=1:50
    subplot(5,10,i),
    
    id_cln = cln.datstr(i).name(1:end-7);
    j = find(strcmp([id_cln '.set'],id_raw)==1);
    
    plot([raw.pro(1:56,j) cln.pro(1:56,i)],'linewidth',2);
    xlabel('# of ICs retained');
    %     set(gca,'xtick',1:size(pro,1),'xticklabel',num2str(class_id(:,i)))
    ylabel('PaLoSi');
    title([id_cln(1:10)]);
end

legend({'raw','preprocessed'});
% legend({'raw','clean windows'});


%% Ger cleaned by clean_rawdata
ttl1 = 'palos_sim_Ger_cleanraw';
ttl2 = 'gersim_ec_cln';

raw = load(ttl1);
cln = load(ttl2);

% removing the zeros
raw.datstr(raw.pro(1,:)==0) = [];
raw.pro(:, raw.pro(1,:)==0) = [];
raw.class_id(:, raw.pro(1,:)==0) = [];

cln.datstr(cln.pro(1,:)==0) = [];
cln.pro(:, cln.pro(1,:)==0) = [];
cln.class_id(:, cln.pro(1,:)==0) = [];

id_raw = {raw.datstr.name};

figure,
for i=1:50
    subplot(5,10,i),
    
    id_cln = cln.datstr(i).name(1:end-7);
    j = find(strcmp([id_cln '.set'],id_raw)==1);
    
    plot([raw.pro(1:56,j) cln.pro(1:56,i)],'linewidth',2);
    xlabel('# of ICs retained');
    %     set(gca,'xtick',1:size(pro,1),'xticklabel',num2str(class_id(:,i)))
    ylabel('PaLoSi'); ylim([0 1]);
    title([id_cln(1:10)]);
end

legend({'raw crd','preprocessed'});
