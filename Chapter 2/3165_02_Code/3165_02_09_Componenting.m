%   3165_02_09: Time Series Analysis
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

% data definition
load timeseriesAnalysis;
%scatter plot of data
plot(x,ydata,'.');title('Time series data plot');
print(gcf,'-dpng','./../3165_02_Images/3165_02_09_1.png');

%DETRENDING THE DATA
y_detrended = detrend(ydata); % detrending the data
subplot(2,1,1);plot(x, ydata-y_detrended,'.');title('The trend extracted');
subplot(2,1,2);plot(x, y_detrended,'.');title('Time series data plot, de-trended');
print(gcf,'-dpng','./../3165_02_Images/3165_02_09_2.png');

%FINDING CYLCLIC COMPONENTS with fourier transforms
ySpectrum=fft(y_detrended); 
subplot(2,1,1);
plot(abs(ySpectrum(1:round(length(y_detrended)/2))));
title('Spectral coefficients, suggest two dominating frequency components');
subplot(2,1,2);
plot(abs(ySpectrum(1:round(length(y_detrended)/2)))); xlim([0 100]);
title('Spectral coefficients, zoomed in');
print(gcf,'-dpng','./../3165_02_Images/3165_02_09_3.png');

% zero out the non-significant Fourier components
freqInd=find(abs(ySpectrum)<100); 
ySpectrum(freqInd)=0;
y_cyclic=ifft(ySpectrum); % The low frequency component in the time domain
residuals=y_detrended - y_cyclic; % The High frequency component in the time domain
subplot(2,1,1);
plot(y_cyclic);
title('Cyclic components reconstructed using the two dominating Fourier coefficients');axis tight;
subplot(2,1,2);
plot(residuals,'.-'); 
title('Residuals constructed by subtracting cyclic and trend components');axis tight;
print(gcf,'-dpng','./../3165_02_Images/3165_02_09_4.png');

