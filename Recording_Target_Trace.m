% 2016-11-05

% 函数说明
% 该函数用于记录 DSTMD 模型检测物体的轨迹


%% Main Function


% % 读取数据
% if ~exist('Clustering_Results','var')
%     
%     %clear all; close all; clc;  
%     DSTMD_Detection_Threshold = 200;
%     File_Max = strcat('D:\Matlab\2016-10-01-Small-Field-System\Data\Clustering_Results-Detection-Threshold-',num2str(DSTMD_Detection_Threshold),'.mat');
%     load(File_Max)  
% end



NumFrame_Clustering = length(Clustering_Results);
DS_STMD_Directions  = 8;


% 生成用于存储物体轨迹的矩阵
% 可能的物体数目
Possible_Target_Num = 5000;
Target_Trace = zeros(Possible_Target_Num,3,NumFrame_Clustering);
Target_Trace_Num = zeros(1,NumFrame_Clustering);
% 用于存储中断的帧数
Num_Interrupt_Frame = zeros(Possible_Target_Num,1);
Max_Interrupt_Frame_Num = 30;

Dist_Threshold = 5;

timedLog('Start Recording Target Trace...')
for j_R = 1:NumFrame_Clustering
    
    
    if j_R == 1
        
        [Target_Positions,Target_Num_PerFrame] = Extract_Clustered_Points_PerFrame(Clustering_Results{j_R});
        
        Target_Trace(1:Target_Num_PerFrame,:,j_R) = Target_Positions;
        Target_Trace_Num(1,j_R) = Target_Num_PerFrame;
        
    else
        
        [Target_Positions,Target_Num_PerFrame] = Extract_Clustered_Points_PerFrame(Clustering_Results{j_R});
        
        
        [Output_Maxtrix,Target_Num_CurrentFrame,Num_Interrupt_Frame] = Find_Target_Trace(Target_Trace(1:Target_Trace_Num(1,j_R-1),:,j_R-1),Target_Trace_Num(1,j_R-1),...
                                                                               Target_Positions,Num_Interrupt_Frame,Dist_Threshold,Max_Interrupt_Frame_Num);
                                                                           
        Target_Trace_Num(1,j_R) = Target_Num_CurrentFrame;
        Target_Trace(1:Target_Num_CurrentFrame,:,j_R) = Output_Maxtrix;
        
    end
    
end


file = [Parameter_File.folder_Global,'/',strcat('Target-Trace-Threshold-',num2str(DSTMD_Detection_Threshold),'.mat')];
save(file,'StartFrame','EndFrame','StartRecordFrame','Target_Trace','DSTMD_Detection_Threshold','Target_Trace_Num','Possible_Target_Num','-v7.3')


timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Recording Target Trace finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Recording Target Trace finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 












