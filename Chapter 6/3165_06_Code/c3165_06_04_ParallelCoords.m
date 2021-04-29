%% CHAPTER 6, PARALLEL COORDINATES
%   3165_06_04: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-05-21 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%plot the figure
figure('units','normalized','position',[0.1214    0.2065    0.5234    0.6991]);
axes('position',[ 0.0587    0.1755    0.6913    0.7530]);

% load the data
load carsmall 
dat = [Acceleration Cylinders Displacement Horsepower MPG Weight];
%define input parameters
% need to normalize each data dimension 
normalize=1;
% create the group Index as an array with the group label 
% of same size as the number of datapoints
for iiii=1:100
    hh{iiii} = deblank(Mfg(iiii,:));
end
yy=unique(hh);
for iiii=1:100
    groupIndex(iiii) = find(strcmp(yy,hh(iiii)));
end
% define x tick labels
labl = {'Acceleration','Cylinders','Displacement','Horsepower','MPG','Weight'};
% define grouping attribute labels
legendLabel=yy;
% make function call  
parallelCoordPlot(dat,normalize,groupIndex ,labl,legendLabel);box on;
%annotate
xlabel('Car Attributes','Fontsize',14);
title({' \color{red}Parallel Coordinate Plot \color{black} showing car attributes from different manufacturers',''},'Fontsize',14);


set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_06_Images/3165_06_04_1' '.png']);

