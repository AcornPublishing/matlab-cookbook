%% CHAPTER 7, ANIMATION BY INCREMENTAL CHANGES TO CHART ELEMENTS
%   3165_07_07: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-07-09 24:00:00

% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%% data generation, two functions are defined over a finite range
s_int = 0.1;                                        % sampling interval constant
t = -10:s_int:10;                                   % interval for function 'f(t)'
f = 0.1*(t.^2);                                     % definition of function 'f(t)'
t1 = -7:s_int:7;                                    % interval for function 'g(t1)'
go = [-1*ones(1,40) ones(1, 61) -1*ones(1, 40)];    % definition of function 'g(t1)'
c = s_int * conv(f, go);                            % convolve: note the multiplation by the sampling interval

% flip 'go(t1)' for the graphical convolutions g = go(-t1)
g = fliplr(go);
tf = fliplr(-t1);

% slide range of 'g' to discard non-ovelapping areas with 'f' in the convolution
tf = tf + ( min(t)-max(tf) );

% get the range of function 'c' which is the convolution of 'f(t)' and 'go(t1)'
tc = [ tf t(2:end)];
tc = tc+max(t1);

%% static plot for initialization
figure('units','normalized','Position', [.16 .14 .31 .69]);
% plot f(t) and go(t1)  
subplot(3,1,1);
plot(t,f, 'b'); hold on; 
plot(t1, go, 'r');
grid on;
xlim( [ ( min(t)-abs(max(tf)-min(tf)) - 1 ) ( max(t)+abs(max(tf)-min(tf)) + 1 ) ] );
title('Graph of f(t) and go(t)');
legend({'f(t)' 'go(t)'});

% plot f in subplot 2
subplot(3,1,2);
plot(t, f);
hold on; grid on;
title('Graphical Convolution: f(t) and g = go(-t1)');
% plot g in subplot 2
q = plot(tf, g, 'r');
xlim( [ ( min(t)-abs(max(tf)-min(tf))-1 ) ( max(t)+abs(max(tf)-min(tf))+1 ) ] );
u_ym = get(gca, 'ylim');
% plot two vertical lines to show the range of ovelapped area
s_l = line( [min(t) min(t)], [u_ym(1) u_ym(2)], 'color', 'g'  );
e_l = line( [min(t) min(t)], [u_ym(1) u_ym(2)], 'color', 'g'  );
hold on; grid on;

% put a yellow shade on ovelapped region
sg = rectangle('Position', [min(t) u_ym(1) 0.0001 u_ym(2)-u_ym(1)], ...
             'EdgeColor', 'w', 'FaceColor', 'y', ...
             'EraseMode', 'xor');
         
% initialize the plot the convolution result 'c'
subplot(3,1,3);
r = plot(tc, c);
grid on; hold on;
xlim( [ ( min(t)-abs(max(tf)-min(tf)) - 1 ) ( max(t)+abs(max(tf)-min(tf)) + 1 ) ] );
ylim( [1.5*min(c) 1.5*max(c)] );
title('Convolutional Product c(t)');
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_07_Images/3165_07_07_1');

%% animation block

for i=1:length(tc)
% control speed of animation minimum is 0, the lower the faster
  pause(0.05);
  %drawnow;

% update the position of sliding function 'g', its handle is 'q'
  tf=tf+s_int;
  set(q,'EraseMode','xor','XData',tf,'YData',g);

% show overlapping regions

% show a vertical line for a left boundary of overlapping region
  sx = min( max( tf(1), min(t) ), max(t) );  
  sx_a = [sx sx];
  set(s_l,'EraseMode','xor', 'XData', sx_a);

% show a second vertical line for the right boundary of overlapping region
  ex = min( tf(end), max(t) );  
  ex_a = [ex ex];
  set(e_l,'EraseMode','xor', 'XData', ex_a);

% update shading on overlapped region
  rpos = [sx u_ym(1) max(0.0001, ex-sx) u_ym(2)-u_ym(1)];  
  set(sg, 'Position', rpos);

% update the plot of convolution product 'c', its handle is r
  set(r,'EraseMode','xor','XData',tc(1:i),'YData',c(1:i) );

end;
print(gcf,'-dpng','./../3165_07_Images/3165_07_07_2');
