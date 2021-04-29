%% CHAPTER 1, VISUALIZING DETAILS WITH DATA TRANSFORMATIONS
%   3165_01_06
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-12 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Plot the original data and the transformed data
x = 1:50;
r = 5e5;
E = [ones(1,30) linspace(1,0,15) zeros(1,5)];
y1 = r * (1+E).^x;
y2 = log(y1);
axes('position',[0.1300    0.1100    0.7750    0.7805]);
[AX,H1,H2] = plotyy(x,y1,x,y2,'plot'); 
title({'Use log transformations to effectively visualize','growth, saturation, decay data profiles'});
set(get(AX(1),'Ylabel'),'String','data'); 
set(get(AX(2),'Ylabel'),'String','log(data)');
xlabel('x'); set(H1,'LineStyle','--'); set(H2,'LineStyle',':');

%% Add annotations
annotation('textarrow',[.26 .28],[.67,.37],'String',['Exponential Growth' char(10) '(Cycles 1 to 30)']);
annotation('textarrow',[.7 .7],[.8,.64],'String',['Non Exponential Decay' char(10) '(Cycles 30 to 45)']);
annotation('textarrow',[.809 .859],[.669,.192],'String',['Zero growth' char(10) '(Cycles 45 to 50)']);
legend({'Untransformed data','Log Transformed data'},'Location','Best');
set(gcf,'Paperpositionmode','auto','Color',[1 1 1]);
print(gcf,'-dpng','./../3165_01_Images/3165_01_06_1.png');

%% turn off scientific notation
% Resize the figure so you can see the huge numbers
set(gcf,'units','normalized','position',[0.0411    0.5157    0.7510    0.3889]);
% AX(1) stores the handle to data on the untransformed axis
title({'Use log transformations to effectively visualize growth, saturation, decay data profiles','Turn off scientific notation for tick labels, if desired'});
n=get(AX(1),'Ytick');
set(AX(1),'yticklabel',sprintf('%d |',n'));
print(gcf,'-dpng','./../3165_01_Images/3165_01_06_2.png');

%% Direct use of semilogx, semilogy, loglog
figure;
subplot(2,1,1);
semilogy(x,y1);
xlabel('x'); 
ylabel('data on log scale');
title({'MATLAB command semilogy was directly used',...
               'to view the y values on a log scale'});
subplot(2,1,2);
plot(x,y1); 
set(gca,'yscale','log');
xlabel('x'); 
ylabel('data on log scale');
title({'Use ordinary x versus y plot','Change yscale property to log for the same effect'});

set(gcf,'Color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_01_Images/3165_01_06_3.png');
