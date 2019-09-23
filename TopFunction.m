% ����˵��
% �ú���Ϊ���������ͷ����

clear all; close all; clc;

%% ���ڵ����������Ƶ�����������С���ٶȣ��Աȶȣ������ٶȣ��˶������
Test_VelocityTuning = 0;     % ������ Velocity Tuning Curve
Test_WidthTuning = 0;        % ������ Width Tuning Curve
Test_HeightTuning = 0;       % ������ Height Tuning Curve

% Parameters for Input Image Sequence

folderName = 'Cluttered-Background-Curvilinear-Motion';    % 'Target-Detection-in-Cluttered-Background';  'Cluttered-Background-Curvilinear-Motion'

if strcmp(folderName,'Target-Detection-in-Cluttered-Background')
    % �ж��ļ��У����ݲ�ͬ�ļ��е���·����
    
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
    
    BackgroundType = 'CB-1';                               % 1 ��ʾ���ӱ�����2 ��ʾ��Ϊ�ɾ��ı����� 0 ��ʾ�ޱ���
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
StartRecordFrame = 300;         % ��ʼ��¼���ݵ�֡
StartFrame = 1;
EndFrame = 1300;


% Cluttered Background   50 - 550  (����300֡ ����)
% White Background 500-1000        (����300֡ ����)

%% ���뺯�� ParameterSetting.m ������������Ĳ���

ParameterSetting

% ����ʱ�� ��Start Point��
tic;
timedLog('Start Motion Perception...')
%% ���� Main.m �ļ����� Input Image Sequence

Main

%===================================================================%
% ����ʱ�� ��End Point��  
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Motion Perception finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Motion Perception finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 












