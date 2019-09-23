function [LoGFilter] = LoGFilter(KernelSize,Sigma)

% 该函数用于生成 LoG 抑制卷积核

% 将卷积核大小设置为奇数
Flag = mod(KernelSize,2);
if Flag == 0
    KernelSize = KernelSize +1;
end

% 确定卷积核的中心
CenX = round(KernelSize/2);
CenY = round(KernelSize/2);
% 生成网格

[X,Y] = meshgrid((-CenX:CenX),(-CenY:CenY));

% 生成卷积核 （此处没有正则化）
LoGFilter = 1/(pi*Sigma^4)*(1-(X.^2+Y.^2)/(2*Sigma^2)).*exp(-(X.^2+Y.^2)/(2*Sigma^2));





