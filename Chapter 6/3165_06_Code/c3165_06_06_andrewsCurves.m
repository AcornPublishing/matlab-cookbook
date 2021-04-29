%% CHAPTER 6: ANDREWS CURVES
%   3165_06_06:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-05-21 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);
% load the data
load fisheriris 
[t curves] = andrewsCurves(meas);

groupIndex = unique(species);
colors = [1 0 0; 0 1 0; 0 0 1];
hold on;
for i = 1:length(groupIndex)
    idx = find(strcmp(species,groupIndex{i}));
    plot(t,curves(idx,:)','color',colors(i,:));
end

% annotate
title('\color{red} Andrews Plots \color{black} using the Fisher Iris dataset','Fontsize',14);
box on;
xlabel('t','Fontsize',12);ylabel('N data dimensions in transformed space','Fontsize',12);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_06_Images/3165_06_06_1' '.png']);
