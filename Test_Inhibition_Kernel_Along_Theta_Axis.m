% 2016-11-02

% 函数说明
% 该函数用于测试沿 Theta 方向的侧抑制核
% 该侧抑制主要作用于 DS-STMD 的输出（Size Inhibition 之后），用于控制方向的协调

% 我们采用一维的 DoG 作为侧抑制核

%% Main Function
close all; clear all;

KernelSize = 15;
Sigma1 = 1.50;
Sigma2 = 3.00;
e = 1.0;


% 将卷积核大小设置为奇数
Flag = mod(KernelSize,2);
if Flag == 0
    KernelSize = KernelSize +1;
end

Half_X = floor(KernelSize/2);
X = -Half_X:Half_X;



% 生成 Gauss 函数 1 和 2
Gauss1 = (1/(sqrt(2*pi)*Sigma1))*exp(-(X.^2)/(2*Sigma1^2));
Gauss2 = (1/(sqrt(2*pi)*Sigma2))*exp(-(X.^2)/(2*Sigma2^2));

% 生成 DoG, 两高斯函数相减
DoG_Filter = Gauss1 - e*Gauss2;

% 绘图
figure
plot(X,DoG_Filter)
grid on


