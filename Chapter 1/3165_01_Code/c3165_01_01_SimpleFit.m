%% CHAPTER 1, MAKING YOUR FIRST MATLAB PLOT
%   3165_01_01
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-12 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Read data in from an excel spreadsheet
[numericData headerLabels]=xlsread('TemperatureXL.xls');
%% Sort data to aid in its visualization (on the independent variable)
[sortedResults I] = sort(numericData(:,1));
%% Plot data
plot(numericData(I,1), numericData(I,2),'.');  
set(gcf,'Paperpositionmode','auto','Color',[1 1 1]);
%% Label
xlabel(['Independent Variable: ' headerLabels{1}]);
ylabel(['Dependent Variable: ' headerLabels{2}]);
title('Scatter plot view of sorted data');
print(gcf,'-dpng','./../3165_01_Images/3165_01_01_2.png');
%% Hold axes to overlay more data
hold on; 
%% Obtain a linear fit for this data using polyfit (polynomial of degree 1)
p = polyfit(numericData(I,1),numericData(I,2),1);
y = polyval(p,numericData(I,1));
%% Plot the linear fit in red
plot(numericData(I,1),y,'r--');
%% Title, legend and print
legend({'Data','Fit'},'Location','NorthWest');
title({'The linear least squares fit',...
    'overlaid on scatter plot view of sorted data'});
print(gcf,'-dpng','./../3165_01_Images/3165_01_01_3.png');

%% Find the handle to the red trend line, make it dashed anf thicker
set(findobj(gca,'Color',[1 0 0]),...
    'Linestyle','-','Linewidth',1.5);
title({'The data shown with a','least squares fit (using a continuous line)'});
print(gcf,'-dpng','./../3165_01_Images/3165_01_01_4.png');
