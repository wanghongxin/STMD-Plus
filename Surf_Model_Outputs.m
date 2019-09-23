
% 函数说明
% 该函数用于将 TQD ON Hand, TQD OFF Hand and DS-STMD 的输出展示在三维平面上（即 Surf）
close all;
%% 导入数据
% 导入 Max Operation 的数据

if IsRecordData == 1
    
    PresentationFrame = 200;
    
    TQD_Correlation_Component_ON_MaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_ON;
    TQD_Correlation_Component_OFF_MaxOperation = RecordedData{PresentationFrame}.TQD_Correlation_Component_OFF;
    DS_STMD_LateralInhibitionOutput_MaxOperation = RecordedData{PresentationFrame}.DS_STMD_LateralInhibitionOutput;
    DS_STMD_Outputs_After_Theta_Inhibition = RecordedData{PresentationFrame}.Outputs_After_Inhibition_Along_Theta_Axis;
else
    
    TQD_Correlation_Component_ON_MaxOperation = TQD_Correlation_Component_ON;
    TQD_Correlation_Component_OFF_MaxOperation = TQD_Correlation_Component_OFF;
    DS_STMD_LateralInhibitionOutput_MaxOperation = DS_STMD_LateralInhibitionOutput;
    DS_STMD_Outputs_After_Theta_Inhibition = Outputs_After_Inhibition_Along_Theta_Axis;
end
PresentationFrame = 51;


%% 
TQD_Directions = size(TQD_Correlation_Component_ON_MaxOperation,3);
%DS_STMD_Directions = size(DS_STMD_LateralInhibitionOutput_MaxOperation,3);

TQD_DirectionMark = ['L','R','U','D'];
DS_STMD_DirectionMark = ['L','R','U','D','RU','LR','LD','RD'];
% (Max Operation)
for j = 1:TQD_Directions
    figure
    surf(TQD_Correlation_Component_ON_MaxOperation(:,:,j)')
    title(strcat('(Max Operation) TQD ON -- ',num2str(j)))
end
for j = 1:TQD_Directions
    figure
    surf(TQD_Correlation_Component_OFF_MaxOperation(:,:,j)')
    title(strcat('(Max Operation) TQD OFF -- ',num2str(j)))
end
for j = 1:DS_STMD_Directions
    figure
    surf(DS_STMD_LateralInhibitionOutput_MaxOperation(:,:,j)')
    title(strcat(' DS-STMD -- ',num2str(j)))
end    

for j = 1:DS_STMD_Directions
    figure
    surf(DS_STMD_Outputs_After_Theta_Inhibition(:,:,j)')
    title(strcat('DS-STMD After Theta Inhibition -- ',num2str(j)))
end    




    
% % (No Max Operation)
% for j = 1:TQD_Directions
%     figure
%     surf(TQD_Correlation_Component_ON_NoMaxOperation(:,:,j)')
%     title(strcat('(No Max) ON Hand Outputs -- ',num2str(j)))
% end
% for j = 1:TQD_Directions
%     figure
%     surf(TQD_Correlation_Component_OFF_NoMaxOperation(:,:,j)')
%     title(strcat('(No Max) OFF Hand Outputs -- ',num2str(j)))
% end
% for j = 1:DS_STMD_Directions
%     figure
%     surf(DS_STMD_LateralInhibitionOutput_NoMaxOperation(:,:,j)')
%     title(strcat('(No Max) DS-STMD Model Outputs -- ',num2str(j)))
% end        

