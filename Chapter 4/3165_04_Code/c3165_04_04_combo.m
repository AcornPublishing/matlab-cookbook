%% CHAPTER 4, INTERACTION BTWEEN LIGHT, TRANSPARENCY AND VIEW
%   3165_04_04
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-03-19 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Construct the Klein bottle
n = 12;
a = .2;                         % the diameter of the small tube
c = .6;                         % the diameter of the bulb
t1 = pi/4 : pi/n : 5*pi/4;      % parameter along the tube
t2 = 5*pi/4 : pi/n : 9*pi/4;    % angle around the tube
u  = pi/2 : pi/n : 5*pi/2;
[X,Z1] = meshgrid(t1,u);
[Y,Z2] = meshgrid(t2,u);
% The handle
len = sqrt(sin(X).^2 + cos(2*X).^2);
x1 = c*ones(size(X)).*(cos(X).*sin(X) ...
    - 0.5*ones(size(X))+a*sin(Z1).*sin(X)./len);
y1 = a*c*cos(Z1).*ones(size(X));
z1 = ones(size(X)).*cos(X) + a*c*sin(Z1).*cos(2*X)./len;
% The bulb
r = sin(Y) .* cos(Y) - (a + 1/2) * ones(size(Y));
x2 = c * sin(Z2) .* r;
y2 = - c * cos(Z2) .* r;
z2 = ones(size(Y)) .* cos(Y);

%% Make a plot of the Klein bottle
% choose the axis
axes('position',[-.02 .12 1 .8]);
% construct the two components of the Klein bottle (body and handle) using
% surface objects
handleHndl=surf(x1,y1,z1,X); shading interp;
hold on;
bulbHndl=surf(x2,y2,z2,Y);shading interp;
colormap(hsv);
% set properties of the Klein bottle
set(handleHndl,'EdgeColor',[.5 .5 .5]);
set(bulbHndl,'EdgeColor',[.5 .5 .5])

colorbar('position',[0.9071    0.1238    0.0149    0.8000]);
% make front faces more transparent than the back faces
set(handleHndl,'alphadata',y1,'facealpha','interp');
set(bulbHndl,'alphadata',y2,'facealpha','interp');

% freezes aspect ratio properties to enable rotation of
%        3-D objects and overrides stretch-to-fill.
axis vis3d
% set the view
view(13,-18);
% do not show the axis
axis off 
% zoom by a certain factor
zoom(1.4);

% add two light sources (position defined in terms of data coordinates)
light('Position',[.5 .5 .5]);
light('Position',[-.67 -.1 -.7]);

% add annotation
h=annotation('textbox','position',[.06 .04 .95 .1],...
    'String',{'The Klein Bottle with surface transparency proportional',...
              'to y coordinate. Two light sources have been used.'},'linestyle','none', 'fontsize',14);

set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_04_Images/3165_04_04_1.png']);

% delete previous annotation
delete(h); 
% rotate camera to bring less trnasparent surface closer to viewer
campos([1.5017   14.2881    3.7572]);
% add new annottation
annotation('textbox','position',[.06 .04 .95 .1],...
    'String',{'The Klein Bottle with surface transparency proportional',...
              'to y coordinate. Less transparent surface brought forward.'},'linestyle','none', 'fontsize',14);
print(gcf,'-dpng',['./../3165_04_Images/3165_04_04_2.png']);

