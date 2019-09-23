function [Parameters] = Generalization_Parameters_DS_STMD_InhibitionKernel(KernerlType)

% Inhibition Kernel 参数选择



if KernerlType == 1
    % DoG
    % 参数调整
    Parameters = zeros(7,1);
    DS_STMD_InhibitionKernel_Size = 13;
    DS_STMD_InhibitionKernel_Sigma1 = 1.5;          % size 5*5 是的最优参数（1.5，3.0）
    DS_STMD_InhibitionKernel_Sigma2 = 3;
    DS_STMD_InhibitionKernel_e = 1.0;
    DS_STMD_InhibitionKernel_rho = 0.0;
    DS_STMD_InhibitionKernel_A = 1;
    DS_STMD_InhibitionKernel_B = 3;
    
    % 将参数存储到向量 Parameters 中
    Parameters(1) = DS_STMD_InhibitionKernel_Size;
    Parameters(2) = DS_STMD_InhibitionKernel_Sigma1;
    Parameters(3) = DS_STMD_InhibitionKernel_Sigma2;
    Parameters(4) = DS_STMD_InhibitionKernel_e;
    Parameters(5) = DS_STMD_InhibitionKernel_rho;
    Parameters(6) = DS_STMD_InhibitionKernel_A;
    Parameters(7) = DS_STMD_InhibitionKernel_B;
    
elseif KernelType == 2
    % LoG
    % 参数调整
    DS_STMD_InhibitionKernel_Size = 13;
    DS_STMD_InhibitionKernel_Sigma = 2;         % size 5*5 是的最优参数（2.0）
    DS_STMD_InhibitionKernel_A = 1;
    DS_STMD_InhibitionKernel_B = 3;
    
    % 将参数存储到向量 Parameters 中
    Parameters = zeros(4,1);
    Parameters(1) = DS_STMD_InhibitionKernel_Size;
    Parameters(2) = DS_STMD_InhibitionKernel_Sigma;
    Parameters(3) = DS_STMD_InhibitionKernel_A;
    Parameters(4) = DS_STMD_InhibitionKernel_B;
    
    
end
    
    
    
    







end

