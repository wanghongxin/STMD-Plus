function [T1_Neuron_Outputs] = T1_Neuron_Function_2(I,T1_Neurons_Kernels,...
                                                            T1_Neuron_Kernel_Num,M,N)
% Reference: Construction and evaluation of an integrated dynamical model
% of visual motion perception
% ����˵��
% �ú����� MonophasicNeurons_Function.m �ļ�棬û�м���ʱ���ӳ�


% ����˵��
% I                             ����ĸ�˹ģ�����ͼ��
% MonoPhasicFilters             Monophasic Neuron ��Ӧʱ�����˲���
% MonoPhasicFilter_Num          Monophasic Neuron ��Ӧʱ�����˲����ĸ���
% M,N                           �����ͼ���С

%% Main Function

% ���ڴ洢 Monophasic Neuron �����
T1_Neuron_Outputs = zeros(M,N,T1_Neuron_Kernel_Num);

% Spatial Interaction (Spatial Part)
for k = 1:T1_Neuron_Kernel_Num
    
    T1_Neuron_Outputs(:,:,k) = conv2(I,T1_Neurons_Kernels(:,:,k),'same');
    
   
end



end

