function [SCR,Contrast_Tar_Bac,Sigma_B,mu_T,mu_B] = Calculate_SCR_Value(TarCenX,TarCenY,I,i,TargetWidth,TargetHeight)

% 函数说明
% Ref: 1. Scale invariant small target detection by optimizing signal-to-clutter ratio in heterogeneous background for infrared search and track
% 2. Infrared patch-image model for small target detection in a single image
% 详见文献 1 中的 Eq.1  或文献 2 中的 Eq.16
% SCR: Signal to clutter ratios
% SCR = |mu_T - mu_B|/Sigma_B
% 用于比较目标与背景的灰度值的差异

% 参数说明
% I: 输入的图像
% TarCenX, TarCenY : 物体的位置坐标
% M,N : 图像 I 的大小

%% Main Function
% 设置物体框的大小
Target_W = TargetWidth;
Target_H = TargetHeight;
T_R1 = round(Target_W/2);
T_R2 = round(Target_H/2);
% 设置背景框的大小
BackgroundSize = 20;
B_R1 = round((Target_W+BackgroundSize)/2);
B_R2 = round((Target_H+BackgroundSize)/2);

[M,N] = size(I);

% 物体对应的区域
T_r1 = max(1,TarCenX - T_R1);
T_r2 = min(M,TarCenX + T_R1);
T_c1 = max(1,TarCenY - T_R2);
T_c2 = min(N,TarCenY + T_R2);


TargetRegion = double(I(T_r1:T_r2,T_c1:T_c2));



% 背景对应的区域
B_r1 = max(1,TarCenX - B_R1);
B_r2 = min(M,TarCenX + B_R1);
B_c1 = max(1,TarCenY - B_R2);
B_c2 = min(N,TarCenY + B_R2);

% if i>834 && i<846
%     %查看框住的目标区域
%     figure
%     imshow(I)
%     hold on
%     plot(T_c1,T_r1:T_r2,'r.')
%     plot(T_c2,T_r1:T_r2,'r.')
%     plot(T_c1:T_c2,T_r1,'r.')
%     plot(T_c1:T_c2,T_r2,'r.')
%     %查看框住的背景区域
%     plot(B_c1,B_r1:B_r2,'b.')
%     plot(B_c2,B_r1:B_r2,'b.')
%     plot(B_c1:B_c2,B_r1,'b.')
%     plot(B_c1:B_c2,B_r2,'b.')
% end

New_I = I;
New_I(T_r1:T_r2,T_c1:T_c2) = -1;

BigBackgroundRegion = New_I(B_r1:B_r2,B_c1:B_c2);
BackgoundRegion = double(BigBackgroundRegion(BigBackgroundRegion>-1));

% % 整个区域
% Whole_Region = double(I(B_r1:B_r2,B_c1:B_c2));


% 计算相关参数
mu_T = mean(TargetRegion(:));
mu_B = mean(BackgoundRegion);
Sigma_B = std(BackgoundRegion);
%mu_B = mean(Whole_Region(:));
%Sigma_B = std(Whole_Region(:));
SCR = abs(mu_T - mu_B)/Sigma_B;
Contrast_Tar_Bac = abs(mu_T - mu_B);

% if i>834 && i<846
%     disp('===============================================')
%     disp(i)
%     mu_T
%     mu_B
%     Sigma_B
% end




end
