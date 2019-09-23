% 2016-11-02

% ����˵��
% �ú������ڲ����� Theta ����Ĳ����ƺ�
% �ò�������Ҫ������ DS-STMD �������Size Inhibition ֮�󣩣����ڿ��Ʒ����Э��

% ���ǲ���һά�� DoG ��Ϊ�����ƺ�

%% Main Function
close all; clear all;

KernelSize = 15;
Sigma1 = 1.50;
Sigma2 = 3.00;
e = 1.0;


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
DoG_Filter = Gauss1 - e*Gauss2;

% ��ͼ
figure
plot(X,DoG_Filter)
grid on


