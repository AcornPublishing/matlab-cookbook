%% CHAPTER 2, SPARKLINES
%   3165_02_03
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00


%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load the data
[dt{1} dateD{1}] = xlsread('AAPL_090784_012412.csv');
[dt{2} dateD{2}] = xlsread('GOOG_090784_012412.csv');
[dt{3} dateD{3}] = xlsread('MSFT_090784_012412.csv');
[dt{4} dateD{4}] = xlsread('SLB_090784_012412.csv');
[dt{5} dateD{5}] = xlsread('YHOO_090784_012412.csv');
[dt{6} dateD{6}] = xlsread('S&P_090784_012412.csv');
[dt{7} dateD{7}] = xlsread('GE_090784_012412.csv');
stocks = {'AAPL','GOOG','MSFT','SLB','YHOO','S&P','GE'};
rangeMIN = datenum('1/1/2011');
rangeMAX = datenum('12/31/2011');

%% Preprocess
for i = 1:length(dt)    
    % Data Processing
    % convert date to a numeric format
    dateD{i} = datenum({dateD{i}{2:end,1}});
    % find dates in range
    idx = find(dateD{i} >= rangeMIN & dateD{i} <= rangeMAX);
    dt{i} = dt{i}(idx); 
    % extract data in range
    dateD{i} = dateD{i}(idx);
    % normalize
    dtn{i} = dt{i}./max(dt{i});
    clear idx
    labels2{i} = num2str(dt{i}(end));    
end

%% Call spark lines 
sparkline(dateD,dtn,stocks,labels2);

print(gcf,'-dpng','./../3165_02_Images/3165_02_03_1.png');
