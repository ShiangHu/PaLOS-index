% summary plot for simulation

load pro;

figure,semilogx(1:1772,pro),xlim([1 1772]); 


nd =unique(round(logspace(0,log10(1772),20)));

figure,semilogx(nd,pro(nd))