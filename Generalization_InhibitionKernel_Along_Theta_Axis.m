function [InhibitionKernel] = Generalization_InhibitionKernel_Along_Theta_Axis(DS_STMD_Directions)


% ����˵��
% �ú��������������� Theta ����Ĳ����ƺ�
% �������������һά DoG ��Ϊ�����ƺ˺���


KernelSize = DS_STMD_Directions;
Sigma1 = 1.50;
Sigma2 = 3.00;


% ������˴�С����Ϊ����
Flag = mod(KernelSize,2);
if Flag == 0
    KernelSize = KernelSize +1;
end

Half_X = floor(KernelSize/2);
X = -Half_X:Half_X;

% ���� Gauss ���� 1 �� 2
Gauss1 = (1/(sqrt(2*pi)*Sigma1))*exp(-(X.^2)/(2*Sigma1^2));
Gauss2 = (1/(sqrt(2*pi)*Sigma2))*exp(-(X.^2)/(2*Sigma2^2));

% ���� DoG, ����˹�������
InhibitionKernel = Gauss1 - Gauss2;

InhibitionKernel = InhibitionKernel(1:DS_STMD_Directions);



end

