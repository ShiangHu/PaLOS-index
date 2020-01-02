% check how the chanlocs info is saved for each step of automagic

clean;
ele = readlocs('CMI_EGI129.sfp'); % default loc file from HBN database

results = dir(fullfile(cd,'Automagic','**','allSteps*.mat'));
stepnm = {'EEGOrig','EEGprep','EEGfiltered','EEGRegressed','EEGMARA','EEGip'};

for i= 1:length(results)
    disp(i);
    filename = results(i).name;
    file = fullfile(results(i).folder,filename);
    allStep = load(file);
    
    
    for j=1:6
        step = stepnm{j};
        eles = getfield(allStep,step,'chanlocs');
        
        for q = 1:length(eles)
            urchan = eles(q).urchan;
            disp(strcat(eles(q).labels,ele(urchan).labels));
            if ~strcmp(eles(q).labels,ele(urchan).labels)
                warning(strcat(q,' in ',step,'mismatch'));
            end
        end
        
    end
    
    
end
