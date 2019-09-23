function [RecordedData] = Extract_Data_Along_A_Line(I,StartPoint,EndPoint,IsPlot)

% 函数说明
% 该函数用于沿着一条确定的直线提取 Input Image (I) 在该直线上的所有值
% 例如：
% 该条直线的起点为 （X_s,Y_s）,终点为 （X_e,Y_e）且 X_s = X_e 或者 Y_s = Y_e
% Data = I(X_s,Y_s:Y:e) 或者 Data = I(X_s:X_e,Y_s)

% 参数说明
% StartPoint = [X_s,Y_s]   直线的起点
% EndPoint = [X_e,Y_e]     直线的终点
% I                        输入信号 默认大小为 M*N*1

%% Main Function

if StartPoint(1) == EndPoint(1)
    
    RecordedData = I(StartPoint(1),StartPoint(2):EndPoint(2));
    if IsPlot == 1
        figure
        plot(StartPoint(2):EndPoint(2),RecordedData)
        title(strcat('Y = ',num2str(StartPoint(1)),'  X = ',num2str(StartPoint(2)),'-',num2str(EndPoint(2))))
        grid on
    end
    
    
elseif StartPoint(2) == EndPoint(2)
    
    RecordedData = I(StartPoint(1):EndPoint(1),StartPoint(2));
    if IsPlot == 1
        figure
        plot(StartPoint(2):EndPoint(2),RecordedData)
        title(strcat('Y = ',num2str(StartPoint(1)),'-',num2str(EndPoint(1)),'   X = ',num2str(StartPoint(2))))
        grid on
    end

end



















end

