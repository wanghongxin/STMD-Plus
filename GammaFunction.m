function [XNow] = GammaFunction(X0,XPast,Tau,Order)
% References: 1. A Theory for Neural Networks with Time Delays
%  2. The Gamma Filter - A New Class of Adaptive IIR Filters With
%  Restricted Feedback

% 该函数用于计算与 Gamma 函数的卷积
% 适用于输入为二维图像的情况 I(x,y,n)

% Parameter Setting
% Tau  Gamma 函数的时间常数
% Order Gamma 函数的阶数
% X0 为此时的输入 I(x,y,n)
% XPast 为上一时刻滤波器输出 X(n-1)
% XNow 为这一时刻滤波器的输出 X(n)


Mu = Order/Tau;

Y1 = XPast(:,:,2:(Order+1));
Y2 = XPast(:,:,1:Order);
Y3 = (1-Mu)*Y1 + Mu*Y2;

XNow(:,:,1) = X0;
XNow(:,:,2:(Order+1)) = Y3;


end

