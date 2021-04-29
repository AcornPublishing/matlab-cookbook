%% CHAPTER 2, NODE LINK PLOTS
%   3165_02_05
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% data definition
[XYCoord] = xlsread('inter_city_distances.xlsx','Sheet3');
[intercitydist citynames] = xlsread('inter_city_distances.xlsx','Distances');
% This code makes sure that a city is not detected as the nearest to
% itself, and also recaluclates the intercity distances
howManyCities = 128;
for i =1:howManyCities;intercitydist(i,i)=Inf;end

%% Define the adjacency matrix (with the road distance-wise closest, being connected)
% An adjacency matrix with n verticies is a matrix of size nxn, 
% where entry i,j=1, if they are connected, otherwise i,j=0
% Let us make an adjacency matrix with the intercitydist, where 
% each city is connected to the city closest to it.
adjacency = zeros(howManyCities,howManyCities);
for i = 1:howManyCities
    alls = find(intercitydist(i,:)==min(intercitydist(i,:)));    
    for j = 1:length(alls)
        adjacency(i,alls(j)) = 1;
        adjacency(alls(j),i) = 1;
    end    
    clear alls
end
figure('units','normalized','position',[ 0.2813    0.2676    0.3536    0.3889]);
plot(XYCoord(1:howManyCities,1),XYCoord(1:howManyCities,2),'ro');hold on;
title('Closest cities connected to each other');
gplot(adjacency,XYCoord);
xlabel('Longitudes');
ylabel('Latitudes');
set(gcf,'Color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_05_1.png');

%% Define the adjacency matrix (with connections between cities a 100 miles or less apart)
% % rearrange city name list by intercity distance, use distances to any one
% % city for sorting and that will put approximately close cities together
for i = 1:howManyCities;  intercitydist(i,i) = 0; end
[balh I] = sort(intercitydist(1,:));
citynames = citynames(I);
XYCoord = XYCoord(I,:);
%% recalculate intercity distance matrix
for i = 1:howManyCities;  
    for j = 1:howManyCities
        if i==j
            intercitydist(i,i) = Inf; 
        else
            intercitydist(i,j) = sqrt((XYCoord(i,1)-XYCoord(j,1))^2 + (XYCoord(i,2)-XYCoord(j,2))^2); 
        end
    end
end
%% redfine adjacency for new problem
adjacency = zeros(howManyCities,howManyCities);
for i = 1:howManyCities
    alls = find(intercitydist(i,:)<100);    
    for j = 1:length(alls)
        adjacency(i,alls(j)) = 1;
        adjacency(alls(j),i) = 1;
    end    
    clear alls
end

%% figure and axes positoning
figure('units','normalized','position',[0.0844    0.2259    0.8839    0.4324]);
axes('Position',[0.0371    0.2893    0.9501    0.6296]); 
xlim([1 howManyCities]);
ylim([0 100]);
hold on;
%% city names on the xaxis
set(gca,'xtick',1:howManyCities,'xticklabel',citynames,...
                                   'ticklength',[0.001 0]);
box on; 
rotateXLabels(gca,90);
%% arc in differenct colors (approx mapping to intercity distance)
m = colormap(pink(howManyCities+1));
cmin = min(min(intercitydist));
cmax = 150;
%% plot arcs
for i = 1:howManyCities
    for j = 1:howManyCities
        if adjacency(i,j)==1
            x=[i (i+j)/2 j]; 
            y=[0 intercitydist(i,j) 0];
            pol_camp=polyval(polyfit(x,y,2),linspace(i,j,25));
            plot(linspace(i,j,25),pol_camp,'Color',m(fix((intercitydist(i,j)-cmin)/(cmax-cmin)*howManyCities)+1,:),'linewidth',100/intercitydist(i,j));        
        end
    end
end
%% annotate
title('Cities that are within 100 miles of each other, by road','fontsize',14);
ylabel('Intercity Distance');
set(gca,'Position',[0.0371    0.2893    0.9501    0.6296]);
%% horizontal grid lines for readability
line(repmat(get(gca,'xlim'),9,1)',[linspace(10,90,9); linspace(10,90,9)],'Color',[.8 .8 .8]);
set(gcf,'Color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_05_2.png');