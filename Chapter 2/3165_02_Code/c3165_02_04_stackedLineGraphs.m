%% CHPATER 2, STACKED LINE GRAPHS
%   3165_02_04
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% load data
[ranksoverdecades names] = xlsread('MockDataNameVoyager.xlsx');
sex = names(2:end,2);
names = names(2:end,1);
years = ranksoverdecades(1,:);
ranksoverdecades = ranksoverdecades(2:end,:);
ranksoverdecades = ranksoverdecades';
% split into male and female names
males = find(strcmp(sex,'M'));
fmales = find(strcmp(sex,'F'));
ymax=max(max(cumsum(ranksoverdecades,2)));

%generate the y coordinates where the name lables will be placed
nameLoc = cumsum(ranksoverdecades(end,:));
nameLoc = [0 nameLoc];
nameLoc = (nameLoc(1:end-1) + nameLoc(2:end))/2;

%% Layout the plot
figure('units','normalized','Position',[ 0.3432    0.1472    0.6542    0.7574]);
%create main axes for the data
axes('position',[.05,.1,.87,.85],'ylim',[0 ymax],'xlim',[min(years) max(years)],'YAxisLocation','right',...
    'ytick',nameLoc,'yticklabel',names,'ticklength',[0.01 0.05],'tickdir','out','fontsize',14);
% create a secondary axes over the first one to place the name labels
axes('Position',get(gca,'Position'));
% draw the lines
h = area(years,ranksoverdecades);
% set the area graph colors per sex of the baby name
set(h(males),'FaceColor',[100	149	237]/255)
set(h(fmales),'FaceColor',[255	192	203]/255);
% fix edgecolor and x and y limits
set(h,'edgecolor',[.5 .5 .5]) % Set all to same value
set(gca,'ylim',[0 ymax],'xlim',[min(years) max(years)],'xticklabel',[],'fontsize',14);
box on;
% annotate the graph
title('Trend in baby names','Fontsize',14);
ylabel('Rank over the years','Fontsize',14);
text(mean(get(gca,'xlim')),-11,'Years','Fontsize',14);

set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_04_1.png');
