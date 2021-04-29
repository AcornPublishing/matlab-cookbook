%% CHAPTER 3, THEMATIC MAPS WITH SYMBOLS
%   3165_03_09: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-02-14 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load data
load topo

%% layout the figure
figure('units','normalized','position',[.36 .42 .38 .48]);

%% define grids
xx = [0:180 -179:-1];
yy = -89:90;
[XX, YY] = meshgrid(xx,yy);

%% calculate the gradient
[FX,FY] = gradient(topo);

%% place the background topography map with special colormap. 
% Make it semi-transparent to be able to see the additional information you will be overlaying 
surf(xx,yy,topo);shading interp;view(2);colormap(topomap1);hold on;alpha(.5);

%% place the gradient data with quiver
quiver(XX,YY,FX,FY,1.7,'Color',[0 0 0],'linewidth',1.5);

%% focus on region of interest
xlim([65 110]); ylim([18 44]);

%% add contour lines joining area of equal interval (beyond 1000 ft, every 1500 ft)
[C, h] = contour(xx,yy,topo,[1000:1500:max(topo(:))],'Color',[.8 .8 .8],'linewidth',1);
% add text labels to contour lines
text_handle = clabel(C,h);
set(text_handle,'BackgroundColor',[1 1 .6],'Edgecolor',[.7 .7 .7],'fontweight','bold')

%% add annotations for overall graph
title({'A topographical map of the Himalayan region',...
       'Arrows show the gradient (magnitude and direction);',...
       'Contour lines join areas of equal elevation'},'Fontsize',14);
xlabel('Longitudes','Fontsize',14);
ylabel('Latitudes','Fontsize',14);

set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_03_Images/3165_03_09_1.png');
