%% CHAPTER 1, A VISUALIZATION TO COMPARE ALGORITHM TEST RESULTS
%   3165_01_08
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-12 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Define a color matrix
Colors = [  141 211 199;
            255 255 179;
            190 186 218;
            251 128 114;
            128 177 211;]/255;
%% Load the plot data
load algoResultsData

%% Define your visualization scheme 
% Define the figure
figure('units','normalized','Position',[ 0.0880    0.1028    0.6000    0.6352]);

% Here is the X Tick labeling for the names of Algorithms under comparison
% Parameters for axes positioning were chosen using methods described in CHAPTER 1, Design Multi Graph Layouts 
hh = axes('Position',[.1,.135,.8,.1]);
set(gca,'Visible','Off','TickLength',[0.0 0.0],'TickDir','out','YTickLabel','','xlim',[0 nosOfMethods],'FontSize',11,'FontWeight','bold');
set(gca,'XTick',.5:nosOfMethods-.5,'XTickLabel',{'K Means','Fuzzy C Means','Hierarchical','Maximize Expectation','Dendogram'});
catgeoryLabels = {'Fresh Tissue','FFPE','Blood','DNA','Simulated'};
rotateXLabels(gca,20);
% Split the available vertical space into the five for the 
% five sample categories
y = linspace(.142,.75,nosOfCategories);

% Place an axes for creating each row dedicated to a sample 
% category. The height of the axes corresponds to the total 
% number of samples in that category.
for i = 1 :nosOfCategories
    
    if CategoryTotals(i); ylimup = CategoryTotals(i); else ylimup = 1; end
    dat = [MethodPerformanceNumbers(i,:)];
    h(i) = axes('Position',[.1,y(i),.8,y(2)-y(1)]);
    set(gca,'XTickLabel','','TickLength',[0.0 0.0],'TickDir','out','YTickLabel','','xlim',[.5 nosOfMethods+.5],'ylim',[0 ylimup]);

    % Use the line command to create bars representing the number of successes 
    % in each category using colour scheme defined at the beginning of this recipe
    line([1:nosOfMethods; 1:nosOfMethods],[zeros(1,nosOfMethods); dat],'Color',Colors(i,:),'Linewidth',7);box on;
    
    % Place the actual number as a text next to the bar
    for j= 1:nosOfMethods
        if dat(j); text(j+.01,dat(j)-.3*dat(j),num2str(dat(j)),'Rotation',20,'FontSize',13); end
    end
    
    % Add the category label
    ylabel([catgeoryLabels{i} char(10) '#Samples' char(10) ' = ' num2str(ylimup) ],'Fontsize',11); 
end
% Add annotations
title('Number of Successes from 5 Clustering Algorithms','Fontsize',14,'Fontweight','bold');
axes(h(3));
text(0.06,-170,'Performance numbers with samples from different categories','rotation',90,'Fontsize',14,'Fontweight','bold');
set(gcf,'Color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_01_Images/3165_01_08_1.png');
