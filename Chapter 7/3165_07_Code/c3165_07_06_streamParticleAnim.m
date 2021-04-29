%% CHAPTER 7, STREAM PARTICLE ANIMATION
%   3165_07_06: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-07-09 24:00:00

% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

load wind

%range over which the data exists
disp([min(x(:)) max(x(:)) min(y(:)) max(y(:)) min(z(:)) max(z(:))]);
[sx sy sz] = meshgrid(85:20:100, 20:2:50, 6);
%Ddefine path
verts = stream3(x,y,z,u,v,w,sx,sy,sz);

figure('position',[ 361   247   879   731]);
sl = streamline(verts);
axis tight; box on; grid on;
daspect([19.9445   15.1002    1.0000]);
campos([ -165.7946 -223.0056   11.0223]);

iverts = interpstreamspeed(x,y,z,u,v,w,verts,0.08);
set(gca,'drawmode','fast');
h = streamparticles(iverts,15,...
    'FrameRate',5,...
	'Animate',2,...
	'ParticleAlignment','on',...
	'MarkerEdgeColor','green',...
	'MarkerFaceColor','green',...
	'Marker','o');