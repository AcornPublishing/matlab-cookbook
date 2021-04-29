%   3165_02_01: Pie charts
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

% Few data points - parts of a whole
pie([20 30 40 1 25 3]);title('2D pie charts');
print(gcf,'-dpng','./../3165_02_Images/3165_02_01_1.png');

% Customize with color, labels and special emphasis on certain pieces 
figure('Position',  [680   360   560   618]);
axes('Position',  [0.1300    0.1100    0.7750    0.8150]);
Expenses = [20 10 40 12 20 19 5 15];
ExpenseCategories = {'Food','Medical','Lodging','Incidentals','Transport','Utilities','Gifts','Shopping'}
% Sort expense values. Save sort order in I
[Expenses I] = sort(Expenses);  
% Sort labels in same increasing order using the saved sort order I
ExpenseCategories = ExpenseCategories(I);
% Define array of the same size as dataset with a nonzero entry for the
% most expensive category that you would like to highlight in the graphic
MostExpensive = Expenses==max(Expenses); 
% Plot data and add title
pie(gca,Expenses,MostExpensive,ExpenseCategories);
set(gca,'FontSize',14);
title('Annual Expense Report');
% Define a pleasing color sequential scheme
A = [247, 252, 253
229, 245, 249
204, 236, 230
153, 216, 201
102, 194, 164
65, 174, 118
35, 139, 69
0, 88, 36]/255;
% Get the current plot to use the custom color scheme
colormap(A); 
print(gcf,'-dpng','./../3165_02_Images/3165_02_01_2.png');


