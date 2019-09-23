% 函数说明
% 该函数在 TopFunction_TargetTracking_LDTB_Velocity_Size.m 中，读取文件夹及设置相关参数


%% Main Function

% 调整输入的视频，包括物体大小，速度，对比度，背景速度，运动方向等
Parameter_File.Test_VelocityTuning = 0;     % 不生成 Velocity Tuning Curve
Parameter_File.Test_WidthTuning = 0;        % 不生成 Width Tuning Curve
Parameter_File.Test_HeightTuning = 0;       % 不生成 Height Tuning Curve
Parameter_File.Test_ContrastTuning = 0;      % 不生成 Contrast Tuning Curve

% Parameters for Input Image Sequence

Parameter_File.folderName = 'Cluttered-Background-Curvilinear-Motion';    % 'Target-Detection-in-Cluttered-Background';  'Cluttered-Background-Curvilinear-Motion'
Parameter_File.BackgroundType = 'CB-4';                               % 1 表示混杂背景，2 表示较为干净的背景， 0 表示无背景
Parameter_File.TargetNum = 'SingleTarget';
% 用于改变物体大小
Parameter_File.TargetWidth = 5;
Parameter_File.TargetHeight = 5;

Parameter_File.TargetVelocity = Velocity_Range(i_Velocity);
Parameter_File.TargetLuminance = 0;
Parameter_File.BackgroundVelocity = 250;
Parameter_File.MotionMode = 'OppositeDirection';                 % OppositeDirection, SameDirection, NoRelativeMotion, BackgroundStationary
Parameter_File.Y_Axis_Amplitude = 15;
Parameter_File.Y_Axis_TemporalFrequency = 2;
Parameter_File.VideoSamplingFrequency = 1000;                         % Default Value : 1 kHz

% Path of Input Image Sequence
Parameter_File.folder0 = ['D:\Matlab\TestSet-STMD\',Parameter_File.folderName,'\',Parameter_File.BackgroundType,'-',Parameter_File.TargetNum,'-TargetWidth-',num2str(Parameter_File.TargetWidth),'-TargetHeight-',num2str(Parameter_File.TargetHeight),...
    '-TargetVelocity-',num2str(Parameter_File.TargetVelocity),'-TargetLuminance-',num2str(Parameter_File.TargetLuminance),'-BackgroundVelocity-',num2str(Parameter_File.BackgroundVelocity),'-',Parameter_File.MotionMode,'-Amp-',...
    num2str(Parameter_File.Y_Axis_Amplitude),'-TemFre-',num2str(Parameter_File.Y_Axis_TemporalFrequency),'-SamplingFrequency-',num2str(Parameter_File.VideoSamplingFrequency)];



% 生成文件夹用于存储数据 RecordedData
Parameter_File.folder_Global = ['Data\Data-for-DR-FA\',Parameter_File.BackgroundType,'\Velocity\','Velocity-',num2str(Velocity_Range(i_Velocity))];

if ~exist(Parameter_File.folder_Global,'dir')
    mkdir(Parameter_File.folder_Global)
end

% Title of Input Image Sequence
Parameter_File.Imagetitle = 'Synthetic-Stimuli';

% Start and end frame of input image sequence
Parameter_File.StartRecordFrame = 300;         % 开始记录数据的帧
Parameter_File.StartFrame = 1;
Parameter_File.EndFrame = 1300;

% Cluttered Background   50 - 550  (更新300帧 即可)
% White Background 500-1000        (更新300帧 即可)

% Start and end frame of input image sequence
% 考虑一下物体速度 

Frame_Target_In_Screen = floor((500*Parameter_File.VideoSamplingFrequency)/Parameter_File.TargetVelocity);

if Frame_Target_In_Screen<=1300
    Parameter_File.EndFrame = Frame_Target_In_Screen;
end

%% 调入函数 ParameterSetting.m 设置整个程序的参数

ParameterSetting

% 计算时间 （Start Point）
tic;
timedLog('Start Motion Perception...')
%% 调入 Main.m 文件处理 Input Image Sequence

file = [Parameter_File.folder_Global,'/','Recorded-Data.mat'];
if ~exist(file,'file')
    
    Main
    
end


clear Parameter_Fun
%===================================================================%
% 计算时间 （End Point）  
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Motion Perception finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Motion Perception finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 

