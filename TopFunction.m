% 函数说明
% 该函数为整个程序的头函数

clear all; close all; clc;

%% 用于调整输入的视频，包括物体大小，速度，对比度，背景速度，运动方向等
Test_VelocityTuning = 0;     % 不生成 Velocity Tuning Curve
Test_WidthTuning = 0;        % 不生成 Width Tuning Curve
Test_HeightTuning = 0;       % 不生成 Height Tuning Curve

% Parameters for Input Image Sequence

folderName = 'Cluttered-Background-Curvilinear-Motion';    % 'Target-Detection-in-Cluttered-Background';  'Cluttered-Background-Curvilinear-Motion'

if strcmp(folderName,'Target-Detection-in-Cluttered-Background')
    % 判断文件夹，根据不同文件夹调整路径名
    
    BackgroundType = 'CB-1';                      %  CB-1, CB-2 or WhiteBackground  
    TargetNum = 'SingleTarget';
    TargetWidth = 5;
    TargetHeight = 5;
    TargetVelocity = 250;
    TargetLuminance = 0;
    BackgroundVelocity = 250;
    MotionMode = 'OppositeDirection';                 % OppositeDirection, SameDirection, NoRelativeMotion, BackgroundStationary
    VideoSamplingFrequency = 1000;                         % Default Value : 1 kHz
    
    % Path of Input Image Sequence
    folder0 = ['D:\Matlab\TestSet-STMD\',folderName,'\',BackgroundType,'-',TargetNum,'-TargetWidth-',num2str(TargetWidth),'-TargetHeight-',num2str(TargetHeight),...
        '-TargetVelocity-',num2str(TargetVelocity),'-TargetLuminance-',num2str(TargetLuminance),'-BackgroundVelocity-',num2str(BackgroundVelocity),'-',MotionMode,...
        '-SamplingFrequency-',num2str(VideoSamplingFrequency)];
    
elseif strcmp(folderName,'Cluttered-Background-Curvilinear-Motion')
    
    BackgroundType = 'CB-1';                               % 1 表示混杂背景，2 表示较为干净的背景， 0 表示无背景
    TargetNum = 'SingleTarget';
    TargetWidth = 5;
    TargetHeight = 5;
    TargetVelocity = 250;
    TargetLuminance = 0;
    BackgroundVelocity = 250;
    MotionMode = 'OppositeDirection';                 % OppositeDirection, SameDirection, NoRelativeMotion, BackgroundStationary
    Y_Axis_Amplitude = 15;
    Y_Axis_TemporalFrequency = 2;
    VideoSamplingFrequency = 1000;                         % Default Value : 1 kHz
    
    % Path of Input Image Sequence
    folder0 = ['D:\Matlab\TestSet-STMD\',folderName,'\',BackgroundType,'-',TargetNum,'-TargetWidth-',num2str(TargetWidth),'-TargetHeight-',num2str(TargetHeight),...
        '-TargetVelocity-',num2str(TargetVelocity),'-TargetLuminance-',num2str(TargetLuminance),'-BackgroundVelocity-',num2str(BackgroundVelocity),'-',MotionMode,'-Amp-',...
        num2str(Y_Axis_Amplitude),'-TemFre-',num2str(Y_Axis_TemporalFrequency),'-SamplingFrequency-',num2str(VideoSamplingFrequency)];
    
end
         

% Title of Input Image Sequence
Imagetitle = 'Synthetic-Stimuli';

% Start and end frame of input image sequence
StartRecordFrame = 300;         % 开始记录数据的帧
StartFrame = 1;
EndFrame = 1300;


% Cluttered Background   50 - 550  (更新300帧 即可)
% White Background 500-1000        (更新300帧 即可)

%% 调入函数 ParameterSetting.m 设置整个程序的参数

ParameterSetting

% 计算时间 （Start Point）
tic;
timedLog('Start Motion Perception...')
%% 调入 Main.m 文件处理 Input Image Sequence

Main

%===================================================================%
% 计算时间 （End Point）  
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Motion Perception finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Motion Perception finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 












