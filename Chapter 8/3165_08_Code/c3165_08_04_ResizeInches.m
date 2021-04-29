%% CHAPTER 8, RESIZING MATLAB PLOTS INCLUSION INTO LATEX
%   3165_08_04: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-07-16 24:00:00

%% Create a Figure
x = -pi:.1:pi;
y = sin(x);
p = plot(x,y)
set(gca,'XTick',-pi:pi/2:pi)
set(gca,'XTickLabel',{'-pi','-pi/2','0','pi/2','pi'})
xlabel('-\pi \leq \Theta \leq \pi')
ylabel('sin(\Theta)')
title('Simulation Results')
text(-pi/4,sin(-pi/4),'\leftarrow sin(-\pi\div4)',...
     'HorizontalAlignment','left')
set(p,'Color','blue','LineWidth',1)

%% Set Parameters for Resizing
font_size = 10;
fig_width = 3;
fig_height=1.5;
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(fig_width*font_rate*144)   round(fig_height*font_rate*144)]);
print(gcf,'-dmeta','./../3165_08_Images/3165_08_04_1');
%% Add the following to your LaTeX code
% \begin{figure}[!t] 
% \centering 
% \includegraphics[width=3in]{myfigure} 
% \caption{Simulation Results} 
% \label{fig_sim} 
% \end{figure}
