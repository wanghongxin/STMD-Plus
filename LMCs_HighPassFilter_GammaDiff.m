function [LMCs_HighPassFilter_Output,GammaFun1_Output,GammaFun2_Output] = LMCs_HighPassFilter_GammaDiff(X0,GammaFun1_Output,GammaFun1_Tau,GammaFun1_Order,GammaFun2_Output,GammaFun2_Tau,GammaFun2_Order)

% 该函数用于计算高通滤波器的输出
% High Pass Filter = Gamma Function 1 - Gamma Function 2


% Parameter Setting

% X0 输入的图像 I(x,y,n)
% GammaFun1_Tau  Gamma 函数 1 的时间常数
% GammaFun1_Order Gamma 函数 1 的阶数
% GammaFun1_Output  Gamma 函数 1 的输出

GammaFun1_Output = GammaFunction(X0,GammaFun1_Output,GammaFun1_Tau,GammaFun1_Order);
GammaFun2_Output = GammaFunction(X0,GammaFun2_Output,GammaFun2_Tau,GammaFun2_Order);

LMCs_HighPassFilter_Output = GammaFun1_Output(:,:,GammaFun1_Order+1) - GammaFun2_Output(:,:,GammaFun2_Order+1);

end

