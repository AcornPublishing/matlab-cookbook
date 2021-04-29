%% CHAPTER 1, USING ANNOTATIONS PINNED TO THE AXES
%   3165_01_03
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-12 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Set up the data
load stdNormalDistribution;
plot(x,y1);

%% Add the |line| at the mean position 
line([mean1 mean1],get(gca,'ylim'));

%% Add the |text arrow| annotation, working from data space annotation
% Convert to norm fig units
[xmeannfu ymeannfu]= dsxy2figxy(gca,[.5,0],[.15,.05]);
% Add the annotation component
annotation('textarrow',xmeannfu,ymeannfu,'String','Mean');
title({'The standard normal probability distribution',...
    ' function is plotted with the mean pointed out with', ...
    'a text arrow to make the figure more informative'});
xlabel('x');ylabel('probability of x');
set(gcf,'Paperpositionmode','auto','Color',[1 1 1]);
print(gcf,'-dpng','./../3165_01_Images/3165_01_03_1.png');

%% Manual insertion of annotation objects
%print(gcf,'-dpng','./../3165_01_Images/3165_01_03_2.png');
%% Pin annotation 
clf;
plot(x,y1);
line([mean1 mean1],get(gca,'ylim'));
title({'The standard normal probability distribution',...
    ' function is plotted with the mean pointed out with', ...
    'a text arrow to make the figure more informative'});
xlabel('x');ylabel('probability of x');
annotation_pinned('textarrow',[.5,0],[.15,.05],'String','Mean');
print(gcf,'-dpng','./../3165_01_Images/3165_01_03_3.png');
