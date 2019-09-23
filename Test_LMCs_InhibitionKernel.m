% �ú�����Ҫ���ڲ��� LMCs Lateral Inhibition Kernel (Spatial Component)

clear all; clc; close all;

%========================֮ǰ�Ĳ���======================================%
% LMCs �����ƵĿռ��򲿷֣�������� Difference of Gaussians
LMCs_KernelSize = 13;
LMCs_Sigma1 = 1.5;
LMCs_Sigma2 = 2.0;
LMCs_SpatialInhibitionKernel = DoGFilter(LMCs_KernelSize,LMCs_Sigma1,LMCs_Sigma2);
% ��������ͼ
figure
surf(LMCs_SpatialInhibitionKernel')

Pos_Com = (abs(LMCs_SpatialInhibitionKernel) + LMCs_SpatialInhibitionKernel)*0.5;
Neg_Com = (abs(LMCs_SpatialInhibitionKernel) - LMCs_SpatialInhibitionKernel)*0.5;

Pos_Com = sum(sum(Pos_Com))
Neg_Com = sum(sum(Neg_Com))

%==========================�޸ĺ�Ĳ���===============================%
% LMCs �����ƵĿռ��򲿷֣�������� Difference of Gaussians
LMCs_KernelSize = 13;
LMCs_Sigma1 = 1.5;
LMCs_Sigma2 = 3.0;
LMCs_SpatialInhibitionKernel = DoGFilter(LMCs_KernelSize,LMCs_Sigma1,LMCs_Sigma2);
% ��������ͼ
figure
surf(LMCs_SpatialInhibitionKernel')

Pos_Com = (abs(LMCs_SpatialInhibitionKernel) + LMCs_SpatialInhibitionKernel)*0.5;
Neg_Com = (abs(LMCs_SpatialInhibitionKernel) - LMCs_SpatialInhibitionKernel)*0.5;

Pos_Com = sum(sum(Pos_Com))
Neg_Com = sum(sum(Neg_Com))
