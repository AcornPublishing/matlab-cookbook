%% CHAPTER 3, CHOROPLETH MAPS
%   3165_03_08:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-02-14 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load the data
[deathRates stateNames] = xlsread('cancerByRegion.xlsx');
stateNames = {stateNames{2:end,1}};
load('USStateboundaries.mat');

%% Choropleth map with cancer incidence data by state
% Layout the map
figure('units','normalized','Position',[.11 .34 .48 .56]);
% set the color scale between the max and min data to present
climMat = [min(deathRates(:,1)) max(deathRates(:,1))];
set(gca,'clim',climMat); hold on;
m = colormap;
% for each state,
for i = 1:49    
    % extract the data value for this state
    dataPoint = deathRates(find(strcmp(states(i).Name, stateNames)),1);
    % extract the color index into the color map that corresponds to this
    % data value
    index = fix((dataPoint-climMat(1))/(climMat(2)-climMat(1))*63)+1;
    % draw a filled polygon (fill color corresponding to colormap value at
    % aforementioned index position
    % need to delete NaN values for fully connected polygon
    fill(states(i).Lon(~isnan(states(i).Lon)), states(i).Lat(~isnan(states(i).Lat)),m(index,:));
end
% annotate
title({'Age adjusted rate of incidence of cancer across all races from 2003 - 2007'},'Fontsize',14);
% dont want to see axis
set(gca,'visible','off');
% but want to see title on invisble axis
set(findall(gca, 'type', 'text'), 'visible', 'on');
% add a color bar
h=colorbar('Location','Southoutside');
xlabel(h,'Rate is reported as number per 100,000 population','Fontsize',13);

set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_03_Images/3165_03_08_1.png');

%% Alternately, doing the above, using the mapping toolbox (not included in textual description of the book)
ax = usamap('conus');
states = shaperead('usastatelo', 'UseGeoCoords', true,...
  'Selector',...
  {@(name) ~any(strcmp(name,{'Alaska','Hawaii'})), 'Name'});

mapStateNames = {states.Name}';
climMat = [min(deathRates(1,:)) max(deathRates(1,:))];
set(gca,'clim',climMat);
cmap = colormap;

for i = 1:length(mapStateNames)
    if ~isempty(find(strcmp(mapStateNames{i}, stateNames)))
        dataInOrder(i) = deathRates(find(strcmp(mapStateNames{i}, stateNames)),1);                
        index = fix((dataInOrder(i)-climMat(1))/(climMat(2)-climMat(1))*length(cmap))+1;
        if index > length(cmap)
            index = length(cmap);
        elseif index <1 
            index = 1;
        end
        colorMap2(i,:) = cmap(index,:);        
    end
end

faceColors = makesymbolspec('Polygon',...
    {'INDEX', [1 numel(states)], 'FaceColor', ... 
    colorMap2}); 

geoshow(ax, states, 'DisplayType', 'polygon', ...
   'SymbolSpec', faceColors);
colorbar('Location','Southoutside');
title({'Age adjusted rate of incidence of Cancer (all types','across all populations) from 2003 - 2007'},'Fontsize',14);
framem off; gridm off; mlabel off; plabel off
