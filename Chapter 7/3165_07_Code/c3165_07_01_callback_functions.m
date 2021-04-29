%% CHAPTER 7, CALLBACK FUNCTIONS
%   3165_07_01: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-05-21 24:00:00

function c3165_07_01_callback_functions

% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

% data definition
load customCountyData
%split data into two chunks - one to do with demographics and the other to
%do with income groups
userdataA.demgraphics = demgraphics;
userdataA.lege = lege;
userdataB.incomeGroups = incomeGroups;
userdataB.crimeRateLI = crimeRateLI;
userdataB.crimeRateHI = crimeRateHI;
userdataB.crimeRateMI = crimeRateMI;
userdataB.AverageSATScoresLI = AverageSATScoresLI;
userdataB.AverageSATScoresMI = AverageSATScoresMI;
userdataB.AverageSATScoresHI = AverageSATScoresHI;
userdataB.icleg = icleg;
% put these two components under one structure
userdataAB.years = years;
userdataAB.userdataA = userdataA;
userdataAB.userdataB = userdataB;

% construct the figure
figure('position',[ 84         124        1156         854]);

% add a uimenu item to the toolbar
f = uimenu('Label','Data Groups');
% define the elements of the application data: these  
% should constitute data to which you will need access 
% from within callback functions.
setappdata(gcf,'mainAxes',[]);
setappdata(gcf,'labelAxes',[]);     
% add submenu items, define callbacks, tag and userdata
uimenu(f,'Label','By Population','Callback',@showData,'tag','demographics','userdata',userdataAB);
uimenu(f,'Label','By IncomeGroups','Callback',@showData,'tag','IncomeGroups','userdata',userdataAB);
uimenu(f,'Label','Show All','Callback',@showData,'tag','together','userdata',userdataAB);
% uimenu(f,'Label','Alternative way to pass data to callback','Callback',{@showData1,userdataAB},'tag','blah');

end
%print(gcf,'-dpng',['./../3165_06_Images/3165_06_06' '.png']);
% function showData1(src, evt, arg1)
%     disp(arg1.years);
% end

function showData(src, evt)
    
    userdata = get(gcbo,'userdata');
    if strcmp(get(gcbo,'tag'),'demographics')   
        mainAxesHandle = getappdata(gcf,'mainAxes');
        labelAxesHandles = getappdata(gcf,'labelAxes');
        if ~isempty(mainAxesHandle), 
            cla(mainAxesHandle); 
            [mainAxesHandle, x, y, ci, cd] = redrawGrid(userdata.years, mainAxesHandle);
        else
            [mainAxesHandle, x, y, ci, cd] = redrawGrid(userdata.years);
        end
        if ~isempty(labelAxesHandles) 
            for ij = 1:length(labelAxesHandles)
                cla(labelAxesHandles(ij));
            end
        end        
        labelAxesHandles = showDemographics(userdata.userdataA, mainAxesHandle, x, y, cd);
        setappdata(gcf,'mainAxes',mainAxesHandle);
        setappdata(gcf,'labelAxes',labelAxesHandles);     
        axes(mainAxesHandle);
        text(1.2,-.75,'Changes in the Demographics Over 10 Years','Fontsize',15);
    elseif strcmp(get(gcbo,'tag'),'IncomeGroups')
        mainAxesHandle = getappdata(gcf,'mainAxes');
        labelAxesHandles = getappdata(gcf,'labelAxes');
        if ~isempty(mainAxesHandle), 
            cla(mainAxesHandle); 
            [mainAxesHandle, x, y, ci, cd] = redrawGrid(userdata.years, mainAxesHandle);
        else
            [mainAxesHandle, x, y, ci, cd] = redrawGrid(userdata.years);
        end

        if ~isempty(labelAxesHandles) 
            for ij = 1:length(labelAxesHandles)
                cla(labelAxesHandles(ij));
            end
        end
        labelAxesHandles = showIncomeGroups(userdata.userdataB, mainAxesHandle, x, y, ci);
        setappdata(gcf,'mainAxes',mainAxesHandle);
        setappdata(gcf,'labelAxes',labelAxesHandles);        
        axes(mainAxesHandle);
        text(1.2,-.75,'Crime Rate and SAT scores across 5 Counties per Income Group Over 10 Years','Fontsize',15);
    else
        mainAxesHandle = getappdata(gcf,'mainAxes');
        labelAxesHandles = getappdata(gcf,'labelAxes');
        if ~isempty(mainAxesHandle), 
            cla(mainAxesHandle); 
            [mainAxesHandle, x, y, ci, cd] = redrawGrid(userdata.years, mainAxesHandle);
        else
            [mainAxesHandle, x, y, ci, cd] = redrawGrid(userdata.years);
        end
        if ~isempty(labelAxesHandles) 
            for ij = 1:length(labelAxesHandles)
                cla(labelAxesHandles(ij));
            end
        end
        labelAxesHandles(1) = showDemographics(userdata.userdataA, mainAxesHandle, x, y, cd);
        labelAxesHandles(2:3) = showIncomeGroups(userdata.userdataB, mainAxesHandle, x, y, ci);  
        setappdata(gcf,'mainAxes',mainAxesHandle);
        setappdata(gcf,'labelAxes',labelAxesHandles);
        axes(mainAxesHandle);
        text(1.2,-.75,'Crime Rate and SAT scores across 5 Counties per Income Group Over 10 Years ALong with Demographic Information','Fontsize',15);
    end

    function labelAxesHandle = showDemographics(userdata, mainAxesHandle, x, y, cd)    
        axes(mainAxesHandle);
        for j = 2:11 % the decade of data
            for i=2:6   %the five spatial coordinate points
                dt =  [0 userdata.demgraphics{i-1}{j-1}/100];
                for r = 1:5
                    line([x(i) x(i)],[y(i)-1+sum(dt(1:r)) y(i)-1+sum(dt(1:r+1))], [j j],'Color',cd(r,:),'Linewidth',5);
                end
            end
        end
        axis off 
        
        labelAxesHandle = axes('position',[0.1107    0.8478    0.2881    0.1347],'Visible','off');axis([0 .6 -.5 5.5]);
        for i = 1:5
            line([0 .2],[5-(i-1) 5-(i-1)],'color',cd(i,:),'Linewidth',5);
            text(.25,5 - (i-1),userdata.lege{i},'Fontsize',12);
        end
    end

    function labelAxesHandle = showIncomeGroups(userdata, mainAxesHandle, x, y, ci)
        axes(mainAxesHandle);
        for j = 2:11 % the decade of data
            for i=2:6   %the five spatial coordinate points        
                dt =  [0 userdata.incomeGroups{i-1}{j-1}];
                for r = 1:3
                    xx1 = x(i)+sum(dt(1:r))/2;
                    xx2 = x(i)+sum(dt(1:r+1))/2;
                    line([xx1 xx2],[y(i) y(i)], [j j],'Color',ci(r,:),'Linewidth',2);
                    switch(r)
                        case 1
                            scatter3((xx1+xx2)/2,y(i),j+.2,100*userdata.AverageSATScoresLI(i-1,j-1),ci(r,:),'filled');
                            scatter3((xx1+xx2)/2,y(i),j-.2,100*userdata.crimeRateLI(i-1,j-1),ci(r,:),'filled');
                        case 2
                            scatter3((xx1+xx2)/2,y(i),j+.2,100*userdata.AverageSATScoresMI(i-1,j-1),ci(r,:),'filled');
                            scatter3((xx1+xx2)/2,y(i),j-.2,100*userdata.crimeRateMI(i-1,j-1),ci(r,:),'filled');
                        case 3
                            scatter3((xx1+xx2)/2,y(i),j+.2,100*userdata.AverageSATScoresHI(i-1,j-1),ci(r,:),'filled');
                            scatter3((xx1+xx2)/2,y(i),j-.2,100*userdata.crimeRateHI(i-1,j-1),ci(r,:),'filled');
                    end
                end
            end
        end
        axis off
        
        labelAxesHandle(1) = axes('position',[0.3495    0.8478   0.2881   0.1347],'Visible','off');axis([0 .6 -.5 5.5]);
        for i = 1:3
            line([0 .2],[3-(i-1) 3-(i-1)],'color',ci(i,:),'Linewidth',5);
            text(.25,3 - (i-1),userdata.icleg{i},'Fontsize',12);
        end
        labelAxesHandle(2) = axes('position',[0.5886    0.8478   0.2881   0.1347]);hold on;
        line([0 .2],[.5 .5],'color',[0 0 0],'Linewidth',2);
        scatter(.1,.5+.1,10, [0 0 0],'filled'); text(.2,.5+.1,'Average SAT Score (per income group)','Fontsize',12);
        scatter(.1,.5-.1,100,[0 0 0],'filled'); text(.2,.5-.1,'Crime Rate (per income group)','Fontsize',12);
        axis([0 1 0 1]);       
        set(gca,'Visible','off');  
    end

    function [mainAxesHandle x y ci cd] = redrawGrid(years, mainAxesHandle)
        if exist('mainAxesHandle')
            axes(mainAxesHandle);
        else
            mainAxesHandle = axes('position',[0.1300    0.1100    0.7750    0.8150]);
        end
        % creating a filled set of polygons (representing the spatial context of the data - the three contiguous counties)
        x1 = [2   3   4.5 3.5 2.5 1.5];
        y1 = [1   1.5 3   4   3.5 2  ];
        x2 = [1.5 2.5 3.5 4   3   2  ];
        y2 = [2   3.5 4   6   5.5 4.5];
        x3 = [4.5 3.5 4   5   5.5   5  ];
        y3 = [3   4   6   5.5 5   4.5];
        patch([x1; x2; x3]',[y1; y2; y3]',0.8*ones(length(x1),3),[.9 .9 .9],'edgecolor',[1 1 1]);hold on;alpha(.9);

        % set the view
        view(3); 
        campos([8.9134  -45.6683   38.5862]);
        set(gcf,'Color',[1 1 1]);
        % % creating centered axis in the z direction
        %line([1.5 1.5],[2 2],[1 11],'Color',[.8 .8 .8]);
        line([3.25 3.25],[2.5 2.5],[1 11],'Color',[.8 .8 .8]);
        line([2 2],[1.5 1.5],[1 11],'Color',[.8 .8 .8]);
        line([4.5 4.5],[5 5],[1 11],'Color',[.8 .8 .8]);
        line([2.5 2.5],[4 4],[1 11],'Color',[.8 .8 .8]);
        line([4 4],[4 4],[1 11],'Color',[.8 .8 .8]);
        %line([6 6],[4 4],[0 11],'Color',[.8 .8 .8]);
        %axis tight off;

        x = [  1.5 2   2.5 3.25 4 4.5 5.2];
        y = [  2   1.5 4   2.5  4 5  4.5];

        %creating the grid for readability
        for i = 2:11
            line([x(1:end-1); x(2:end)],[y(1:end-1); y(2:end)],i*ones(2,6),'Color',[.8 .8 .8]);
        end        
        r1 = .075; r2 = .15;
        cd = [141 211 199; 255 255 179; 190 186 218; 251 128 114; 128 177 211]/255;
        ci = [205 207 150; 254 178 76; 240 59 32]/255;
        %amat = linspace(0,360,7)*pi/180;amat = amat(1:end-1);

        for i = 2:11
            text(x(1),y(1),i,years{i-1});
            text(x(7),y(7),i,years{i-1});
        end
        
        mainAxesHandle = gca;     
    end

end

