%% CHAPTER 5, 3D SCATTER PLOTS
%   3165_05_01: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-04-16 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

% Load the data
load latticeExample
xx = x(:);yy = y(:);zz = z(:);
% locate the non-zero points
a = find(T~=0);
% plot the non-zero points using a scatter plot
% use the values of T to represent both color and size of symbols
scatter3(xx(a),yy(a),zz(a),1000*T(a),T(a),'filled');
% set the view
view(3); 
campos([ -7.8874 -217.1200   13.7208]);
%add colorbar to read Energy values
h=colorbar;set(get(h,'ylabel'),'String','Probability values');
% add annotations
ylabel('Lattice Y');
xlabel('Lattice X');
zlabel('Lattice Z');
title('3D Scatter plot with electron hopping probability at each point in a lattice');
grid on; box on;
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_01_1' '.png']);

%% Interaction cloud
figure('units','normalized','position',[.24 .28 .41 .63]);
% smooth the data in 3D space using a Gaussian filter
data = smooth3(TB_Eigen,'gaussian');
% unwrap the smoothed data
d = data(:);

%% generate color values for each point by querying the color map
idx = find(d~=0);
cmapH(:,1:3) = colormap;
cmin=min(5*d(idx));cmax=max(5*d(idx));
caxis([cmin cmax]);
Cidxs = fix((5*d(idx)-cmin)/(cmax-cmin)*length(cmapH))+1;
Cidxs(find(Cidxs>64))=64;

%% generate alpha values for each point by querying the alpha map 
% generate the alpha map (with 100 levels)
idx = find(d~=0);
amapH = linspace(0,1,100);
% to make highest value most transparent, reverse the alpha map
amapH = amapH(end:-1:1);
amin=min(d(idx));amax=max(d(idx));
Aidxs = fix((d(idx)-amin)/(amax-amin)*length(amapH))+1;
Aidxs(find(Aidxs>100))=100;

%% bubbleplot3(x,y,z,r,c,alpha) 
% is a three-dimensional bubbleplotter, bubbles of radii r 
% are plotted at x, y, z. c is a rgb-triplet for color. alphadata plots the
% bubbles at said transparency.
bubbleplot3(xx(idx),yy(idx),zz(idx),5*d(idx),cmapH(Cidxs,:),amapH(Aidxs)); 

%% set the view
view(3);
axis([min(xx) max(xx) min(yy) max(yy) min(zz) max(zz)]);box on;
campos([-80.6524  -54.7234   44.2951]);
zoom(1.2);

%% add annotation
ylabel('Lattice Y','Fontsize',14);
xlabel('Lattice X','Fontsize',14);
zlabel('Lattice Z','Fontsize',14);
title({'3D scatter plot with electron hopping probability cloud at each point in a lattice.',...
       'Probability directly proportional to cloud size and color;','inversely proportional to transparency.',''},'Fontsize',14);
h=colorbar('location','SouthOutside','position',[ 0.1286    0.0552    0.7750    0.0172]); 
set(get(h,'title'),'string','Probability value color key');

set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_01_2' '.png']);
