
clean;
mneeg_path = 'D:\CCLAB\Multinational EEG';
mnpath = 'D:\CCLAB\CCC-Internal Project - Multinational EEG Norms by Dataset';
nations = dir(mnpath);
nations = nations([nations.isdir]);
nations = nations(3:17);
country_list = {nations.name};

chan = eeg_checkchanlocs(readlocs('19Cuba10-20.loc'));

for n=1:length(country_list)
    nation_nm = nations(n).name;
    disp(['==============',nation_nm,'==============>>',newline,newline])
    
    one_nation = dir(fullfile(nations(n).folder,nation_nm,'*.mat'));
    
    for i = 1:length(one_nation)
        try
            load(fullfile(one_nation(i).folder,one_nation(i).name),'data_struct');
            EEG = eeg_emptyset;
            EEG.filename = data_struct.name;
        catch
            continue;
        end
        
        EEG.srate = data_struct.srate;
        EEG.nbchan = data_struct.nchan;
        EEG.ref = data_struct.ref;
        EEG.data = reshape(data_struct.data,[size(data_struct.data,1), size(data_struct.data,2)*size(data_struct.data,3)]);
        EEG.chanlocs = chan;
        EEG.etc.age = data_struct.age;
        EEG.etc.amp = data_struct.EEGMachine;
        EEG.etc.cnm = data_struct.pais;
        EEG.etc.sex = data_struct.sex;
        EEG = eeg_checkset(EEG);
        data_struct = [];
        
        datapath = fullfile(mneeg_path,nation_nm,one_nation(i).name(1:end-4));
        crtfd(datapath);
        pop_saveset(EEG,'filepath',datapath,'filename',[one_nation(i).name(1:end-4),'.set'],'savemode','onefile');
    end
end