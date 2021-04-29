%% CHAPTER 8, EXPORT FORMAT AND RESOLUTION
%
%   3165_08_01: Image Resolution, Formats 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-07-16 24:00:00
%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

% create a figure
peaks;view(2);shading interp;
set(gcf,'Color',[1 1 1]);

% print to specs JPEG
print(gcf,'-djpeg','-r200','./../3165_08_Images/3165_08_01_1.jpeg');



