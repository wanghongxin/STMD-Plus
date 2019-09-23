function [LateralInhibitionOutput,CorrelationOutput,DS_STMD_GammaFun_Output_ON,DS_STMD_GammaFun_Output_OFF_1,DS_STMD_GammaFun_Output_OFF_2] ...
                           = DS_STMD_MotionDetector(ON_Channel,OFF_Channel,...
                           DS_STMD_GammaFun_Order_ON,DS_STMD_GammaFun_Tau_ON,DS_STMD_GammaFun_Output_ON,...
                           DS_STMD_GammaFun_Order_OFF_1,DS_STMD_GammaFun_Tau_OFF_1,DS_STMD_GammaFun_Output_OFF_1,...
                           DS_STMD_GammaFun_Order_OFF_2,DS_STMD_GammaFun_Tau_OFF_2,DS_STMD_GammaFun_Output_OFF_2,...
                           DS_STMD_Dist,DS_STMD_Directions,M,N,InhibitionKernel)


% �ú������ڼ��� Directionally Selective Small Target Motion Detector �����
% ��Ҫʵ�ֲ��ְ������¼��㣺
% 1. Channel Delay �����е��ӳ���ͨ���� Gamma ���������ʵ�ֵ�
% 2. Channel Correlation
% 3. Lateral Inhibition   ͨ���� DoG-like kernel �ľ��ʵ��

% ����˵��
% ON_Channel, OFF_Channel      ��ǰʱ�� ON �� OFF  ͨ�������  
% DS_STMD_GammaFun_Order_ON    ON Channel �ӳٽ��� ��Gamma Function��
% DS_STMD_GammaFun_Tau_ON      ON Channel �ӳ�ʱ�䳣�� ��Gamma Function��
% DS_STMD_GammaFun_Output_ON   ON Channel �ӳٵ������ ��Gamma Function�������뷵��������
% DS_STMD_GammaFun_Order_OFF_1   ��һ�� OFF Channel �ӳٽ��� ��Gamma Function��  
% DS_STMD_GammaFun_Tau_OFF_1     ��һ�� OFF Channel �ӳ�ʱ�䳣�� ��Gamma Function��
% DS_STMD_GammaFun_Output_OFF_1  ��һ�� OFF Channel �ӳٵ������ ��Gamma Function�� ���뷵��������
% DS_STMD_GammaFun_Order_OFF_2   �ڶ��� OFF Channel �ӳٽ��� ��Gamma Function��
% DS_STMD_GammaFun_Tau_OFF_2     �ڶ��� OFF Channel �ӳ�ʱ�䳣�� ��Gamma Function��
% DS_STMD_GammaFun_Output_OFF_2  �ڶ��� OFF Channel �ӳٵ������ ��Gamma Function�������뷵��������
% DS_STMD_Dist                   Correlation ����֮��ľ���
% DS_STMD_Directions             Correlation �ķ���Ĭ��Ϊ 8
% M,N                            ԭͼ���С
% InhibitionKernel               �����Ƶľ����

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

% ȷ������ Correlation ������
CorrelationRegion_Row = (DS_STMD_Dist+1):(M-DS_STMD_Dist);
CorrelationRegion_Col = (DS_STMD_Dist+1):(N-DS_STMD_Dist);

% DS-STMD Correlation
% ����   Left  <---   Direction = pi
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,1) = ...
                                  ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                  DelayON_Channel(CorrelationRegion_Row,CorrelationRegion_Col+DS_STMD_Dist)).*DelayOFF_Channel_2(CorrelationRegion_Row,CorrelationRegion_Col+DS_STMD_Dist);

% ����   Right  --->   Direction = 0
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,2) = ...
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row,CorrelationRegion_Col-DS_STMD_Dist)).*DelayOFF_Channel_2(CorrelationRegion_Row,CorrelationRegion_Col-DS_STMD_Dist);
                                                                 
% ����  Direction = pi/2
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,3) = ....
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row+DS_STMD_Dist,CorrelationRegion_Col)).*DelayOFF_Channel_2(CorrelationRegion_Row+DS_STMD_Dist,CorrelationRegion_Col);
                                                          
% ����  Direction = 3*pi/2
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,4) = ...
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row-DS_STMD_Dist,CorrelationRegion_Col)).*DelayOFF_Channel_2(CorrelationRegion_Row-DS_STMD_Dist,CorrelationRegion_Col);



% ����б�Խǵ� Correlation ���ʱ��Ҫ�� DS_STMD_Dist �ֽ��������
Diagonal_Dist = round(DS_STMD_Dist*cos(pi/4));

% б�Խ�  Direction = pi/4 (����)��
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,5) = ...
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row+Diagonal_Dist,CorrelationRegion_Col-Diagonal_Dist)).*DelayOFF_Channel_2(CorrelationRegion_Row+Diagonal_Dist,CorrelationRegion_Col-Diagonal_Dist);

% б�Խ�  Direction = 3*pi/4 (����)
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,6) = ...
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row+Diagonal_Dist,CorrelationRegion_Col+Diagonal_Dist)).*DelayOFF_Channel_2(CorrelationRegion_Row+Diagonal_Dist,CorrelationRegion_Col+Diagonal_Dist);                             
                             
% б�Խ�  Direction = 5*pi/4 (����)
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,7) = ...
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row-Diagonal_Dist,CorrelationRegion_Col+Diagonal_Dist)).*DelayOFF_Channel_2(CorrelationRegion_Row-Diagonal_Dist,CorrelationRegion_Col+Diagonal_Dist);                             
                             
% б�Խ�  Direction = 7*pi/4 (����)
CorrelationOutput(CorrelationRegion_Row,CorrelationRegion_Col,8) = ...
                                 ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*(DelayOFF_Channel_1(CorrelationRegion_Row,CorrelationRegion_Col)+ ...
                                 DelayON_Channel(CorrelationRegion_Row-Diagonal_Dist,CorrelationRegion_Col-Diagonal_Dist)).*DelayOFF_Channel_2(CorrelationRegion_Row-Diagonal_Dist,CorrelationRegion_Col-Diagonal_Dist);



%% Lateral Inhibition
% convn ��������ʡȥ conv2 �� for ѭ��
LateralInhibitionOutput = convn(CorrelationOutput,InhibitionKernel,'same');
% Half-wave Rectification ������ֵ
LateralInhibitionOutput = (abs(LateralInhibitionOutput)+LateralInhibitionOutput)*0.5;



end

