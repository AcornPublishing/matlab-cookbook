%   3165_02_02: Hierarchical bar charts
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

% Example with the multi-level x labels
% define data
A =  {81.4724, 'A233', 'Joe', 'Man';
      90.5792, 'A233', 'Joe', 'Auto';
      82.6987, 'A233', 'Sam', 'Man';
      91.3376, 'A233', 'Sam', 'Auto';
      63.2359, 'A233', 'Sam', 'Man2';
      79.7540, 'B211', 'Joe', 'Man';
      77.8498, 'B211', 'Joe', 'Auto';
      54.6882, 'B211', 'Sam', 'Man';
      95.7507, 'C234', 'Joe', 'Man';};

scramble = [2 5 8 9 7 6 1 4 3  ];
data = cell2mat({A{scramble,1}}');
level1 = {A{scramble,2}}; 
level2 = {A{scramble,3}};
level3 = {A{scramble,4}};

for i = 1:length(data)
   level2{i} = [level1{i} ',' level2{i}];
   level3{i} = [',' level2{i} ',' level3{i}];
end
uniqLevel1 = unique(level1);
uniqLevel2 = unique(level2);

% start drawing
figure('Position',[ 685         327        1215         651]);

% Calculate text placement locations for the Level3 labels
xSpan = get(gca,'xlim');
xLabel3Locs = linspace(0,range(xSpan),2*numel(data)+1);
vertiX3 = linspace(0,range(xSpan),numel(data)+1);

% Calculate text placement locations for the Level1 labels
for i=1:numel(uniqLevel1)
    level1n(i) = length(find(strcmp(level1,uniqLevel1{i})));
    pos1 = xLabel3Locs(sum(level1n(1:i-1))*2+1);
    pos2 = xLabel3Locs(sum(level1n(1:i))*2+1);
    xLabel1Locs(i) = pos1 + .25*abs(pos2-pos1);
    if i~=numel(uniqLevel1)
        vertiX1(i) = xLabel3Locs(sum(level1n(1:i))*2+1);
    end
end

% Calculate text placement locations for the Level2 labels
for i=1:numel(uniqLevel2)
    level2n(i) = length(find(strcmp(level2,uniqLevel2{i})));
    pos1 = xLabel3Locs(sum(level2n(1:i-1))*2+1);
    pos2 = xLabel3Locs(sum(level2n(1:i))*2+1);
    xLabel2Locs(i) = pos1 + .25*abs(pos2-pos1);
    if i~=numel(uniqLevel2)
        vertiX2(i) = xLabel3Locs(sum(level2n(1:i))*2+1);
    end
end

[E uniqLevel2] = strtok(uniqLevel2,',');
[uniqLevel2] = strtok(uniqLevel2,',');
uniqLevel3 = unique(level3);
[E uniqLevel3] = strtok(uniqLevel3,',');
[E uniqLevel3] = strtok(uniqLevel3,',');
[uniqLevel3] = strtok(uniqLevel3,',');

bar(xLabel3Locs(2:2:end-1),data,.25);hold on;
ylimv = get(gca,'ylim');
xlimv = get(gca,'xlim');
ymin = min(ylimv);
set(gca,'Xtick',xLabel3Locs,'Xticklabel',[],'TickLength',[0.0 0.0],'TickDir','out');

xLabel3LocsN = xLabel3Locs(2:2:end-1);
delta = abs(xLabel3LocsN(2)-xLabel3LocsN(1));
strt = 0.25*delta;
xLabel3LocsN = strt:delta:delta*length(xLabel3LocsN);
text(xLabel3LocsN,(ymin - 0.05*range(ylimv))*ones(size(xLabel3LocsN)),uniqLevel3,'Fontsize',12);
text(xLabel2Locs,(ymin - 0.15*range(ylimv))*ones(size(xLabel2Locs)),uniqLevel2,'Fontsize',12);
text(xLabel1Locs,(ymin - 0.25*range(ylimv))*ones(size(xLabel1Locs)),uniqLevel1,'Fontsize',12);

line(xlimv,[(ymin - 0.10*range(ylimv)) (ymin - 0.10*range(ylimv))],'Color','k');
line(xlimv,[(ymin - 0.20*range(ylimv)) (ymin - 0.20*range(ylimv))],'Color','k');
line(xlimv,[(ymin - 0.30*range(ylimv)) (ymin - 0.30*range(ylimv))],'Color','k');
ylimvN = [(ymin - 0.30*range(ylimv)) max(ylimv)];
ylim(ylimvN);

ylimvN = [(ymin - 0.10*range(ylimv)) max(ylimv)];
line([vertiX3; vertiX3],[ylimvN(1)*ones(size(vertiX3)); ylimvN(2)*ones(size(vertiX3));],'color','k');
ylimvN = [(ymin - 0.20*range(ylimv)) max(ylimv)];
line([vertiX2; vertiX2],[ylimvN(1)*ones(size(vertiX2)); ylimvN(2)*ones(size(vertiX2));],'color','k')
ylimvN = [(ymin - 0.30*range(ylimv)) max(ylimv)];
line([vertiX1; vertiX1],[ylimvN(1)*ones(size(vertiX1)); ylimvN(2)*ones(size(vertiX1));],'color','k')

hh=get(gca,'ytickLabel');
for i=1:length(hh)
    kk{i} = char(deblank(hh(i,:)));
end
set(gca,'yTicklabel',{' ',' ',kk{3:end}});

text(-.01,(ymin - 0.05*range(ylimv)),'Method','Fontsize',12,'HorizontalAlignment','right');
text(-.01,(ymin - 0.15*range(ylimv)),'Operator','Fontsize',12,'HorizontalAlignment','right');
text(-.01,(ymin - 0.25*range(ylimv)),'Instrument','Fontsize',12,'HorizontalAlignment','right');

title('Bar chart of instrument success rates with two operators and three test methods','Fontsize',12);
print(gcf,'-dpng','./../3165_02_Images/3165_02_02_1.png');
%add errorbars
L = 10*rand(size(data));
U = 10*rand(size(data));
errorbar(xLabel3Locs(2:2:end-1), data, L, U ,'.r','linewidth',2); 

ylimvN = [ymin max([ymin max(data+U)])];
line([vertiX3; vertiX3],[ylimvN(1)*ones(size(vertiX3)); ylimvN(2)*ones(size(vertiX3));],'color','k');
ylimvN = [(ymin - 0.20*range(ylimv)) max([get(gca,'ylim') max(data+U)])];
line([vertiX2; vertiX2],[ylimvN(1)*ones(size(vertiX2)); ylimvN(2)*ones(size(vertiX2));],'color','k')
ylimvN = [(ymin - 0.30*range(ylimv)) max([get(gca,'ylim') max(data+U)])];
line([vertiX1; vertiX1],[ylimvN(1)*ones(size(vertiX1)); ylimvN(2)*ones(size(vertiX1));],'color','k')

set(gca,'ylim',[min(ylimvN) round(max(ylimvN))]);

print(gcf,'-dpng','./../3165_02_Images/3165_02_02_2.png');


