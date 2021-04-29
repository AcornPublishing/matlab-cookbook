%   3165_02_09: arc chart
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

% data definition
[intercitydist citynames] = xlsread('inter_city_distances.xlsx');
d=20;

figure('Position',[ 650         314        1230         664]);
axes('Position',[0.0472    0.2379    0.8146    0.6296]); xlim([1 d]);
hold on;

%Lets pick any 20 cities and show the intercity distances
set(gca,'xtick',[1:d]);
m = colormap(pink(d+1));
cityIndices = [11  12   99  32  26 64  80 50 121   71  100  29 31   82 18   62  45 51 19   101];

citynames = citynames(cityIndices);
intercitydist = intercitydist(cityIndices,cityIndices);

cmin = min(min(intercitydist));
cmax = max(max(intercitydist));

levels = [1000 2000 3000];
cmax = 4000;
for i = [3 17]
    for j = d:-1:1        
        if i~=j
            if (intercitydist(i,j)<= levels(1))
                heightOfArc = levels(1);lineWidth=2;
            elseif (intercitydist(i,j) > levels(1)) & (intercitydist(i,j) <= levels(2))
                heightOfArc = levels(2);lineWidth=3;
            elseif (intercitydist(i,j) > levels(3))
                heightOfArc = levels(3);lineWidth=8;
            end
            x=[i (i+j)/2 j]; 
            y=[0 heightOfArc 0];
            pol_camp=polyval(polyfit(x,y,2),linspace(i,j,25));
            plot(linspace(i,j,25),pol_camp,'color',m(fix((intercitydist(i,j)-cmin)/(cmax-cmin)*d)+1,:),'Linewidth',lineWidth);        
        end
    end
end

set(gca,'xticklabel',citynames);
rotateXLabels(gca,60);
ylim([0 max(get(gca,'ylim'))]);
title('Color (and thickness) is used to represent inter City Distance in Miles','Fontsize',14);box on;
set(gca,'yticklabel',[],'ticklength',[0 0]);box on;
xlabel('Cities');
%colorbar;
colorbar('Position',[0.9236    0.1100    0.0203    0.8150],'yticklabels',linspace(cmin,cmax,11));

annotation('arrow',[0.1170 0.1170],[0.0744 0.1316]);
annotation('arrow',[0.7167 0.7167],[0.0755 0.1327]);
print(gcf,'-dpng','./../3165_02_Images/3165_02_05.png');



