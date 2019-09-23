function [ DoG_Filter ] = DoGFilter(KernelSize,Sigma1,Sigma2)

% 函数说明
% 该函数主要用于生成 Difference of Gaussians 卷积核
% W(x,y) = G_1(x,y) - G_2(x,y)

% 参数说明
% KernelSize  Inhibition Kernel 的大小，一般为奇数
% Sigma1      Gauss 函数 1 的 Sigma
% Sigma2      Gauss 函数 2 的 Sigma

%% Main Function

% 将卷积核大小设置为奇数
Flag = mod(KernelSize,2);
   
if Flag == 0
    KernelSize = KernelSize +1;
end

% 确定卷积核的中心
CenX = round(KernelSize/2);
CenY = round(KernelSize/2);
% 生成网格
[X,Y] = meshgrid(1:KernelSize,1:KernelSize);
% 网格平移
ShiftX = X-CenX;
ShiftY = Y-CenY;

% 生成 Gauss 函数 1 和 2
Gauss1 = (1/(2*pi*Sigma1^2))*exp(-(ShiftX.*ShiftX + ShiftY.*ShiftY)/(2*Sigma1^2));
Gauss2 = (1/(2*pi*Sigma2^2))*exp(-(ShiftX.*ShiftX + ShiftY.*ShiftY)/(2*Sigma2^2));

% 生成 DoG, 两高斯函数相减
DoG_Filter = Gauss1 - Gauss2;

   

end

