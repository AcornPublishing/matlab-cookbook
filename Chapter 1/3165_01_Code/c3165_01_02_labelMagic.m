%% CHAPTER 1, LAYING OUT LONG TICK LABELS WITHOUT OVER-WRITING
%   3165_01_02
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-12 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load the gene expression data on 14 types of cancer, with data from 16063 genes, 144+54 = 198 samples.
load 14cancer.mat

%% Look at expression levels for a particular gene and group by the cancer labels
expressionLevel = [Xtrain(:,2798); Xtest(:,2798)];
cancerTypes = [ytrainLabels ytestLabels];
for j = 1:14
    indexes = expressionLevel(find(cancerTypes==j));
    meanExpressionLevel(j) = median(indexes);
    stdExpressionLevel(j) = 3*std(indexes);
end
errorbar(1:14,meanExpressionLevel,stdExpressionLevel,stdExpressionLevel);  
ylabel('Gene Expression Values for gene # 2798');
xlabel('Cancer types');
title({'Line charts showing the median','Bars showing the 3\sigma limits around the median',...
    'Gene #2798 expression in 198 samples, 14 cancers',...
    'Note the overwritten long labels are undecipherable!'},...
    'Color',[1 0 0]);

%% Add x tick labels as the names of the cancer classes
set(gcf,'Paperpositionmode','auto','Color',[1 1 1]);
set(gca,'Fontsize',11);
set(gca, 'XTick',1:14,'XTickLabel',classLabels);
print(gcf,'-dpng','./../3165_01_Images/3165_01_02_1.png');

%% Rotate the extra long tick labels
rotateXLabels(gca, 45);
%re title
title({'Line charts showing the median','Bars showing the 3\sigma limits around the median',...
    'Gene # 2798 expression in 198 samples, 14 cancers',},...
    'Color',[0 0 0]);
set(gca,'position',[0.1244    0.1612    0.7750    0.7353]);
% Resize the figure to make everything visible
set(gcf,'units','normalized','position',[ 0.2703    0.2519    0.3750    0.6528],'PaperPositionMode','auto','color',[1 1 1]);
print(gcf,'-dpng','./../3165_01_Images/3165_01_02_2.png');
