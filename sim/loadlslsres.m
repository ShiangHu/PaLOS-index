
clean;

lslsres = dir('../lslsres/*.set');
fdpath = lslsres(1).folder;
name = {lslsres.name};


for i=1:length(lslsres)
    
    nm = name{i};
    
    EEG = pop_loadset([fdpath,filesep,nm]);
    
    close; viewictypes(EEG);
    
    saveas(gcf,[fdpath,filesep,nm(1:end-4),'.png']);
end