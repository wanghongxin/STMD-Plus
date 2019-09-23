function [ Filters ] = Generalize_T1_Neuron_Kernels(Sigma,Alpha,Theta,FilterSize)



% Ref: Construction and Evaluation of an Integrated Dynamical Model of
% Visual Motion Perception

% 函数说明
% 该函数用于生成 Ref 中 Eq.(2) 的空间滤波器
% 即：
% Filter  = G(x-a*cos,y-a*sin)-G(x+a*cos,y+a*sin)
% 也即本文所提及的 T1 神经元的卷积核

% 参数说明
% FilterSize        滤波器大小
% Alpha             Eq.2 中高斯函数中心与滤波器中心的距离
% Theta             滤波器的偏转角度，默认为角度， 如 0,45,90,135,180...
% Sigma             高斯函数的 Sigma 

% 对于大小为 5*5 的物体， 
% FilterSize = 11
% Sigma = 1.5
% Alpha = 3
% Theta = [0 45 90 135 180 225 270 315]

%% Main Function

% 若滤波器大小为偶数，则强制设置为奇数
if mod(FilterSize,2) == 0
    FilterSize = FilterSize + 1;
end
% 角度转化为弧度
Theta = Theta*pi/180;

% 确定滤波器的个数
FilterNum = length(Theta);

% 用于存储生成的滤波器
Filters = zeros(FilterSize,FilterSize,FilterNum);

% 
[Y,X] = meshgrid(-floor(FilterSize/2):floor(FilterSize/2),-floor(FilterSize/2):floor(FilterSize/2));

for k = 1:FilterNum
    
    % 确定两个高斯函数的中心
    X1 = X - Alpha*cos(Theta(k));
    Y1 = Y - Alpha*sin(Theta(k));
    X2 = X + Alpha*cos(Theta(k));
    Y2 = Y + Alpha*sin(Theta(k));
    
    % 生成两个高斯函数
    Gauss1 = (1/(2*pi*Sigma^2))*(exp(-(X1.^2+Y1.^2)./(2*Sigma^2)));
    Gauss2 = (1/(2*pi*Sigma^2))*(exp(-(X2.^2+Y2.^2)./(2*Sigma^2)));
    
    % Filter = Gauss1 - Gauss2;
    Filters(:,:,k) = Gauss1 - Gauss2;
    
end



end

