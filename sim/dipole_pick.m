function d = dipole_pick(coordinates,nd)
% DIPOLE_PICK pick the dipoles for simulation from the iEEG cortex
% here the sEEG activities are taken as the dipolar time series  
% Input
%         nd: # of dipoles
% coordinates: coordinates of the sEEG channels

switch nd
    case 1
        d = 152;  % emperically selected from bst plot
        
    case 2
%         d = [1182 830]; % right frontal - left occiptal 
        d = [1058 1059]; % right occipital
        
    case 3
        
        d = [1058 1059 1060];
        
        
    otherwise    
        rng('default');
        d = randsample(size(coordinates,1),nd);

end

end