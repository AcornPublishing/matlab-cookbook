%% CHAPTER 2, PIE CHARTS, STEM PLOTS AND STAIRS PLOTS
%   3165_02_01
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Pie charts
% Customize with color, labels and special emphasis on certain pieces 
figure('units','normalized','Position',  [ 0.3536    0.3324    0.2917    0.5731]);
axes('Position',  [0.05    0.05    .9    .9]);
Expenses = [20 10 40 12 20 19 5 15];
ExpenseCategories = {'Food','Medical','Lodging','Incidentals','Transport','Utilities','Gifts','Shopping'};
MostLeastExpensive = (Expenses==max(Expenses)|Expenses==min(Expenses)); 
h=pie(gca,Expenses,MostLeastExpensive,ExpenseCategories);
% Every alternate handle returned by pie is atext object handle
for i =2:2:16;set(h(i),'fontsize',14);end
title({'Annual Expense Report, highlighting','the most and least expensive items'},'fontsize',14);
print(gcf,'-dpng','./../3165_02_Images/3165_02_01_1.png');

%% Stem charts
figure
x = linspace(0,2,100);
x1 = x(1:13:end);
x2 = x(1:5:end);
y = exp(.3*x).*cos(-2*x);
yy = round(rand(1,length(x1)));yy(find(yy==0))=-1;
y1 = exp(.3*x1).*cos(-2*x1)+yy.*rand(1,length(x1));
yy = round(rand(1,length(x2)));yy(find(yy==0))=-1;
y2 = exp(.3*x2).*cos(-2*x2)+yy.*rand(1,length(x2));
plot(x,y); hold on;
h1 = stem(x1,y1);
h2 = stem(x2,y2);
% Choose marker size and style of your choice
set(h1,'MarkerFaceColor','green','Marker','o','Markersize',7,'Color',[0 0 0]);
set(h2,'MarkerFaceColor','red','Marker','square','Color',[0 0 0]);
xlabel('x');ylabel('signal');
title({'Discretizing continuous signal, by sampling at certain intervals','Measurement noise yields imperfect recordings'});
legend({'Original Signal','Noisy Discretization 1','Noisy Discretization 2'});
print(gcf,'-dpng','./../3165_02_Images/3165_02_01_2.png');

%% Stairs charts
figure;
load algoResultsData.mat
h=stairs([MethodPerformanceNumbers nan(5,1)]'); 
legendMatrix = {'Fresh Tissue','FFPE','Blood','DNA','Simulated'};
for i = 1:5;
    set(h(i),'linewidth',2); % thicken the lines
    % add total # of samples in this category tolegend
    legendMatrix{i} = [legendMatrix{i} ', Total# = ' num2str(CategoryTotals(i))];
end
set(gca,'xlim',[0.5 6.5],'XTick',1.5:nosOfMethods+1,'XTickLabel',{'K Means','Fuzzy C Means','Hierarchical','Maximize Expectation','Dendogram'});
title({'Algorithm Test Results with 5 Clustering',' Algorithms on 5 Source Sample Types'});
ylabel('Number of successes');
legendflex(h,...                %handle to plot lines
    legendMatrix,...            %corresponding legend entries
    'ref', gcf, ...             %which figure
    'anchor', {'ne','ne'}, ...  %location of legend box
    'buffer',[0 0], ...         % an offset wrt the location
    'fontsize',8,...            %font size
    'xscale',.5);               %a scale factor for actual symbols    
rotateXLabels(gca,20);
set(gca,'position',[0.1139    0.1989    0.7750    0.6638]);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_01_3.png');

