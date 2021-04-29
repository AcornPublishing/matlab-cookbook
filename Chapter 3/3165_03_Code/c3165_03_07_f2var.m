%% CHAPTER 3, GRIDDING SCATTERED DATA
%   3165_03_07: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-02-14 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Generate random 2D data
% x = [-10*rand(30,1); 10*rand(30,1)]; 
% y = [-10*rand(30,1); 10*rand(30,1)]; 
load griddataExample;
R = sqrt(x.^2 + y.^2) + eps;
z = sin(R)./R;

%% define the uniform grid
xx = linspace(min(x),max(x),30);
yy = linspace(min(y),max(y),30);
[X,Y] = meshgrid(xx,yy);

%% fit using griddata
Z_griddata = griddata(x,y,z,X,Y);

%% fit using th emore modern triscatteredinterp
triScatterInterp_F = TriScatteredInterp(x,y,z,'natural');
Z_triScatterInterp = triScatterInterp_F(X,Y);

%% set up the figure
figure('units','normalized','Position',[.312 .1463 .488 .712]);

%% plot 1 = Fit using griddata, plot with pcolor','clear grid lines
subplot(2,2,1);
h=pcolor(X,Y,Z_griddata);set(h,'edgecolor','none');  hold on; 
title({'Fit using \color{red}griddata','\color{black}Plot with \color{red}pcolor,\color{black}Clear mesh lines'},'Fontsize',12);
plot(x,y,'o','markerfacecolor',[0 0 0]);
box on; grid on;axis([-10 10 -10 10]);

%% plot 2 - Fit using griddata, Plot with mesh
subplot(2,2,2);
mesh(X,Y,Z_triScatterInterp); hold on;
h=mesh(X,Y,Z_griddata);view(2);set(h,'edgecolor','none');  hold on; 
title({'Fit using \color{red}griddata','\color{black}Plot with \color{red}mesh'},'Fontsize',12);
plot(x,y,'o','markerfacecolor',[0 0 0]);
box on; grid on;axis([-10 10 -10 10]);

%% plot 3 - 'Fit using tri scatter interp','Plot using triangular patches'
subplot(2,2,3);
tri = delaunay(X,Y);
h= trisurf(tri,X,Y,Z_triScatterInterp); set(h,'edgecolor','none');   view(2); hold on;
title({'Fit using \color{red}triScatterInterp','\color{black}Plot using \color{red}trisurf \color{black}(triangular patches), Clear mesh lines'},'Fontsize',12);
plot(x,y,'o','markerfacecolor',[0 0 0]);
box on; grid on;axis([-10 10 -10 10]);

%% plot 4 - Fit using triScatterInterp, Plot with surf + interp shading
subplot(2,2,4);
surf(X,Y,Z_triScatterInterp); view(2); shading interp; hold on; 
title({'Fit using \color{red}triScatterInterp','\color{black}Plot with \color{red}surf + interp shading'},'Fontsize',12);
plot(x,y,'o','markerfacecolor',[0 0 0]);
box on; grid on;axis([-10 10 -10 10]);

%%
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_03_Images/3165_03_07_1.png');

%% check
% check to see if the triangulations look good
figure; 
dt = DelaunayTri(x,y);
triplot(dt);
title({'\color{red}How do you know you got a good fit?',...
    '\color{black}Always check the underlying Delaunay triangulation. If',...
    'triangles look far from being equilaterals, you cannot',...
    'expect to get good results in those neighborhoods.'},'Fontsize',12);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');axis([-10 10 -10 10]);
print(gcf,'-dpng','./../3165_03_Images/3165_03_07_2.png');


