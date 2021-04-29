%% CHAPTER 6, GLYPHS
%   3165_06_03:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-05-21 24:00:00

%% load the data
load carsmall;

% layout the figure
figure('units','normalized','position',[0.0010    0.1028    0.6443    0.8028]);

% because you will use color as one of the graphical attributes to code a data 
% dimension, set the climits to the min and max value of that data dimension
m = colormap;
climMat = [min(Weight) max(Weight)];

% choose which data points to display using the glyph
tryThese = [5 26 27 29 36 59 62 66];

% generate a graphic to act as the key to interpret the rest of the glyphs label the 
% meaning of the start and end points of the glyph, the color, line width and
% title; specially mark it gray to make it stand out against the rest
subplot(3,3,1);
quiver(50,50,200,95,'Linewidth',2,'Color',[0 0 0],'linestyle','--');
text(15,40,'Acceleration, MPG');
text(100,150,'Displacement, Horsepower');
xlim([0 350]);ylim([0 200]);
title({'\color{red}Glyph Key','\color{black}Linewidth = #cylinders'},'fontsize',12);
set(gca,'color',[.9 .9 .9]);
% plot the 8 chosen 6 dimensional data points with the glyph
for ii = 1:8
    subplot(3,3,ii+1);set(gca,'clim',climMat); hold on;box on;
    i = tryThese(ii);
    index = fix((Weight(i)-climMat(1))/(climMat(2)-climMat(1))*63)+1;
    quiver(Acceleration(i),MPG(i),Displacement(i),Horsepower(i),'Linewidth',Cylinders(i),'Color',m(index,:));
    title({['\color{black}Model = \color{red}' deblank(Model(i,:)) '\color{black},Year = \color{red}' num2str(Model_Year(i,:)) ],...
           ['\color{black}Mfg = \color{red}' deblank(Mfg(i,:)) '\color{black}, Origin = \color{red}' deblank(Origin(i,:))]},'fontsize',12); 
    xlim([0 350]);ylim([0 200]);
end
% add a color bar and annotation
h=colorbar;
set(h,'position',[0.0323    0.1252    0.0073    0.7172]);
ylabel(h,'Weight of car','fontsize',12);
annotation('textbox','position',[0.2013    0.0256    0.5756    0.0323],...
    'string',['Quiver used as a  \color{red}glyph \color{black} to present 6 numerical properties'...
    ' associated with each car'],'fontsize',14,'linestyle','none');

set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_06_Images/3165_06_03_1' '.png']);

%% % statistics toolbox - star plot
%set up the figure
figure;
set(gcf,'units','normalized','position',[ 0.3547    0.1306    0.5510    0.4041]);
set(gca,'position',[ 0.0320    0.0035    0.9257    0.9965],'fontsize',12);
% ready the data
x = [Acceleration Cylinders Displacement Horsepower MPG Weight];
varLabels = {'Acceleration','Cylinders','Displacement','Horsepower','MPG','Weight'};
%make a call to glybphplot, the default glyph used is of type star
h = glyphplot(x(tryThese(1:3),:),'standardize','column',...
            'obslabels',deblank(Model(tryThese(1:3),:)),...             
            'grid',[1 3]);
% get the xdata, ydata out from the set of handles returned by glyph plot         
xdata=get(h(1,2),'XData');
ydata=get(h(1,2),'YData');
% to construct the key, rotate each var label to align with the spokes of
% the star
r = [0 60 120 180 -120 -60];
for i = 1:6
    text(xdata(1,2+(i-1)*3),ydata(1,2+(i-1)*3),varLabels{i},'rotation',r(i),'fontsize',12);
end
% set font size for the axis of each star
set(h(1,3),'Fontsize',14);
set(h(2,3),'Fontsize',14);
set(h(3,3),'Fontsize',14);
% set the view
axis off
% annotation
annotation('textbox','position',[ 0.4258    0.7821    0.4900    0.1399],...
    'string',['Star \color{red}glyphs \color{black}showing six data'...
    ' dimensions per data point (various attributes of different models of automobiles.)'],...
    'fontsize',14,'linestyle','none');
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_06_images/3165_06_03_2' '.png']);

%% % statistics toolbox - face plot
figure;
h=glyphplot(x,'glyph','face',...
            'obslabels',Model,...
            'grid',[2 2],...
            'page',3);
for i = 1:4
    set(h(i,3),'Fontsize',12);
end        
annotation('textbox','position',[0.1607    0.8273    0.7587    0.1399],...
    'string',['Facial \color{red}glyphs \color{black}showing six '...
    ' dimensions per data point'],...
    'fontsize',14,'linestyle','none');
axis off
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
        
print(gcf,'-dpng',['./../3165_06_images/3165_06_03_3' '.png']);
