% ����˵��
% �ú����� TopFunction_TargetTracking_LDTB_Velocity_Size.m �У���ȡ�ļ��м�������ز���


%% Main Function

% Path of Input Image Sequence
Parameter_File.folder0 = 'Test-Image-Sequence';


% �����ļ������ڴ洢���� RecordedData
Parameter_File.folder_Global = ['Result\Data-for-DR-FA\',Parameter_File.folder0];

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

