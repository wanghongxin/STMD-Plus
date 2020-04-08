% 函数说明
% 该函数用于记录 Detection Rate and False Alarm Rate 曲线，在不同的 LDTB， Size and
% Velocity 下的物体运动

clear all; close all; clc;

%% Main
% 给定 DSTMD 的检测阈值
DSTMD_Detection_Threshold_Range = [1e5:-1e4:2e4,1e4:-1e3:2e3,1e3:-1e2:1e2];
Num_Detection_Threshold = length(DSTMD_Detection_Threshold_Range);

% 用于存储 Detection Rate 及 False Alarm Rate
All_DSTMD_Detection_Rate_Velocity = zeros(1,Num_Detection_Threshold);
All_DSTMD_False_Alarm_Velocity = zeros(1,Num_Detection_Threshold);
All_STMD_Plus_Detection_Rate_Velocity = zeros(1,Num_Detection_Threshold);
All_STMD_Plus_False_Alarm_Velocity = zeros(1,Num_Detection_Threshold);


%% 读取文件夹，调用 Main.m 函数处理视频
Read_In_Folder_Name

%% 对 DSTMD 的输出结果进行三维的 Max 操作，只需运行一次即可
Max_Operation_On_DSTMD_Outputs

for j_Velocity = 1:Num_Detection_Threshold
    
    % 确定 DS-STMD 检测阈值
    DSTMD_Detection_Threshold = DSTMD_Detection_Threshold_Range(j_Velocity);
    
    disp('=====================================================')
    disp(strcat('Detection Threshold = ',num2str(DSTMD_Detection_Threshold)))
    
    
    % 调用函数 Clustering_Detected_Points.m 进行聚类运算
    Clustering_Detected_Points
    
    
    % 对聚类的结果进行分析，记录运动轨迹
    Recording_Target_Trace
    
    % 用于记录并展示运动轨迹的相应的 T1 Neuron Outputs
    % 展示哪条轨迹的输出需要在 Show_Monophasic_Outputs_Along_Target_Trace.m 中指定
    Show_T1_Neuron_Outputs_Along_Target_Trace
    
    % 记录 Ground Truth
    if ~exist('Ground_Truth','var')
        load([Parameter_File.folder0,'/','Ground-Truth.mat'])
    end
    
    % 用于计算算法的正确率
    Calculate_Detection_Accuracy_and_False_Alarm
    
    All_DSTMD_Detection_Rate_Velocity(1,j_Velocity) = Detection_Rate_DSTMD;
    All_DSTMD_False_Alarm_Velocity(1,j_Velocity) = False_Alarm_Rate_DSTMD;
    All_STMD_Plus_Detection_Rate_Velocity(1,j_Velocity) = Detection_Rate_STMD_Plus;
    All_STMD_Plus_False_Alarm_Velocity(1,j_Velocity) = False_Alarm_Rate_STMD_Plus;
    
    
end

% 循环 i_Velocity 时，必须重新记录 Ground_Truth
clearvars Ground_Truth All_T1_Neuron_Outputs Max_Operation_DSTMD_Outputs

% 绘图

plot(All_DSTMD_False_Alarm_Velocity(1,:),All_DSTMD_Detection_Rate_Velocity(1,:),'color','r','LineStyle','-','Marker','>','DisPlayName','DSTMD','linewidth',1)
hold on
plot(All_STMD_Plus_False_Alarm_Velocity(1,:),All_STMD_Plus_Detection_Rate_Velocity(1,:),'color','b','LineStyle','-','Marker','o','DisPlayName','STMD Plus','linewidth',1)
hold on


legend('show')
axis([0,25,0,1])
xlabel('False Alarm Rate')
ylabel('Detection Rate')


% 存储数据
file = [Parameter_File.folder_Global,'\','Detection-Rate-False-Alarm-Rate.mat'];
save(file,'DSTMD_Detection_Threshold_Range','All_DSTMD_Detection_Rate_Velocity','All_DSTMD_False_Alarm_Velocity','All_STMD_Plus_Detection_Rate_Velocity','All_STMD_Plus_False_Alarm_Velocity','-v7.3')


