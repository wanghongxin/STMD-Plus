function [SCR,Contrast_Tar_Bac,Sigma_B,mu_T,mu_B] = Calculate_SCR_Value(TarCenX,TarCenY,I,i,TargetWidth,TargetHeight)

% ����˵��
% Ref: 1. Scale invariant small target detection by optimizing signal-to-clutter ratio in heterogeneous background for infrared search and track
% 2. Infrared patch-image model for small target detection in a single image
% ������� 1 �е� Eq.1  ������ 2 �е� Eq.16
% SCR: Signal to clutter ratios
% SCR = |mu_T - mu_B|/Sigma_B
% ���ڱȽ�Ŀ���뱳���ĻҶ�ֵ�Ĳ���

% ����˵��
% I: �����ͼ��
% TarCenX, TarCenY : �����λ������
% M,N : ͼ�� I �Ĵ�С

%% Main Function
% ���������Ĵ�С
Target_W = TargetWidth;
Target_H = TargetHeight;
T_R1 = round(Target_W/2);
T_R2 = round(Target_H/2);
% ���ñ�����Ĵ�С
BackgroundSize = 20;
B_R1 = round((Target_W+BackgroundSize)/2);
B_R2 = round((Target_H+BackgroundSize)/2);

[M,N] = size(I);

% �����Ӧ������
T_r1 = max(1,TarCenX - T_R1);
T_r2 = min(M,TarCenX + T_R1);
T_c1 = max(1,TarCenY - T_R2);
T_c2 = min(N,TarCenY + T_R2);


TargetRegion = double(I(T_r1:T_r2,T_c1:T_c2));



% ������Ӧ������
B_r1 = max(1,TarCenX - B_R1);
B_r2 = min(M,TarCenX + B_R1);
B_c1 = max(1,TarCenY - B_R2);
B_c2 = min(N,TarCenY + B_R2);

% if i>834 && i<846
%     %�鿴��ס��Ŀ������
%     figure
%     imshow(I)
%     hold on
%     plot(T_c1,T_r1:T_r2,'r.')
%     plot(T_c2,T_r1:T_r2,'r.')
%     plot(T_c1:T_c2,T_r1,'r.')
%     plot(T_c1:T_c2,T_r2,'r.')
%     %�鿴��ס�ı�������
%     plot(B_c1,B_r1:B_r2,'b.')
%     plot(B_c2,B_r1:B_r2,'b.')
%     plot(B_c1:B_c2,B_r1,'b.')
%     plot(B_c1:B_c2,B_r2,'b.')
% end

New_I = I;
New_I(T_r1:T_r2,T_c1:T_c2) = -1;

BigBackgroundRegion = New_I(B_r1:B_r2,B_c1:B_c2);
BackgoundRegion = double(BigBackgroundRegion(BigBackgroundRegion>-1));

% % ��������
% Whole_Region = double(I(B_r1:B_r2,B_c1:B_c2));


% ������ز���
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
