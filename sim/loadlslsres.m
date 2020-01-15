
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

% view the ic type ratios
cab; EEG = pop_loadset; viewictypes(EEG);

% view the component from any subject
cab;
sptopt = {'freqrange', [0.5 50]};
pop_prop_extended(pop_loadset,0,20,nan,sptopt,{},0);