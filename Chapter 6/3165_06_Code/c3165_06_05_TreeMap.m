%% CHAPTER 6: TREE MAPS
%   3165_06_05:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-05-21 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

% layout the figure;
set(gcf,'units','normalized','position',[.03 .25 .67 .66]);
set(gca,'position',[.01 .04 .89 .89]);

% Load the GDB per country
gdp = xlsread('GDP_By_Country_And_Continent_Treemap.csv','C2:C101');
[blah labels] = xlsread('GDP_By_Country_And_Continent_Treemap.csv','a2:a101');

% set the color
m=colormap;
climMat=[min(log(gdp)) max(log(gdp))];
set(gca,'clim',climMat);
index = fix((log(gdp)-climMat(1))/...
                (climMat(2)-climMat(1))*63)+1;    

%compute the treemap
r = treemap(gdp);
             
%plot the results
plotRectangles(r,labels,m(index,:));

h=colorbar('position',[.95 .03 .01 .89]);
ylabel(h,'log(Millions of US Dollars)','fontsize',14);
title('\color{red}Tree maps \color{black} representing the Gross Domestic Product across 100 countries','fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_06_Images/3165_06_05_1' '.png']);
