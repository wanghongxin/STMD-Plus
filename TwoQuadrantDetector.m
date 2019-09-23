function [TQD_Output,TQD_Correlation_Component_ON,TQD_Correlation_Component_OFF,GammaFun_Output_ON,GammaFun_Output_OFF] = TwoQuadrantDetector(ON_Channel,OFF_Channel,GammaFun_Output_ON,GammaFun_Output_OFF,GammaFun_Tau,GammaFun_Order,TQD_Output,Dist,Directions,M,N)

% �ú������ڼ��� Two Quadrant Motion Detector �� correlation output

% Parameter Setting
% ON_Channel : ��ǰʱ�� ON ͨ��������
% OFF_Channel ����ǰʱ�� OFF ͨ��������
% GammaFun_Output_ON : Time Delay �� Gamma Convolution ʵ�֣��ò���Ϊ ON Channel �� Gamma �����ĵ������
% GammaFun_Output_OFF : Time Delay �� Gamma Convolution ʵ�֣��ò���Ϊ OFF Channel �� Gamma �����ĵ������
% Dist : Distance Between Two Pixels (Elementary Motion Detector)
% M,N �� ͼ��ķֱ���
% TQD_Output : ���ڴ洢 TQD �����

% ON Channel Delay
[GammaFun_Output_ON] = GammaFunction(ON_Channel,GammaFun_Output_ON,GammaFun_Tau,GammaFun_Order);
DelayON_Channel = GammaFun_Output_ON(:,:,GammaFun_Order+1);
% OFF Channel Delay
[GammaFun_Output_OFF] = GammaFunction(OFF_Channel,GammaFun_Output_OFF,GammaFun_Tau,GammaFun_Order);
DelayOFF_Channel = GammaFun_Output_OFF(:,:,GammaFun_Order+1);


% ȷ������ Correlation ������

CorrelationRegion_Row = (Dist+1):(M-Dist);
CorrelationRegion_Col = (Dist+1):(N-Dist);

% ������ֱ������� Correlation
% ON Channel
TQD_ON_Vertical_C1 = ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayON_Channel(CorrelationRegion_Row+Dist,CorrelationRegion_Col);    % ����
TQD_ON_Vertical_C2 = ON_Channel(CorrelationRegion_Row+Dist,CorrelationRegion_Col).*DelayON_Channel(CorrelationRegion_Row,CorrelationRegion_Col);    % ����
% OFF Channel
TQD_OFF_Vertical_C1 = OFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayOFF_Channel(CorrelationRegion_Row+Dist,CorrelationRegion_Col);    % ����
TQD_OFF_Vertical_C2 = OFF_Channel(CorrelationRegion_Row+Dist,CorrelationRegion_Col).*DelayOFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col);    % ����

% ����ˮƽ������� Correlation
% ON Channel
TQD_ON_Horizontal_C1 = ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayON_Channel(CorrelationRegion_Row,CorrelationRegion_Col+Dist);         % ����  <-----
TQD_ON_Horizontal_C2 = ON_Channel(CorrelationRegion_Row,CorrelationRegion_Col+Dist).*DelayON_Channel(CorrelationRegion_Row,CorrelationRegion_Col);          % ����  ------>
% OFF Channel
TQD_OFF_Horizontal_C1 = OFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col).*DelayOFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col+Dist);         % ����  <-----
TQD_OFF_Horizontal_C2 = OFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col+Dist).*DelayOFF_Channel(CorrelationRegion_Row,CorrelationRegion_Col);          % ����  ------>


% �洢 Correlation ֮��Ľ��
TQD_Output(CorrelationRegion_Row,CorrelationRegion_Col,1) = (TQD_ON_Horizontal_C1 - TQD_ON_Horizontal_C2) + (TQD_OFF_Horizontal_C1 - TQD_OFF_Horizontal_C2); % ����Ϊ������
TQD_Output(CorrelationRegion_Row,CorrelationRegion_Col,2) = (TQD_ON_Vertical_C1 - TQD_ON_Vertical_C2) + (TQD_OFF_Vertical_C1 - TQD_OFF_Vertical_C2); % ����Ϊ������
% �洢��������ķ���
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

