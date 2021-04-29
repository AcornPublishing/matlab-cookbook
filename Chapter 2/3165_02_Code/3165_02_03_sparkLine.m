%   3165_02_03: Spark Lines
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

% data definition
[AAPL dateAPPL] = xlsread('AAPL_090784_012412.csv');
[GOOG dateGOOG] = xlsread('GOOG_090784_012412.csv');
[MSFT dateMSFT] = xlsread('MSFT_090784_012412.csv');

dateAPPL = datenum({dateAPPL{2:end,1}});
dateGOOG = datenum({dateGOOG{2:end,1}});
dateMSFT = datenum({dateMSFT{2:end,1}});

rangeMIN = datenum('1/1/2011')
rangeMAX = datenum('12/31/2011');
idx = find(dateAPPL >= rangeMIN & dateAPPL <= rangeMAX);
APPL = AAPL(idx); dateAPPL = dateAPPL(idx);
clear idx;
idx = find(dateGOOG >= rangeMIN & dateGOOG <= rangeMAX);
GOOG = GOOG(idx); dateGOOG = dateGOOG(idx);
clear idx;
idx = find(dateMSFT >= rangeMIN & dateMSFT <= rangeMAX);
MSFT = MSFT(idx); dateMSFT = dateMSFT(idx);
clear idx;

%normalize the dataset
APPLn = APPL./max(APPL);
GOOGn = GOOG./max(GOOG);
MSFTn = MSFT./max(MSFT);

% find locations of max and points in the data
applMax = find(APPL==max(APPL)); applMin = find(APPL==min(APPL));
googMax = find(GOOG==max(GOOG)); googMin = find(GOOG==min(GOOG));
msftMax = find(MSFT==max(MSFT)); msftMin = find(MSFT==min(MSFT));

% make the plots by bumping up each sparkline with an arbitrary unit of
% separation. Here unitOfSep=1;
unitOfSep=1;
plot(dateAPPL, APPLn,'k'); hold; 
plot(dateAPPL(applMax),APPLn(applMax),'bo','MarkerFaceColor','b');plot(dateAPPL(applMin),APPLn(applMin),'ro','MarkerFaceColor','r');
text(dateAPPL(end), mean(APPLn),'APPL','HorizontalAlignment','right');
text(dateAPPL(1), mean(APPLn),num2str(APPL(1)),'HorizontalAlignment','left');
plot(dateGOOG, GOOGn+unitOfSep,'k');
plot(dateGOOG(googMax),GOOGn(googMax)+unitOfSep,'bo','MarkerFaceColor','b');plot(dateGOOG(googMin),GOOGn(googMin)+unitOfSep,'ro','MarkerFaceColor','r');
text(dateGOOG(end), mean(GOOGn)+unitOfSep,'GOOG','HorizontalAlignment','right');
text(dateGOOG(1), mean(GOOGn)+unitOfSep,num2str(GOOG(1)),'HorizontalAlignment','left');
plot(dateMSFT, MSFTn+2*unitOfSep,'k');
plot(dateMSFT(msftMax),MSFTn(msftMax)+2*unitOfSep,'bo','MarkerFaceColor','b');plot(dateMSFT(msftMin),MSFTn(msftMin)+2*unitOfSep,'ro','MarkerFaceColor','r');
text(dateMSFT(end), mean(MSFTn)+2*unitOfSep,'MSFT','HorizontalAlignment','right');
text(dateMSFT(1), mean(MSFTn)+2*unitOfSep,num2str(MSFT(1)),'HorizontalAlignment','left');
endpt = max([dateAPPL(1) dateGOOG(1) dateMSFT(1)]);
strtpt= min([dateAPPL(end) dateGOOG(end) dateMSFT(end)]);
set(gca,'ylim',[0+unitOfSep/2 1+2*unitOfSep+unitOfSep/2],'yticklabel',[],'xlim',[strtpt-.15*(endpt-strtpt) endpt+.15*(endpt-strtpt)],'xticklabel',[],'TickLength',[0 0]);


print(gcf,'-dpng','./../3165_02_Images/3165_02_03.png');
