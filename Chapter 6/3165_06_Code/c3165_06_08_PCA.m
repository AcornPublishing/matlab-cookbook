%% CHPATER 6, PRINCIPAL COMPONENT ANALYSIS  
%   3165_06_08
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-05-21 24:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);
% load the data
% read from text file
fid = fopen('GLASS.txt');
C = textscan(fid, '%d,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
fclose(fid);
% arrange relevant data into a matrix format, 
% first position ignored as it is a positional index
data = reshape(cell2mat({C{2:11}}'),214,10);
%layout the figure
set(gcf,'units','normalized','position',[.21 .22 .43 .69]); hold on;
% perform PCA
[coeff, score, latent, tsquared] = princomp(data(:,1:9));
% ready the annotations
glassTypes = [1 2 3 5 6 7];
glassTypesStr = {'building windows _{float processed}','building windows_{non-float processed}',... 
'vehicle windows_{float processed}', 'vehicle_{windows_non_float_processed} (none in this database)',... 
'containers','tableware', 'headlamps'};
%select a color pallete to color each marker by glass type
colors = colormap;
colors = colors(round(linspace(1,64,length(glassTypes))),:);
% investigate the data in the space of the first 2 components
for i = 1:length(glassTypes)
    idx=find(data(:,10)==glassTypes(i));
    plot(score(idx,1),score(idx,2),'.','Markersize',30,'Color',colors(i,:)); 
end
box on; grid on;
%add annotation
legend(glassTypesStr(glassTypes),'position',[0.0506    0.0756    0.3429    0.2066]);
set(gca,'Fontsize',12);
xlabel('Principal Component 1','Fontsize',12);
ylabel('Principal Component 2','Fontsize',12);
title('Data Viewed in the first 2 \color{red}Principal Component \color{black}Space (color coded by source type)','Fontsize',12);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_06_Images/3165_06_08_1' '.png']);

% how much does each component contribute to the total variance of this dataset
figure;plot(latent,'.-'); 
set(gca,'Fontsize',12);
title('Contribution from each principal component to the total variance of the data','Fontsize',12);
xlabel('Principal Components ordered by Eigen values','Fontsize',12);
ylabel('Variance contribution','Fontsize',12);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng',['./../3165_06_Images/3165_06_08_2' '.png']);

% using the biplot
figure;biplot(coeff(:,1:2),'Scores', score(:,1:2))
set(gcf,'color',[1 1 1],'paperpositionmode','auto');box on;
title('The function \color{red}biplot \color{black} showing the two principal components and the scores','Fontsize',12);
print(gcf,'-dpng',['./../3165_06_Images/3165_06_08_3' '.png']);

