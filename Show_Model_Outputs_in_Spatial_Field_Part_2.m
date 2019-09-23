
% ����˵��
% �ú������ڽ� TQD ON Hand, TQD OFF Hand and DS-STMD �����չʾ�ڶ�άƽ���ϣ�������άƽ��ͶӰ��
% �ú����� Show_Model_Outputs_in_Spatial_Field.m �ĺ����������� Show_Model_Outputs_in_Spatial_Field.m
% ��ͬ���ڲ���ϸ�����в���


close all; clc;

%% ��ȡ����

% ȷ��չʾ��֡��
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
        % ����м�¼���ݵĻ�����ֱ�Ӵ� RecordedData �ж�ȡ
        TQD_Correlation_Component_ON_MaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_ON;
        TQD_Correlation_Component_OFF_MaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_OFF;
        %DS_STMD_LateralInhibitionOutput_MaxOperation = RecordedData{PresentationFrame}.DS_STMD_LateralInhibitionOutput;
        DS_STMD_Outputs_After_Theta_Inhibition = RecordedData{PresentationFrame}.Outputs_After_Inhibition_Along_Theta_Axis;
        
    else
        % ���û�м�¼���ݵĻ�����ֱ�Ӷ�ȡ���һ֡�����
        TQD_Correlation_Component_ON_MaxOperation = TQD_Correlation_Component_ON;
        TQD_Correlation_Component_OFF_MaxOperation = TQD_Correlation_Component_OFF;
        %DS_STMD_LateralInhibitionOutput_MaxOperation = DS_STMD_LateralInhibitionOutput;
        DS_STMD_Outputs_After_Theta_Inhibition = Outputs_After_Inhibition_Along_Theta_Axis;
    end
end

% �Ƿ���� DS-STMD �Ľ��
Is_DS_STMDProjection = 0;
% �Ƿ�������� Theta Direction Inhibition �Ľ��
Is_Theta_Inhibition_Outputs_Projection = 0;


%% Max Operation
% �� TQD ON Hand �����ͶӰ����άƽ��
% �Ƿ�� Z ���ֵ����ȡ��
IsRound = 1;
% �Ƿ��ͼ
IsPlot = 0;
% �趨ͶӰ����ֵ (Z>ProjectionThreshold)
TQD_ProjectionThreshold = 1;
% ȷ�� TQD ����ķ������
TQD_Directions = size(TQD_Correlation_Component_ON_MaxOperation,3);
% ������ɫ
MarkerEdgeColors = jet(TQD_Directions);
% ����ͼ��ĳ��Ϳ�
Input_Image_M = 250;
Input_Image_N = 500;

% �� TQD ON Hand �� TQD OFF Hand �����������ͬһ Figure ��
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


% �� TQD ON Hand �� OFF Hand �Ľ���ֿ����

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

% ��� TQD ON Hand �Ľ���������ȶ�ͬһ���ص��ز�ͬ��������ȡ Max
% ȷ��ͼ�����
[TQD_M,TQD_N,TQD_Directions] = size(TQD_Correlation_Component_ON_MaxOperation);
% ȷ�� Max Operation ������MaxRegionSize = 0 ��ʾ���� Z �᷽����� Max
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


% �� TQD OFF Hand �����ͶӰ����άƽ��
% ���������ʽ
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




% ====================�� DS-STMD Output �����ͶӰ����άƽ��===============%
if Is_DS_STMDProjection == 1
    IsRound = 1;
    IsPlot = 0;
    DS_STMD_ProjectionThreshold = 1500;
    [DS_STDM_M,DS_STMD_N,DS_STMD_Directions] = size(DS_STMD_LateralInhibitionOutput_MaxOperation);
    DS_STMD_MaxRegionSize = 1;
    % �� Z ����� Max
    [DS_STMD_3D_Max] = MaxOperation_3D(DS_STMD_LateralInhibitionOutput_MaxOperation,DS_STDM_M,DS_STMD_N,DS_STMD_Directions);
    % ���������ʽ
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
    
    
    % ���˸������ֿ���
    
    
    
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
    % �� Z ����� Max
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






