%% CHAPTER 5, ISOSURFACE, ISONORMALS AND ISOCAPS
%   3165_05_03:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-04-16 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% load the data
load mri

% Changing the Data Format
D = squeeze(D);

%% isosurface, isonormals
% create figure with predefined colormap
figure('Colormap',map)
% smooth the data
Ds = smooth3(D);
% create a isosurface; use patch to construct the image
% choose face color for common skin tone
hiso = patch(isosurface(Ds,5),...
	'FaceColor',[1,.75,.65],...
	'EdgeColor','none');
% The isonormals are constructed based on the gradient values of the actual values of the surface elements. 
isonormals(Ds,hiso);
% set the view    
view(35,30) 
axis tight 
daspect([1,1,.4]);
% orient the light, set the lighting algorithm to phong to create a realistic rendering; 
lightangle(45,30);
lighting phong
title({['Use of \color{red} isosurface, isonormals \color{black} and \color{red} Phong '],...
        ['\color{black} lighting algorithm with the MRI dataset.']},'fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_03_1' '.png']);

%% add a isocap
hcap = patch(isocaps(D,5),...
	'FaceColor','interp',...
	'EdgeColor','none');
% adjust lighting
set(hcap,'AmbientStrength',.6)
set(hiso,'SpecularColorReflectance',0,'SpecularExponent',50);
%redjust title to reflect new technique
title({['Use of \color{red} isosurface, isonormals, isocaps \color{black} and \color{red} Phong '],...
        ['\color{black} lighting algorithm with the MRI dataset.']},'fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_03_2' '.png']);

%% interactive version

figure('units','normalized','position',[.35 .36 .29 .54]);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
s = volumeVisualization_isosurface(double(D),[1,.75,.65]);

% Add uicontrol for x
annotation('textbox',[.75,.1388,.06,.05],'String','V','fontweight','bold','linestyle','none');
hSliderx = uicontrol(...
    'Units','normalized', ...
    'Position',[.79 .13 .2 .05], ...
    'Style','slider', ...
    'Min',s.vMin, ...
    'Max',s.vMax, ...
    'Value',s.vMin, ...
    'userdata',s,...
    'Callback',@volVisIsoSurfaceUpdateSliderPosition);
%annotate
title('Use of user driven isosurface plotting with the MRI dataset',...
    'fontsize',14); 
print(gcf,'-dpng',['./../3165_05_Images/3165_05_03_3' '.png']);
