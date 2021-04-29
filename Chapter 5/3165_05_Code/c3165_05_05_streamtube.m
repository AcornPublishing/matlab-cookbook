%% CHAPTER 5, STREAM LINES, RIBBONS, TUBES
%   3165_05_05: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-04-16 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% load the data
load wind

%% stream line
% define start points for streamlines
[sx sy sz] = meshgrid(80, 20:10:50, 0:4:16);
plot3(sx(:),sy(:),sz(:),'bo','MarkerFaceColor','b'); hold on;
%plot the stream lines
h=streamline(x,y,z,u,v,w,sx(:),sy(:),sz(:));
set(h,'linewidth',2','color',[1 0 0]);
% set the view
axis(volumebounds(x,y,z,u,v,w))
grid; box; daspect([2.5 3 1.5]);
%annotate
title('Wind flow data using \color{red} streamlines','fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_05_1' '.png']);

%% stream ribbons
figure;
% calculate the curl and windspeed
cav = curl(x,y,z,u,v,w);
wind_speed = sqrt(u.^2 + v.^2 + w.^2);
% Generate vertices from which the stream ribbons should start. 
%Use the stream3 command to generate the streamlines. 
[sx sy sz] = meshgrid(80,20:10:50,0:4:16);
verts = stream3(x,y,z,u,v,w,sx,sy,sz,1);
%plot custom ribbons
h = streamribbon(verts,x,y,z,cav,wind_speed,2);
set(h,'FaceColor','g',...
	'EdgeColor',[.7 .7 .7],...
	'AmbientStrength',.6)
% set the view (including lighting)
axis(volumebounds(x,y,z,wind_speed))
grid on
view(3)
camlight left; 
lighting phong
%annotate
title('Wind flow data using \color{red} streamribbons','fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_05_2' '.png']);

%% stream tubes
figure;
%calculate the divergence
div = divergence(x,y,z,u,v,w);
%use stream3 to calculate the streams and 
[sx sy sz] = meshgrid(80,20:10:50,0:4:16);
verts = stream3(x,y,z,u,v,w,sx,sy,sz,1);
%plot with tubes
h=streamtube(verts,x,y,z,div);
shading interp;
% set the view (including lighting)
daspect([1 1 1]);
grid on
view(3);axis tight
set(gcf,'Renderer','zbuffer');
camlight; lighting gouraud
%annotate
title('Wind flow data using \color{red} streamtubes','fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_05_3' '.png']);

