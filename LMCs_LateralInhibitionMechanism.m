function [LMC_Inhibition_Output,LMC_Inhibition_Output_NT,W1_PastY,W1_PastX,W2_PastY,W2_PastX] = LMCs_LateralInhibitionMechanism(HighPassFilter_Output,...
                                             SpatialInhibitionKernel,W1_PastY,W1_PastX,W1_Alpha,W2_PastY,W2_PastX,W2_Alpha,IsTemporalInhibition_LMC)

% 函数说明
% 该函数主要用于实现位于 High-pass Filter Output 的侧抑制，该侧抑制作用于 Large Monopolar Cells
% (L1 and L2) 的突触末端

% 该侧抑制核可以用下面方程描述
% W(x,y,t) = W_C(x,y)W_1(t)-W_S(x,y)W_2(t)
% W_C(x,y) 为空间域上的刺激
% W_S(x,y) 为空间域上的抑制
% W_1(t),W_2(t) 分别为时域上的卷积核

% 参数说明
% HighPassFilter_Output    高通滤波器的输出
% SpatialInhibitionKernel     SpatialInhibitionKernel = W_C(x,y) - W_S(x,y)
%                             在这里我们取 SpatialInhibitionKernel 为 Difference of Gaussians
% 时间域上的卷积核 W_1(t) 及 W_2(t), 我们在这里采用指数型的一阶低通滤波器
% W1_PastY W1_PastX W1_Alpha      W_1 的相关参数，输入及输出   W1_Alpha 为滤波器常数
% W2_PastY W2_PastX W2_Alpha      W_2 的相关参数，输入及输出   W2_Alpha 为滤波器常数
% IsTemporalInhibition_LMC        是否进行时间维度上的卷积操作 （W_1, W_2）

%% Main Function


if IsTemporalInhibition_LMC == 1
    
    % 时间域上的卷积
    % 计算 W_1(t) 及 W_2(t) 的卷积输出
    % 在这里，我们采用指数型的一阶低通滤波器
    IsNormalized = 1;
    T = 1;                % 采样频率默认值为  1
    % W_1(t) 
    [W1_Y,W1_PastY,W1_PastX] = Exponential_1st_Order_LowPassFilter(HighPassFilter_Output,W1_PastX,W1_PastY,W1_Alpha,T,IsNormalized);
    % W_2(t)
    [W2_Y,W2_PastY,W2_PastX] = Exponential_1st_Order_LowPassFilter(HighPassFilter_Output,W2_PastX,W2_PastY,W2_Alpha,T,IsNormalized);
    
    % 空间域上的卷积
    % 提取出 Spatial Inhibition Kernel 的正部及负部
    % 在这里 Spatial Inhibition Kernel 一般为 Difference of Gaussians
    SpatialInhibitionKernel_C = (abs(SpatialInhibitionKernel)+SpatialInhibitionKernel)*0.5;  % 刺激 Excitation
    SpatialInhibitionKernel_S = (abs(SpatialInhibitionKernel)-SpatialInhibitionKernel)*0.5;  % 抑制 Inhibition
    
    LMC_Inhibition_Output = conv2(W1_Y,SpatialInhibitionKernel_C,'same') - conv2(W2_Y,SpatialInhibitionKernel_S,'same');
    
    % 没有时域部分，仅有空间域部分的侧抑制 (NT, No Temporal Part)
    LMC_Inhibition_Output_NT = conv2(HighPassFilter_Output,SpatialInhibitionKernel,'same');
  
    
elseif IsTemporalInhibition_LMC == 0
    
    % 不需要时域上的卷积，则 LMCs 的 Inhibition kernel 退化为 
    % W(x,y) = W_ON(x,y) - W_OFF(x,y)
    
    LMC_Inhibition_Output = conv2(HighPassFilter_Output,SpatialInhibitionKernel,'same');
   
end



end

