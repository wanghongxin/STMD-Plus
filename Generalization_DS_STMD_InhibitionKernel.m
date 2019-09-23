function [DS_STMD_InhibitionKernel] = Generalization_DS_STMD_InhibitionKernel(Parameters,KernelType)

% 函数说明




%% Main Function
if KernelType == 1
    %--------------------------------------------%
    % 该函数用于生成 DS-STMD 的侧面抑制卷积核, DoG 形式
    % W(x,y) = A*[g_1(x,y)] - B[-g_1(x,y)]    % [x]   max(x,0)
    % g_1 = G_1(x,y) - e*G_2(x,y) - rho

    % 参数说明
    % KernelSize  Inhibition Kernel 的大小，一般为奇数
    % Sigma1      Gauss 函数 1 的 Sigma
    % Sigma2      Gauss 函数 2 的 Sigma
    % e           参数 e
  %----------------------------------------------%    
    KernelSize = Parameters(1);
    Sigma1 = Parameters(2);
    Sigma2 = Parameters(3);
    e = Parameters(4);
    rho = Parameters(5);
    A = Parameters(6);
    B = Parameters(7);
  
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
   DoG_Filter = Gauss1 - e*Gauss2 - rho;

   % max(x,0)  
   Positive_Component = (abs(DoG_Filter) + DoG_Filter)*0.5;
   Negative_Component = (abs(DoG_Filter) - DoG_Filter)*0.5;
   % Inhibition Kernel

   DS_STMD_InhibitionKernel = A*Positive_Component - B*Negative_Component;
   
elseif KernelType == 2
    
    KernelSize = Parameters(1);
    Sigma = Parameters(2);
    A = Parameters(3);
    B = Parameters(4);
    
    Flag = mod(KernelSize,2);
    if Flag == 0
        KernelSize = KernelSize +1;
    end

   % 确定卷积核的中心
   CenX = round(KernelSize/2);
   CenY = round(KernelSize/2);
   % 生成网格
   [X,Y] = meshgrid((-CenX:CenX),(-CenY:CenY));
   
   % 生成卷积核
    LoGFilter = 1/(pi*Sigma^4)*(1-(X.^2+Y.^2)/(2*Sigma^2)).*exp(-(X.^2+Y.^2)/(2*Sigma^2));
    
    % Normalization (正则化)
    LoGFilter = Sigma^2*LoGFilter;
    
    % max(x,0)  
   Positive_Component = (abs(LoGFilter) + LoGFilter)*0.5;
   Negative_Component = (abs(LoGFilter) - LoGFilter)*0.5;
   % Inhibition Kernel

   DS_STMD_InhibitionKernel = A*Positive_Component - B*Negative_Component;
    
    
    
    
end
   
   
   




end

