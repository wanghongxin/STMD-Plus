function [ Normalized_Data ] = Data_Normalization(Data,Normalization_Range)

% 函数说明
% 该函数用于将输入数据 （Data） 正则化到区间 （Normalization_Range）
% 输出为正则化后的数据 Normalized_Data

% 参数说明
% Normalization_Range   正则化区间 Normalization_Range = [min,max]


%% Main Function
K = Normalization_Range(2)-Normalization_Range(1);
B = Normalization_Range(1);

Normalized_Data = K*(Data-min(Data))/(max(Data)-min(Data))+B;







end

