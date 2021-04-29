%% CHAPTER 8, PRESERVING ON SCREEN FONT SIZE AND ASPECT RATIOS
%   3165_08_03: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-07-16 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%get the data ready
peaks;view(2);shading interp;

%resize figure 
set(gcf,'units','normalized','position',...
    [ 0.0547    0.1694    0.5901    0.7352]);
% print related options
set(gcf,'PaperOrientation','landscape');
set(gcf,'paperposition',[.25 2.5 8 6],...
'PaperUnits','inches');
set(gcf,'PaperPositionMode','auto');
set(gca,'position',[ 0.1300    0.1100    0.7676    0.6835]);
%add equation at 20 points
h=title({'$z =  3(1-x)^2e^{-(x^2) - (y+1)^2} $ ',...
'$- 10(\frac{x}{5} - x^3 - y^5)e^{-x^2-y^2} $',... 
'$- \frac{1}{3}e^{-(x+1)^2 - y^2}$'},...
'interpreter','latex','Fontsize',20);
%print(gcf,'-dmeta','./../3165_08_Images/3165_08_03_1');

% using the exportfig utility from Ben Hinkle
exportfig(gcf, './../3165_08_Images/3165_08_03_2','format','eps','preview','tiff', 'height',4,'width',7,'color','cmyk','Fontmode','fixed','fontsize',15);
             