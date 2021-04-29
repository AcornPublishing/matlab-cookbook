%% CHAPTER 4, TRANSPARENCY
%   3165_04_01:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-03-19 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load the telescope data
load W6

%% use surface plots; encode same information in transparency and color 
% layout the fig
figure('units','normalized','position',[.2 .5 .55 .4]); hold on;
% define grids
xx=[84-3/8:-(((84-3/8)-(77+3/8))/(size(W6,2)-1)):77+3/8];
yy=[-1.5-.1:(abs((-1.5-.1)-(1.5+.1))/(size(W6,1)-1)):1.5+.1];
% surf the data
surf(xx,yy,W6,'alphadata',W6,'facealpha','interp'); view(2); shading interp; axis tight;alim([-0.05 .2]);
% add annotations for overall graph
title({'Transparency (and color) used to encode same information; the higher the magnitude, the ',...
       'less transparent is the datapoint. Data was obtained from the Westerbork Synthesis Radio Telescope ',...
       '(WSRT) in the Netherlands, recorded in the radio frequency (327 MHz) range.',...
       '4(f) gray scale range 0 - 150 mJy / beam'},'Fontsize',14);
xlabel('Galactic Longitudes','Fontsize',14);
ylabel('Galactic Latitudes','Fontsize',14);

set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_04_Images/3165_04_01_1.png');

%% use surface plots; encode different information in transparency and color
% layout the fig
figure('units','normalized','position',[.2 .5 .55 .4]); hold on;
h=surf(xx,yy,W6); view(2); shading interp; axis tight;
% create a mask to act as the transparency data for the surface

tt = .5*ones(size(W6));
tt1 = repmat([.5*ones(1,140) 0*ones(1,80) 0.5*ones(1,140) 0*ones(1,80) 0.5*ones(1,140) 0*ones(1,80) 0.5*ones(1,140) 0*ones(1,79) ],365,1);
tt2 = repmat([0.5*ones(1,65) 0*ones(1,40) 0.5*ones(1,63) 0*ones(1,40) 0.5*ones(1,62) 0*ones(1,40) 0.5*ones(1,55)]',1,879);
tt = .5*(double(tt1 & tt2)) + .5;

% set the alpha data to this mask
set(h,'alphadata',tt,'facealpha','interp');alim([0 1]);
% add annotations for overall graph
title({'Color codes the raw data; A box pattern is used as the transparency data,',...
       'creating pockets of complete and partial transparency.'},'Fontsize',14);
xlabel('Galactic Longitudes','Fontsize',14);
ylabel('Galactic Latitudes','Fontsize',14);

set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_04_Images/3165_04_01_2.png');

%% overlay pulsar location
% layout the fig
figure('units','normalized','position',[.2 .5 .55 .4]); hold on;
surf(xx,yy,W6,'alphadata',W6,'facealpha','interp'); view(2); hold on;
shading interp; axis tight;alim([-0.05 .2]);
% add markers to indicate location of pulsars
plot(pulsars(2).lon,pulsars(2).lat,'s','MarkerEdgeColor','none','Markersize',18, 'Markerfacecolor',[1 1 0]);
plot(pulsars(2).lon-.5,pulsars(2).lat-.1,'s','MarkerEdgeColor','none','Markersize',18, 'Markerfacecolor',[1 0 1]);
plot(pulsars(2).lon-1,pulsars(2).lat-.2,'s','MarkerEdgeColor','none','Markersize',18, 'Markerfacecolor',[0 1 0]);
plot(pulsars(2).lon-2,pulsars(2).lat-.3,'s','MarkerEdgeColor','none','Markersize',18, 'Markerfacecolor',[1 0 0]);
% add annotations for overall graph
title({'Interaction of opacity and color between two surfaces may create false color.',...
       'Use colors of opposite hues to reduce false color. Reduce saturation of color ',...
       'on the rear surface, while keeping the lightness fixed to avoid false color.'},'Fontsize',14);
xlabel('Galactic Longitudes','Fontsize',14);
ylabel('Galactic Latitudes','Fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_04_Images/3165_04_01_3.png');
