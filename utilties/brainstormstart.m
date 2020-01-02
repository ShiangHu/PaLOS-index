function brainstormstart(varargin)
% add brainstorm toolbox
addpath('E:\OneDrive - Neuroinformatics Collaboratory\Scripting\Toolbox\brainstorm\brainstorm3');
if nargin==0
    brainstorm
else
brainstorm nogui;
end
end