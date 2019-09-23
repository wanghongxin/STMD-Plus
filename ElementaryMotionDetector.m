function [EMD_Output,GammaFun_Output] = ElementaryMotionDetector(X0,GammaFun_Output,GammaFun_Tau,GammaFun_Order,EMD_Output,Dist,M,N)

% �ú������ڼ��� EMD correlation output

% Parameter Setting
% XO : ��ǰʱ�̸�ͨ�˲��������
% GammaFilter_Output : Time Delay �� Gamma Convolution ʵ�֣��ò���Ϊ Gamma �����ĵ������
% Dist : Distance Between Two Pixels (Elementary Motion Detector)
% M,N �� ͼ��ķֱ���
% EMD_Output : ���ڴ洢 EMD �����

[GammaFun_Output] = GammaFunction(X0,GammaFun_Output,GammaFun_Tau,GammaFun_Order);
DelaySignal = GammaFun_Output(:,:,GammaFun_Order+1);

% ȷ������ Correlation ������

CorrelationRegion_Row = (Dist+1):(M-Dist);
CorrelationRegion_Col = (Dist+1):(N-Dist);

% ������ֱ������� Correlation
EMD_Vertical_C1 = X0(CorrelationRegion_Row,CorrelationRegion_Col).*DelaySignal(CorrelationRegion_Row+Dist,CorrelationRegion_Col);
EMD_Vertical_C2 = X0(CorrelationRegion_Row+Dist,CorrelationRegion_Col).*DelaySignal(CorrelationRegion_Row,CorrelationRegion_Col);

% ����ˮƽ������� Correlation
EMD_Horizontal_C1 = X0(CorrelationRegion_Row,CorrelationRegion_Col).*DelaySignal(CorrelationRegion_Row,CorrelationRegion_Col+Dist);   % <-----    �˶����� Left
EMD_Horizontal_C2 = X0(CorrelationRegion_Row,CorrelationRegion_Col+Dist).*DelaySignal(CorrelationRegion_Row,CorrelationRegion_Col);    % ----->   �˶����� Right



% �洢 Correlation ֮��Ľ��
EMD_Output(CorrelationRegion_Row,CorrelationRegion_Col,1) = EMD_Horizontal_C1;
EMD_Output(CorrelationRegion_Row,CorrelationRegion_Col,2) = EMD_Horizontal_C2;
EMD_Output(CorrelationRegion_Row,CorrelationRegion_Col,3) = EMD_Vertical_C1;
EMD_Output(CorrelationRegion_Row,CorrelationRegion_Col,4) = EMD_Vertical_C2;



end

