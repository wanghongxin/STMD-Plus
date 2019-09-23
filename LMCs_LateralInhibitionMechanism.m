function [LMC_Inhibition_Output,LMC_Inhibition_Output_NT,W1_PastY,W1_PastX,W2_PastY,W2_PastX] = LMCs_LateralInhibitionMechanism(HighPassFilter_Output,...
                                             SpatialInhibitionKernel,W1_PastY,W1_PastX,W1_Alpha,W2_PastY,W2_PastX,W2_Alpha,IsTemporalInhibition_LMC)

% ����˵��
% �ú�����Ҫ����ʵ��λ�� High-pass Filter Output �Ĳ����ƣ��ò����������� Large Monopolar Cells
% (L1 and L2) ��ͻ��ĩ��

% �ò����ƺ˿��������淽������
% W(x,y,t) = W_C(x,y)W_1(t)-W_S(x,y)W_2(t)
% W_C(x,y) Ϊ�ռ����ϵĴ̼�
% W_S(x,y) Ϊ�ռ����ϵ�����
% W_1(t),W_2(t) �ֱ�Ϊʱ���ϵľ����

% ����˵��
% HighPassFilter_Output    ��ͨ�˲��������
% SpatialInhibitionKernel     SpatialInhibitionKernel = W_C(x,y) - W_S(x,y)
%                             ����������ȡ SpatialInhibitionKernel Ϊ Difference of Gaussians
% ʱ�����ϵľ���� W_1(t) �� W_2(t), �������������ָ���͵�һ�׵�ͨ�˲���
% W1_PastY W1_PastX W1_Alpha      W_1 ����ز��������뼰���   W1_Alpha Ϊ�˲�������
% W2_PastY W2_PastX W2_Alpha      W_2 ����ز��������뼰���   W2_Alpha Ϊ�˲�������
% IsTemporalInhibition_LMC        �Ƿ����ʱ��ά���ϵľ������ ��W_1, W_2��

%% Main Function


if IsTemporalInhibition_LMC == 1
    
    % ʱ�����ϵľ��
    % ���� W_1(t) �� W_2(t) �ľ�����
    % ��������ǲ���ָ���͵�һ�׵�ͨ�˲���
    IsNormalized = 1;
    T = 1;                % ����Ƶ��Ĭ��ֵΪ  1
    % W_1(t) 
    [W1_Y,W1_PastY,W1_PastX] = Exponential_1st_Order_LowPassFilter(HighPassFilter_Output,W1_PastX,W1_PastY,W1_Alpha,T,IsNormalized);
    % W_2(t)
    [W2_Y,W2_PastY,W2_PastX] = Exponential_1st_Order_LowPassFilter(HighPassFilter_Output,W2_PastX,W2_PastY,W2_Alpha,T,IsNormalized);
    
    % �ռ����ϵľ��
    % ��ȡ�� Spatial Inhibition Kernel ������������
    % ������ Spatial Inhibition Kernel һ��Ϊ Difference of Gaussians
    SpatialInhibitionKernel_C = (abs(SpatialInhibitionKernel)+SpatialInhibitionKernel)*0.5;  % �̼� Excitation
    SpatialInhibitionKernel_S = (abs(SpatialInhibitionKernel)-SpatialInhibitionKernel)*0.5;  % ���� Inhibition
    
    LMC_Inhibition_Output = conv2(W1_Y,SpatialInhibitionKernel_C,'same') - conv2(W2_Y,SpatialInhibitionKernel_S,'same');
    
    % û��ʱ�򲿷֣����пռ��򲿷ֵĲ����� (NT, No Temporal Part)
    LMC_Inhibition_Output_NT = conv2(HighPassFilter_Output,SpatialInhibitionKernel,'same');
  
    
elseif IsTemporalInhibition_LMC == 0
    
    % ����Ҫʱ���ϵľ������ LMCs �� Inhibition kernel �˻�Ϊ 
    % W(x,y) = W_ON(x,y) - W_OFF(x,y)
    
    LMC_Inhibition_Output = conv2(HighPassFilter_Output,SpatialInhibitionKernel,'same');
   
end



end

