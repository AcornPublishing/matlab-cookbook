%% CHAPTER 3, DENDROGRAMS AND CLUSTERGRAMS
%   3165_03_05:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-02-14 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load the data
load 14cancer.mat
data = [Xtrain(find(ytrainLabels==9),genesSet); Xtest(find(ytestLabels==9),genesSet)];

%% create the dendogram for the breast cancer samples and 100 genes of interest.
Z_genes =   linkage(pdist(data'));
Z_samples = linkage(pdist(data));

%% position the figure
figure('units','normalized','Position',[0.5641    0.2407    0.3807    0.6426]);
mainPanel = axes('Position',[.25 .08 .69 .69]);
leftPanel = axes('Position',[.08 .08 .17 .69]);
topPanel =  axes('Position',[.25 .77 .69 .21]);

%% make lower values lighter
m = colormap(pink); m = m(end:-1:1,:);
colormap(m);

%% plot the dendrograms - reveal all nodes for genes (without the 0, it will defaul to 30 nodes max)
axes(leftPanel);h = dendrogram(Z_samples,'orient','left'); set(h,'color',[0.1179         0         0],'linewidth',2);
axes(topPanel); h = dendrogram(Z_genes,0);set(h,'color',[0.1179         0         0],'linewidth',2);

%% get the ordering proposed by the dendrograms and heatmap the data
Z_samples_order = str2num(get(leftPanel,'yticklabel'));
Z_genes_order = str2num(get(topPanel,'xticklabel'));
axes(mainPanel);
surf(data(Z_samples_order,Z_genes_order),'edgecolor',[.8 .8 .8]);view(2);
set(mainPanel,'Xticklabel',[],'yticklabel',[]);

%% align the x and y axis
set(leftPanel,'ylim',[1 size(data,1)],'Visible','Off');
set(topPanel,'xlim',[1 size(data,2)],'Visible','Off');
axes(mainPanel);axis([1 size(data,2) 1 size(data,1)]);

%% add annotations
axes(mainPanel); xlabel('30 different genes','Fontsize',14); 
colorbar('Location','northoutside','Position',[ 0.0584    0.8761    0.3082    0.0238]); 
annotation('textbox',[.5 .87 .4 .1],'String',{'Expression levels', 'Leukaemia'},'Linestyle','none','fontsize',14);

%% special trick to show axis labels, even when axis is invisible
set(leftPanel,'yaxislocation','left');
set(get(leftPanel,'ylabel'),'string','Samples','Fontsize',14);
set(findall(leftPanel, 'type', 'text'), 'visible', 'on');

set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_03_Images/3165_03_05_1.png');
