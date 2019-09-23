
% ����˵��
% �ú������ڽ� TQD ON Hand, TQD OFF Hand and DS-STMD �����չʾ�ڶ�άƽ���ϣ�������άƽ��ͶӰ��

close all; clc;
%
%% ��������
% ���� Max Operation ������


if ~exist('RecordedData','var')
    
    clear all; close all; clc;
        
    File_Max = 'D:\Matlab\2016-10-01-Small-Field-System\Data\Recorded-Data-NoMaxOperation';
    load(File_Max)
%     File_NoMax = 'D:\Matlab\2016-10-01-Small-Field-System\Results\9. Max Operation\Reset\No Max\TV-250-BV-250-SFrame-200-EFrame-400-Dist-3\Recorded-Data-NoMax.mat';
%     load(File_NoMax)

%     TQD_Correlation_Component_ON_MaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_ON;
%     TQD_Correlation_Component_OFF_MaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_OFF;
    %DS_STMD_LateralInhibitionOutput_MaxOperation = RecordedData{PresentationFrame}.DS_STMD_LateralInhibitionOutput;

    % TQD_Correlation_Component_ON_NoMaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_ON;
    % TQD_Correlation_Component_OFF_NoMaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_OFF;
    % DS_STMD_LateralInhibitionOutput_NoMaxOperation = RecordedData{PresentationFrame}.DS_STMD_LateralInhibitionOutput;
    
end    

PresentationFrame = 50;

TQD_Correlation_Component_ON_MaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_ON;
TQD_Correlation_Component_OFF_MaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_OFF;
DS_STMD_LateralInhibitionOutput_MaxOperation = RecordedData{PresentationFrame}.DS_STMD_LateralInhibitionOutput;

%% Max Operation
% �� TQD ON Hand �����ͶӰ����άƽ��
IsRound = 1;
IsPlot = 0;
TQD_ProjectionThreshold = 1;
TQD_Directions = size(TQD_Correlation_Component_ON_MaxOperation,3);
% ���������ʽ
MarkerEdgeColors = jet(TQD_Directions);
DirectionMark = ['L','R','U','D'];

figure
for j = 1:(TQD_Directions)
    
   [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(TQD_Correlation_Component_ON_MaxOperation(:,:,j),IsRound,IsPlot,TQD_ProjectionThreshold);
    ON_NUM = length(X)
    Z = num2str(Z);
    %Str = [repmat('(',length(X),1),num2str(X),repmat(',',length(X),1),num2str(Y),repmat(')-',length(X),1),repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
    %Str = [repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
    plot(Y,X,'*','color',MarkerEdgeColors(j,:),'DisPlayName',num2str(j))    
    
    %text(X,Y,Str)
    %text(Y,X,Z)
    hold on   

end
legend('show')
axis([0,500,0,250])
grid on
title('TQD Correlation Component ON')


% �� TQD OFF Hand �����ͶӰ����άƽ��
IsRound = 1;
IsPlot = 0;

TQD_Directions = size(TQD_Correlation_Component_OFF_MaxOperation,3);
% ���������ʽ
MarkerEdgeColors = jet(TQD_Directions);

% figure
for j = 1:(TQD_Directions)
    
    [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(TQD_Correlation_Component_OFF_MaxOperation(:,:,j),IsRound,IsPlot,TQD_ProjectionThreshold);
    OFF_NUM = length(X)
    Z = num2str(Z);
    %Str = [repmat('(',length(X),1),num2str(X),repmat(',',length(X),1),num2str(Y),repmat(')-',length(X),1),repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
    % Str = [repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
    plot(Y,X,'o','color',MarkerEdgeColors(j,:),'DisPlayName',num2str(j))    
    %text(X,Y,Str)
    %text(Y,X,Z)
    hold on 

end
legend('show')
axis([0,500,0,250])
grid on

title('TQD Correlation Component OFF')


% �� DS-STMD Output �����ͶӰ����άƽ��
IsRound = 1;
IsPlot = 0;
DS_STMD_ProjectionThreshold = 1000;
DS_STMD_Directions = size(DS_STMD_LateralInhibitionOutput_MaxOperation,3);
% ���������ʽ
MarkerEdgeColors = jet(DS_STMD_Directions);


for j = 1:(DS_STMD_Directions)
    figure
   [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(DS_STMD_LateralInhibitionOutput_MaxOperation(:,:,j),IsRound,IsPlot,DS_STMD_ProjectionThreshold);
   
    Z = num2str(Z);
    %Str = [repmat('(',length(X),1),num2str(X),repmat(',',length(X),1),num2str(Y),repmat(')-',length(X),1),repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
    % Str = [repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
    plot(Y,X,'s','color',MarkerEdgeColors(j,:),'DisPlayName',num2str(j))    
    %text(X,Y,Str)
    %text(X,Y,Z)
    legend('show')
    axis([0,500,0,250])
    grid on   

end

% title('DS-STMD Model Outputs')

% %%   No Max Operation
% % �� TQD ON Hand �����ͶӰ����άƽ��
% IsRound = 1;
% IsPlot = 0;
% ProjectionThreshold = 5000;
% TQD_Directions = size(TQD_Correlation_Component_ON_NoMaxOperation,3);
% % ���������ʽ
% MarkerEdgeColors = jet(TQD_Directions);
% DirectionMark = ['L','R','U','D'];
% 
% figure
% for j = 1:(TQD_Directions)
%     
%    [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(TQD_Correlation_Component_ON_NoMaxOperation(:,:,j),IsRound,IsPlot,ProjectionThreshold);
%    
%     Z = num2str(Z);
%     %Str = [repmat('(',length(X),1),num2str(X),repmat(',',length(X),1),num2str(Y),repmat(')-',length(X),1),repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
%     Str = [repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
%     plot(Y,X,'*','color',MarkerEdgeColors(j,:),'DisPlayName',DirectionMark(j))    
%     
%     %text(X,Y,Str)
%     %text(X,Y,Z)
%     hold on   
% end
% legend('show')
% axis([0,500,0,250])
% grid on
% title('TQD Correlation Component ON')
% 
% 
% % �� TQD OFF Hand �����ͶӰ����άƽ��
% IsRound = 1;
% IsPlot = 0;
% ProjectionThreshold = 5000;
% TQD_Directions = size(TQD_Correlation_Component_OFF_NoMaxOperation,3);
% % ���������ʽ
% MarkerEdgeColors = jet(TQD_Directions);
% DirectionMark = ['L','R','U','D'];
% 
% figure
% for j = 1:(TQD_Directions)
%     
%    [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(TQD_Correlation_Component_OFF_NoMaxOperation(:,:,j),IsRound,IsPlot,ProjectionThreshold);
%    
%     Z = num2str(Z);
%     %Str = [repmat('(',length(X),1),num2str(X),repmat(',',length(X),1),num2str(Y),repmat(')-',length(X),1),repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
%     % Str = [repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
%     plot(Y,X,'*','color',MarkerEdgeColors(j,:),'DisPlayName',DirectionMark(j))    
%     %text(X,Y,Str)
%     %text(X,Y,Z)
%     hold on   
% end
% legend('show')
% axis([0,500,0,250])
% grid on
% title('TQD Correlation Component OFF')
% 
% 
% % �� DS-STMD Output �����ͶӰ����άƽ��
% IsRound = 1;
% IsPlot = 0;
% ProjectionThreshold = 1e4;
% DS_STMD_Directions = size(DS_STMD_LateralInhibitionOutput_NoMaxOperation,3);
% % ���������ʽ
% MarkerEdgeColors = jet(DS_STMD_Directions);
% DirectionMark = ['L','R','U','D','RU','LR','LD','RD'];
% 
% figure
% for j = 1:(DS_STMD_Directions)
%     
%    [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(DS_STMD_LateralInhibitionOutput_NoMaxOperation(:,:,j),IsRound,IsPlot,ProjectionThreshold);
%    
%     Z = num2str(Z);
%     %Str = [repmat('(',length(X),1),num2str(X),repmat(',',length(X),1),num2str(Y),repmat(')-',length(X),1),repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
%     % Str = [repmat(DirectionMark(j),length(X),1),repmat('-',length(X),1),Z];
%     plot(Y,X,'*','color',MarkerEdgeColors(j,:),'DisPlayName',DirectionMark(j))    
%     %text(X,Y,Str)
%     %text(X,Y,Z)
%     hold on   
% end
% legend('show')
% axis([0,500,0,250])
% grid on
% title('DS-STMD Model Outputs')
% 
% 
% 
