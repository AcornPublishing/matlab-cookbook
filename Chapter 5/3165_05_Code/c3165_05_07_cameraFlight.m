%% CHAPTER 5, CAMERA MOTION
%   3165_05_07
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-03-19 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% load the data
[x y z v] = flow;

%% the fly by
% create a first view, plot in red
p = patch(isosurface(x,y,z,v,-2));
set(p,'FaceColor','red','EdgeColor','none');
% set the view
camproj perspective 
% set scene lighting parameters
hlight = camlight('headlight'); 
set(p,'AmbientStrength',.1,...
      'SpecularStrength',1,...
      'DiffuseStrength',1);
lighting gouraud
set(gcf,'Renderer','OpenGL')
% set the view
set(gca,'CameraViewAngleMode','manual');
axis vis3d off
% set(gca,'CameraUpVector',[4.5 1 2.5]);
% theta=[0:1:60]; for i = 1:length(theta); camorbit(theta(i),theta(i)); pause(.1);end
% define the path
xp = [30*ones(1,50) linspace(30,55,50) linspace(55,45,50) linspace(45,-45,50) linspace(45,15,50)];
yp = [linspace(-12,5,50) linspace(5,-0.5,50) linspace(-0.5,-30,50) linspace(-30,-25,50) linspace(-25,-15,50)];
zp = [5.4*ones(1,50) linspace(5.4,-25,50) linspace(-25,10,50) linspace(10,30,50) linspace(30,80,50)];

%set figure properties up for the snapshot
set(gcf,'color',[1 1 1],'paperpositionmode','auto');

% move camera along path
for i=1:length(yp)
     campos([30,yp(i),zp(i)]);
     camtarget([3.5,-0.1666,0]);
     camlight(hlight,'headlight');
     % reflect effect of new camera position
     drawnow
     %take snapshots at some locations for reproduction into book
     if mod(i,50)==0
         print(gcf,'-dpng',['./../3165_05_Images/3165_05_07_1_' num2str(i) '.png']);
     end
     % allow time to observe effect of camera move
     pause(0.01);
end

%% the fly through
camproj perspective 
% have the effect of a zoom in
camva(5);
% define the path
xt = [linspace(1,.2,25) linspace(.2,.1,75)];
yp = [linspace(0,.8,25) .4*linspace(2,4,25) 1.6+.4*linspace(0,10,50)];
yt = [linspace(-.4/3,-.4/3,50) -(.4/3)*linspace(1,10,50) ];
zt = [linspace(0,0,25) linspace(0,0,75) ];

% move camera along the path
for i=1:length(xt)
     % set camera positiom
     campos([xt(i)+10,yp(i),zt(i)]);
     % set camera target, in step with camera position
     camtarget([xt(i) yt(i) zt(i) ]);
     % add a headlight
     camlight(hlight,'headlight');
     % reflect changes of last camera position move
     drawnow
     % take a snapshot
     if mod(i,25)==0
         print(gcf,'-dpng',['./../3165_05_Images/3165_05_07_3_' num2str(i) '.png']);
     end
     pause(0.1);
end