% 函数说明
% 该函数用于调用 Main.m，记录 TQD 及 DS-STMD 的 Velocity Tuning 曲线

clear all; close all; clc;

%% 用于调整输入的视频，包括物体大小，速度，对比度，背景速度，运动方向等
Test_VelocityTuning = 0;     % 不生成 Velocity Tuning Curve
Test_WidthTuning = 1; 
Test_HeightTuning = 0;
% 从哪一帧开始记录数据 （EndFrame - VelocityTuning_Frame）
WidthTuning_Frame = 20;

% 确定物体速度的变化范围
Target_Width_Range = [1 2 3 4 5 6 7 8 9 10 11 12 15 20];


% 生成用于存储 TQD 及 DS-STMD 响应的矩阵
TQD_ON_Responses_WidthTuning = zeros(WidthTuning_Frame,length(Target_Width_Range));
TQD_OFF_Responses_WidthTuning = zeros(WidthTuning_Frame,length(Target_Width_Range));
TQD_ON_OFF_Responses_WidthTuning = zeros(WidthTuning_Frame,length(Target_Width_Range));
DS_STMD_Responses_WidthTuning = zeros(WidthTuning_Frame,length(Target_Width_Range));

tic;
timedLog('Start Record Width Tuning Curve ...')

for k = 1:length(Target_Width_Range)
    
    disp('======================================')
    disp(strcat('Target Width =  ',num2str(Target_Width_Range(k))))
    
    % Parameters for Input Image Sequence
    folderName = 'Width-Tuning';                     % 'Target-Detection-in-Cluttered-Background';
    BackgroundType = 'WhiteBackground';                 %  ClutteredBackground or WhiteBackground
    TargetNum = 'SingleTarget';
    TargetWidth = Target_Width_Range(k);
    TargetHeight = 5;
    TargetVelocity = 250;         % 确定物体运动速度
    TargetLuminance = 0;
    BackgroundVelocity = 0;
    MotionMode = 'BackgroundStationary';                 % OppositeDirection, SameDirection, NoRelativeMotion, BackgroundStationary
    VideoSamplingFrequency = 1000;                         % Default Value : 1 kHz

    % Path of Input Image Sequence
    folder0 = ['D:\Matlab\TestSet-STMD\',folderName,'\',BackgroundType,'-',TargetNum,'-TargetWidth-',num2str(TargetWidth),'-TargetHeight-',num2str(TargetHeight),...
                 '-TargetVelocity-',num2str(TargetVelocity),'-TargetLuminance-',num2str(TargetLuminance),'-BackgroundVelocity-',num2str(BackgroundVelocity),'-',MotionMode,...
                 '-SamplingFrequency-',num2str(VideoSamplingFrequency)];

    % Title of Input Image Sequence
    Imagetitle = 'Synthetic-Stimuli';

    % Start and end frame of input image sequence
    StartFrame = 1;
    EndFrame = 300;

    %% 调入函数 ParameterSetting.m 设置整个程序的参数

    ParameterSetting
    
    %% 生成记录每次循环响应的矩阵
    
    TQD_ON_Responses_WidthTuning_EachStep = zeros(WidthTuning_Frame,1);
    TQD_OFF_Responses_WidthTuning_EachStep = zeros(WidthTuning_Frame,1);
    TQD_ON_OFF_Responses_WidthTuning_EachStep = zeros(WidthTuning_Frame,1);
    DS_STMD_Responses_WidthTuning_EachStep = zeros(WidthTuning_Frame,1);


    %% 调入 Main.m 文件处理 Input Image Sequence
      
    Main
    
    %% 记录 TQD 及 DS-STMD 的响应
    TQD_ON_Responses_WidthTuning(:,k) = TQD_ON_Responses_WidthTuning_EachStep;
    TQD_OFF_Responses_WidthTuning(:,k) = TQD_OFF_Responses_WidthTuning_EachStep;
    TQD_ON_OFF_Responses_WidthTuning(:,k) = TQD_ON_OFF_Responses_WidthTuning_EachStep;
    DS_STMD_Responses_WidthTuning(:,k) = DS_STMD_Responses_WidthTuning_EachStep;

end

% 存储记录的数据
file = ['Data','/','Width-Tuning-Data.mat'];
save(file,'TQD_ON_Responses_WidthTuning','TQD_OFF_Responses_WidthTuning','TQD_ON_OFF_Responses_WidthTuning','DS_STMD_Responses_WidthTuning','-v7.3')

%% 数据处理
% Method 1
% 对每个 Velocity 记录 VelocityTuning_Frame 帧数据，对这些记录的数据取 Max
MaxValue_TQD_ON_WidthTuning = max(TQD_ON_Responses_WidthTuning,[],1);
MaxValue_TQD_OFF_WidthTuning = max(TQD_OFF_Responses_WidthTuning,[],1);
MaxValue_TQD_ON_OFF_WidthTuning = max(TQD_ON_OFF_Responses_WidthTuning,[],1);
MaxValue_DS_STMD_WidthTuning = max(DS_STMD_Responses_WidthTuning,[],1);

% Data Normalization
Normalized_MaxValue_TQD_ON_WidthTuning = Data_Normalization([0 MaxValue_TQD_ON_WidthTuning],[0,1]);
Normalized_MaxValue_TQD_OFF_WidthTuning = Data_Normalization([0 MaxValue_TQD_OFF_WidthTuning],[0,1]);
Normalized_MaxValue_TQD_ON_OFF_WidthTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_WidthTuning],[0,1]);
Normalized_MaxValue_DS_STMD_WidthTuning = Data_Normalization([0 MaxValue_DS_STMD_WidthTuning],[0,1]);

figure
plot([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_WidthTuning,'r','DisPlayName','TQD ON')
hold on
plot([0 Target_Width_Range], Normalized_MaxValue_TQD_OFF_WidthTuning,'b','DisPlayName','TQD OFF')
hold on
plot([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_OFF_WidthTuning,'g','DisPlayName','TQD ON-OFF')
hold on
plot([0 Target_Width_Range], Normalized_MaxValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
% 保存图片
saveas(gcf,'Figures\Width-Tuning-MaxValue.fig')


figure
plot([0 Target_Width_Range], Normalized_MaxValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
saveas(gcf,'Figures\Width-Tuning-MaxValue-DS-STMD.fig')


%---------------------- X (log)------------------------%
% 对 X 轴取对数，重新绘制 Tuning 曲线
figure
semilogx([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_WidthTuning,'r','DisPlayName','TQD ON')
hold on
semilogx([0 Target_Width_Range], Normalized_MaxValue_TQD_OFF_WidthTuning,'b','DisPlayName','TQD OFF')
hold on
semilogx([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_OFF_WidthTuning,'g','DisPlayName','TQD ON-OFF')
hold on
semilogx([0 Target_Width_Range], Normalized_MaxValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
% 保存图片
saveas(gcf,'Figures\Width-Tuning-MaxValue-2.fig')

% Method 2
% 对每个 Velocity 记录 VelocityTuning_Frame 帧数据，对这些记录的数据取 Mean
MeanValue_TQD_ON_WidthTuning = mean(TQD_ON_Responses_WidthTuning,1);
MeanValue_TQD_OFF_WidthTuning = mean(TQD_OFF_Responses_WidthTuning,1);
MeanValue_TQD_ON_OFF_WidthTuning = mean(TQD_ON_OFF_Responses_WidthTuning,1);
MeanValue_DS_STMD_WidthTuning = mean(DS_STMD_Responses_WidthTuning,1);

% Data Normalization
Normalized_MeanValue_TQD_ON_WidthTuning = Data_Normalization([0 MeanValue_TQD_ON_WidthTuning],[0,1]);
Normalized_MeanValue_TQD_OFF_WidthTuning = Data_Normalization([0 MeanValue_TQD_OFF_WidthTuning],[0,1]);
Normalized_MeanValue_TQD_ON_OFF_WidthTuning = Data_Normalization([0 MeanValue_TQD_ON_OFF_WidthTuning],[0,1]);
Normalized_MeanValue_DS_STMD_WidthTuning = Data_Normalization([0 MeanValue_DS_STMD_WidthTuning],[0,1]);

figure
plot([0 Target_Width_Range],Normalized_MeanValue_TQD_ON_WidthTuning,'r','DisPlayName','TQD ON')
hold on
plot([0 Target_Width_Range],Normalized_MeanValue_TQD_OFF_WidthTuning,'b','DisPlayName','TQD OFF')
hold on
plot([0 Target_Width_Range],Normalized_MeanValue_TQD_ON_OFF_WidthTuning,'g','DisPlayName','TQD ON-OFF')
hold on
plot([0 Target_Width_Range],Normalized_MeanValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Mean Value')
% 保存图片
saveas(gcf,'Figures\Width-Tuning-MeanValue.fig')


figure
plot([0 Target_Width_Range],Normalized_MeanValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Mean Value')
saveas(gcf,'Figures\Width-Tuning-MeanValue-DS-STMD.fig')




%---------------------- X (log)------------------------%
% 对 X 轴取对数，重新绘制 Tuning 曲线
figure
semilogx([0 Target_Width_Range],Normalized_MeanValue_TQD_ON_WidthTuning,'r','DisPlayName','TQD ON')
hold on
semilogx([0 Target_Width_Range],Normalized_MeanValue_TQD_OFF_WidthTuning,'b','DisPlayName','TQD OFF')
hold on
semilogx([0 Target_Width_Range],Normalized_MeanValue_TQD_ON_OFF_WidthTuning,'g','DisPlayName','TQD ON-OFF')
hold on
semilogx([0 Target_Width_Range],Normalized_MeanValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Mean Value')
% 保存图片
saveas(gcf,'Figures\Width-Tuning-MeanValue-2.fig')


%====================== 记录时间 ===========================%
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Recording finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Recording finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 