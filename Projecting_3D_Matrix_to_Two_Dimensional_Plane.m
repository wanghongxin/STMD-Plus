function [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(InputSignal,IsRound,IsPlot,Threshold)

% 函数说明
% 该函数用于将三维矩阵投射到二维平面上

% 参数说明
% InputSignal     输入的三维矩阵
% IsRound         是否对 Z 轴取整
% IsPlot          是否绘图
% Threshold       对 Z 轴设定一个阈值，只将大于阈值的点投影到二维平面

%% Main Function

% 寻找非零元
[X,Y,Z] = find(InputSignal);

% 寻找大于 Threshold 的点
Index = Z>Threshold;

X = X(Index);
Y = Y(Index);
Z = Z(Index);

% 对 Z 取整
if IsRound == 1
    % 对 Z 取整
    Z = round(Z);
end

% 绘图
if IsPlot == 1
    % 将数值转化为字符串
    Z = num2str(Z);
    figure
    plot(X,Y,'r*')
    %text(X,Y,cellstr(Z))
    text(X,Y,Z)
    axis([0,250,0,500])
    grid on
end


end

