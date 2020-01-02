clc; clear;

ele = loadtxt('CMI_EGI129.sfp');

elc = cell2mat(ele(:,2:4));

save cmi_egi129.elc elc -ascii;

% executefile = fopen('cmi_egi129.txt','w');
% fprintf(executefile,strcat('cmi','\n',input1,'\n'));
% fclose(executefile);
% addpath('F:\OneDrive - Neuroinformatics Collaboratory\Archive\YaoLab\sph lead field calculation');
% system('LeadField.exe < cmi_egi129.txt');

G = importdata('Lead_Field.dat');
G = G';
G = G(4:132,:);
save G_cmi G;


