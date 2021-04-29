%% CHAPTER 3, CONTOUR PLOTS
%   3165_03_06: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-02-14 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% load the data 
load('topo.mat');

%% set up the figure
figure('units','normalized','Position', [.1063 .4083 .513 .4963]);
axis equal
box on

%% set the colormap
colormap(topomap1);

%% try out the contour command with various optional arguments
% position contour lines beyond 3000, every 100 ft
contour(0:359,-89:90,topo,[1000:100:5800]); hold on;
set(gca,'clim',[min(topo(:)) max(topo(:))]);
% add a thick contour to 0 sea level to denote the land edge
contour(0:359,-89:90,topo,[0 0],'Linewidth',2); 

%% add colorbar
colorbar;

%% annotate
set(gca,'XLim',[0 360],'YLim',[-90 90], ...
    'XTick',[0 60 120 180 240 300 360], ...
    'Ytick',[-90 -60 -30 0 30 60 90]);
xlabel('Longitudes','Fontsize',14);
ylabel('Latitudes','Fontsize',14);
title({'Contour lines, using a topological colormap',...
       'Contours show elevation beyond 1000 ft, at 100 ft interval',...
       'Thick contour at sea level delineate land from sea'},...
    'Fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_03_Images/3165_03_06_1.png');

close;
%% How to create filled contours with non-uniform color scale?
% Define a color map with the handful of RGB values you will be using.
ColorMat = [255 255 255;       255 98 89;       255 151 99;       255 234 129;       227 249 149; ...      
    155  217 106;       76 202 130;       0 255 0;]/255; 
% Here is the definition for the Gaussian function (data generation step).
[X,Y] = meshgrid(linspace(0,1,50), linspace(0,1,50));
Z = exp(-(((X-.25).^2)./(2*.5^2) + ((Y-.5).^2)./(2*.5^2)));        
v=.5;
% Define the values at which you would like to change the contour color in the vector x.
x = [0,0.4,0.7,0.9,0.95,0.98,.99,1]; 
Nx = length(x);

% Now, construct the vector y as a fine grid from the lowest to highest values in your dataset 
% (0 and 1 in this example). For all values in y between two consecutive values in x, pad with 
% the greater of the two x values.
y = 0:0.005:1.0; 
for k=1:Nx-1, 
    y(y>x(k) & y<=	x(k+1)) = x(k+1); 
end

%Generate the color map corresponding to y, by interpolating the color map corresponding to x. 
cmap2 = [...
    interp1(x(:),ColorMat(:,1),y(:)) ...
    interp1(x(:),ColorMat(:,2),y(:)) ...
    interp1(x(:),ColorMat(:,3),y(:)) ...
    ]; 
% plot
surf(X,Y,Z); box on;                            
view(2);   
shading flat;      
% add colromap
colormap(cmap2);
clim = [0 1];
caxis(clim);
colorbar;
% annotate
xlabel('x'); ylabel('y');
title({'Figure shows the confidence levels for data modelled with a Gaussian function.',... 
       'The distance from the center is inversely proportional to the confidence level.',...
       'Figure colors the regions of the graph with high confidence level with',...
       'enhanced granularity, using a non-uniform color map.'});
  
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_03_Images/3165_03_06_2.png');
