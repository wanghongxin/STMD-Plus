function [InhibitionKernel] = Generalization_InhibitionKernel_Along_Theta_Axis(DS_STMD_Directions)


% 函数说明
% 该函数用于生成沿着 Theta 方向的侧抑制核
% 我们在这里采用一维 DoG 作为侧抑制核函数


KernelSize = DS_STMD_Directions;
Sigma1 = 1.50;
Sigma2 = 3.00;


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
InhibitionKernel = Gauss1 - Gauss2;

InhibitionKernel = InhibitionKernel(1:DS_STMD_Directions);



end

