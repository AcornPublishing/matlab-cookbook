%% CHAPTER 4, LIGHTING
%   3165_04_02: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-03-19 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Launch the demo
teapotdemo
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_04_Images/3165_04_02_1.png');

%% change lighting style and material
lighting flat
material dull
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_04_Images/3165_04_02_2.png');

%% Demonstrate the effect of SpecularExponent, SpecularStrength, DiffuseStrength and SpecularcolorRefectance
h=findobj(gca,'type','patch');
set(h,'FaceLighting','phong',...
      'FaceColor',[1 1 0],...
      'EdgeColor','none',...                          
      'SpecularExponent',12,...
      'DiffuseStrength',1,...
      'SpecularStrength',5, ...
'SpecularColorReflectance',.5);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_04_Images/3165_04_02_3.png');

%% Demonstrate the effect of AmbientStrength and AmbientLightColor
set(h,'AmbientStrength', 0.5,...
	'DiffuseStrength', 0.6,...
	'SpecularStrength',0.9,...
	'SpecularExponent',10,...
	'SpecularColorReflectance',1)
set(findobj(gca,'type','axes'),'AmbientLightColor', [1 0 1]);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_04_Images/3165_04_02_4.png');

%% surface normals
figure('units','normalized','position',[.35 .69 .29 .21]);
% generate data
x_lim=1-.01; y_lim=1-.01; z_lim=1-.01; step=.1;
x=[-x_lim:step:x_lim]; y=[-y_lim:step:y_lim]; z=[-z_lim:step:z_lim];
[x y z]=meshgrid(x,y,z);r=sqrt(x.^2+y.^2+z.^2);
r_s=.01;
w=2*sqrt(r_s*(r-r_s)); 
w = interp3(w,3,'cubic');
% make the plots
subplot(1,2,1)
p1 = patch(isosurface(w,.05),...
'FaceColor',[.8 .7 .5],'EdgeColor','none');
% set the view
view(3); daspect([1,1,1]); axis tight
% adjust lighting
camlight; camlight(-80,-10); lighting phong; 
% annotate
title('Triangle Normals')

% make the next fine plot
subplot(1,2,2)
p2 = patch(isosurface(w,.05),...
    'FaceColor',[.8 .7 .5],'EdgeColor','none');
isonormals(w,p2);
% set the view
view(3); daspect([1 1 1]); axis tight
% adjust lighting
camlight;  camlight(-80,-10); lighting phong; 
% annotate
title('Data Normals')
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_04_Images/3165_04_02_5.png');

%% backface lighting
teapotdemo;
h=findobj(gca,'type','patch');
set(h,'BackFaceLighting','unlit');
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_04_Images/3165_04_02_6_1.png');
set(h,'BackFaceLighting','lit');
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_04_Images/3165_04_02_6_2.png');


