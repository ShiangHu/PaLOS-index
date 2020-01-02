% clc;clear;close all;
% load iris_dataset;
% 
% S1 = cov(irisInputs(:,1:50)');
% S2 = cov(irisInputs(:,51:100)');
% S3 = cov(irisInputs(:,101:150)');
% S = [S1,S2,S3];
% S = reshape(S,[4,4,3]);
% n = [50 50 50];
% lmax = 500;
% 
% [Lambda,Q] = CPCstepwise1(S,n,lmax);


clc;clear;close all;
load Svv;
S = Svv_rest;
ns = 128;
nw = 4;
n = ns*2*nw*ones(1,size(S,3));
pmax =104;
lmax = 50;
tic;
[Lambda,Q] = CPCstepwise1(S,n,pmax,lmax);
toc;

figure, semilogy(real(Lambda'))
figure, imagesc(abs(Q))
% t = cumsum(sum(abs(Lambda),2))/sum(abs(Lambda(:))); figure, plot(t)
% t = (sum(abs(Lambda),2))./sum(abs(Lambda(:))); figure, plot(t)
figure, pareto(sum(abs(Lambda),2)./sum(abs(Lambda(:))));

figure, 
for i=1:8
    subplot(2,4,i)
    topoplot(abs(Q(:,i)),'105.ced'), title(num2str(i))
end