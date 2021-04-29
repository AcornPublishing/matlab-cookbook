%% CHAPTER 7, LINKED AXES AND DATA BRUSHING
%   3165_07_03:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-06-16 24:00:00

% data definition
load clusterInteractivData
data(:,1) = X;
data(:,2) = Y;
data(:,3) = atan(Y./X);
data(:,4) = sqrt(X.^2 + Y.^2);
clear X Y

% layout the figure and plots
figure('units','normalized','position',[.40 .08 .51 .84]);
axes('position',[ 0.3196    0.6191    0.3537    0.3211],'Fontsize',12); 
scatter(data(:,1), data(:,2),'ks','XDataSource','data(:,1)','YDataSource','data(:,2)');box on;
xlabel('Dye 1 Intensity');ylabel('Dye 1 Intensity');title('Cluster Plot');
axes('position',[0.0682    0.3009    0.4051    0.2240],'Fontsize',12); 
scatter(1:length(data),data(:,3),'ks','YDataSource','data(:,3)');box on;
xlabel('Serial Number of Points');title('Angle made by each point to the x axis');ylabel('tan^{-1}(Y/X)');
axes('position',[ 0.5588    0.3009    0.4051    0.2240],'Fontsize',12); 
scatter(1:length(data),data(:,4),'ks','YDataSource','data(:,4)');box on;
xlabel('Serial Number of Points');title('Amplitude of each point');ylabel('{\surd(X^2 + Y^2)}');
axes('position',[0.0682    0.0407    0.4051    0.1730],'Fontsize',12);
hist(data(:,1)); title('Histogram of Dye 1 Intensities');
axes('position',[0.5588    0.0407    0.4051    0.1730],'Fontsize',12);
hist(data(:,2)); title('Histogram of Dye 2 Intensities');
set(gcf,'color',[1 1 1]);
linkdata;
h = brush;
set(h,'Color',[0 1 0],'Enable','on');
set(gcf,'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_07_Images/3165_07_03_1');

% brush action
print(gcf,'-dpng','./../3165_07_Images/3165_07_03_2');

% create manual links to the histograms
print(gcf,'-dpng','./../3165_07_Images/3165_07_03_3');

%% linkaxes
figure('units','normalized','position',[.09 .47 .56 .43]); 
axes('position',[.13 .11 .34 .71]);
scatter(data(:,1), data(:,2),'ks');box on;
axes('position',[.57 .11 .34 .71]);
scatter(data(:,1), data(:,2),[],rand(size(data,1),1),'marker','o','LineWidth',2);box on;
linkaxes;
annotation('textbox','position',[.2250 .8793 .6245 .0733],'linestyle','none','string',...
           'Zoom and pan actions on any one axes will affect the linked axis similarly','fontsize',14);
set(gcf,'Color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_07_Images/3165_07_03_4');

