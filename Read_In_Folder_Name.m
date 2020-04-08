% 函数说明
% 该函数在 TopFunction_TargetTracking_LDTB_Velocity_Size.m 中，读取文件夹及设置相关参数


%% Main Function

% Path of Input Image Sequence
Parameter_File.folder0 = 'Test-Image-Sequence';


% 生成文件夹用于存储数据 RecordedData
Parameter_File.folder_Global = ['Result\Data-for-DR-FA\',Parameter_File.folder0];

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

