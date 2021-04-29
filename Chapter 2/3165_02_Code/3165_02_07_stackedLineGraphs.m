%   3165_02_03: Stacked Line Graphs
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

figure('Position',[660         160        1256         818]);

% data definition
[ranksoverdecades names] = xlsread('MockDataNameVoyager.xlsx');
sex = names(2:end,2);
names = names(2:end,1);
years = ranksoverdecades(1,:);
ranksoverdecades = ranksoverdecades(2:end,:);

males = find(strcmp(sex,'M'));
fmales = find(strcmp(sex,'F'));

ranksoverdecades = ranksoverdecades';

ymax=max(max(cumsum(ranksoverdecades,2)));

nameLoc = cumsum(ranksoverdecades(end,:));
nameLoc = [0 nameLoc];
nameLoc = (nameLoc(1:end-1) + nameLoc(2:end))/2;

axes('ylim',[0 ymax],'xlim',[min(years) max(years)],'YAxisLocation','right','fontweight','bold','ytick',nameLoc,'yticklabel',names,'ticklength',[0.01 0.05],'tickdir','out');
axes('Position',get(gca,'Position'));
h = area(years,ranksoverdecades);

set(h(males),'FaceColor',[100	149	237]/255)
set(h(fmales),'FaceColor',[255	192	203]/255);
set(h,'edgecolor',[.5 .5 .5]) % Set all to same value
set(gca,'ylim',[0 ymax],'xlim',[min(years) max(years)],'xticklabel',[]);
box on;

title('Name trends for babies','Fontsize',14);
ylabel('Rank over the years','Fontsize',14);
xlabel('Years','Fontsize',14);
print(gcf,'-dpng','./../3165_02_Images/3165_02_07.png');
