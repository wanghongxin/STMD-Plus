% 该函数主要用于测试 DS-STMD Lateral Inhibition Kernel


clear all; close all; clc;

% DS-STMD Inhibition Kernel
% Inhibition Kernel 参数选取
% KernerlType = 1   DoG
% KernerlType = 2   LoG
DS_STMD_KernelType = 1;
Parameters_DS_STMD_InhibitionKernel = Generalization_Parameters_DS_STMD_InhibitionKernel(DS_STMD_KernelType);
% 生成侧抑制核
[DS_STMD_InhibitionKernel] = Generalization_DS_STMD_InhibitionKernel(Parameters_DS_STMD_InhibitionKernel,DS_STMD_KernelType);

% 绘制曲面图
figure
surf(DS_STMD_InhibitionKernel')

% 提取正部及负部
Pos_Com = (abs(DS_STMD_InhibitionKernel)+DS_STMD_InhibitionKernel)*0.5;
Neg_Com = (abs(DS_STMD_InhibitionKernel)-DS_STMD_InhibitionKernel)*0.5;

% 
Pos_Com = sum(sum(Pos_Com))
Neg_Com = sum(sum(Neg_Com))

Factor_Neg_Pos = Neg_Com/Pos_Com
