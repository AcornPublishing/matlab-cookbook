%% CHAPTER 3, BI-DIRECTIONAL ERROR BARS
%   3165_03_03: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-02-14 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load data
load flatPlateBoundaryLayerData

%% bin the data
xx = laminarFlow(:,2);
yy = laminarFlow(:,3);

% declare the grid
xg=linspace(min(xx),max(xx),6);
yg=linspace(min(yy),max(yy),6);

% compute frequency of points in each grid, their mean and std
for cnt_x=1:length(xg)-1
    x_ind=intersect(find(xx>xg(cnt_x)),find(xx<=xg(cnt_x+1)));  
    x(cnt_x)=mean(xx(x_ind));
    e_x(cnt_x)=std(xx(x_ind));
end
for cnt_y=1:length(yg)-1
    y_ind=intersect(find(yy>yg(cnt_y)),find(yy<=yg(cnt_y+1)));  
    y(cnt_y)=mean(yy(y_ind));
    e_y(cnt_y)=std(yy(y_ind));
end


%% figure 
figure('units','normalized','Position',[0.0750    0.5157    0.5703    0.3889]);
axes('Position',[0.0676    0.1100    0.8803    0.8150]);

%% call the function for bi dir error bars
h = biDirErrBar(x,y,e_x,e_y);

%% annotation
set(get(h,'title'),'string','Bidirectional Error Bars with Laminar Flow','Fontsize',15);
set(get(h,'xlabel'),'string','Position Measurement','Fontsize',15);
set(get(h,'ylabel'),'string','Velocity Measurement','Fontsize',15);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');

print(gcf,'-dpng','./../3165_03_Images/3165_03_03_1.png');
