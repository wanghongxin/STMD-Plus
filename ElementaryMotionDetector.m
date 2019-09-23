function [EMD_Output,GammaFun_Output] = ElementaryMotionDetector(X0,GammaFun_Output,GammaFun_Tau,GammaFun_Order,EMD_Output,Dist,M,N)

% 该函数用于计算 EMD correlation output

% Parameter Setting
% XO : 当前时刻高通滤波器的输出
% GammaFilter_Output : Time Delay 由 Gamma Convolution 实现，该参数为 Gamma 函数的迭代输出
% Dist : Distance Between Two Pixels (Elementary Motion Detector)
% M,N ： 图像的分辨率
% EMD_Output : 用于存储 EMD 的输出

[GammaFun_Output] = GammaFunction(X0,GammaFun_Output,GammaFun_Tau,GammaFun_Order);
DelaySignal = GammaFun_Output(:,:,GammaFun_Order+1);

% 确定计算 Correlation 的区域

CorrelationRegion_Row = (Dist+1):(M-Dist);
CorrelationRegion_Col = (Dist+1):(N-Dist);

% 沿着竖直方向进行 Correlation
EMD_Vertical_C1 = X0(CorrelationRegion_Row,CorrelationRegion_Col).*DelaySignal(CorrelationRegion_Row+Dist,CorrelationRegion_Col);
EMD_Vertical_C2 = X0(CorrelationRegion_Row+Dist,CorrelationRegion_Col).*DelaySignal(CorrelationRegion_Row,CorrelationRegion_Col);

% 沿着水平方向进行 Correlation
EMD_Horizontal_C1 = X0(CorrelationRegion_Row,CorrelationRegion_Col).*DelaySignal(CorrelationRegion_Row,CorrelationRegion_Col+Dist);   % <-----    运动方向 Left
EMD_Horizontal_C2 = X0(CorrelationRegion_Row,CorrelationRegion_Col+Dist).*DelaySignal(CorrelationRegion_Row,CorrelationRegion_Col);    % ----->   运动方向 Right



% 存储 Correlation 之后的结果
EMD_Output(CorrelationRegion_Row,CorrelationRegion_Col,1) = EMD_Horizontal_C1;
EMD_Output(CorrelationRegion_Row,CorrelationRegion_Col,2) = EMD_Horizontal_C2;
EMD_Output(CorrelationRegion_Row,CorrelationRegion_Col,3) = EMD_Vertical_C1;
EMD_Output(CorrelationRegion_Row,CorrelationRegion_Col,4) = EMD_Vertical_C2;



end

