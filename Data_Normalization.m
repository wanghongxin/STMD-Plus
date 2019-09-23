function [ Normalized_Data ] = Data_Normalization(Data,Normalization_Range)

% ����˵��
% �ú������ڽ��������� ��Data�� ���򻯵����� ��Normalization_Range��
% ���Ϊ���򻯺������ Normalized_Data

% ����˵��
% Normalization_Range   �������� Normalization_Range = [min,max]


%% Main Function
K = Normalization_Range(2)-Normalization_Range(1);
B = Normalization_Range(1);

Normalized_Data = K*(Data-min(Data))/(max(Data)-min(Data))+B;







end

