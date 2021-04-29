%% CHAPTER 3, 2D SCATTER PLOTS
%   3165_03_01:
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-02-14 12:00:00

%% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

%%  Load dataset
[attrib className] = xlsread('iris.xlsx');

%% basic scatter plot
figure('units','normalized','Position',[0.2359    0.3009    0.4094    0.6037]);
scatter(attrib(:,1),attrib(:,2),10*attrib(:,3),[1 0 0],'filled','Marker','^');
set(gca,'Fontsize',12);
title({'The Fisher Iris dataset (shown here) has 150 samples, with 4 attribute dimensions',...    
    'A scaled version of attribute 3 is used to determine the size of the marker',...
    'Customizations include user-defined marker style and face color'});
xlabel('Attribute 1'); ylabel('Attribute 2');
box on;
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_03_Images/3165_03_01_1.png');

%% plot matrix
% The output parameters have 
% A matrix of handles to the objects created in H, 
% A matrix of handles to the individual subaxes in AX, 
% A handle to a big (invisible) axes that frames the subaxes in BigAx, 
% A matrix of handles for the histogram plots in P. BigAx is left as the current axes so that a subsequent title, xlabel, or ylabel command is centered with respect to the matrix of axes.
figure('units','normalized','Position',[ 0.2359    0.3009    0.4094    0.6037]);
[H,AX,BigAx,P] = plotmatrix(attrib,'r.');
attribName = {[char(10) 'Sepal length'],[char(10) 'Sepal width'],[char(10) 'Petal length'],[char(10) 'Petal width']};
% add annotations
for i = 1:4
    set(get(AX(i,1),'ylabel'),'string',['Attribute ' num2str(i) attribName{i}]); 
    set(get(AX(4,i),'xlabel'),'string',['Attribute ' num2str(i) attribName{i}]);
end
set(get(BigAx,'title'),'String',{'Scatter Plot Matrix (Fisher dataset with 3 known classes of iris flowers)', ...
    'Figure shows the 3 classes are not separable based on any two dimensions'},'Fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_03_Images/3165_03_01_2.png');

%% distibution on axis
figure('units','normalized','Position',[0.2589    0.3296    0.3859    0.5750]);
[mainDataAxes xhistAxes yhistAxes] = scatterHistV(attrib(:,2),attrib(:,3),50,50);
set(get(mainDataAxes,'title'),'String','1 of the 3 iris classes is separable based on these 2 attribute values','Fontsize',12);
set(get(mainDataAxes,'xlabel'),'String','x (Attribute 2, Sepal width)','Fontsize',14);
set(get(mainDataAxes,'ylabel'),'String','y (Attribute 3, Petal length)','Fontsize',14);
set(gcf,'color',[1 1 1],'paperpositionmode','auto');
print(gcf,'-dpng','./../3165_03_Images/3165_03_01_3.png');
