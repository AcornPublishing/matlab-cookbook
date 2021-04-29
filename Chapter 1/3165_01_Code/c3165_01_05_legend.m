%% CHAPTER 1, BRINGING ORDER TO CHAOS WITH LEGENDS
%   3165_01_05
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-12 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Adding Simple Legends
load 10NormalDistributions
plot(dataVect');
set(gcf,'Paperpositionmode','auto','Color',[1 1 1]);
title({'Ten different normal distributions','using unhelpful legends that occlude the actual data,',' and uses ill-separated or, repeating colors!'},'Color',[1 0 0]); 
xlabel('x'); ylabel('probability density function of x');
legend(legendMatrix);
print(gcf,'-dpng','./../3165_01_Images/3165_01_05_1.png');

%% Complex Legends
% Define a matrix of line spec options
LineStyles = {'-'}; % solid line
MarkerSpecs = {'+','o'}; % plus, circle ... there are more
ColorSpecs = {'r','g','b','k','m'}; % red, green, blue, black ... there are more
cnt = 1;
for i = 1:length(LineStyles)
    for j = 1:length(MarkerSpecs)
        for k = 1:length(ColorSpecs)
            LineSpecs{cnt} = [LineStyles{i} MarkerSpecs{j} ColorSpecs{k}];
            cnt = cnt+1;
        end
    end
end

figure; hold on;set(gcf,'Paperpositionmode','auto','Color',[1 1 1]);
for i = 1:10
    dataVect(i,:) = (1/sqrt(2*pi*stdVect(i).^2))*exp(-(x-meanVect(i)).^2/(2*stdVect(i).^2)); % Gaussian function
    plot(dataVect(i,:), LineSpecs{i});
    legendMatrix{i} = [sprintf('mean = %.2f, ',meanVect(i)) char(10) sprintf('std = %.2f',stdVect(i))];    
end
title({'Ten different normal distributions','Using legends with distinct colors and different marker styles;', 'Allowing maximal focus on data plot'},'Color',[0 0 0]); 
xlabel('x'); ylabel('probability density function of x');
legend(legendMatrix,'Location','NorthEastOutside','Fontsize',8);
box on;
print(gcf,'-dpng','./../3165_01_Images/3165_01_05_2.png');

%% N in one color
figure; hold;set(gcf,'Paperpositionmode','auto','Color',[1 1 1]);
plot(dataVect(1:6,:)','Color',[1 0 0]);
plot(dataVect(7:10,:)','Color',[0 0 0]);
h=legend(['Color 1' char(10) 'first 6 curves'],['Color 2' char(10) 'remaining 4 curves'], 'Location','Best'); 
c=get(h,'Children'); 
set(c(1:3),'Color',[1 0 0]); 
set(c(4:6),'Color',[0 0 0]);
title({'Demonstrate that multiple lines can','be made to correspond to one legend entry'});
xlabel('x'); ylabel('probability density function of x');
box on;
print(gcf,'-dpng','./../3165_01_Images/3165_01_05_3.png');

%% Flex legend
figure('units','normalized','position',[ 0.4172    0.1769    0.2917    0.5861]); 
hold on;set(gcf,'Paperpositionmode','auto','Color',[1 1 1]);
for i = 1:10
    h(i) = plot(dataVect(i,:), LineSpecs{i});
end
legendflex(h,...                %handle to plot lines
    legendMatrix,...            %corresponding legend entries
    'ref', gcf, ...             %which figure
    'anchor', {'nw','nw'}, ...  %location of legend box
    'buffer',[50 0], ...        % an offset wrt the location
    'nrow',4, ...               % number of rows
    'fontsize',8,...            %font size
    'xscale',.5);               %a scale factor for actual symbols    
box on;
title({'flexlegend allows to choose the location of the legend box','the size of symbols, the font size and the layout of legend entries.'});
xlabel('x'); ylabel('probability density function of x');
set(gca,'position',[0.1300    0.0648    0.7629    0.6477]);
print(gcf,'-dpng','./../3165_01_Images/3165_01_05_4.png');
