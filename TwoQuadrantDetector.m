function [TQD_Output,TQD_Correlation_Component_ON,TQD_Correlation_Component_OFF,GammaFun_Output_ON,GammaFun_Output_OFF] = TwoQuadrantDetector(ON_Channel,OFF_Channel,GammaFun_Output_ON,GammaFun_Output_OFF,GammaFun_Tau,GammaFun_Order,TQD_Output,Dist,Directions,M,N)

% 该函数用于计算 Two Quadrant Motion Detector 的 correlation output

% Parameter Setting
% ON_Channel : 当前时刻 ON 通道的输入
% OFF_Channel ：当前时刻 OFF 通道的输入
% GammaFun_Output_ON : Time Delay 由 Gamma Convolution 实现，该参数为 ON Channel 的 Gamma 函数的迭代输出
% GammaFun_Output_OFF : Time Delay 由 Gamma Convolution 实现，该参数为 OFF Channel 的 Gamma 函数的迭代输出
% Dist : Distance Between Two Pixels (Elementary Motion Detector)
% M,N ： 图像的分辨率
% TQD_Output : 用于存储 TQD 的输出

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
TQD_ON_Vertical_C1 = ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayON_Channel(CorrelationRegion_Row+Dist,CorrelationRegion_Col);    % 向下
TQD_ON_Vertical_C2 = ON_Channel(CorrelationRegion_Row+Dist,CorrelationRegion_Col).*DelayON_Channel(CorrelationRegion_Row,CorrelationRegion_Col);    % 向上
% OFF Channel
TQD_OFF_Vertical_C1 = OFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayOFF_Channel(CorrelationRegion_Row+Dist,CorrelationRegion_Col);    % 向下
TQD_OFF_Vertical_C2 = OFF_Channel(CorrelationRegion_Row+Dist,CorrelationRegion_Col).*DelayOFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col);    % 向上

% 沿着水平方向进行 Correlation
% ON Channel
TQD_ON_Horizontal_C1 = ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayON_Channel(CorrelationRegion_Row,CorrelationRegion_Col+Dist);         % 向左  <-----
TQD_ON_Horizontal_C2 = ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col+Dist).*DelayON_Channel(CorrelationRegion_Row,CorrelationRegion_Col);          % 向右  ------>
% OFF Channel
TQD_OFF_Horizontal_C1 = OFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayOFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col+Dist);         % 向左  <-----
TQD_OFF_Horizontal_C2 = OFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col+Dist).*DelayOFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col);          % 向右  ------>


% 存储 Correlation 之后的结果
TQD_Output(CorrelationRegion_Row,CorrelationRegion_Col,1) = (TQD_ON_Horizontal_C1 - TQD_ON_Horizontal_C2) + (TQD_OFF_Horizontal_C1 - TQD_OFF_Horizontal_C2); % 向左为正方向
TQD_Output(CorrelationRegion_Row,CorrelationRegion_Col,2) = (TQD_ON_Vertical_C1 - TQD_ON_Vertical_C2) + (TQD_OFF_Vertical_C1 - TQD_OFF_Vertical_C2); % 向下为正方向
% 存储各个方向的分量
TQD_Correlation_Component_ON = zeros(M,N,2*Directions);
TQD_Correlation_Component_OFF = zeros(M,N,2*Directions);
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

