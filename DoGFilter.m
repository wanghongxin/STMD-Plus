function [ DoG_Filter ] = DoGFilter(KernelSize,Sigma1,Sigma2)

% ����˵��
% �ú�����Ҫ�������� Difference of Gaussians �����
% W(x,y) = G_1(x,y) - G_2(x,y)

% ����˵��
% KernelSize  Inhibition Kernel �Ĵ�С��һ��Ϊ����
% Sigma1      Gauss ���� 1 �� Sigma
% Sigma2      Gauss ���� 2 �� Sigma

%% Main Function

% ������˴�С����Ϊ����
Flag = mod(KernelSize,2);
   
if Flag == 0
    KernelSize = KernelSize +1;
end

% ȷ������˵�����
CenX = round(KernelSize/2);
CenY = round(KernelSize/2);
% ��������
[X,Y] = meshgrid(1:KernelSize,1:KernelSize);
% ����ƽ��
ShiftX = X-CenX;
ShiftY = Y-CenY;

% ���� Gauss ���� 1 �� 2
Gauss1 = (1/(2*pi*Sigma1^2))*exp(-(ShiftX.*ShiftX + ShiftY.*ShiftY)/(2*Sigma1^2));
Gauss2 = (1/(2*pi*Sigma2^2))*exp(-(ShiftX.*ShiftX + ShiftY.*ShiftY)/(2*Sigma2^2));

% ���� DoG, ����˹�������
DoG_Filter = Gauss1 - Gauss2;

   

end

