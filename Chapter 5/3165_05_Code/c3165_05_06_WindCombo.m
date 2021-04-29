%% CHAPTER 5, SCALAR AND VECTOR DATA WITH VARIOUS TECHNIQUES
%   3165_05_06:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-04-16 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% load the data
load wind
% generate certain values from the data set to be used later
wind_speed = sqrt(u.^2 + v.^2 + w.^2);
xmin = min(x(:));xmax = max(x(:));
ymax = max(y(:));ymin = min(y(:));

%% create a iso surface at wind-speed 40
figure('units','normalized','position',[ 0.3536    0.6204    0.2917    0.2843]);
p = patch(isosurface(x,y,z,wind_speed, 40));
% use isonormals for a smoother surface
isonormals(x,y,z,wind_speed, p);
% set the facecolor to red and no edge marks
set(p, 'FaceColor', 'red', 'EdgeColor', 'none');
% add isocaps
p2 = patch(isocaps(x,y,z,wind_speed, 40));
set(p2, 'FaceColor', 'interp', 'EdgeColor', 'none')
%set the view
box on
camproj perspective;
axis(volumebounds(x,y,z,wind_speed))
campos([ -203.7953  253.0409  129.3906]);
daspect([1 1 1]);
lighting phong;
%annotate
title('Wind flow data using \color{red} isosurface, isocaps','fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_06_1' '.png']);

%%	Draw contour slices on the two back walls. 
%resize figure to fit in new title
set(gcf,'position',[0.3578    0.5907    0.2870    0.3148]);
hold on;
% Create one slice at max y and add color from the data
hslice = slice(x,y,z,wind_speed,xmax,ymin,[]);
set(hslice,'FaceColor','interp','EdgeColor','none')
%Change the transparency of the isosurface to make contour lines approximately visible. 
alpha(0.7);     
color_lim = caxis;
% add contour intervals on it
cont_intervals = linspace(color_lim(1),color_lim(2),17);
hcont = contourslice(x,y,z,wind_speed,xmax,ymin,...
	[],cont_intervals,'linear');
set(hcont,'EdgeColor',[.4 .4 .4],'LineWidth',1);
%annotate
h=annotation('textbox','position',[ 0.0911    0.8730    0.8696    0.1163],...
    'String',{'Wind flow data using \color{red} isosurface, isocaps, slice ',...
       'contourslice, transparency'},'fontsize',14,'linestyle','none');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_06_2' '.png']);

%% show wind direction with cone plots
%clear previous annotation
delete(h);
% calculate path
[f verts] = reducepatch(isosurface(x,y,z,wind_speed, 30), .2);
% add with coneplot
h=coneplot(x,y,z,u,v,w,verts(:,1),verts(:,2),verts(:,3),2);
set(h, 'FaceColor', 'cyan', 'EdgeColor', 'none');
% move axes down to accomodate annotation
set(gca,'position',[0.1228    0.0041    0.7750    0.8150]);
% add annotation
h=annotation('textbox','position',[ 0.0911    0.8730    0.8696    0.1163],...
    'String',{'Wind flow data using \color{red} isosurface, isocaps, slice ',...
       ['contourslice, transparency, coneplots \color{black}(showing wind direction)' ...
       '\color{red} streamlines, streamtubes, lighting']},...
       'fontsize',14,'linestyle','none');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_06_3' '.png']);

%% add stream lines and stream tubes
%clear previous annotation
delete(h);
% calculate path for stream lines
[sx sy sz] = meshgrid(120:6:130, 50:2:60, 0:5:15);
% add streamalines
h2=streamline(x,y,z,u,v,w,sx,sy,sz);
set(h2, 'Color', [.6 .6 .6],'Linewidth',1);
% calculate path fro stream tubes
[sx,sy,sz] = meshgrid(xmin:10:xmax,ymin:10:ymax,0:2);
% add stream tubes
htubes = streamtube(x,y,z,u,v,w,sx,sy,sz,[.5 20]);
set(htubes,'EdgeColor','none','facecolor',[.2 .5 .2],...
	'AmbientStrength',.5)
% add lighting
camlight left; 
camlight right;
lighting gouraud
% add annotation
h=annotation('textbox','position',[ 0.0911    0.8730    0.8696    0.1163],...
    'String',{'Wind flow data using \color{red} isosurface, isocaps, slice ',...
       'contourslice, transparency, coneplots \color{black}(showing wind direction)'},...
       'fontsize',14,'linestyle','none');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_06_4' '.png']);
