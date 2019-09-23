function [CurrentY,PastY,PastX] = Exponential_1st_Order_LowPassFilter(CurrentX,PastX,PastY,Alpha,T,IsNormalized)

%% 函数说明
% 该函数用于计算指数型一阶低通滤波器的输出（Y）
% h(t) = (1/a)*exp(-t/a) or exp(-t/a)

% IsNormalized    若为 1，则 h(t) = (1/a)*exp(-t/a)
%                 若为 0，则 h(t) = exp(-t/a)
% CurrentX        当前滤波器的输入信号  X[n]
% PastX           滤波器之前的输入信号  X[n-1]
% CurrentY        当前滤波器的输出信号  Y[n]
% PastY           滤波器之前的输出信号  Y[n-1]
% Alpha               指数函数常数
% T               采样频率，默认值为 1


%% Main Function

c = 2/T;

% 迭代
if IsNormalized == 1
    A = 1/(1+Alpha*c);
    B = (1-Alpha*c)/(1+Alpha*c);
    CurrentY = A*CurrentX + A*PastX - B*PastY;
    
elseif IsNormalized == 0
    A = Alpha/(1+Alpha*c);
    B = (1-Alpha*c)/(1+Alpha*c);
    CurrentY = A*CurrentX + A*PastX - B*PastY;
end
% 更新
PastX = CurrentX;
PastY = CurrentY;



end

