function [TQD_Correlation_Component_ON,TQD_Correlation_Component_OFF,GammaFun_Output_ON,GammaFun_Output_OFF] = ...
                          SingleHand_TwoQuadrantDetector(ON_Channel,OFF_Channel,...
                          GammaFun_Output_ON,GammaFun_Output_OFF,GammaFun_Tau,GammaFun_Order,...
                          Dist,Directions,M,N)
% 函数说明
% 该函数用于计算 Single Hand Two Quadrant Motion Detector 的 correlation output
% 该函数与 TwoQuadrantDetector.m 存在的区别在于该函数只计算单臂 Correlation Output


% 参数说明
% ON_Channel : 当前时刻 ON 通道的输入
% OFF_Channel ：当前时刻 OFF 通道的输入
% GammaFun_Output_ON : Time Delay 由 Gamma Convolution 实现，该参数为 ON Channel 的 Gamma 函数的迭代输出
% GammaFun_Output_OFF : Time Delay 由 Gamma Convolution 实现，该参数为 OFF Channel 的 Gamma 函数的迭代输出
% Dist : Distance Between Two Pixels (Elementary Motion Detector)
% M,N ： 图像的分辨率
% Directions    进行 Correlation 的方向，默认为四个方向（上下左右，不考虑倾斜方向）

% ON Channel Delay
[GammaFun_Output_ON] = GammaFunction(ON_Channel,GammaFun_Output_ON,GammaFun_Tau,GammaFun_Order);
DelayON_Channel = GammaFun_Output_ON(:,:,GammaFun_Order+1);
% OFF Channel Delay
[GammaFun_Output_OFF] = GammaFunction(OFF_Channel,GammaFun_Output_OFF,GammaFun_Tau,GammaFun_Order);
DelayOFF_Channel = GammaFun_Output_OFF(:,:,GammaFun_Order+1);


% 确定计算 Correlation 的区域

CorrelationRegion_Row = (Dist+1):(M-Dist);
CorrelationRegion_Col = (Dist+1):(N-Dist);

% 沿着竖直方向进行 Correlation
% ON Channel 
TQD_ON_Vertical_C1 = ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayON_Channel(CorrelationRegion_Row+Dist,CorrelationRegion_Col);     % 向上运动（Upward）
TQD_ON_Vertical_C2 = ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayON_Channel(CorrelationRegion_Row-Dist,CorrelationRegion_Col);     % 向下运动（Downward）
% OFF Channel
TQD_OFF_Vertical_C1 = OFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayOFF_Channel(CorrelationRegion_Row+Dist,CorrelationRegion_Col);    % 向上运动（Upward）
TQD_OFF_Vertical_C2 = OFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayOFF_Channel(CorrelationRegion_Row-Dist,CorrelationRegion_Col);    % 向下运动（Downward）

% 沿着水平方向进行 Correlation
% ON Channel
TQD_ON_Horizontal_C1 = ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayON_Channel(CorrelationRegion_Row,CorrelationRegion_Col+Dist);     % 向左运动（Leftward）
TQD_ON_Horizontal_C2 = ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayON_Channel(CorrelationRegion_Row,CorrelationRegion_Col-Dist);     % 向右运动（Rightward）
% OFF Channel
TQD_OFF_Horizontal_C1 = OFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayOFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col+Dist);   % 向左运动（Leftward）
TQD_OFF_Horizontal_C2 = OFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayOFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col-Dist);   % 向右运动（Rightward）

% 存储各个方向的分量
TQD_Correlation_Component_ON = zeros(M,N,Directions);
TQD_Correlation_Component_OFF = zeros(M,N,Directions);
% ON
TQD_Correlation_Component_ON(CorrelationRegion_Row,CorrelationRegion_Col,1) = TQD_ON_Horizontal_C1;
TQD_Correlation_Component_ON(CorrelationRegion_Row,CorrelationRegion_Col,2) = TQD_ON_Horizontal_C2;
TQD_Correlation_Component_ON(CorrelationRegion_Row,CorrelationRegion_Col,3) = TQD_ON_Vertical_C1;
TQD_Correlation_Component_ON(CorrelationRegion_Row,CorrelationRegion_Col,4) = TQD_ON_Vertical_C2;
% OFF
TQD_Correlation_Component_OFF(CorrelationRegion_Row,CorrelationRegion_Col,1) = TQD_OFF_Horizontal_C1;
TQD_Correlation_Component_OFF(CorrelationRegion_Row,CorrelationRegion_Col,2) = TQD_OFF_Horizontal_C2;
TQD_Correlation_Component_OFF(CorrelationRegion_Row,CorrelationRegion_Col,3) = TQD_OFF_Vertical_C1;
TQD_Correlation_Component_OFF(CorrelationRegion_Row,CorrelationRegion_Col,4) = TQD_OFF_Vertical_C2;

end

