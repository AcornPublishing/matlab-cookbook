%% CHAPTER 6, FALSE COLOR IMAGING
%   3165_06_01: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-05-21 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);
% set the fig
set(gcf,'units','normalized','position',[.34 .36 .32 .54]);
axes('position',[.12 .08 .78 .76]);
% read in the data
X = multibandread('0612-1615_rad_sub.dat', ...filename
                  [1160, 320, 360], ... SIZE = [LINES, SAMPLES, BANDS]
                  'uint16', ... PRECISION corresponds to the data type in the ENVI header file. 
                   0,...OFFSET: the same as offset parameter from ENVI header file
                  'bil',... INTERLEAVE: the same as interleave parameter from ENVI header file: 'bsq', 'bil' or 'bip'.
                  'ieee-le', ...BYTEORDER: corresponds to byte order parameter from ENVI header file. However it has to be translated to MATLAB codification.
                   {'Band','Range',[1,5,360]},... SUBSET to load, = {DIM, METHOD, INDEX}, where DIM = 'Row', 'Column' or 'Band', METHOD = 'Direct' or 'Range'.
                   {'Row','Range',[150,1,1000]},...
                   {'Column','Range',[60,1,300]}...
               );
%normalize           
X = X./max(X(:));
% visualize median signal across several bands
surf(log(median(X,3))); view(2); shading interp;axis tight;brighten(-.8);
% annotate
title({['Figure showing the median' ...
        '\color{red} hyperspectral \color{black}data'],...
        ' from 72 spectral bands, from the 2010 oil spill in the Gulf of Mexico,',...
        'collected at 2.2m GSD, covering 390-2450nm, from SpecTIR.'},'Fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_06_Images/3165_06_01_1' '.png']);

% alternately, use the data to generate RGB values with some transform
clf;
axes('position',[.12 .08 .78 .76]);
R = log(median(X,3));R = abs(R./max(abs(R(:))));
G = log(range(X.^2,3));G = abs(G./max(abs(G(:))));
B = log(median(X,3));B = abs(B./max(abs(B(:))));
d(:,:,1) = G;d(:,:,2) = B;d(:,:,3) = R;
image(d);
title({['\color{red}False Color Image \color{black}showing the' ...
        '\color{red} hyperspectral \color{black}data'],...
        ' from 72 spectral bands, from the 2010 oil spill in the Gulf of Mexico,',...
        'collected at 2.2m GSD, covering 390-2450nm, from SpecTIR.'},'Fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_06_Images/3165_06_01_2' '.png']);

