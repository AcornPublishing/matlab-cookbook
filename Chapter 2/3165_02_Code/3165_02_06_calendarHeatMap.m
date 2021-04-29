%   3165_02_09: calendar heat map
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

% data definition
[GOOG dateGOOG] = xlsread('GOOG_090784_012412.csv');
dateGOOG = datenum({dateGOOG{2:end,1}});
dateGOOG = dateGOOG(end:-1:1);
GOOG = GOOG(end:-1:1,:);
% sub select last two years data
% entries for all consecutive dates needed
newData = [];
newDateData=[];
for i =1:numel(dateGOOG)-1
    if abs(dateGOOG(i+1)-dateGOOG(i))==1
        newData     =   [newData;   GOOG(i)];
        newDateData =   [newDateData dateGOOG(i)];
    else
        delta = abs(dateGOOG(i+1)-dateGOOG(i));
        for j = 1:delta
            newData     =   [newData;   NaN];
            newDateData =   [newDateData dateGOOG(i)+j-1];
        end
    end
end
newData     =   [newData;   GOOG(end)];
newDateData =   [newDateData dateGOOG(end)];
idx = find(newDateData<=datenum('12/31/2011')&newDateData>=datenum('1/1/2010'));
newData=newData(idx);
newDateData = newDateData(idx);

%layout 6 months in a row, 2 years --> 4 rows
figure('Position',[650          97        1230         881]);
colormap('cool');
xs = [0.03 .03+.005*1+1*.1525 0.03+.005*2+2*.1525 0.03+.005*3+3*.1525 0.03+.005*4+4*.1525 0.03+.005*5+5*.1525];
ys = [0.14 .14+0.04*1+1*.165   .14+0.04*2+2*.165   .14+0.04*3+3*.165];
D = 0;
for i = 1:4
    for j = 1:6
        axes('Position',[xs(j) ys(i) .1525    0.165]); 
        idx = find(newDateData>=datenum([datestr(newDateData(1)+D,'mm') '/01/'  datestr(newDateData(1)+D,'yyyy')]) & ...
             newDateData<=datenum([datestr(newDateData(1)+D,'mm') '/31/' datestr(newDateData(1)+D,'yyyy')]));
        A = calendar(newDateData(1)+D);
        data = NaN(size(A));
        for k = 1:max(max(A))
            [xx yy] = find(A==k);
            data(xx,yy) = newData(idx(k));
        end
        imagesc(data); alpha(.4);hold on;set(gca,'fontweight','bold');
        xlim([.5 7.5]); ylim([0 6.5]);
        for m = 1:6
            for n= 1:7
                text(n,m,num2str(A(m,n)));
            end
        end        
        text(.75,.25,'S','fontweight','bold'); text(1.75,.25,'M','fontweight','bold');text(2.75,.25,'T','fontweight','bold');
        text(3.75,.25,'W','fontweight','bold');text(4.75,.25,'R','fontweight','bold');text(5.75,.25,'F','fontweight','bold');text(6.75,.25,'S','fontweight','bold');
        title([datestr(newDateData(1)+D,'mmm')  datestr(newDateData(1)+D,'yy')]);
        set(gca,'xticklabel',[],'yticklabel',[],'ticklength',[0 0]);
        line([-.5:7.5; -.5:7.5], [zeros(1,9); 6.5*ones(1,9)],'Color',[.8 .8 .8]);
        line([zeros(1,9); 7.5*ones(1,9)],[-.5:7.5; -.5:7.5], 'Color',[.8 .8 .8]);
        box on;
        D=D+30;
    end
end

colorbar('Location','SouthOutside','Position',[ 0.1227    0.0613    0.7750    0.0263]);alpha(.4);
annotation('textbox',[0.4000 0.9354 0.3366 0.0571],'String','GOOGLE Stock Price from Jan 2010 to Dec 2011','LineStyle','none','Fontweight','bold');
print(gcf,'-dpng','./../3165_02_Images/3165_02_06.png');



