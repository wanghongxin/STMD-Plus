% ����˵��
% �ú����� TopFunction_TargetTracking_LDTB_Velocity_Size.m �У���ȡ�ļ��м�������ز���


%% Main Function

% �����������Ƶ�����������С���ٶȣ��Աȶȣ������ٶȣ��˶������
Parameter_File.Test_VelocityTuning = 0;     % ������ Velocity Tuning Curve
Parameter_File.Test_WidthTuning = 0;        % ������ Width Tuning Curve
Parameter_File.Test_HeightTuning = 0;       % ������ Height Tuning Curve
Parameter_File.Test_ContrastTuning = 0;      % ������ Contrast Tuning Curve

% Parameters for Input Image Sequence

Parameter_File.folderName = 'Cluttered-Background-Curvilinear-Motion';    % 'Target-Detection-in-Cluttered-Background';  'Cluttered-Background-Curvilinear-Motion'
Parameter_File.BackgroundType = 'CB-4';                               % 1 ��ʾ���ӱ�����2 ��ʾ��Ϊ�ɾ��ı����� 0 ��ʾ�ޱ���
Parameter_File.TargetNum = 'SingleTarget';
% ���ڸı������С
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



% �����ļ������ڴ洢���� RecordedData
Parameter_File.folder_Global = ['Data\Data-for-DR-FA\',Parameter_File.BackgroundType,'\Velocity\','Velocity-',num2str(Velocity_Range(i_Velocity))];

if ~exist(Parameter_File.folder_Global,'dir')
    mkdir(Parameter_File.folder_Global)
end

% Title of Input Image Sequence
Parameter_File.Imagetitle = 'Synthetic-Stimuli';

% Start and end frame of input image sequence
Parameter_File.StartRecordFrame = 300;         % ��ʼ��¼���ݵ�֡
Parameter_File.StartFrame = 1;
Parameter_File.EndFrame = 1300;

% Cluttered Background   50 - 550  (����300֡ ����)
% White Background 500-1000        (����300֡ ����)

% Start and end frame of input image sequence
% ����һ�������ٶ� 

Frame_Target_In_Screen = floor((500*Parameter_File.VideoSamplingFrequency)/Parameter_File.TargetVelocity);

if Frame_Target_In_Screen<=1300
    Parameter_File.EndFrame = Frame_Target_In_Screen;
end

%% ���뺯�� ParameterSetting.m ������������Ĳ���

ParameterSetting

% ����ʱ�� ��Start Point��
tic;
timedLog('Start Motion Perception...')
%% ���� Main.m �ļ����� Input Image Sequence

file = [Parameter_File.folder_Global,'/','Recorded-Data.mat'];
if ~exist(file,'file')
    
    Main
    
end


clear Parameter_Fun
%===================================================================%
% ����ʱ�� ��End Point��  
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Motion Perception finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Motion Perception finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 

