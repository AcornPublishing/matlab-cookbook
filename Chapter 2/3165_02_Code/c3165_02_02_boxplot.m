%% CHAPTER 2, BOXPLOTS
%   3165_02_02
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-12 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% load the gene expression data on 14 types of cancer, with data from 16063 genes, 144+54 = 198 samples.
load 14cancer.mat

%% Generate first, second and third tier labels
tier1 = classLabels;
tier2 = {'Upper body','Lower body','Upper body','Lower body','Distributed','Lower body','Distributed','Lower body','Distributed','Lower body','Lower body','Lower body','Distributed','Upper body'};
tier3 = {'low','low','medium','medium','low','low','low','low','medium','low','high','low','medium','medium'};
% Find the correct order for each tier of labels and where the lines
% separating different groups should lie
[tier1, tier2 tier3, sep2, sep3, I] = multiTierLabel(tier1, tier2, tier3);

%% Generate the box plot parameters
data = [Xtrain(:,2798); Xtest(:,2798)];
[lowerQuartile medianv upperQuartile upperOuter lowerInner outliers] =  boxplotV(data, [ytrainLabels ytestLabels]');

%% Reorder results per the order for the labels
lowerQuartile=lowerQuartile(I);
medianv=medianv(I);
upperQuartile=upperQuartile(I);
upperOuter=upperOuter(I);
lowerInner=lowerInner(I);
outliers=outliers(I);

%% plot the data, add the three tiers of labels and grouping grid lines
figure('units','normalized','Position',[0.3563    0.3019    0.6328    0.6028]);
% take the total y height, keep 80% for data, 20% for squeezing in the
% three tier of labels for the data axes
hData = axes('position',[0.0831    0.2000    0.8930    0.7200]);box on;
boxwidth = .5/2;
hold on;
for i = 1:length(tier1)
    % drawing the actual box + median
    line([i-boxwidth i-boxwidth i-boxwidth i+boxwidth; i+boxwidth i+boxwidth i-boxwidth i+boxwidth;],...
         [lowerQuartile(i) upperQuartile(i) lowerQuartile(i) upperQuartile(i); ...
          lowerQuartile(i) upperQuartile(i) upperQuartile(i) lowerQuartile(i);],'Color',[0 0 1]);
    line([i-boxwidth; i+boxwidth;],[medianv(i); medianv(i);],'Color',[1 0 0]);
    % the whiskers
    line([i i i-.5*boxwidth i-.5*boxwidth; i i i+.5*boxwidth i+.5*boxwidth;],...
         [upperQuartile(i) lowerQuartile(i) lowerInner(i) upperOuter(i); ...
          upperOuter(i) lowerInner(i) lowerInner(i)  upperOuter(i);],'Color',[0 0 0]);
    % the outliers
    plot(repmat(i,size(outliers(i).mat)),outliers(i).mat,'r+');
end
set(gca,'xticklabel',[],'ticklength',[0 0],'ylim',[1.1*min(data) 1.1*max(data)]);
ylabel('Gene Expression levels','fontsize',12);
title({'Boxplot showing the gene expression across 198 samples','for a specific gene across 14 cancers'},'fontsize',12);

%% The tiered tick labels and grouping grid lines
% add the grouping grid lines
sepLine = unique([sep2 sep3]) +.5;
if sepLine(end)==length(tier1)
    sepLine = sepLine(1:end-1);
end
line([sepLine; sepLine], [min(get(gca,'ylim'))*ones(size(sepLine)); max(get(gca,'ylim'))*ones(size(sepLine))],'Color',[.8 .8 .8]);
% add the primary tier tick labels
hLabels = axes('position',[0.0831,.05,0.8930,.15]);box on;
set(hLabels,'ticklength',[0 0],'xticklabel',[],'yticklabel',[],'xlim',get(hData,'xlim'),'ylim',[0 1]);%
line(get(gca,'xlim'),[1 1],'Color',[0 0 0]);
line(get(gca,'xlim'),[0 0],'Color',[0 0 0]);

% add tier 1 labels
text([1:14]-boxwidth,.8*ones(size(tier1)),strtrim(tier1),'Fontsize',10);
% add the grouping grid lines
line([sepLine; sepLine], [.5*ones(size(sepLine)); max(get(gca,'ylim'))*ones(size(sepLine))],'Color',[.8 .8 .8]);
% add separator line
line(get(gca,'xlim'),[.6 .6],'Color',[0 0 0]);
% add tier 2 labels
x=[0 sep2 length(tier1)];
x = (x(1:end-1)+ x(2:end))/2;
text(x,.43*ones(length(sep2)+1,1),tier2([sep2 length(tier1)]),'Fontsize',10);
% add the grouping grid lines
line([sepLine; sepLine], [.3*ones(size(sepLine)); max(get(gca,'ylim'))*ones(size(sepLine))],'Color',[.8 .8 .8]);
% add separator line
line(get(gca,'xlim'),[.3 .3],'Color',[0 0 0]);
% add tier 3 labels
x=[0 sep3 length(tier1)];
x = (x(1:end-1)+ x(2:end))/2;
text(x,.1*ones(length(sep3)+1,1),tier3([sep3 length(tier1)]),'Fontsize',10);
% add the grouping grid lines
line([sep3; sep3]+.5, [min(get(gca,'ylim'))*ones(size(sep3)); .3*ones(size(sep3));],'Color',[.8 .8 .8]);

% add meta labels
text(-1,.1,'Fatality','fontsize',12);
text(-1,.43,'Location','fontsize',12);
text(-1,.8,'Cancer','fontsize',12);

set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_02_1.png');
