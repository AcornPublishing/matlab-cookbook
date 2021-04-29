%% CHAPTER 2, DISTRIBUTIONAL DATA ANALYSIS
%   3165_02_07
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% Load data
load distriAnalysisData;

%% Steps of investigation
% Plot initial histograms;
figure('units','normalized','position',[  0.2099    0.6269    0.4354    0.2778]);
subplot(1,2,1);plot(sort(B),'.');xlabel('series');ylabel('observations');title('1D scatter plot');
subplot(1,2,2);hist(B);xlabel('bins');ylabel('frequency of observations');title('Histogram');
set(gcf,'Color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_07_1.png');close;

%% Conside an alternate binning 
figure('units','normalized','position',[  0.2099    0.6269    0.4354    0.2778]);
[N c] = hist(B,round(sqrt(length(B))));bar(c,N);title('Alternate binning, bin size = sqrt(n)');
xlabel('bins');ylabel('frequency of observations');title('Histogram, with an optimal bin size to reveal underlying structure of data');
set(gcf,'Color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_07_2.png'); close

%% Find envelope of the histogram using a spline fit to the bar heights
[N c] = hist(B,200);
% Compute the envelope with a spline fit
env = interp1(c,N,c,'spline'); 
%plot normalized envelope with actual data on xaxis
figure('units','normalized','position',[ 0.2099    0.6269    0.4354    0.2778]);
bar(c,N./max(N));hold;
plot(c,env./max(env),'r','Linewidth',3);
xlabel('bins'); ylabel({'normalized envelope','of histogram with bin size =200'});
title('The envelope of the histogram is a useful tool to model the empirical distribution of your data');
set(gcf,'Color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_07_3.png');close

%% qqplots with MATLAB
figure;qqplot(B);box on
title({get(get(gca,'title'),'String'),'The closer the points lie on the line, the more normal is the distribution.'});
set(gcf,'Color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_07_4.png');

%% investigate your residuals
figure;
sigma_ampl = [79.267229       8.121365              5       6.254915       5.062882      11.117357      577.45966      531.38438      962.45674           1800           1800      357.92132];
mu=[29 38 51 70 103 133];
% Gaussian mixture model
f_sum=0;x=1:200;
for i=1:6
    f_sum=f_sum+sigma_ampl(i+6)./(sigma_ampl(i)).*exp(-(x-mu(i)).^2./(2*sigma_ampl(i).^2));
end
subplot(2,1,1);
clear h;
h(1)=plot(c,env,'Linewidth',1.5);hold on;
h(2)=plot(c,f_sum,'r','Linewidth',1.5); axis tight
legendflex(h,{'Histogram Profile','Gaussian Mixture Model'},'ref',gcf,'anchor',{'ne','ne'},'xscale',.5,'buffer',[-50 -50]);
title({'After a model is fit to the data, investigate the residuals to assess how much ','of the variability in the data has been accounted for by the model'});
subplot(2,1,2);
plot(c,env-f_sum,'.');axis tight;
title(['Residuals = signal - fit, Mean Squared Error = ' num2str(sqrt(sum(abs(env-f_sum).^2)))]);
set(gcf,'Color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_07_5.png');

