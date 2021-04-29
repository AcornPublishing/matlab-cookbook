%% CHAPTER 6: RADIAL COORDINATE VISUALIZATION
%   3165_06_09:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-05-21 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);
% load the data
load 14cancer.mat
data = [Xtest; Xtrain];

% layout figure
set(gcf,'units','normalized','position',[.30 .35 .35 .55]);

%normalize
for i =1:size(data,2)
    data(:,i) = data(:,i)./range(data(:,i));
end
% calculate the radial coordinate visualization
[ux uy] = radviz(data);

%select a color pallete to color each marker by cancer type
colors = colormap;
colors = colors(round(linspace(1,64,14)),:);

% plot the 2D projection data with marker color determined by cancer type
hold on;
for i = 1:14
    mm=find([ytestLabels ytestLabels]==i);
    plot(ux(mm),uy(mm),'.','Markersize',30,'color',colors(i,:));     
end
% plot a radial border
plot(cos((pi/180)*linspace(0,360,361)),sin((pi/180)*linspace(0,360,361)),'.','markersize',2);
% add annorarion
legend(strtrim(classLabels),'location','bestoutside');
set(gca,'Fontsize',12);
title({'\color{red}Radial Coordinate Visualization \color{black}. 16063 gene expression ',...
       'levels per sample plotted in 2D space',...
       'Figure shows this data is not separable in 2D space',''},'Fontsize',12);
% set the view
axis equal square
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_06_Images/3165_06_09_1' '.png']);

