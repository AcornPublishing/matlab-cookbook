%% CHAPTER 4, VIEW CONTROL
%   3165_04_03:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-03-19 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load the data
load viewCntrolDataSet

%% create a view with specs for azimuth and elevation
figure;surf(x,y,w); shading interp;
view(38,26);
title({'Define the view in terms of the angles of azimuth and elevation',...
       '\color{red}view(38,26)'},'Fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_04_Images/3165_04_03_1.png']);
 
%% Define the view in terms of a data aspect ratio
figure('units','normalized','position',[.4 .6 .3 .3]);
surf(x,y,w); shading interp;daspect([1 1 1]);
title({'Define the view in terms of a data aspect ratio', '\color{red}daspect([1 1 1])'},'Fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_04_Images/3165_04_03_2.png']);

%% Define the view using camera position
figure('units','normalized','position',[.4 .6 .3 .3]);
surf(x,y,w); shading interp;
campos([-13.7329  -10.5376    0.0642]);
title({'Define the view in terms of the camera position', ...
    '\color{red}campos([-13.7329  -10.5376    0.0642])'},'Fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_04_Images/3165_04_03_3.png']);

%% Define the view using camera position
figure('units','normalized','position',[.4 .6 .3 .3]);
surf(x,y,w); shading interp;
set(gca,'cameraUpVector',[-4 5 .5]);
title({'Define the view in terms of the camera  up vector', ...
    '\color{red}set(gca,"cameraUpVector",[-4 5 .5])'},'Fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_04_Images/3165_04_03_4.png']);

%% view distortions
figure;
axes('position',[0.4813    0.6728    0.1989    0.2539]); surf(x,y,w); shading interp;
axes('position',[0.0710    0.4005    0.6163    0.1842]); surf(x,y,w); shading interp;
axes('position',[0.0710    0.1073    0.6163    0.1842]); surf(x,y,w); shading interp;xlim([-.3 .8]);
axes('position',[0.7709    0.0995    0.1670    0.8255]); surf(x,y,w); shading interp;
annotation('textbox',[0.0515    0.6754    0.3499    0.2330],'String',...
    ['The aspect ratio of the data will influence viewer percerption. ' ...
     'Here, the same data is presented with various aspect ratios and zoom regions.'],...
     'linestyle','none');
set(gcf,'color',[1 1 1],'paperpositionmode','auto');

