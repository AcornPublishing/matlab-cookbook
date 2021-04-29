%% CHAPTER 8, VECTOR GRAPHICS FOR INCLUSION INTO DOCUMENTS
%   3165_08_02: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-07-16 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

% create a figure
A = flow; surf(A(:,:,14)); shading interp;
set(gcf,'color',[1 1 1]);

% print as EMF
print(gcf,'-dmeta','./../3165_08_Images/3165_08_02_1');

% print as EPS with a TIFF preview
print('-depsc','-tiff','-r300','./../3165_08_Images/3165_08_02_2');