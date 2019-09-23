function [XNow] = GammaFunction(X0,XPast,Tau,Order)
% References: 1. A Theory for Neural Networks with Time Delays
%  2. The Gamma Filter - A New Class of Adaptive IIR Filters With
%  Restricted Feedback

% �ú������ڼ����� Gamma �����ľ��
% ����������Ϊ��άͼ������ I(x,y,n)

% Parameter Setting
% Tau  Gamma ������ʱ�䳣��
% Order Gamma �����Ľ���
% X0 Ϊ��ʱ������ I(x,y,n)
% XPast Ϊ��һʱ���˲������ X(n-1)
% XNow Ϊ��һʱ���˲�������� X(n)


Mu = Order/Tau;

Y1 = XPast(:,:,2:(Order+1));
Y2 = XPast(:,:,1:Order);
Y3 = (1-Mu)*Y1 + Mu*Y2;

XNow(:,:,1) = X0;
XNow(:,:,2:(Order+1)) = Y3;


end

