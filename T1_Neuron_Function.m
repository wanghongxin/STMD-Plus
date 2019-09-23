function [T1_Neuron_Outputs,T1_Neuron_GammaFun_Outputs] = T1_Neuron_Function(I,T1_Neuron_GammaFun_Outputs,...
                         T1_Neuron_GammaFun_Tau,T1_Neuron_GammaFun_Order,T1_Neurons_Kernels,...
                         T1_Neuron_Kernel_Num,M,N)
% Reference: Construction and evaluation of an integrated dynamical model
% of visual motion perception
% ����˵��
% �ú������ڼ��� Monophasic Neuron ����� (Eq.(2))


% ����˵��
% I                             ����ĸ�˹ģ�����ͼ��
% Monophasic_GammaFun_Output    Monophasic Neuron ��Ӧ Gamma function �����
% Monophasic_GammaFun_Tau       Monophasic Neuron ��Ӧ Gamma function �� Tau
% Monophasic_GammaFun_Order     Monophasic Neuron ��Ӧ Gamma function �Ľ�
% MonoPhasicFilters             Monophasic Neuron ��Ӧʱ�����˲���
% MonoPhasicFilter_Num          Monophasic Neuron ��Ӧʱ�����˲����ĸ���
% M,N                           �����ͼ���С

%% Main Function

% ʱ���ϵ��ӳ� ��Temporal Part��
[T1_Neuron_GammaFun_Outputs] = GammaFunction(I,T1_Neuron_GammaFun_Outputs,T1_Neuron_GammaFun_Tau,T1_Neuron_GammaFun_Order);
T1_Neuron_Temporal_Outputs = T1_Neuron_GammaFun_Outputs(:,:,T1_Neuron_GammaFun_Order+1);
% Monophasic_GammaFun_Output ���뷵��������

% ���ڴ洢 Monophasic Neuron �����
T1_Neuron_Outputs = zeros(M,N,T1_Neuron_Kernel_Num);

% Spatial Interaction (Spatial Part)
for i = 1:T1_Neuron_Kernel_Num
    
    T1_Neuron_Outputs(:,:,i) = conv2(T1_Neuron_Temporal_Outputs,T1_Neurons_Kernels(:,:,i),'same');
    
   
end



end

