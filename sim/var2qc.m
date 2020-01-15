function [pro,rkr,EEG] = var2qc(V,elc,fs,nw,fm,varargin)
% VAR2QC


EEG = var2set(V,elc,fs);

if ~isempty(varargin)
    view_eegspt(EEG,varargin);
else
    view_eegspt(EEG);
end

EEG = pop_runica(EEG,'icatype','runica');
%     eeglab redraw;

% check how palos varies with # of ICs
[pro,rkr]= palos_varIC(EEG,nw,fm);
end