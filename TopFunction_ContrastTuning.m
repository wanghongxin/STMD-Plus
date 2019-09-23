% 函数说明
% 该函数用于调用 Main.m，记录 TQD 及 DS-STMD 的 LDTB Tuning 曲线
% LDTB (Luminance Difference Between Target and Background)
% LDTB = abs(Lumiance of Target - Luminance of Backgroud)/255
% 类似于 SCR, 但将分母由 Sigma_Backgorund 改为 255



clear all; close all; clc;

%% 用于调整输入的视频，包括物体大小，速度，对比度，背景速度，运动方向等

Test_VelocityTuning = 0; 
Test_WidthTuning = 0; 
Test_HeightTuning = 0;
Test_ContrastTuning = 1;

% 从哪一帧开始记录数据 （EndFrame - VelocityTuning_Frame）
ContrastTuning_Frame = 20;

% 确定物体速度的变化范围
Target_Luminance_Range = [0 25 50 75 100 125 150 175 200 225 250];

% 生成用于存储 TQD 及 DS-STMD 响应的矩阵
TQD_ON_Responses_ContrastTuning = zeros(ContrastTuning_Frame,length(Target_Luminance_Range));
TQD_OFF_Responses_ContrastTuning = zeros(ContrastTuning_Frame,length(Target_Luminance_Range));
TQD_ON_OFF_Responses_ContrastTuning = zeros(ContrastTuning_Frame,length(Target_Luminance_Range));
DS_STMD_Responses_ContrastTuning = zeros(ContrastTuning_Frame,length(Target_Luminance_Range));

tic;
timedLog('Start Record Contrast Tuning Curve ...')

for k = 1:length(Target_Luminance_Range)
    
    disp('======================================')
    disp(strcat('Target Luminance =  ',num2str(Target_Luminance_Range(k))))
    
    % Parameters for Input Image Sequence
    folderName = 'Contrast-Tuning';                     % 'Target-Detection-in-Cluttered-Background';
    BackgroundType = 'WhiteBackground';                 %  ClutteredBackground or WhiteBackground
    TargetNum = 'SingleTarget';
    TargetWidth = 5;
    TargetHeight = 5;
    TargetVelocity = 250;                             % 确定物体运动速度
    TargetLuminance = Target_Luminance_Range(k);
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
    
    TQD_ON_Responses_ContrastTuning_EachStep = zeros(ContrastTuning_Frame,1);
    TQD_OFF_Responses_ContrastTuning_EachStep = zeros(ContrastTuning_Frame,1);
    TQD_ON_OFF_Responses_ContrastTuning_EachStep = zeros(ContrastTuning_Frame,1);
    DS_STMD_Responses_ContrastTuning_EachStep = zeros(ContrastTuning_Frame,1);


    %% 调入 Main.m 文件处理 Input Image Sequence
      
    Main
    
    %% 记录 TQD 及 DS-STMD 的响应
    TQD_ON_Responses_ContrastTuning(:,k) = TQD_ON_Responses_ContrastTuning_EachStep;
    TQD_OFF_Responses_ContrastTuning(:,k) = TQD_OFF_Responses_ContrastTuning_EachStep;
    TQD_ON_OFF_Responses_ContrastTuning(:,k) = TQD_ON_OFF_Responses_ContrastTuning_EachStep;
    DS_STMD_Responses_ContrastTuning(:,k) = DS_STMD_Responses_ContrastTuning_EachStep;
    


end
% 存储记录的数据
file = ['Data','/','Contrast-Tuning-Data.mat'];
save(file,'TQD_ON_Responses_ContrastTuning','TQD_OFF_Responses_ContrastTuning','TQD_ON_OFF_Responses_ContrastTuning','DS_STMD_Responses_ContrastTuning','-v7.3')

%% 数据处理
% Method LDTB 记录 VelocityTuning_Frame 帧数据，对这些记录的数据取 Max
MaxValue_TQD_ON_ContrastTuning = max(TQD_ON_Responses_ContrastTuning,[],1);
MaxValue_TQD_OFF_ContrastTuning = max(TQD_OFF_Responses_ContrastTuning,[],1);
MaxValue_TQD_ON_OFF_ContrastTuning = max(TQD_ON_OFF_Responses_ContrastTuning,[],1);
MaxValue_DS_STMD_ContrastTuning = max(DS_STMD_Responses_ContrastTuning,[],1);

% Data Normalization
Normalized_MaxValue_TQD_ON_ContrastTuning = Data_Normalization([MaxValue_TQD_ON_ContrastTuning,0],[0,1]);
Normalized_MaxValue_TQD_OFF_ContrastTuning = Data_Normalization([MaxValue_TQD_OFF_ContrastTuning,0],[0,1]);
Normalized_MaxValue_TQD_ON_OFF_ContrastTuning = Data_Normalization([MaxValue_TQD_ON_OFF_ContrastTuning,0],[0,1]);
Normalized_MaxValue_DS_STMD_ContrastTuning = Data_Normalization([MaxValue_DS_STMD_ContrastTuning,0],[0,1]);



figure
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_TQD_ON_OFF_ContrastTuning,'r','DisPlayName','LPTC')
hold on
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_DS_STMD_ContrastTuning,'b','DisPlayName','STMD')
legend('show')
saveas(gcf,'Figures\Contrast-Tuning-MaxValue-DS-STMD.fig')


%---------------------- X (log)------------------------%
% 对 X 轴取对数，重新绘制 Tuning 曲线
figure
semilogx(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_TQD_ON_OFF_ContrastTuning,'r','DisPlayName','LPTC')
hold on
semilogx(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_DS_STMD_ContrastTuning,'b','DisPlayName','STMD')
legend('show')
saveas(gcf,'Figures\Contrast-Tuning-MaxValue-2.fig')

% Method 2
% 对每个 LDTB 记录 LDTBTuning_Frame 帧数据，对这些记录的数据取 Mean
MeanValue_TQD_ON_ContrastTuning = mean(TQD_ON_Responses_ContrastTuning,1);
MeanValue_TQD_OFF_ContrastTuning = mean(TQD_OFF_Responses_ContrastTuning,1);
MeanValue_TQD_ON_OFF_ContrastTuning = mean(TQD_ON_OFF_Responses_ContrastTuning,1);
MeanValue_DS_STMD_ContrastTuning = mean(DS_STMD_Responses_ContrastTuning,1);

% Data Normalization
Normalized_MeanValue_TQD_ON_ContrastTuning = Data_Normalization([MeanValue_TQD_ON_ContrastTuning 0],[0,1]);
Normalized_MeanValue_TQD_OFF_ContrastTuning = Data_Normalization([MeanValue_TQD_OFF_ContrastTuning 0],[0,1]);
Normalized_MeanValue_TQD_ON_OFF_ContrastTuning = Data_Normalization([MeanValue_TQD_ON_OFF_ContrastTuning 0],[0,1]);
Normalized_MeanValue_DS_STMD_ContrastTuning = Data_Normalization([MeanValue_DS_STMD_ContrastTuning 0],[0,1]);

figure
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MeanValue_TQD_ON_OFF_ContrastTuning,'r','DisPlayName','LPTC')
hold on
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MeanValue_DS_STMD_ContrastTuning,'b','DisPlayName','STMD')
legend('show')
saveas(gcf,'Figures\Contrast-Tuning-MeanValue.fig')

%---------------------- X (log)------------------------%
% 对 X 轴取对数，重新绘制 Tuning 曲线
figure
semilogx(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MeanValue_TQD_ON_OFF_ContrastTuning,'r','DisPlayName','LPTC')
hold on
semilogx(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MeanValue_DS_STMD_ContrastTuning,'b','DisPlayName','STMD')
legend('show')
saveas(gcf,'Figures\Contrast-Tuning-MeanValue-2.fig')

%====================== 记录时间 ===========================%
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Recording finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Recording finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 