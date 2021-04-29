%% CHAPTER 2, TIME SERIES ANALYSIS
%   3165_02_08
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-01-30 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% data definition
% Data reference: 
% Goldberger AL, Rigney DR. Nonlinear dynamics at the bedside. 
% In: Glass L, Hunter P, McCulloch A, eds. Theory of Heart: Biomechanics, Biophysics, 
% and Nonlinear Dynamics of Cardiac Function. New York: Springer-Verlag, 1991, pp. 583-605. 
load timeseriesAnalysis;

%% scatter plot of data
figure;
subplot(2,1,1);plot(x,ydata1);title('Instantaneous heart rate, recorded at 0.5 seconds interval, from subject 1');xlabel('Time (in secoonds)');ylabel('Heart rate (beats per minute)');
subplot(2,1,2);plot(x,ydata2);title('Instantaneous heart rate, recorded at 0.5 seconds interval, from subject 2');xlabel('Time (in secoonds)');ylabel('Heart rate (beats per minute)');
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_08_1.png');

%% DETRENDING THE DATA
figure;
y_detrended1 = detrend(ydata1); 
y_detrended2 = detrend(ydata2); 
subplot(2,1,1);plot(x, ydata1,'-',x, ydata1-y_detrended1,'r');title('Detrended Signal 1');
legend({'signal','trend'});
xlabel('Time (in secoonds)');ylabel('Heart rate (beats per minute)');
subplot(2,1,2);plot(x, ydata2,'-',x, ydata2-y_detrended2,'r');title('Detrended Signal 2');
legend({'signal','trend'});
xlabel('Time (in secoonds)');ylabel('Heart rate (beats per minute)');
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_08_2.png');

%% AUTO CORRELATION FUNCTION
figure;
y_autoCorr1 = acf(subplot(2,1,1),ydata1,100); 
set(get(gca,'title'),'String','Autocorrelation function for Heart Rate data, subject 1');
set(get(gca,'xlabel'),'String','Lag (in seconds)');
tt = get(gca,'xtick');
for i = 1:length(tt); ttc{i} = sprintf('%.2f ',0.5*tt(i)); end
set(gca,'xticklabel',ttc);
y_autoCorr2 = acf(subplot(2,1,2),ydata2, 100);
set(gca,'xticklabel',ttc);
set(get(gca,'title'),'String','Autocorrelation function for Heart Rate data, subject 2');
set(get(gca,'xlabel'),'String','Lag (in seconds)');
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_08_3.png');

%% FINDING CYLCLIC COMPONENTS with fourier transforms
figure;
% Use next highest power of 2 greater than or equal to length(x) to calculate fft
nfft = 2^(nextpow2(length(x)));
% Take fft, padding with zeros so that length(fftx) is equal to nfft 
ySpectrum1 = fft(y_detrended1,nfft);
ySpectrum2 = fft(y_detrended2,nfft);
% If nfft is even (which it will be, if you use the above two commands above), 
% then the magnitude of the fft will be symmetric, such that the first (1+nfft/2) 
% points are unique, and the rest are symmetrically redundant. 
% The DC component of x is fftx(1) , and fftx(1+nfft/2)> is the Nyquist frequency 
% component of x. If nfft is odd, however, the Nyquist frequency component is not 
% evaluated, and the number of unique points is (nfft+1)/2 . 
% This can be generalized for both cases to ceil((nfft+1)/2) . 
NumUniquePts = ceil((nfft+1)/2);
% FFT is symmetric, throw away second half and use the magnitude of the coeeicients only
powerSpectrum1 = abs(ySpectrum1(1:NumUniquePts));
powerSpectrum2 = abs(ySpectrum2(1:NumUniquePts));
% Scale the fft so that it is not a function of the length of x
powerSpectrum1 = powerSpectrum1./max(powerSpectrum1);
powerSpectrum2 = powerSpectrum2./max(powerSpectrum2);
powerSpectrum1 = powerSpectrum1.^2;
powerSpectrum2 = powerSpectrum2.^2;
% Since we dropped half the FFT, we multiply the coeffixients we have by 2 to keep the same energy.
% The DC component and Nyquist component, if it exists, are unique and should not be multiplied by 2. 
if rem(nfft, 2) % odd nfft excludes Nyquist point 
     powerSpectrum1(2:end) = powerSpectrum1(2:end)*2;
     powerSpectrum2(2:end) = powerSpectrum2(2:end)*2;
else
     powerSpectrum1(2:end -1) = powerSpectrum1(2:end -1)*2;
     powerSpectrum2(2:end -1) = powerSpectrum2(2:end -1)*2;
end
% This is an evenly spaced frequency vector with NumUniquePts points.
% Sampling frequency
Fs = 1/(x(2)-x(1)); 
f = (0:NumUniquePts-1)*Fs/nfft;
plot(f,powerSpectrum1,'-',f,powerSpectrum2,'r');
title('Power Spectrum of the Heart Rate Signal');
xlabel('Frequency (in Hertz)'); ylabel('Power');
xlim([0 .25]);
annotation_pinned('textarrow',[.15,.085],[.25,.03],'String',{'Peak near 0.1 Hz','(most likely, the frequency','of respiration in this subject)'});
annotation_pinned('textarrow',[.1,.02],[.75,.87],'String',{'Peak near 0.02 Hz','(most likely, the frequency','of respiration in this subject)'});
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_08_4.png');

%% Zero out the non-significant Fourier components to smooth the signal
figure;
% Dont use zero padding
ySpectrum1 = fft(ydata1);
ySpectrum2 = fft(ydata2);
% Zero out some less significant coeffs
freqInd1=find(abs(ySpectrum1)<400); 
freqInd2=find(abs(ySpectrum2)<400); 
ySpectrum1(freqInd1)=0;
ySpectrum2(freqInd2)=0;
% Reconstruct signal
y_cyclic1=ifft(ySpectrum1);
y_cyclic2=ifft(ySpectrum2);
subplot(2,1,1);
h(1)= plot(x,ydata1,'b');hold on;h(2)=plot(x,y_cyclic1,'r','linewidth',1.5);
title('Heart Rate Signal 1');axis tight;
legendflex(h,...                %handle to plot lines
    {'original','smoothed'},... %corresponding legend entries
    'ref', gcf, ...             %which figure
    'anchor', {'e','e'}, ...  %location of legend box
    'buffer',[-10 0], ...         % an offset wrt the location
    'fontsize',8,...            %font size
    'xscale',.5);               %a scale factor for actual symbols    
xlabel('Time (in secoonds)');ylabel('Heart rate (beats per minute)');
subplot(2,1,2);
h(1) = plot(x,ydata2,'b');hold on;h(2)=plot(x,y_cyclic2,'r','linewidth',1.5);
title('Heart Rate Signal 2');axis tight;
xlabel('Time (in secoonds)');ylabel('Heart rate (beats per minute)');
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_02_Images/3165_02_08_5.png');
