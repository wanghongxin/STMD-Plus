% 函数说明
% 该函数用于调用 Main.m，记录 TQD 及 DS-STMD 的 Velocity Tuning 曲线

clear all; close all; clc;

%% 用于调整输入的视频，包括物体大小，速度，对比度，背景速度，运动方向等
Test_VelocityTuning = 0;     % 不生成 Velocity Tuning Curve
Test_WidthTuning = 0; 
Test_HeightTuning = 1; 

% 从哪一帧开始记录数据 （EndFrame - VelocityTuning_Frame）
HeightTuning_Frame = 20;

% 确定物体速度的变化范围
Target_Height_Range = [1 2 3 4 5 6 7 8 9 10 11 12 15 20];

% 生成用于存储 TQD 及 DS-STMD 响应的矩阵
TQD_ON_Responses_HeighthTuning = zeros(HeightTuning_Frame,length(Target_Height_Range));
TQD_OFF_Responses_HeightTuning = zeros(HeightTuning_Frame,length(Target_Height_Range));
TQD_ON_OFF_Responses_HeightTuning = zeros(HeightTuning_Frame,length(Target_Height_Range));
DS_STMD_Responses_HeightTuning = zeros(HeightTuning_Frame,length(Target_Height_Range));

tic;
timedLog('Start Record Height Tuning Curve ...')

for k = 1:length(Target_Height_Range)
    
    disp('======================================')
    disp(strcat('Target Height =  ',num2str(Target_Height_Range(k))))
    
    % Parameters for Input Image Sequence
    folderName = 'Height-Tuning';                     % 'Target-Detection-in-Cluttered-Background';
    BackgroundType = 'WhiteBackground';                 %  ClutteredBackground or WhiteBackground
    TargetNum = 'SingleTarget';
    TargetWidth = 5;
    TargetHeight = Target_Height_Range(k);
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
    
    TQD_ON_Responses_HeightTuning_EachStep = zeros(HeightTuning_Frame,1);
    TQD_OFF_Responses_HeightTuning_EachStep = zeros(HeightTuning_Frame,1);
    TQD_ON_OFF_Responses_HeightTuning_EachStep = zeros(HeightTuning_Frame,1);
    DS_STMD_Responses_HeightTuning_EachStep = zeros(HeightTuning_Frame,1);


    %% 调入 Main.m 文件处理 Input Image Sequence
      
    Main
    
    %% 记录 TQD 及 DS-STMD 的响应
    TQD_ON_Responses_HeighthTuning(:,k) = TQD_ON_Responses_HeightTuning_EachStep;
    TQD_OFF_Responses_HeightTuning(:,k) = TQD_OFF_Responses_HeightTuning_EachStep;
    TQD_ON_OFF_Responses_HeightTuning(:,k) = TQD_ON_OFF_Responses_HeightTuning_EachStep;
    DS_STMD_Responses_HeightTuning(:,k) = DS_STMD_Responses_HeightTuning_EachStep;

end

% 存储记录的数据
file = ['Data','/','Height-Tuning-Data.mat'];
save(file,'TQD_ON_Responses_HeighthTuning','TQD_OFF_Responses_HeightTuning','TQD_ON_OFF_Responses_HeightTuning','DS_STMD_Responses_HeightTuning','-v7.3')


%% 数据处理
% Method 1
% 对每个 Velocity 记录 VelocityTuning_Frame 帧数据，对这些记录的数据取 Max
MaxValue_TQD_ON_HeightTuning = max(TQD_ON_Responses_HeighthTuning,[],1);
MaxValue_TQD_OFF_HeightTuning = max(TQD_OFF_Responses_HeightTuning,[],1);
MaxValue_TQD_ON_OFF_HeightTuning = max(TQD_ON_OFF_Responses_HeightTuning,[],1);
MaxValue_DS_STMD_HeightTuning = max(DS_STMD_Responses_HeightTuning,[],1);

% Data Normalization
Normalized_MaxValue_TQD_ON_HeightTuning = Data_Normalization([0 MaxValue_TQD_ON_HeightTuning],[0,1]);
Normalized_MaxValue_TQD_OFF_HeightTuning = Data_Normalization([0 MaxValue_TQD_OFF_HeightTuning],[0,1]);
Normalized_MaxValue_TQD_ON_OFF_HeightTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_HeightTuning],[0,1]);
Normalized_MaxValue_DS_STMD_HeightTuning = Data_Normalization([0 MaxValue_DS_STMD_HeightTuning],[0,1]);

figure
plot([0 Target_Height_Range],Normalized_MaxValue_TQD_ON_HeightTuning,'r','DisPlayName','TQD ON')
hold on
plot([0 Target_Height_Range],Normalized_MaxValue_TQD_OFF_HeightTuning,'b','DisPlayName','TQD OFF')
hold on
plot([0 Target_Height_Range],Normalized_MaxValue_TQD_ON_OFF_HeightTuning,'g','DisPlayName','TQD ON-OFF')
hold on
plot([0 Target_Height_Range],Normalized_MaxValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
% 保存图片
saveas(gcf,'Figures\Height-Tuning-MaxValue.fig')

figure
plot([0 Target_Height_Range],Normalized_MaxValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
saveas(gcf,'Figures\Height-Tuning-MaxValue-DS-STMD.fig')



%---------------------- X (log)------------------------%
% 对 X 轴取对数，重新绘制 Tuning 曲线
figure
semilogx([0 Target_Height_Range],Normalized_MaxValue_TQD_ON_HeightTuning,'r','DisPlayName','TQD ON')
hold on
semilogx([0 Target_Height_Range],Normalized_MaxValue_TQD_OFF_HeightTuning,'b','DisPlayName','TQD OFF')
hold on
semilogx([0 Target_Height_Range],Normalized_MaxValue_TQD_ON_OFF_HeightTuning,'g','DisPlayName','TQD ON-OFF')
hold on
semilogx([0 Target_Height_Range],Normalized_MaxValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
% 保存图片
saveas(gcf,'Figures\Height-Tuning-MaxValue-2.fig')

% Method 2
% 对每个 Velocity 记录 VelocityTuning_Frame 帧数据，对这些记录的数据取 Mean
MeanValue_TQD_ON_HeightTuning = mean(TQD_ON_Responses_HeighthTuning,1);
MeanValue_TQD_OFF_HeightTuning = mean(TQD_OFF_Responses_HeightTuning,1);
MeanValue_TQD_ON_OFF_HeightTuning = mean(TQD_ON_OFF_Responses_HeightTuning,1);
MeanValue_DS_STMD_HeightTuning = mean(DS_STMD_Responses_HeightTuning,1);

% Data Normalization
Normalized_MeanValue_TQD_ON_HeightTuning = Data_Normalization([0 MeanValue_TQD_ON_HeightTuning],[0,1]);
Normalized_MeanValue_TQD_OFF_HeightTuning = Data_Normalization([0 MeanValue_TQD_OFF_HeightTuning],[0,1]);
Normalized_MeanValue_TQD_ON_OFF_HeightTuning = Data_Normalization([0 MeanValue_TQD_ON_OFF_HeightTuning],[0,1]);
Normalized_MeanValue_DS_STMD_HeightTuning = Data_Normalization([0 MeanValue_DS_STMD_HeightTuning],[0,1]);

figure
plot([0 Target_Height_Range],Normalized_MeanValue_TQD_ON_HeightTuning,'r','DisPlayName','TQD ON')
hold on
plot([0 Target_Height_Range],Normalized_MeanValue_TQD_OFF_HeightTuning,'b','DisPlayName','TQD OFF')
hold on
plot([0 Target_Height_Range],Normalized_MeanValue_TQD_ON_OFF_HeightTuning,'g','DisPlayName','TQD ON-OFF')
hold on
plot([0 Target_Height_Range],Normalized_MeanValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Mean Value')
% 保存图片
saveas(gcf,'Figures\Height-Tuning-MeanValue.fig')



figure
plot([0 Target_Height_Range],Normalized_MeanValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD')
grid on
legend('Mean Value')
saveas(gcf,'Figures\Height-Tuning-MeanValue-DS-STMD.fig')

%---------------------- X (log)------------------------%
% 对 X 轴取对数，重新绘制 Tuning 曲线
figure
semilogx([0 Target_Height_Range], Normalized_MeanValue_TQD_ON_HeightTuning,'r','DisPlayName','TQD ON')
hold on
semilogx([0 Target_Height_Range], Normalized_MeanValue_TQD_OFF_HeightTuning,'b','DisPlayName','TQD OFF')
hold on
semilogx([0 Target_Height_Range], Normalized_MeanValue_TQD_ON_OFF_HeightTuning,'g','DisPlayName','TQD ON-OFF')
hold on
semilogx([0 Target_Height_Range], Normalized_MeanValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Mean Value')
% 保存图片
saveas(gcf,'Figures\Height-Tuning-MeanValue-2.fig')


%====================== 记录时间 ===========================%
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Recording finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Recording finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 