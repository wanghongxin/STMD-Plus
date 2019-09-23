
% ����˵��
% �ú������ڻ��� Gamma Function �� Difference of Gamma Functions �Ķ�άͼ��


clear all; close all; clc;
%% Main Function
T = 30;               % ʱ�䷶Χ
DelatT = 0.1;          % ʱ����
t = 0:DelatT:T;

% Gamma Function 1
GammaFun_1_Order = 2;          
GammaFun_1_Tau = 3;
% Gamma Function 2
GammaFun_2_Order = 6;
GammaFun_2_Tau = 9;
% Difference of Gamma Function
GammaFun_1 = ((GammaFun_1_Order*t).^GammaFun_1_Order).*(exp(-GammaFun_1_Order*t/GammaFun_1_Tau)/(factorial(GammaFun_1_Order-1)*GammaFun_1_Tau^(GammaFun_1_Order+1)));
GammaFun_2 = ((GammaFun_2_Order*t).^GammaFun_2_Order).*(exp(-GammaFun_2_Order*t/GammaFun_2_Tau)/(factorial(GammaFun_2_Order-1)*GammaFun_2_Tau^(GammaFun_2_Order+1)));
figure
plot(t,GammaFun_1-GammaFun_2,'b','linewidth',3)
axis([0,30,-0.1,0.2])
%title(strcat('Gamma 1','-Order-',num2str(GammaFun_1_Order),'-Tau-',num2str(GammaFun_1_Tau),'- Gamma 2','-Order-',num2str(GammaFun_2_Order),'-Tau-',num2str(GammaFun_2_Tau)))

% % Single Gamma Function
GammaFun_3_Order = 6;
GammaFun_3_Tau = 9;

GammaFun_3 = ((GammaFun_3_Order*t).^GammaFun_3_Order).*(exp(-GammaFun_3_Order*t/GammaFun_3_Tau)/(factorial(GammaFun_3_Order-1)*GammaFun_3_Tau^(GammaFun_3_Order+1)));

figure
plot(t,GammaFun_3,'b','linewidth',3)
axis([0,30,0,0.12])
%title(strcat('Gamma ','-Order-',num2str(GammaFun_3_Order),'-Tau-',num2str(GammaFun_3_Tau)))



