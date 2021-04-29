%% CHAPTER 7, OBTAINING USER INPUT FROM THE GRAPH
%   3165_07_02: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-06-16 24:00:00

function c3165_07_02_ObtainUserIPFromGraph
% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%layout the figure
figure('units','normalized','position',[.04 .11 .60 .80],'color',[1 1 1],'paperpositionmode','auto');

% data definition
load clusterInteractivData
userdata.symbChoice = {'+','x','o','s','^'};
userdata.boundDef =[];
userdata.X = X;
userdata.Y = Y;
userdata.Calls = ones(size(X));
set(gcf,'userdata',userdata);

% make the initial plot
plot(userdata.X,userdata.Y,'k.','Markersize',18); hold on;
uicontrol('style','pushbutton','string','Add cluster boundaries?','Callback',@addBound,'Position', [10 21 250 20],'fontsize',12);
uicontrol('style','pushbutton','string','Classify','Callback',@classifyPts,'Position', [270 21 100 20],'fontsize',12);
uicontrol('style','pushbutton','string','Clear Boundaries','Callback',@clearBounds,'Position', [380 21 150 20],'fontsize',12);
end

function addBound(src, evt)
    userdata = get(gcf,'userdata');     
    if length(userdata.boundDef)>4
        msgbox('A maximum of five clusters allowed!');
        return;
    end
        
    h=imellipse(gca);  
    userdata.boundDef{length(userdata.boundDef)+1} = h.getPosition; %xmin ymin width height
    hold on;
    axis tight;
    set(gcf,'userdata',userdata);    
end

function classifyPts(src, evt)
    userdata = get(gcf,'userdata');
    if isempty(userdata.boundDef)
        msgbox('Draw boundaries to classify points');
        return;
    end
    cla;
    clfpts = ones(size(userdata.X));
    for i = 1:length(userdata.boundDef)
%         pts = find( (userdata.X>min(userdata.boundDef{i}(:,1)))&(userdata.X<max(userdata.boundDef{i}(:,1))) &...
%               (userdata.Y>min(userdata.boundDef{i}(:,2)))&(userdata.Y<max(userdata.boundDef{i}(:,2))));
        pts = find( (userdata.X>(userdata.boundDef{i}(:,1)))&(userdata.X<(userdata.boundDef{i}(:,1)+userdata.boundDef{i}(:,3))) &...
                    (userdata.Y>(userdata.boundDef{i}(:,2)))&(userdata.Y<(userdata.boundDef{i}(:,2)+userdata.boundDef{i}(:,4))));
        userdata.Calls(pts) = i;  
        plot(userdata.X(pts),userdata.Y(pts),[userdata.symbChoice{i}],'Markersize',18); hold on;
        clfpts(pts)=0;
    end
    plot(userdata.X(find(clfpts)),userdata.Y(find(clfpts)),'k.','Markersize',18); hold on;
    set(gcf,'userdata',userdata);    
    
end

function clearBounds(src, evt)
    cla;
    userdata = get(gcf,'userdata');
    userdata.boundDef = [];
    set(gcf,'userdata',userdata);
    cla;
    plot(userdata.X,userdata.Y,'k.','Markersize',15); hold on;
end
