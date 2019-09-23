function [LateralInhibitionOutput,CorrelationOutput,DS_STMD_GammaFun_Output_ON,DS_STMD_GammaFun_Output_OFF_1,DS_STMD_GammaFun_Output_OFF_2] ...
                           = DS_STMD_MotionDetector(ON_Channel,OFF_Channel,...
                           DS_STMD_GammaFun_Order_ON,DS_STMD_GammaFun_Tau_ON,DS_STMD_GammaFun_Output_ON,...
                           DS_STMD_GammaFun_Order_OFF_1,DS_STMD_GammaFun_Tau_OFF_1,DS_STMD_GammaFun_Output_OFF_1,...
                           DS_STMD_GammaFun_Order_OFF_2,DS_STMD_GammaFun_Tau_OFF_2,DS_STMD_GammaFun_Output_OFF_2,...
                           DS_STMD_Dist,DS_STMD_Directions,M,N,InhibitionKernel)


% 该函数用于计算 Directionally Selective Small Target Motion Detector 的输出
% 主要实现部分包含以下几点：
% 1. Channel Delay 程序中的延迟是通过与 Gamma 函数做卷积实现的
% 2. Channel Correlation
% 3. Lateral Inhibition   通过与 DoG-like kernel 的卷积实现

% 参数说明
% ON_Channel, OFF_Channel      当前时刻 ON 及 OFF  通道的输出  
% DS_STMD_GammaFun_Order_ON    ON Channel 延迟阶数 （Gamma Function）
% DS_STMD_GammaFun_Tau_ON      ON Channel 延迟时间常数 （Gamma Function）
% DS_STMD_GammaFun_Output_ON   ON Channel 延迟迭代输出 （Gamma Function），必须返回主函数
% DS_STMD_GammaFun_Order_OFF_1   第一次 OFF Channel 延迟阶数 （Gamma Function）  
% DS_STMD_GammaFun_Tau_OFF_1     第一次 OFF Channel 延迟时间常数 （Gamma Function）
% DS_STMD_GammaFun_Output_OFF_1  第一次 OFF Channel 延迟迭代输出 （Gamma Function， 必须返回主函数
% DS_STMD_GammaFun_Order_OFF_2   第二次 OFF Channel 延迟阶数 （Gamma Function）
% DS_STMD_GammaFun_Tau_OFF_2     第二次 OFF Channel 延迟时间常数 （Gamma Function）
% DS_STMD_GammaFun_Output_OFF_2  第二次 OFF Channel 延迟迭代输出 （Gamma Function），必须返回主函数
% DS_STMD_Dist                   Correlation 两点之间的距离
% DS_STMD_Directions             Correlation 的方向，默认为 8
% M,N                            原图像大小
% InhibitionKernel               侧抑制的卷积核

%% Channel Delay

% ON Channel Delay 
[DS_STMD_GammaFun_Output_ON] = GammaFunction(ON_Channel,DS_STMD_GammaFun_Output_ON,DS_STMD_GammaFun_Tau_ON,DS_STMD_GammaFun_Order_ON);
DelayON_Channel = DS_STMD_GammaFun_Output_ON(:,:,DS_STMD_GammaFun_Order_ON+1);
% OFF Channel Delay 1
[DS_STMD_GammaFun_Output_OFF_1] = GammaFunction(OFF_Channel,DS_STMD_GammaFun_Output_OFF_1,DS_STMD_GammaFun_Tau_OFF_1,DS_STMD_GammaFun_Order_OFF_1);
DelayOFF_Channel_1 = DS_STMD_GammaFun_Output_OFF_1(:,:,DS_STMD_GammaFun_Order_OFF_1+1);
% OFF Channel Delay 2
[DS_STMD_GammaFun_Output_OFF_2] = GammaFunction(OFF_Channel,DS_STMD_GammaFun_Output_OFF_2,DS_STMD_GammaFun_Tau_OFF_2,DS_STMD_GammaFun_Order_OFF_2);
DelayOFF_Channel_2 = DS_STMD_GammaFun_Output_OFF_2(:,:,DS_STMD_GammaFun_Order_OFF_2+1);


%% Channel Correlation

CorrelationOutput = zeros(M,N,DS_STMD_Directions);

% 确定计算 Correlation 的区域
CorrelationRegion_Row = (DS_STMD_Dist+1):(M-DS_STMD_Dist);
CorrelationRegion_Col = (DS_STMD_Dist+1):(N-DS_STMD_Dist);

% DS-STMD Correlation
% 向左   Left  <---   Direction = pi
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,1) = ...
                                  ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                  DelayON_Channel(CorrelationRegion_Row,CorrelationRegion_Col+DS_STMD_Dist)).*DelayOFF_Channel_2(CorrelationRegion_Row,CorrelationRegion_Col+DS_STMD_Dist);

% 向右   Right  --->   Direction = 0
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,2) = ...
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row,CorrelationRegion_Col-DS_STMD_Dist)).*DelayOFF_Channel_2(CorrelationRegion_Row,CorrelationRegion_Col-DS_STMD_Dist);
                                                                 
% 向上  Direction = pi/2
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,3) = ....
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row+DS_STMD_Dist,CorrelationRegion_Col)).*DelayOFF_Channel_2(CorrelationRegion_Row+DS_STMD_Dist,CorrelationRegion_Col);
                                                          
% 向下  Direction = 3*pi/2
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,4) = ...
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row-DS_STMD_Dist,CorrelationRegion_Col)).*DelayOFF_Channel_2(CorrelationRegion_Row-DS_STMD_Dist,CorrelationRegion_Col);



% 计算斜对角的 Correlation 输出时，要将 DS_STMD_Dist 分解成两部分
Diagonal_Dist = round(DS_STMD_Dist*cos(pi/4));

% 斜对角  Direction = pi/4 (方向)，
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,5) = ...
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row+Diagonal_Dist,CorrelationRegion_Col-Diagonal_Dist)).*DelayOFF_Channel_2(CorrelationRegion_Row+Diagonal_Dist,CorrelationRegion_Col-Diagonal_Dist);

% 斜对角  Direction = 3*pi/4 (方向)
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,6) = ...
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row+Diagonal_Dist,CorrelationRegion_Col+Diagonal_Dist)).*DelayOFF_Channel_2(CorrelationRegion_Row+Diagonal_Dist,CorrelationRegion_Col+Diagonal_Dist);                             
                             
% 斜对角  Direction = 5*pi/4 (方向)
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,7) = ...
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row-Diagonal_Dist,CorrelationRegion_Col+Diagonal_Dist)).*DelayOFF_Channel_2(CorrelationRegion_Row-Diagonal_Dist,CorrelationRegion_Col+Diagonal_Dist);                             
                             
% 斜对角  Direction = 7*pi/4 (方向)
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,8) = ...
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row-Diagonal_Dist,CorrelationRegion_Col-Diagonal_Dist)).*DelayOFF_Channel_2(CorrelationRegion_Row-Diagonal_Dist,CorrelationRegion_Col-Diagonal_Dist);



%% Lateral Inhibition
% convn 函数可以省去 conv2 的 for 循环
LateralInhibitionOutput = convn(CorrelationOutput,InhibitionKernel,'same');
% Half-wave Rectification 消除负值
LateralInhibitionOutput = (abs(LateralInhibitionOutput)+LateralInhibitionOutput)*0.5;



end

