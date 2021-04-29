%% CHAPTER 7, MAGNIFYING GLASS DEMO
% Adapted from File Exchange submission by: Mingjing Zhang
%   Vision and Media Laboratory, Simon Fraser University
%   Presented by Stellari Studio, 2012

% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Read the picture
userdata.img_rgb = imread('sampleImage.png');

% Define parameters for passage to callback function 
% to be invoked in response to cursor movement
% The image size
userdata.size_img = size(userdata.img_rgb); 
% the start time (to be used along with the frame rate information 
% to determine how often image should be updated)
userdata.start_time = tic;   
% The frame rate
userdata.FPS = 20;           
% Magnifying Power
userdata.MagPower = 2;       
% The Radius of the Magnifier
userdata.MagRadius = 100;    
% The radius of the image to be magnified
userdata.PreMagRadius = userdata.MagRadius./userdata.MagPower; 
userdata.alreadyDrawn = 0;

% Set up the figure and axes
MainFigureHdl = figure('Name', 'Magnifier Demo adapted from File Exchange submission by Mingjing Zhang', ...
    'NumberTitle' ,'off', ...
    'Units', 'normalized', ...
    'Position', [ 0.1854    0.0963    0.4599    0.8083], ...
    'MenuBar', 'figure', ...
    'Renderer', 'opengl');
MainAxesHdl = axes('Parent', MainFigureHdl, ...
    'Units', 'normalized',...
    'Position', [0 0 1 1], ...
    'color', [0 0 0], ...
    'YDir', 'reverse', ...
    'NextPlot', 'add', ...
    'Visible', 'on');

%plot the initial image and initial magnified image at the initial cursor
%tip position
userdata.img_hdl = image(0,0,userdata.img_rgb); 
axis tight
% The magnified image object
userdata.mag_img_hdl = image(0,0,[]);
userdata.mag_img = userdata.img_rgb(1:userdata.PreMagRadius*2+1,1:userdata.PreMagRadius*2+1,:);

% create a circular mask for the magnified image
[x y] = meshgrid(-userdata.PreMagRadius:userdata.PreMagRadius);
dist = double(sqrt(x.^2+y.^2)); % The distance from each pixel to center
in_circle_log = dist<userdata.PreMagRadius-1;
out_circle_log = dist>userdata.PreMagRadius+1;
dist(in_circle_log) = 0;
dist(out_circle_log) = 1;
dist(~(in_circle_log|out_circle_log)) = (dist(~(in_circle_log|out_circle_log)) - (userdata.PreMagRadius-1))./2;
userdata.mask_img = 1 - dist;

% Initialize the image object
set(userdata.mag_img_hdl, 'CData',userdata.mag_img, 'AlphaData', userdata.mask_img);
%designate the call back function so that magnified image moves with cursor
% position
set(MainFigureHdl,'userdata',userdata,'WindowButtonMotionFcn',@stl_magnifier_WindowButtonMotionFcn,'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_07_Images/3165_07_04_1');
