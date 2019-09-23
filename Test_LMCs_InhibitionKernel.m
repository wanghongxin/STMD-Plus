% 该函数主要用于测试 LMCs Lateral Inhibition Kernel (Spatial Component)

clear all; clc; close all;

%========================之前的参数======================================%
% LMCs 侧抑制的空间域部分，这里采用 Difference of Gaussians
LMCs_KernelSize = 13;
LMCs_Sigma1 = 1.5;
LMCs_Sigma2 = 2.0;
LMCs_SpatialInhibitionKernel = DoGFilter(LMCs_KernelSize,LMCs_Sigma1,LMCs_Sigma2);
% 绘制曲面图
figure
surf(LMCs_SpatialInhibitionKernel')

Pos_Com = (abs(LMCs_SpatialInhibitionKernel) + LMCs_SpatialInhibitionKernel)*0.5;
Neg_Com = (abs(LMCs_SpatialInhibitionKernel) - LMCs_SpatialInhibitionKernel)*0.5;

Pos_Com = sum(sum(Pos_Com))
Neg_Com = sum(sum(Neg_Com))

%==========================修改后的参数===============================%
% LMCs 侧抑制的空间域部分，这里采用 Difference of Gaussians
LMCs_KernelSize = 13;
LMCs_Sigma1 = 1.5;
LMCs_Sigma2 = 3.0;
LMCs_SpatialInhibitionKernel = DoGFilter(LMCs_KernelSize,LMCs_Sigma1,LMCs_Sigma2);
% 绘制曲面图
figure
surf(LMCs_SpatialInhibitionKernel')

Pos_Com = (abs(LMCs_SpatialInhibitionKernel) + LMCs_SpatialInhibitionKernel)*0.5;
Neg_Com = (abs(LMCs_SpatialInhibitionKernel) - LMCs_SpatialInhibitionKernel)*0.5;

Pos_Com = sum(sum(Pos_Com))
Neg_Com = sum(sum(Neg_Com))
