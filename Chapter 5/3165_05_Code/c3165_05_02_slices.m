%% CHAPTER 5, SLICE (CROSS SECTIONAL VIEW)
%   3165_05_02:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-04-16 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% load the data
load mri

%% Changing the Data Format
D = squeeze(D);

%% for exploration, plot a couple of MRI images from this set (horizontal slice)
% layout figure; instruct to use colormap that came with dataset
figure('units','normalized','position',[0.3016    0.3556    0.3438    0.5500],'Colormap',map)
axes('position',[0.1300    0.2295    0.7750    0.8150]);
% view horizontal slices
whichSlices = 3:5:27;
h=slice(1:128,1:128,1:27,double(D),[],[],whichSlices);shading interp; 
% set alphadata same as data; set alim so that only the lowest values
% become transparent (invisible)
for i =1:length(h)
    set(h(i),'alphadata',double(D(:,:,whichSlices(i))),'facealpha','interp');alim([0 2])
end
% set the view
zoom(1.2);
campos([-706 -778  111]);
axis off; zlim([1 25]);
% annotate
annotation('textbox',[.05 .07 .9 .1],'String',...
        {['Horizontal \color{red} slice \color{black} views from '...
          'the MRI dataset. Visual uses transparency to hide '...
          'extreme low values that would otherwise show'...
          'up in black']},'fontsize',14,'linestyle','none'); 
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_02_1' '.png']);

%% Create a combination of slices with different orientation
figure;
% choose a colormap, invert it so low values are light colored
m=colormap('jet');
m = m(end:-1:1,:);
colormap(m);
% do your slices
h=slice(1:128,1:128,1:27,double(D),90,50,[1 15]);shading interp; axis tight;
% set the transparency so low values are invisible
set(h(1),'alphadata',squeeze(double(D(90,:,:))),'facealpha','interp'); alim([0 2])
set(h(2),'alphadata',squeeze(double(D(:,50,:))),'facealpha','interp'); alim([0 2])
set(h(3),'alphadata',squeeze(double(D(:,:,1))),'facealpha','interp'); alim([0 2])
set(h(4),'alphadata',squeeze(double(D(:,:,15))),'facealpha','interp'); alim([0 2])
% set the view
daspect([128 128 27]);
campos([-637 366 177]);
axis off;
% annotate
colorbar('location','southoutside','position',[.08 .07 .83 .02]);
title(['Combination of \color{red} slice \color{black} views using '...
        'the MRI dataset.'],'fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_02_2' '.png']);

%% investigate other cross sections
figure('Colormap',map);hold on;view(3);
% define the slice that you want to rotate
hslice = slice(1:128,1:128,1:27,double(D),[],[],15); shading interp; axis tight;
%rotate the slice
rotate(hslice,[-1,0,0],-35);
% extract the x, y and z data from rotated slice
xd1 = get(hslice,'XData');yd1 = get(hslice,'YData');zd1 = get(hslice,'ZData');
% remove the rotated slice
delete(hslice);
% call slice function with extracted data
h=slice(1:128,1:128,1:27,double(D),xd1,yd1,zd1); shading interp; axis tight;
% set its transprency to also correspond with the data values
set(h,'alphadata',squeeze(double(D(:,:,15))),'facealpha','interp'); alim([0 2])
% declare two other horizontal slices
h=slice(1:128,1:128,1:27,double(D),[],[],[1 18]); shading interp; axis tight;
% set the transparencies for the additional slices
set(h(1),'alphadata',squeeze(double(D(:,:,1))),'facealpha','interp'); alim([0 2])
set(h(2),'alphadata',squeeze(double(D(:,:,18))),'facealpha','interp'); alim([0 2])
% set the view
zlim([1 27]);box on
campos([-710.945 617.6196 126.5833]);
% annotate
title('Using a tilted plane as a slicer, with the MRI dataset',...
    'fontsize',14); 
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_02_3' '.png']);
%% non-planar slice 
% add a boundary slice
figure;
h=slice(1:128,1:128,1:27,double(D),[],[],[1 13 18]); shading interp; axis tight; hold on;
set(h(1),'alphadata',squeeze(double(D(:,:,1))),'facealpha','interp'); alim([0 2])
set(h(2),'alphadata',squeeze(double(D(:,:,13))),'facealpha','interp'); alim([0 2])
set(h(3),'alphadata',squeeze(double(D(:,:,18))),'facealpha','interp'); alim([0 2])
%create a surface on which you want the projection
[xsp,ysp,zsp] = sphere;
% scale and translate your surface so that it covers the data zone
hsp = surface(30*xsp+60,30*ysp+60,10*zsp+13);
% get the data out 
xd = get(hsp,'XData');
yd = get(hsp,'YData');
zd = get(hsp,'ZData');
% delet the temp surface
delete(hsp)
% plot the surface as part of the slice command
hslicer = slice(1:128,1:128,1:27,squeeze(double(D)),xd,yd,zd);shading interp;
%set(hslicer,'alphadata',squeeze(double(D(:,:,18))),'facealpha','interp'); alim([0 2])
% set the view
axis tight 
view(-103.5,28);
%annotate
title('Use of non-planar surface as a slicer with the MRI dataset',...
    'fontsize',14); 
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_05_Images/3165_05_02_4' '.png']);

%% slider driven interactive slicing
figure('units','normalized','position',[.35 .36 .29 .54]);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
s = volumeVisualization(1:128,1:128,1:27,double(D));

% Add uicontrol for x
annotation('textbox',[.75,.1388,.06,.05],'String','X','fontweight','bold','linestyle','none');
hSliderx = uicontrol(...
    'Units','normalized', ...
    'Position',[.79 .13 .2 .05], ...
    'Style','slider', ...
    'Min',s.xMin, ...
    'Max',s.xMax, ...
    'Value',s.xMin, ...
    'tag','x',...
    'userdata',s,...
    'Callback',@volVisSlicesUpdateSliderPosition);

% Add uicontrol for y
annotation('textbox',[.75,.0788,.06,.05],'String','Y','fontweight','bold','linestyle','none');
hSlidery = uicontrol(...
    'Units','normalized', ...
    'Position',[.79 .07 .2 .05], ...
    'Style','slider', ...
    'Min',s.yMin, ...
    'Max',s.yMax, ...
    'Value',s.yMin, ...
    'tag','y',...    
    'userdata',s,...
    'Callback',@volVisSlicesUpdateSliderPosition);

% Add uicontrol for z
annotation('textbox',[.75,.0088,.06,.05],'String','Z','fontweight','bold','linestyle','none');
hSliderz = uicontrol(...
    'Units','normalized', ...
    'Position',[.79 .01 .2 .05], ...
    'Style','slider', ...
    'Min',s.zMin, ...
    'Max',s.zMax, ...
    'Value',s.zMin, ...
    'tag','z',...    
    'userdata',s,...
    'Callback',@volVisSlicesUpdateSliderPosition);

%annotate
title('Use of user driven orthogonal slicer with the MRI dataset',...
    'fontsize',14); 
print(gcf,'-dpng',['./../3165_05_Images/3165_05_02_5' '.png']);
