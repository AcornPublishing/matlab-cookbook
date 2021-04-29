%   3165_02_06: Emperical Distribution analysis
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

% data definition
load distriAnalysisData;

% histograms;
hist(B);
print(gcf,'-dpng','./../3165_02_Images/3165_02_08_1.png');

% alternate binning 
[N c] = hist(B,200);bar(c,N);title('Alternate binning, bin size = 200');
print(gcf,'-dpng','./../3165_02_Images/3165_02_08_2.png');

%find envelope of the histogram using a spline fit to the bar heights
[N c] = hist(B,200);
env = interp1(c,N,c,'spline'); 

%plot normalized envelope with actual data on xaxis
plot(c,env./max(env),'b','Linewidth',2); hold;
line([B B]',[-0.05*ones(size(B)) 0*ones(size(B))]','Color',[1 0 0]);axis tight
xlabel('data'); ylabel({'normalized envelope','of histogram with bin size =200'});
print(gcf,'-dpng','./../3165_02_Images/3165_02_08_3.png');

% qqplots with MATLAB
qqplot(B);
print(gcf,'-dpng','./../3165_02_Images/3165_02_08_4.png');
