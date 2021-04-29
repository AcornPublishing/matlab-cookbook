%% CHAPTER 4, 2D NODE LINK PLOTS
%   3165_03_04: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-02-14 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load data
load characterCoOccurences

%% set up the figure and axes 
figure('units','normalized','Position',[ 0.1990    0.1324    0.4854    0.7731]);
mainAx = axes('position',[ 0.1361    0.0143    0.8042    0.8038]);

% set up a color map, reverse it so that low values are lighter (because
% you have a sparse matrix here
m = colormap(copper);
m = m(end:-1:1,:);
colormap(m);

% create the heatmap with surf plot
r=surf(lesMiserables);view(2);
% set the edgecolors to semi-transparent 
set(r,'edgealpha',0.2);
set(gca,'clim',[min(lesMiserables(:)) max(lesMiserables(:))]);

% position the colorbar
h=colorbar('northoutside'); 

% add tick labels
set(mainAx,'xAxisLocation','top','xtick',0:78,'xticklabel',{' ' LABELS{:} ' '},...
         'ytick',0:78,'yticklabel',{' ' LABELS{:} ' '},'ticklength',[0 0],'fontsize',8);
axis tight;
rotateXLabels(gca,90);

% reposition colorbar and axis, becaus ethey are impacted by tick label rotation
set(h,'position',[0.1006    0.9209    0.8047    0.0128]);
set(get(h,'title'),'String','Number of co-appearances of characters in Les Miserables by Victor Hugo','Fontsize',14);
set(mainAx,'position',[ 0.1361    0.0143    0.8042    0.8038]);

set(gcf,'color',[1 1 1],'paperpositionmode','auto');
box on;
print(gcf,'-dpng','./../3165_03_Images/3165_03_04_1.png');
