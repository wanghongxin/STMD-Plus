function [T1_Neuron_Outputs] = T1_Neuron_Function_2(I,T1_Neurons_Kernels,...
                                                            T1_Neuron_Kernel_Num,M,N)
% Reference: Construction and evaluation of an integrated dynamical model
% of visual motion perception
% 函数说明
% 该函数是 MonophasicNeurons_Function.m 的简版，没有加入时间延迟


% 参数说明
% I                             输入的高斯模糊后的图像
% MonoPhasicFilters             Monophasic Neuron 对应时间域滤波器
% MonoPhasicFilter_Num          Monophasic Neuron 对应时间域滤波器的个数
% M,N                           输入的图像大小

%% Main Function

% 用于存储 Monophasic Neuron 的输出
T1_Neuron_Outputs = zeros(M,N,T1_Neuron_Kernel_Num);

% Spatial Interaction (Spatial Part)
for k = 1:T1_Neuron_Kernel_Num
    
    T1_Neuron_Outputs(:,:,k) = conv2(I,T1_Neurons_Kernels(:,:,k),'same');
    
   
end



end

