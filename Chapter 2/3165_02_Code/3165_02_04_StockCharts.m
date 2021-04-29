%   3165_02_09: Stock Charts
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

% data definition
[AAPL dateAAPL] = xlsread('AAPL_090784_012412.csv');
dateAAPL = datenum({dateAAPL{2:end,1}});
dateAAPL = dateAAPL(end:-1:1);
AAPL = AAPL(end:-1:1,:);

%choose window for the main display
rangeMIN = datenum('1/1/2011');
rangeMAX = datenum('12/31/2011');
idx = find(dateAAPL >= rangeMIN & dateAAPL <= rangeMAX);

figure('Position',[83         228        1157         750]);

%panel 1 with the closing stock prices within date range
Panel1 = axes('Position',[ 0.0570    0.5520    0.8850    0.3730]);hold; 
area(AAPL(idx,4),'FaceColor',[188 210 238]/255,'edgecolor',[54 100 139 ]/255); 
xlim([1 length(idx)]); 
yminv = min(AAPL(idx,4))-.5*range(AAPL(idx,4));
ymaxv = max(AAPL(idx,4))+.1*range(AAPL(idx,4));
ylim([yminv ymaxv]);
%grid lines
set(gca,'Ticklength',[0 0],'YAxisLocation','right');
line([linspace(1,length(idx),15);linspace(1,length(idx),15)],[yminv*ones(1,15); ymaxv*ones(1,15)],'Color',[.7 .7 .7]);
line([ones(1,10); length(idx)*ones(1,10)],[linspace(yminv, ymaxv,10); linspace(yminv, ymaxv,10);],'Color',[.7 .7 .7]);
set(gca,'xtick',linspace(1,length(idx),15),'xticklabel',datestr(linspace(dateAAPL(idx(1)),dateAAPL(idx(end)),15),'mmmyy'));
title('Apple Inc Stock Price, detailed view from selected time window');
box on;

%panel 2 with the volume numbers for the same window of time
Panel2 = axes('Position',[ 0.0570    0.2947    0.8850    0.1880]);
bar(1:length(idx), AAPL(idx,5),.25,'FaceColor',[54 100 139 ]/255); hold; xlim([1 length(idx)]);hold on;
%grid lines
yminv = 0;
ymaxv = round(max(AAPL(idx,5)));
line([linspace(1,length(idx),15);linspace(1,length(idx),15)],[yminv*ones(1,15); ymaxv*ones(1,15)],'Color',[.7 .7 .7]);
line([ones(1,10); length(idx)*ones(1,10)],[linspace(yminv, ymaxv,10); linspace(yminv, ymaxv,10);],'Color',[.7 .7 .7]);
set(gca,'Ticklength',[0 0]);
set(gca,'xtick',linspace(1,length(idx),15),'xticklabel',datestr(linspace(dateAAPL(idx(1)),dateAAPL(idx(end)),15),'mmmyy'));
ylim([yminv ymaxv]);
tickpos = get(Panel2,'ytick')/1000000;
for i = 1:numel(tickpos)
    C{i} = [num2str(tickpos(i)) 'M']; 
end
set(Panel2,'yticklabel',C,'YAxisLocation','right');
text(0,1.1*ymaxv,'Volume','VerticalAlignment','top','Color',[54 100 139 ]/255,'Fontweight','bold');

%panel 3 with the full range of the data with a highlight to indicate the
%selected time window within the larger context
Panel3 = axes('Position',[0.0570    0.1100    0.8850    0.1273]);
area(dateAAPL, AAPL(:,4),'FaceColor',[234 234 234 ]/255,'edgecolor',[.8 .8 .8]); hold; 
line([min(idx) min(idx)],get(gca,'ylim'),'Color','k');
line([max(idx) max(idx)],get(gca,'ylim'),'Color','k');
set(gca,'Ticklength',[0 0]);
area(dateAAPL(idx),AAPL(idx,4),'FaceColor',[188 210 238]/255,'edgecolor',[54 100 139 ]/255); 
ylim([min(AAPL(:,4)) 1.1*max(AAPL(:,4))]);
xlabel('Long term stock prices');
line([min(get(gca,'xlim')) min(get(gca,'xlim'))],get(gca,'ylim'),'Color',[1 1 1]);
line([max(get(gca,'xlim')) max(get(gca,'xlim'))],get(gca,'ylim'),'Color',[1 1 1]);
line(get(gca,'xlim'),[max(get(gca,'ylim')) max(get(gca,'ylim'))],'Color',[1 1 1]);
line(get(gca,'xlim'),[min(get(gca,'ylim')) min(get(gca,'ylim'))],'Color',[1 1 1]);

set(gca,'xticklabel',datestr(get(gca,'xtick'),'yyyy'),'yticklabel',[]);


print(gcf,'-dpng','./../3165_02_Images/3165_02_04.png');

