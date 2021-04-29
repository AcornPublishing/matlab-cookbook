%% CHAPTER 1, TUFTE STYLE GRIDDING FOR READABILITY
%   3165_01_02: Setting grids
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-12 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load the market survey data on 14 questions, and 8993 responses.
load MarketingData.mat

%% Extract the income group and ethnicity related data
% Among the different ethnicities, how is the income distributed?
% Ethnicity is the 13th column of data, Annual Income is the 1st
y = NaN(length(ANNUAL_INCOMEL),length(ETHNIC_CLASSIFICATION));
for i = 1:length(ETHNIC_CLASSIFICATION)
    forThisGroup = find(data(:,13)==i);
    for j = 1:length(ANNUAL_INCOMEL)
        y(j,i) = length(find(data(forThisGroup,1)==j));        
    end
end

%% Prepare for plotting with stacked bar charts
figure('units','normalized','position',[ 0.3474    0.3481    0.2979    0.5565]);
set(gcf,'Paperpositionmode','auto','Color',[1 1 1]);
axes('position',[ 0.1300    0.2240    0.6505    0.6816]);colormap('summer');
% Customize the width of bars used. Remove black broder lines from the bars
bar(y,.4,'stacked','linestyle','none');
% Add suitable x and y labels, title and tick labels
set(gca,'Fontsize',11,'Xtick',[1:9]-.5,'XTickLabel', [num2str(ANNUAL_INCOMEL') repmat(' to ',9,1) num2str(ANNUAL_INCOMEU')]);
rotateXLabels(gca, 45);
ylabel('Number of responses','Fontsize',11);
xlabel('Income groups','Fontsize',11);
title({'Distribution of ethnicities in each','income group of SF bay area residents','Using Default Grid Lines'});box on;
% Add a color bar and add the category labels to that colorbar
h=colorbar;
set(h,'Fontsize',11,'ytick',1:8,'yticklabel',ETHNIC_CLASSIFICATION); ylabel(h,'Ethnicity','Fontsize',11);
set(gcf,'Color',[1 1 1],'paperpositionmode','auto');
% Turn the automatic grid lines on
grid on;
% Print
print(gcf,'-dpng','./../3165_01_Images/3165_01_04_1.png');

%% Tun on minor grid lines
grid minor;
title({'Distribution of ethnicities in each','income group of SF bay area residents','Using Minor Grid Lines'});box on;
print(gcf,'-dpng','./../3165_01_Images/3165_01_04_2.png');

%% Prepare customized grid lines 
% Turn the automatic grid lines off
grid off; box off;
% Set y grid positions and draw lines (no x grid lines needed)
xlim([0 10]);ylim([0 1800]);
YgridPos = [0:200:1800];
set(gca,'ytick',YgridPos,'yticklabel',YgridPos,'ticklength',[0 0]);
xLimits = get(gca,'xlim');
line([xLimits(1)*ones(size(YgridPos,2),1) xLimits(2)*ones(size(YgridPos,2),1)]',[YgridPos; YgridPos],'Color',[.8 .8 .8],'LineStyle','-');
XgridPos = .5:9.5;
yLimits = get(gca,'ylim');
% Draw special grid line for separating data into groups
line([XgridPos([2 9]); XgridPos([2 9])],[yLimits(1)*ones(2,1) yLimits(2)*ones(2,1)]','Color',[.4 .4 .4],'LineStyle','-','Linewidth',2);
% Wipe out outer boundary for a Tufte style bar plot
line([xLimits(1) xLimits(2)]',[YgridPos(1); YgridPos(1)],'Color',[1 1 1],'LineStyle','-');
line([xLimits(1) xLimits(1)]',[YgridPos(1); YgridPos(end)],'Color',[1 1 1],'LineStyle','-');
line([xLimits(end) xLimits(end)]',[YgridPos(1); YgridPos(end)],'Color',[1 1 1],'LineStyle','-');
line([xLimits(1) xLimits(2)]',[YgridPos(end); YgridPos(end)],'Color',[1 1 1],'LineStyle','-');
% Add annotations to explain the thicker grid lines
[xmeannfu ymeannfu]= dsxy2figxy(gca,[2,1.5],[1600,1600]);
annotation('textarrow',xmeannfu,ymeannfu,'String',{'Grid lines','to separate categories','with one missing bound'});
[xmeannfu ymeannfu]= dsxy2figxy(gca,[6.5,8.5],[1600,1600]);
annotation('arrow',xmeannfu,ymeannfu);
title({'Distribution of ethnicities in each','income group of SF bay area residents','Using Custom Grid Lines'});box on;
% The last ytick label is unnecessary
for i = 1:length(YgridPos)-1
    cellticks{i} = num2str(YgridPos(i));
end
cellticks{i+1} = '';
set(gca,'ytick',YgridPos,'YTicklabel',cellticks);
% colorbar doesn't need a box around it wither
axes(h);box off;
print(gcf,'-dpng','./../3165_01_Images/3165_01_04_3.png');

