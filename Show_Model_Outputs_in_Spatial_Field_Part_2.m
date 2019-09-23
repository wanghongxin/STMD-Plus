
% 函数说明
% 该函数用于将 TQD ON Hand, TQD OFF Hand and DS-STMD 的输出展示在二维平面上（即往二维平面投影）
% 该函数是 Show_Model_Outputs_in_Spatial_Field.m 的后续，基本与 Show_Model_Outputs_in_Spatial_Field.m
% 相同，在部分细节上有差异


close all; clc;

%% 读取数据

% 确定展示的帧数
PresentationFrame = 150;


if ~exist('RecordedData','var')
    load('Data\Recorded-Data.mat')
    
    TQD_Correlation_Component_ON_MaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_ON;
    TQD_Correlation_Component_OFF_MaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_OFF;
    %DS_STMD_LateralInhibitionOutput_MaxOperation = RecordedData{PresentationFrame}.DS_STMD_LateralInhibitionOutput;
    DS_STMD_Outputs_After_Theta_Inhibition = RecordedData{PresentationFrame}.Outputs_After_Inhibition_Along_Theta_Axis;
    IsRecordData = 1;
else
    if IsRecordData == 1
        % 如果有记录数据的话，则直接从 RecordedData 中读取
        TQD_Correlation_Component_ON_MaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_ON;
        TQD_Correlation_Component_OFF_MaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_OFF;
        %DS_STMD_LateralInhibitionOutput_MaxOperation = RecordedData{PresentationFrame}.DS_STMD_LateralInhibitionOutput;
        DS_STMD_Outputs_After_Theta_Inhibition = RecordedData{PresentationFrame}.Outputs_After_Inhibition_Along_Theta_Axis;
        
    else
        % 如果没有记录数据的话，则直接读取最后一帧的输出
        TQD_Correlation_Component_ON_MaxOperation = TQD_Correlation_Component_ON;
        TQD_Correlation_Component_OFF_MaxOperation = TQD_Correlation_Component_OFF;
        %DS_STMD_LateralInhibitionOutput_MaxOperation = DS_STMD_LateralInhibitionOutput;
        DS_STMD_Outputs_After_Theta_Inhibition = Outputs_After_Inhibition_Along_Theta_Axis;
    end
end

% 是否输出 DS-STMD 的结果
Is_DS_STMDProjection = 0;
% 是否输出经过 Theta Direction Inhibition 的结果
Is_Theta_Inhibition_Outputs_Projection = 0;


%% Max Operation
% 将 TQD ON Hand 的输出投影到二维平面
% 是否对 Z 轴的值进行取整
IsRound = 1;
% 是否绘图
IsPlot = 0;
% 设定投影的阈值 (Z>ProjectionThreshold)
TQD_ProjectionThreshold = 1;
% 确定 TQD 输出的方向个数
TQD_Directions = size(TQD_Correlation_Component_ON_MaxOperation,3);
% 设置颜色
MarkerEdgeColors = jet(TQD_Directions);
% 输入图像的长和宽
Input_Image_M = 250;
Input_Image_N = 500;

% 将 TQD ON Hand 及 TQD OFF Hand 的输出绘制在同一 Figure 上
figure
for j = 1:(TQD_Directions)
    
    % ON
    [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(TQD_Correlation_Component_ON_MaxOperation(:,:,j),IsRound,IsPlot,TQD_ProjectionThreshold);
    ON_NUM = length(X)
    %Z = num2str(Z);
    plot(Y,Input_Image_M-X+1,'*','color',MarkerEdgeColors(j,:),'DisPlayName',strcat('ON-',num2str(j)))    
    %text(Y,X,Z)
    hold on   
    % OFF
    [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(TQD_Correlation_Component_OFF_MaxOperation(:,:,j),IsRound,IsPlot,TQD_ProjectionThreshold);
    OFF_NUM = length(X)
    %Z = num2str(Z);
    plot(Y,Input_Image_M-X+1,'o','color',MarkerEdgeColors(j,:),'DisPlayName',strcat('OFF-',num2str(j)))    
    %text(Y,X,Z)
    hold on 

end
legend('show')
axis([0,500,0,250])
grid on
title('TQD Correlation Component ON and OFF')


% 将 TQD ON Hand 及 OFF Hand 的结果分开输出

% TQD ON Hand 
figure
for j = 1:(TQD_Directions)
    
   [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(TQD_Correlation_Component_ON_MaxOperation(:,:,j),IsRound,IsPlot,TQD_ProjectionThreshold);
    ON_NUM = length(X)
    Z = num2str(Z);
    plot(Y,Input_Image_M-X+1,'*','color',MarkerEdgeColors(j,:),'DisPlayName',num2str(j))    
    hold on   

end
legend('show')
axis([0,500,0,250])
grid on
title('TQD Correlation Component ON')

% 输出 TQD ON Hand 的结果，但首先对同一像素点沿不同方向的输出取 Max
% 确定图像参数
[TQD_M,TQD_N,TQD_Directions] = size(TQD_Correlation_Component_ON_MaxOperation);
% 确定 Max Operation 的区域，MaxRegionSize = 0 表示仅沿 Z 轴方向进行 Max
TQD_MaxRegionSize = 0;
TQD_MaxThreshold_Along_Z_axis = 0;
% Max Operation Along Z axis  ON
[TQD_Correlation_Component_ON_3D_Max] = MaxOperation_3D(TQD_Correlation_Component_ON_MaxOperation,TQD_MaxRegionSize,TQD_MaxThreshold_Along_Z_axis,TQD_M,TQD_N,TQD_Directions);

figure
for j = 1:(TQD_Directions)
    
    [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(TQD_Correlation_Component_ON_3D_Max(:,:,j),IsRound,IsPlot,TQD_ProjectionThreshold);
    ON_NUM = length(X)
    plot(Y,Input_Image_M-X+1,'*','color',MarkerEdgeColors(j,:),'DisPlayName',num2str(j))
    hold on

end
legend('show')
axis([0,500,0,250])
grid on
title('TQD Correlation Component ON (Max)')


% 将 TQD OFF Hand 的输出投影到二维平面
% 设置输出格式
MarkerEdgeColors = jet(TQD_Directions);
figure
for j = 1:(TQD_Directions)
    
    [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(TQD_Correlation_Component_OFF_MaxOperation(:,:,j),IsRound,IsPlot,TQD_ProjectionThreshold);
    OFF_NUM = length(X)
    plot(Y,Input_Image_M-X+1,'o','color',MarkerEdgeColors(j,:),'DisPlayName',num2str(j))
    hold on 

end
legend('show')
axis([0,500,0,250])
grid on
title('TQD Correlation Component OFF')


% Max Operation Along Z axis 
[TQD_Correlation_Component_OFF_3D_Max] = MaxOperation_3D(TQD_Correlation_Component_OFF_MaxOperation,TQD_MaxRegionSize,TQD_MaxThreshold_Along_Z_axis,TQD_M,TQD_N,TQD_Directions);
figure
for j = 1:(TQD_Directions)
    
   [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(TQD_Correlation_Component_OFF_3D_Max(:,:,j),IsRound,IsPlot,TQD_ProjectionThreshold);
    OFF_NUM = length(X)
    plot(Y,Input_Image_M-X+1,'o','color',MarkerEdgeColors(j,:),'DisPlayName',num2str(j))
    hold on   

end
legend('show')
axis([0,500,0,250])
grid on
title('TQD Correlation Component OFF (Max)')




% ====================将 DS-STMD Output 的输出投影到二维平面===============%
if Is_DS_STMDProjection == 1
    IsRound = 1;
    IsPlot = 0;
    DS_STMD_ProjectionThreshold = 1500;
    [DS_STDM_M,DS_STMD_N,DS_STMD_Directions] = size(DS_STMD_LateralInhibitionOutput_MaxOperation);
    DS_STMD_MaxRegionSize = 1;
    % 沿 Z 轴进行 Max
    [DS_STMD_3D_Max] = MaxOperation_3D(DS_STMD_LateralInhibitionOutput_MaxOperation,DS_STDM_M,DS_STMD_N,DS_STMD_Directions);
    % 设置输出格式
    MarkerEdgeColors = jet(DS_STMD_Directions);
    
    figure
    for j = 1:(DS_STMD_Directions)
        
        [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(DS_STMD_3D_Max(:,:,j),IsRound,IsPlot,DS_STMD_ProjectionThreshold);
        
        Z = num2str(Z);
        %Str = [repmat('(',length(X),1),num2str(X),repmat(',',length(X),1),num2str(Y),repmat(')-',length(X),1),repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
        % Str = [repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
        %plot(Y,X,'d','color',MarkerEdgeColors(j,:),'DisPlayName',strcat('DS-STMD Model -',num2str(j)))
        %text(X,Y,Str)
        text(Y,X,num2str(j))
        hold on
%         plot(Y,X,'d','color','b','DisPlayName',strcat('DS-STMD Model -',num2str(j)))
%         hold on
        
        
    end
    legend('show')
    axis([0,500,0,250])
    grid on
    
    
    % 将八个分量分开画
    
    
    
    for j = 1:(DS_STMD_Directions)
        
        figure
        [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(DS_STMD_3D_Max(:,:,j),IsRound,IsPlot,DS_STMD_ProjectionThreshold);
        Z = num2str(Z);
        text(Y,X,num2str(j))
        hold on
%         plot(Y,X,'d','color','b','DisPlayName',strcat('DS-STMD Model -',num2str(j)))
%         hold on
        title(strcat('DS-STMD model Output ',num2str(j)))
        axis([0,500,0,250])
        grid on
    end


end



%======================Theta Inhibition==================================%
if Is_Theta_Inhibition_Outputs_Projection == 1
    
    [DS_STDM_M,DS_STMD_N,DS_STMD_Directions] = size(DS_STMD_LateralInhibitionOutput_MaxOperation);
    DS_STMD_MaxRegionSize = 0;
    DS_STMD_Maxthreshold_Along_Z_Axis = 0;
    Theta_Inhibition_ProjectionThreshold = 350;
    % 沿 Z 轴进行 Max
    [DS_STMD_Outputs_After_Theta_Inhibition_3D_Max] = MaxOperation_3D(DS_STMD_Outputs_After_Theta_Inhibition,DS_STMD_MaxRegionSize,DS_STMD_Maxthreshold_Along_Z_Axis,DS_STDM_M,DS_STMD_N,DS_STMD_Directions);
    
    figure
    for j = 1:(DS_STMD_Directions)
        
        [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(DS_STMD_Outputs_After_Theta_Inhibition_3D_Max(:,:,j),IsRound,IsPlot,Theta_Inhibition_ProjectionThreshold);
        
        Z = num2str(Z);
        %Str = [repmat('(',length(X),1),num2str(X),repmat(',',length(X),1),num2str(Y),repmat(')-',length(X),1),repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
        % Str = [repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
        %plot(Y,X,'d','color',MarkerEdgeColors(j,:),'DisPlayName',strcat('DS-STMD Model -',num2str(j)))
        %text(X,Y,Str)
        text(Y,X,num2str(j))
        hold on
%         plot(Y,X,'d','color','b','DisPlayName',strcat('DS-STMD Model -',num2str(j)))
%         hold on
        
        
    end
    legend('show')
    axis([0,500,0,250])
    grid on
    
    
    
    for j = 1:(DS_STMD_Directions)
        
        figure
        [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(DS_STMD_Outputs_After_Theta_Inhibition_3D_Max(:,:,j),IsRound,IsPlot,Theta_Inhibition_ProjectionThreshold);
        Z = num2str(Z);
        text(Y,X,num2str(j))
        hold on
%         plot(Y,X,'d','color','b','DisPlayName',strcat('DS-STMD Model -',num2str(j)))
%         hold on
        title(strcat('Model Output After Theta Inhibition ',num2str(j)))
        axis([0,500,0,250])
        grid on
    end

end






