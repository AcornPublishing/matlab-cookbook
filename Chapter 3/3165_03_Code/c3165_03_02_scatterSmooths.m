%% CHAPTER 3, SCATTER PLOT SMOOTHING
%   3165_03_02:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-02-14 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% data generation
z = [repmat([1 2],1000,1) + randn(1000,2)*[1 .5; 0 1.32];...
     repmat([9 1],1000,1) + randn(1000,2)*[1.4 .2; 0 0.98];...
     repmat([4 8],1000,1) + randn(1000,2)*[1 .7; 0  0.71];];

%% raw data plot
figure('units','normalized','position',[ 0.4458    0.6296    0.1995    0.2759]);
plot(z(:,1),z(:,2),'.');
title({'Original data','The scatter plot view has significant overplotting'});
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_03_Images/3165_03_02_1.png');


%% density plots
figure;
densityPlot2D(z(:,1),z(:,2),100);
print(gcf,'-dpng','./../3165_03_Images/3165_03_02_2.png');

%% scatter plot smooth
figure;
scatterPlotSmooth2D(z(:,1),z(:,2),.1,100);
print(gcf,'-dpng','./../3165_03_Images/3165_03_02_3.png');
