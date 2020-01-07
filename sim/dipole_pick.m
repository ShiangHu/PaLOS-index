function d = dipole_pick(Gridloc,nd)
% pick the dipoles for simulation from the iEEG cortex
% Input
%         nd: # of dipoles
switch nd
    case 1
        d = 7019;
        
    case 2
        d1 = 21822; % right frontal
        d2 = 1821;     % left occiptal
        d = [d1 d2];
        
    otherwise    
        d = randsample(size(Gridloc,1),nd);

end

end