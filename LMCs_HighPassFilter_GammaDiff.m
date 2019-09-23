function [LMCs_HighPassFilter_Output,GammaFun1_Output,GammaFun2_Output] = LMCs_HighPassFilter_GammaDiff(X0,GammaFun1_Output,GammaFun1_Tau,GammaFun1_Order,GammaFun2_Output,GammaFun2_Tau,GammaFun2_Order)

% �ú������ڼ����ͨ�˲��������
% High Pass Filter = Gamma Function 1 - Gamma Function 2


% Parameter Setting

% X0 �����ͼ�� I(x,y,n)
% GammaFun1_Tau  Gamma ���� 1 ��ʱ�䳣��
% GammaFun1_Order Gamma ���� 1 �Ľ���
% GammaFun1_Output  Gamma ���� 1 �����

GammaFun1_Output = GammaFunction(X0,GammaFun1_Output,GammaFun1_Tau,GammaFun1_Order);
GammaFun2_Output = GammaFunction(X0,GammaFun2_Output,GammaFun2_Tau,GammaFun2_Order);

LMCs_HighPassFilter_Output = GammaFun1_Output(:,:,GammaFun1_Order+1) - GammaFun2_Output(:,:,GammaFun2_Order+1);

end

