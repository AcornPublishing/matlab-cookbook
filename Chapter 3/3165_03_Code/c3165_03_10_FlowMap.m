%% CHAPTER 3, FLOW MAPS
%   3165_03_10: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-02-14 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load the itinerary info
load romanHoliday

%% Get the map using Google API
% Parameter Definition
height = 640;
width = 640;
% construct the query string with all the lat/lon balues
pos = [];
for i = 1:length(Lats)-1
    pos= [pos num2str(Lats(i)) ',' num2str(Lons(i)) '&markers='];
end
pos = ['http://maps.google.com/staticmap?markers=' pos num2str(Lats(end)) ',' num2str(Lons(end)) '&size=' num2str(width) 'x' num2str(height) '&scale=2']; % '&maptype=satellite'

% retrieve as image from google maps
[I map]=imread(pos,'gif');
RGB=ind2rgb(I,map);
figure('units','normalized','position',[.09 .09 .34 .81]);
% plot the image
mapPanel = axes('position',[.11 .36 .78 .57]);
image(RGB);hold on;

% References:
% http://www.maptiler.org/google-maps-coordinates-tile-bounds-projection/
% http://developers.google.com/maps/documentation/staticmaps/

%% Set x y tick labeling and limits
axes(mapPanel);
set(gca,'XTickLabel',[],'YTickLabel',[]);
xlim([170 466 ]); ylim([110 528]);box on;

%% Delcare the additional flow info panel
metaPanel = axes('position',[.11 .11 .78 .25]);ylim([0 12]);xlim([170 466 ]);
set(metaPanel,'ytick',1:11,'yticklabel',{'Day 1','Day 2','Day 3','Day 4','Day 5','Day 6','Day 7','Day 8','Day 9','Day 10','Day 11'});
[bl I] = sort(X);
set(metaPanel,'xtick',X(I),'xticklabel',stops(I));
rotateXLabels(metaPanel,90);
grid on;hold on;

%% Plot the path showing length of stay at each stop and method of transporation between stops
for i = 1:7
    j = i+1;
    if i==7, 
        j = 4;
    end
    axes(mapPanel);
    if strcmp( meansOfTransportation{i},'Road')
        c = [0 0 1];
        line([X(i) X(j)],[Y(i) Y(j)],'Color',[0 0 1],'linewidth',2);
    elseif strcmp( meansOfTransportation{i},'Air')        
        c = [0 .3 0];
        line([X(i) X(j)],[Y(i) Y(j)],'Color',[0 .3 0],'linewidth',2);        
    elseif strcmp( meansOfTransportation{i},'Train')
        c = [1 0 0];
        line([X(i) X(j)],[Y(i) Y(j)],'Color',[1 0 0],'linewidth',2);        
    end    
    
    axes(metaPanel);
    if i==1
        fill([X(i)-5 X(i)+5 X(i)+5 X(i)-5 X(i)-5],[0 0 sum(daysSpent(1:i)) sum(daysSpent(1:i)) 0],[.5 .5 .5]);alpha(.5);
        line([X(i) X(j)],[sum(daysSpent(1)) sum(daysSpent(1:2))],'Color',c,'linewidth',2);
    else
        if j < i
            line([X(i) X(j)],[sum(daysSpent(1:i)) sum(daysSpent(1:i))],'Color',c,'linewidth',2);
        else
            line([X(i) X(j)],[sum(daysSpent(1:i)) sum(daysSpent(1:j))],'Color',c,'linewidth',2);
            fill([X(i)-5 X(i)+5 X(i)+5 X(i)-5 X(i)-5],[sum(daysSpent(1:i-1)) sum(daysSpent(1:i-1)) sum(daysSpent(1:i)) sum(daysSpent(1:i)) sum(daysSpent(1:i-1))],[.5 .5 .5]);alpha(.5);
        end
    end
end

%% add annotations
axes(metaPanel);ylabel('Length Of Stay'); box on;
axes(mapPanel);title({'A flow map to show an itinerary for touring Italy','Path Color shows: \color{blue}ROAD \color{red}TRAIN \color[rgb]{0 .3 0}AIR'},'Fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_03_Images/3165_03_10_1.png');
