%% CHPATER 6, DOWNSAMPLING FOR FAST GRAPHS
%   3165_06_07: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-05-21 24:00:00

% generate the data
dat = rand(10e6,1) + cos(linspace(0,360,10e6)' + exp(rand(10e6,1)));
% Lay out the column totals
tic
plot(dat); box on; grid on;
toc
title({'The raw data with 10 million points'},'Fontsize',14); 
print(gcf,'-dpng',['./../3165_06_Images/3165_06_07_1' '.png']);

% Every 100^{th} point connected with red lines
hold on;
tic
plot(1:100:10e6,dat(1:100:10e6),'r'); box on; grid on;
toc
title({'Every 100^{th} point connected with red lines'},'Fontsize',14); 
print(gcf,'-dpng',['./../3165_06_Images/3165_06_07_2' '.png']);

% Every 100 points binned and binned average plotted  with red lines
figure;
plot(dat); box on; grid on;cnt = 1;cnt1=1;
while cnt+1000<10e6
    datbin(cnt1) = mean(dat(cnt:cnt+1000));
    cnt = cnt + 1000;
    cnt1 = cnt1 + 1;
end
tic
plot(1:cnt1-1,datbin,'r'); box on; grid on;
toc
title({'Every 100 points binned and binned average plotted  with red lines'},'Fontsize',14); 
print(gcf,'-dpng',['./../3165_06_Images/3165_06_07_3' '.png']);

