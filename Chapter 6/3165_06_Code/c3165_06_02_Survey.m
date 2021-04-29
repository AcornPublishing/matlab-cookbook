%%  CHAPTER 6, SURVEY PLOTS
%   3165_06_02:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-05-21 24:00:00

%% data definition 
% years = {'2000', '2001','2002','2003','2004','2005','2006','2007','2008','2009'};
% lege = {'Caucasian','African American','Hispanic','Asian','Other'};
% icleg = {'Low Income','Med Income','High Income'};
% AverageSATScoresHI = abs(repmat((1700 + 80*rand(1,10)),5,1) + (repmat((500 + 80*rand(1,10)),5,1)).*randn(5,10));
% AverageSATScoresMI = abs(repmat((2000 + 80*rand(1,10)),5,1) + (repmat((800 + 80*rand(1,10)),5,1)).*randn(5,10));
% AverageSATScoresLI = abs(repmat((1200 + 80*rand(1,10)),5,1) + (repmat((1100 + 80*rand(1,10)),5,1)).*randn(5,10));
% n = max([AverageSATScoresHI(:); AverageSATScoresMI(:); AverageSATScoresLI(:)]);
% AverageSATScoresLI = AverageSATScoresLI/n;
% AverageSATScoresMI = AverageSATScoresMI./n;
% AverageSATScoresHI = AverageSATScoresHI./n;
% crimeRateHI = abs(repmat((20 + 8*rand(1,10)),5,1) + (repmat((6 + 4*rand(1,10)),5,1)).*randn(5,10));
% crimeRateMI = abs(repmat((10 + 8*rand(1,10)),5,1) + (repmat((8 + 4*rand(1,10)),5,1)).*randn(5,10));
% crimeRateLI = abs(repmat((30 + 8*rand(1,10)),5,1) + (repmat((10 + 4*rand(1,10)),5,1)).*randn(5,10));
% n = max([crimeRateHI(:); crimeRateMI(:); crimeRateLI(:)]);
% crimeRateLI = crimeRateLI/n;
% crimeRateMI = crimeRateMI./n;
% crimeRateHI = crimeRateHI./n;
% incomeGroups{1} = {[.2 .2 .6],[.2 .3 .5],[.2 .35 .45],[.2 .33 .47],[.2 .35 .45],[.2 .36 .44],[.2 .39 .41],[.2 .38 .42],[.2 .39 .41],[.25 .38 .37]};
% incomeGroups{2} = {[.15 .34 .51],[.13 .36 .51],[.15 .35 .5],[.16 .36 .48],[.15 .35 .5],[.16 .34 .5],[.17 .35 .48],[.17 .34 .49],[.16 .36 .48],[.18 .36 .46]};
% incomeGroups{3} = {[.2 .3 .5],[.2 .34 .46],[.15 .39 .46],[.15 .35 .5],[.15 .34 .51],[.14 .37 .49],[.13 .37 .5],[.22 .33 .45],[.08 .32 .6],[.08 .32 .6]};
% incomeGroups{4} = {[.4 .4 .2],[.45 .4 .15],[.45 .4 .15],[.45 .35 .2],[.45 .38 .17],[.5 .37 .13],[.45 .37 .18],[.4 .38 .22],[.39 .4 .21],[.45 .4 .15]};
% incomeGroups{5} =  {[.7 .2 .1],[.65 .25 .1],[.68 .15 .17],[.67 .14 .19],[.69 .13 .18],[.7 .18 .12],[.71 .18 .11],[.72 .17 .11],[.72 .16 .12],[.73 .16 .11]};
% demgraphics{1} = {[40 25 15 15 5],[38 22 18 17 5],[34 22 22 17 5],[34 17 22 21 6],[32 17 22 23 6],[31 16 22 25 6],[30 15 22 27 6],...
%     [30 14 22 28 6],[28 15 21 30 6],[27 15 21 31 6]};
% demgraphics{2} = {[45 35 10 5 5],[43 35 12 5 5],[42 36 12 5 5],[39 36 15 5 5],[38 37 15 5 5],[36 39 15 5 5],[36 39 17 5 3],...
%     [35 40 17 5 3],[33 40 19 5 3],[32 40 20 5 3]};
% demgraphics{3} = {[30 16 16 30 8],[30 14 15 33 8],[28 12 14 37 9],[28 12 9 42 9],[28 9 9 45 9],[26 9 10 46 9],[26 9 9 47 9],...
%     [26 8 7 50 9],[26 7 7 50 10],[24 7 7 52 10]};
% demgraphics{4} = {[30 16 30 16 8],[30 14 33 15 8],[28 12  37 14 9],[28 12 42 9 9],[28 9 45 9 9],[26 9  46 10 9],[26 9 47 9 9],...
%     [26 8 50 7 9],[26 7 50 7 10],[24 7 52 7 10]};
% demgraphics{5} = {[26 24 26 16 8],[26 21 30 15 8],[27 22 28 15 8],[24 23 32 14 7],[25 22 32 14 7],[25 24 33 11 7],[23 24 35 11 7],...
%     [23 25 36 11 5],[24 26 36 9 5],[24 27 36 8 5]};

%% load data
load customCountyData

% layout figure
figure('units','normalized','position',[.04 .12 .6 .8]);
axes('position',[0.0606    0.0515    0.9065    0.8747]);

% creating a filled set of polygons (representing the spatial origin of the data - the three contiguous counties)
%coordinates
x1 = [2   3   4.5 3.5 2.5 1.5];y1 = [1   1.5 3   4   3.5 2  ];
x2 = [1.5 2.5 3.5 4   3   2  ];y2 = [2   3.5 4   6   5.5 4.5];
x3 = [4.5 3.5 4   5   5.5   5];y3 = [3   4   6   5.5 5   4.5];
% command to plot the counties with above set of coordinates
patch([x1; x2; x3]',[y1; y2; y3]',0.8*ones(length(x1),3),[.9 .9 .9],'edgecolor',[1 1 1]);hold;alpha(.9);

% creating 5 data axes in the z direction and a grid connecting the axes
% for readability
% x,y locations for the data axes
x = [  1.5 2   2.2 3.32   3.8 4.5 5.2];
y = [  2   1.5 3.8 2.5   4   5   4.5];
% draw vertical data position lines
for i = 2:6
    line([x(i) x(i)],[y(i) y(i)],[1 11],'Color',[.8 .8 .8]);
end
% draw connecting grid lines
for i = 2:11
    line([x(1:end-1); x(2:end)],[y(1:end-1); y(2:end)],i*ones(2,6),'Color',[.8 .8 .8]);
end

% r1 = .075; 
% r2 = .15;

% cd defines the colors used for the ethnicity
cd = [141 211 199; 255 255 179; 190 186 218; 251 128 114; 128 177 211]/255;
% ci defines the colors used for the crime rate
ci = [205 207 150; 254 178 76; 240 59 32]/255;

for j = 2:11 % the decade of data
    for i=2:6   %the five spatial coordinate points
        
        % the line representing the ethnic distribution
        % it is extended along the y axis
        dt =  [0 demgraphics{i-1}{j-1}/100];               
        for r = 1:5            
            line([x(i) x(i)],[y(i)-1+sum(dt(1:r)) y(i)-1+sum(dt(1:r+1))], [j j],'Color',cd(r,:),'Linewidth',5);
        end

        % the line representing the income groups
        % it is extended along the x axis
        dt =  [0 incomeGroups{i-1}{j-1}];
        for r = 1:3
            xx1 = x(i)+sum(dt(1:r))/2;
            xx2 = x(i)+sum(dt(1:r+1))/2;
            line([xx1 xx2],[y(i) y(i)], [j j],'Color',ci(r,:),'Linewidth',2);
            % draw circles of area proportional to the average SAT scores,
            % and crime rates
            switch(r)
                case 1
                    scatter3((xx1+xx2)/2,y(i),j+.2,100*AverageSATScoresLI(i-1,j-1),ci(r,:),'filled');
                    scatter3((xx1+xx2)/2,y(i),j-.2,100*crimeRateLI(i-1,j-1),ci(r,:),'filled');
                case 2
                    scatter3((xx1+xx2)/2,y(i),j+.2,100*AverageSATScoresMI(i-1,j-1),ci(r,:),'filled');
                    scatter3((xx1+xx2)/2,y(i),j-.2,100*crimeRateMI(i-1,j-1),ci(r,:),'filled');
                case 3
                    scatter3((xx1+xx2)/2,y(i),j+.2,100*AverageSATScoresHI(i-1,j-1),ci(r,:),'filled');
                    scatter3((xx1+xx2)/2,y(i),j-.2,100*crimeRateHI(i-1,j-1),ci(r,:),'filled');
            end
        end
    end
end

% set the view
view(3); 
campos([ 14.7118  -42.0473   45.3905]);
axis tight off
% add annotations
annotation('textbox','position',[0.2664    0.0657    0.6817    0.0351],'string',{'\color{red}Survey plots \color{black}with a decade of Crime Rate and SAT scores across five counties,',...
    'split by Income Group. Also shows ethnic makeup of the data locations.'},'Fontsize',14,'linestyle','none');
% Add the year labels
for i = 2:11
    text(x(1),y(1),i,years{i-1});
    text(x(7),y(7),i,years{i-1});
end
% Add the location labels
for i = 2:6
    text(x(i),y(i),1,num2str(i-1),'fontsize',12);
end
% legends
axes('position',[0.1107    0.8478    0.2881    0.1347],'Visible','off');axis([0 .6 -.5 5.5]);
for i = 1:5
    line([0 .2],[5-(i-1) 5-(i-1)],'color',cd(i,:),'Linewidth',5);
    text(.2,5 - (i-1),lege{i},'Fontsize',12);
end
axes('position',[0.3495    0.8478   0.2881   0.1347],'Visible','off');axis([0 .6 -.5 5.5]);
for i = 1:3
    line([0 .2],[3-(i-1) 3-(i-1)],'color',ci(i,:),'Linewidth',5);
    text(.2,3 - (i-1),icleg{i},'Fontsize',12);
end
axes('position',[0.5886    0.8478   0.2881   0.1347]);hold on;
line([0 .2],[.5 .5],'color',[0 0 0],'Linewidth',2);
scatter(.1,.5+.1,10, [0 0 0],'filled'); text(.2,.5+.1,'Average SAT Score (per income group)','Fontsize',12);
scatter(.1,.5-.1,100,[0 0 0],'filled'); text(.2,.5-.1,'Crime Rate (per income group)','Fontsize',12);
axis([0 1 0 1]);
set(gca,'Visible','off');

set(gcf,'color',[1 1 1],'paperpositionmode','auto');

print(gcf,'-dpng',['./../3165_06_Images/3165_06_02_1' '.png']);