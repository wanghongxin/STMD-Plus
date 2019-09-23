function [T1_Neuron_Outputs,T1_Neuron_GammaFun_Outputs] = T1_Neuron_Function(I,T1_Neuron_GammaFun_Outputs,...
                         T1_Neuron_GammaFun_Tau,T1_Neuron_GammaFun_Order,T1_Neurons_Kernels,...
                         T1_Neuron_Kernel_Num,M,N)
% Reference: Construction and evaluation of an integrated dynamical model
% of visual motion perception
% 函数说明
% 该函数用于计算 Monophasic Neuron 的输出 (Eq.(2))


% 参数说明
% I                             输入的高斯模糊后的图像
% Monophasic_GammaFun_Output    Monophasic Neuron 对应 Gamma function 的输出
% Monophasic_GammaFun_Tau       Monophasic Neuron 对应 Gamma function 的 Tau
% Monophasic_GammaFun_Order     Monophasic Neuron 对应 Gamma function 的阶
% MonoPhasicFilters             Monophasic Neuron 对应时间域滤波器
% MonoPhasicFilter_Num          Monophasic Neuron 对应时间域滤波器的个数
% M,N                           输入的图像大小

%% Main Function

% 时域上的延迟 （Temporal Part）
[T1_Neuron_GammaFun_Outputs] = GammaFunction(I,T1_Neuron_GammaFun_Outputs,T1_Neuron_GammaFun_Tau,T1_Neuron_GammaFun_Order);
T1_Neuron_Temporal_Outputs = T1_Neuron_GammaFun_Outputs(:,:,T1_Neuron_GammaFun_Order+1);
% Monophasic_GammaFun_Output 必须返回主函数

% 用于存储 Monophasic Neuron 的输出
T1_Neuron_Outputs = zeros(M,N,T1_Neuron_Kernel_Num);

% Spatial Interaction (Spatial Part)
for i = 1:T1_Neuron_Kernel_Num
    
    T1_Neuron_Outputs(:,:,i) = conv2(T1_Neuron_Temporal_Outputs,T1_Neurons_Kernels(:,:,i),'same');
    
   
end



end

