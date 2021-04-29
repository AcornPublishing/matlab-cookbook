%% CHAPTER 1, DESIGNING MULTI GRAPH LAYOUTS
%   3165_01_07
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-12 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load the data (reverse to get earliest first)
[AAPL dateAAPL] = xlsread('AAPL_090784_012412.csv');
dateAAPL = datenum({dateAAPL{2:end,1}});
dateAAPL = dateAAPL(end:-1:1);
AAPL = AAPL(end:-1:1,:);
% Choose a window for the main display
rangeMIN = datenum('1/1/2011');
rangeMAX = datenum('12/31/2011');
idx = find(dateAAPL >= rangeMIN & dateAAPL <= rangeMAX);

%% Use subplot to create regular grid of displays 
% Notice the title on each sub plot to understand how the 
% MATLAB subplot function accesses each position
figure('units','normalized','position',[ 0.0609    0.0593    0.5844    0.8463]);
matNames = {'Open','High','Low','Close','Volume','Adj Close'};
for i = 1:6
    subplot(3,2,i); 
    plot(idx,AAPL(idx,i));
    if i~=5
        title([matNames{i} ' $, subplot(3,2,' num2str(i) ')'],'Fontsize',12,'Color',[1 0 0 ]);    
        ylabel('$');
    else
        title([matNames{i} ' vol, subplot(3,2,' num2str(i) ')'],'Fontsize',12,'Color',[1 0 0 ]);
        ylabel('Volume');
    end
    set(gca,'xtick',linspace(idx(1),idx(end),12),'xticklabel',...
        datestr(linspace(dateAAPL(idx(1)),dateAAPL(idx(end)),12),...
                                                'mmm'),'Fontsize',10,'fontweight','bold');
    rotateXLabels(gca,40);
    box on; axis tight
end
% Add a title to tie the set of plots together
annotation('textbox',[ 0.37   0.96   0.48   0.03],'String','Apple Inc Stock Price over year 2011','Fontsize',14,'Linestyle','none');
% Set the background color
% Set the paper position mode to ensure that the figure and 
% axes sizing parameters are retained in the print out
set(gcf,'Color',[1 1 1],'Paperpositionmode','auto');
print(gcf,'-dpng','./../3165_01_Images/3165_01_07_1.png');

%% Customize grid layout
figure('units','normalized','Position',[ 0.0427    0.2102    0.6026    0.6944]);

%% Panel 1 with the closing stock prices within date range
% Layout the axis
Panel1 = axes('Position',[ 0.0570    0.5520    0.8850    0.3730]);hold; 
% use area graphs to create the plot with a filled out area under the curve 
area(AAPL(idx,4),'FaceColor',[188 210 238]/255,'edgecolor',[54 100 139 ]/255); 
% set axis view parameters
xlim([1 length(idx)]); 
yminv = min(AAPL(idx,4))-.5*range(AAPL(idx,4));
ymaxv = max(AAPL(idx,4))+.1*range(AAPL(idx,4));
ylim([yminv ymaxv]);
box on;
% set up the grid lines
set(gca,'Ticklength',[0 0],'YAxisLocation','right');
line([linspace(1,length(idx),15);linspace(1,length(idx),15)],[yminv*ones(1,15); ymaxv*ones(1,15)],'Color',[.9 .9 .9]);
line([ones(1,10); length(idx)*ones(1,10)],[linspace(yminv, ymaxv,10); linspace(yminv, ymaxv,10);],'Color',[.9 .9 .9]);
% set up the annotations
set(gca,'xtick',linspace(1,length(idx),10),'xticklabel',datestr(linspace(dateAAPL(idx(1)),dateAAPL(idx(end)),10),'ddmmmyy'));
title({'Apple Inc Stock Price,','(detailed view of data from selected time window)'},'Fontsize',12);

%% Panel 2 with the volume numbers for the same window of time
% Layout the axis
Panel2 = axes('Position',[ 0.0570 0.2947  0.8850  0.1880]);
% Plot the volume data with bar chart
bar(1:length(idx), AAPL(idx,5),.25,...
                     'FaceColor',[54 100 139 ]/255); 
hold; xlim([1 length(idx)]);hold on;
% Add grid lines
yminv = 0;
ymaxv = round(max(AAPL(idx,5)));
line([linspace(1,length(idx),30);...
      linspace(1,length(idx),30)],...
     [yminv*ones(1,30); ymaxv*ones(1,30)],...
                            'Color',[.9 .9 .9]);
line([ones(1,5); length(idx)*ones(1,5)],...
     [linspace(yminv, ymaxv,5); ...
      linspace(yminv, ymaxv,5);],'Color',[.9 .9 .9]);
ylim([yminv ymaxv]);
% Set the special date tick labels
set(gca, 'Ticklength',[0 0],...
'xtick',linspace(1,length(idx),10),'xticklabel',...
  datestr(linspace(dateAAPL(idx(1)),dateAAPL(idx(end)),10),...
                                                'ddmmmyy'));
tickpos = get(Panel2,'ytick')/1000000;
for i = 1:numel(tickpos)
    C{i} = [num2str(tickpos(i)) 'M']; 
end
set(Panel2,'yticklabel',C,'YAxisLocation','right');
text(0,1.1*ymaxv,'Volume','VerticalAlignment','top',...
        'Color',[54 100 139 ]/255,'Fontweight','bold');

%% Panel 3 with the full range of the data with a highlight to indicate the
% selected time window within the larger context
Panel3 = axes('Position',[0.0570    0.1100    0.8850    0.1273]);
area(dateAAPL, AAPL(:,4),'FaceColor',[234 234 234 ]/255,'edgecolor',[.8 .8 .8]); hold; 
line([min(idx) min(idx)],get(gca,'ylim'),'Color','k');
line([max(idx) max(idx)],get(gca,'ylim'),'Color','k');
set(gca,'Ticklength',[0 0]);
% overplot for emphasis (use same color to establish connection)
area(dateAAPL(idx),AAPL(idx,4),'FaceColor',[188 210 238]/255,'edgecolor',[54 100 139 ]/255); 
ylim([min(AAPL(:,4)) 1.1*max(AAPL(:,4))]);
xlabel('Long term stock prices');
line([min(get(gca,'xlim')) min(get(gca,'xlim'))],get(gca,'ylim'),'Color',[1 1 1]);
line([max(get(gca,'xlim')) max(get(gca,'xlim'))],get(gca,'ylim'),'Color',[1 1 1]);
line(get(gca,'xlim'),[max(get(gca,'ylim')) max(get(gca,'ylim'))],'Color',[1 1 1]);
line(get(gca,'xlim'),[min(get(gca,'ylim')) min(get(gca,'ylim'))],'Color',[1 1 1]);
set(gca,'xticklabel',datestr(get(gca,'xtick'),'yyyy'),'yticklabel',[]);

set(gcf,'Color',[1 1 1],'paperpositionmode','auto');

print(gcf,'-dpng','./../3165_01_Images/3165_01_07_2.png');





