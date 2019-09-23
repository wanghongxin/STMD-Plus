% 2016-11-14

% 函数说明
% 该函数用于对 DS-STMD 的输出结果，在给定阈值下进行聚类
% 接着，对于聚类结果分析相应的运动轨迹
% 最后，对特定的运动轨迹输出对应的 Monophasic Outputs


%% Main Function
clear all; close all; clc;

% 对 DS-STMD 的输出结果进行三维的 Max 操作，只需运行一次即可
if ~exist('Max_Operation_DS_STMD_Outputs','var')
    if ~exist('Data\Max_Operation_DS_STMD_Outputs.mat','file')
        Max_Operation_On_DS_STMD_Outputs
    else
        load('Data\Max_Operation_DS_STMD_Outputs.mat')
    end
end

% 给定 DS-STMD 的检测阈值
DS_STMD_Detection_Threshold_Range = 500:-25:50;
Num_Detection_Threshold = length(DS_STMD_Detection_Threshold_Range);

% 用于存储 Detection Rate 及 False Alarm Rate
All_DS_STMD_Detection_Rate = zeros(1,Num_Detection_Threshold);
All_DS_STMD_False_Alarm = zeros(1,Num_Detection_Threshold);
All_Visual_System_Detection_Rate = zeros(1,Num_Detection_Threshold);
All_Visual_System_False_Alarm = zeros(1,Num_Detection_Threshold);


for ll = 1:Num_Detection_Threshold
    
    % 对 DS-STMD 的输出进行聚类
    % 对 DS-STMD 的输出需要事先给定阈值 Detection_Threshold
    
    % 确定检测阈值 （DS-STMD Model）
    DS_STMD_Detection_Threshold = DS_STMD_Detection_Threshold_Range(ll);
    
    disp('=====================================================')
    disp(strcat('Detection Threshold = ',num2str(DS_STMD_Detection_Threshold)))
    % 调用函数 Clustering_Detected_Points.m 进行聚类运算
    Clustering_Detected_Points
    
    
    % 对聚类的结果进行分析，记录运动轨迹
    
    Recording_Target_Trace
    
    
%     % 用于展示聚类结果及运动轨迹
%     close all;
%     Show_Clustering_Results

%     Show_Target_Trace

    
    % 用于展示运动轨迹的相应的 T1 Neuron Outputs
    % 展示哪条轨迹的输出需要在 Show_Monophasic_Outputs_Along_Target_Trace.m 中指定
    Show_T1_Neuron_Outputs_Along_Target_Trace

    
    % 用于计算算法的正确率
    Calculate_Detection_Accuracy_and_False_Alarm
    
    All_DS_STMD_Detection_Rate(ll) = Detection_Rate_DS_STMD;
    All_DS_STMD_False_Alarm(ll) = False_Alarm_Rate_DS_STMD;
    All_Visual_System_Detection_Rate(ll) = Detection_Rate_System;
    All_Visual_System_False_Alarm(ll) = False_Alarm_Rate_System;
    
end

% 绘制 False Alarm 及 Detection Rate 的曲线图

figure
plot(All_DS_STMD_False_Alarm,All_DS_STMD_Detection_Rate,'r>-','DisPlayName','DS-STMD','linewidth',1)
hold on
plot(All_Visual_System_False_Alarm,All_Visual_System_Detection_Rate,'bo-','DisPlayName','Visual-System','linewidth',1)
legend('show')
grid on
axis([0,25,0,1])
xlabel('False Alarm Rate')
ylabel('Detection Rate')

% 存储数据
file = ['Data','/','Detection-Rate-False-Alarm-Rate.mat'];
save(file,'DS_STMD_Detection_Threshold_Range','All_DS_STMD_Detection_Rate','All_DS_STMD_False_Alarm','All_Visual_System_Detection_Rate','All_Visual_System_False_Alarm','-v7.3')





