% 函数说明
% 该函数用于对现有的 Figure 增加标注


clear all; clc;

%% Main Function
DS_STMD_Directions = 8;
MarkerEdgeColors = jet(DS_STMD_Directions);
X_0 = 1000;
Y_0 = 1000;



H1 = plot(X_0,Y_0+1,'.','color',MarkerEdgeColors(1,:),'DisPlayName','\theta = \pi');

H2 = plot(X_0,Y_0+2,'.','color',MarkerEdgeColors(2,:),'DisPlayName','\theta = 0');

H3 = plot(X_0,Y_0+3,'.','color',MarkerEdgeColors(3,:),'DisPlayName','\theta = \pi/2');

H4 = plot(X_0,Y_0+4,'.','color',MarkerEdgeColors(4,:),'DisPlayName','\theta = 3\pi/2');

H5 = plot(X_0,Y_0+5,'.','color',MarkerEdgeColors(5,:),'DisPlayName','\theta = \pi/4');

H6 = plot(X_0,Y_0+6,'.','color',MarkerEdgeColors(6,:),'DisPlayName','\theta = 3\pi/4');

H7 = plot(X_0,Y_0+7,'.','color',MarkerEdgeColors(7,:),'DisPlayName','\theta = 5\pi/4');

H8 = plot(X_0,Y_0+8,'.','color',MarkerEdgeColors(8,:),'DisPlayName','\theta = 7\pi/4');

axis([0,500,0,250])
set(gca,'Position',[0.1 0.3 0.8 0.4]);


legend([H2,H5,H3,H6,H1,H7,H4,H8],'\theta = 0','\theta = \pi/4','\theta = \pi/2','\theta = 3\pi/4','\theta = \pi','\theta = 5\pi/4','\theta = 3\pi/2','\theta = 7\pi/4')



