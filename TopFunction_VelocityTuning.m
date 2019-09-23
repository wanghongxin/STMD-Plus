% ����˵��
% �ú������ڵ��� Main.m����¼ TQD �� DS-STMD �� Velocity Tuning ����

clear all; close all; clc;

%% ���ڵ����������Ƶ�����������С���ٶȣ��Աȶȣ������ٶȣ��˶������

Test_VelocityTuning = 1; 
Test_WidthTuning = 0; 
Test_HeightTuning = 0;
% ����һ֡��ʼ��¼���� ��EndFrame - VelocityTuning_Frame��
VelocityTuning_Frame = 20;

% ȷ�������ٶȵı仯��Χ
Target_Velocity_Range = [50 100 150 200 250 300 350 400 450 500 550 600 650 700 800 900 1000];

% �������ڴ洢 TQD �� DS-STMD ��Ӧ�ľ���
TQD_ON_Responses_VelocityTuning = zeros(VelocityTuning_Frame,length(Target_Velocity_Range));
TQD_OFF_Responses_VelocityTuning = zeros(VelocityTuning_Frame,length(Target_Velocity_Range));
TQD_ON_OFF_Responses_VelocityTuning = zeros(VelocityTuning_Frame,length(Target_Velocity_Range));
DS_STMD_Responses_VelocityTuning = zeros(VelocityTuning_Frame,length(Target_Velocity_Range));

tic;
timedLog('Start Record Velocity Tuning Curve ...')

for k = 1:length(Target_Velocity_Range)
    
    disp('======================================')
    disp(strcat('Target Velocity =  ',num2str(Target_Velocity_Range(k))))
    
    % Parameters for Input Image Sequence
    folderName = 'Velocity-Tuning';                     % 'Target-Detection-in-Cluttered-Background';
    BackgroundType = 'WhiteBackground';                 %  ClutteredBackground or WhiteBackground
    TargetNum = 'SingleTarget';
    TargetWidth = 5;
    TargetHeight = 5;
    TargetVelocity = Target_Velocity_Range(k);         % ȷ�������˶��ٶ�
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

    %% ���뺯�� ParameterSetting.m ������������Ĳ���

    ParameterSetting
    
    %% ���ɼ�¼ÿ��ѭ����Ӧ�ľ���
    
    TQD_ON_Responses_VelocityTuning_EachStep = zeros(VelocityTuning_Frame,1);
    TQD_OFF_Responses_VelocityTuning_EachStep = zeros(VelocityTuning_Frame,1);
    TQD_ON_OFF_Responses_VelocityTuning_EachStep = zeros(VelocityTuning_Frame,1);
    DS_STMD_Responses_VelocityTuning_EachStep = zeros(VelocityTuning_Frame,1);


    %% ���� Main.m �ļ����� Input Image Sequence
      
    Main
    
    %% ��¼ TQD �� DS-STMD ����Ӧ
    TQD_ON_Responses_VelocityTuning(:,k) = TQD_ON_Responses_VelocityTuning_EachStep;
    TQD_OFF_Responses_VelocityTuning(:,k) = TQD_OFF_Responses_VelocityTuning_EachStep;
    TQD_ON_OFF_Responses_VelocityTuning(:,k) = TQD_ON_OFF_Responses_VelocityTuning_EachStep;
    DS_STMD_Responses_VelocityTuning(:,k) = DS_STMD_Responses_VelocityTuning_EachStep;
    


end
% �洢��¼������
file = ['Data','/','Velocity-Tuning-Data.mat'];
save(file,'TQD_ON_Responses_VelocityTuning','TQD_OFF_Responses_VelocityTuning','TQD_ON_OFF_Responses_VelocityTuning','DS_STMD_Responses_VelocityTuning','-v7.3')

%% ���ݴ���
% Method 1
% ��ÿ�� Velocity ��¼ VelocityTuning_Frame ֡���ݣ�����Щ��¼������ȡ Max
MaxValue_TQD_ON_VelocityTuning = max(TQD_ON_Responses_VelocityTuning,[],1);
MaxValue_TQD_OFF_VelocityTuning = max(TQD_OFF_Responses_VelocityTuning,[],1);
MaxValue_TQD_ON_OFF_VelocityTuning = max(TQD_ON_OFF_Responses_VelocityTuning,[],1);
MaxValue_DS_STMD_VelocityTuning = max(DS_STMD_Responses_VelocityTuning,[],1);

% Data Normalization
Normalized_MaxValue_TQD_ON_VelocityTuning = Data_Normalization([0 MaxValue_TQD_ON_VelocityTuning],[0,1]);
Normalized_MaxValue_TQD_OFF_VelocityTuning = Data_Normalization([0 MaxValue_TQD_OFF_VelocityTuning],[0,1]);
Normalized_MaxValue_TQD_ON_OFF_VelocityTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_VelocityTuning],[0,1]);
Normalized_MaxValue_DS_STMD_VelocityTuning = Data_Normalization([0 MaxValue_DS_STMD_VelocityTuning],[0,1]);

figure
plot([0 Target_Velocity_Range],Normalized_MaxValue_TQD_ON_VelocityTuning,'r','DisPlayName','TQD ON')
hold on
plot([0 Target_Velocity_Range],Normalized_MaxValue_TQD_OFF_VelocityTuning,'b','DisPlayName','TQD OFF')
hold on
plot([0 Target_Velocity_Range],Normalized_MaxValue_TQD_ON_OFF_VelocityTuning,'g','DisPlayName','TQD ON-OFF')
hold on
plot([0 Target_Velocity_Range],Normalized_MaxValue_DS_STMD_VelocityTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
% ����ͼƬ
saveas(gcf,'Figures\Velocity-Tuning-MaxValue.fig')


figure
plot([0 Target_Velocity_Range],Normalized_MaxValue_DS_STMD_VelocityTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
saveas(gcf,'Figures\Velocity-Tuning-MaxValue-DS-STMD.fig')



%---------------------- X (log)------------------------%
% �� X ��ȡ���������»��� Tuning ����
figure
semilogx([0 Target_Velocity_Range],Normalized_MaxValue_TQD_ON_VelocityTuning,'r','DisPlayName','TQD ON')
hold on
semilogx([0 Target_Velocity_Range],Normalized_MaxValue_TQD_OFF_VelocityTuning,'b','DisPlayName','TQD OFF')
hold on
semilogx([0 Target_Velocity_Range],Normalized_MaxValue_TQD_ON_OFF_VelocityTuning,'g','DisPlayName','TQD ON-OFF')
hold on
semilogx([0 Target_Velocity_Range],Normalized_MaxValue_DS_STMD_VelocityTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
saveas(gcf,'Figures\Velocity-Tuning-MaxValue-2.fig')

% Method 2
% ��ÿ�� Velocity ��¼ VelocityTuning_Frame ֡���ݣ�����Щ��¼������ȡ Mean
MeanValue_TQD_ON_VelocityTuning = mean(TQD_ON_Responses_VelocityTuning,1);
MeanValue_TQD_OFF_VelocityTuning = mean(TQD_OFF_Responses_VelocityTuning,1);
MeanValue_TQD_ON_OFF_VelocityTuning = mean(TQD_ON_OFF_Responses_VelocityTuning,1);
MeanValue_DS_STMD_VelocityTuning = mean(DS_STMD_Responses_VelocityTuning,1);

% Data Normalization
Normalized_MeanValue_TQD_ON_VelocityTuning = Data_Normalization([0 MeanValue_TQD_ON_VelocityTuning],[0,1]);
Normalized_MeanValue_TQD_OFF_VelocityTuning = Data_Normalization([0 MeanValue_TQD_OFF_VelocityTuning],[0,1]);
Normalized_MeanValue_TQD_ON_OFF_VelocityTuning = Data_Normalization([0 MeanValue_TQD_ON_OFF_VelocityTuning],[0,1]);
Normalized_MeanValue_DS_STMD_VelocityTuning = Data_Normalization([0 MeanValue_DS_STMD_VelocityTuning],[0,1]);

figure
plot([0 Target_Velocity_Range],Normalized_MeanValue_TQD_ON_VelocityTuning,'r','DisPlayName','TQD ON')
hold on
plot([0 Target_Velocity_Range],Normalized_MeanValue_TQD_OFF_VelocityTuning,'b','DisPlayName','TQD OFF')
hold on
plot([0 Target_Velocity_Range],Normalized_MeanValue_TQD_ON_OFF_VelocityTuning,'g','DisPlayName','TQD ON-OFF')
hold on
plot([0 Target_Velocity_Range],Normalized_MeanValue_DS_STMD_VelocityTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Mean Value')
saveas(gcf,'Figures\Velocity-Tuning-MeanValue.fig')

figure
plot([0 Target_Velocity_Range],Normalized_MeanValue_DS_STMD_VelocityTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Mean Value')
saveas(gcf,'Figures\Velocity-Tuning-MeanValue-DS-STMD.fig')

%---------------------- X (log)------------------------%
% �� X ��ȡ���������»��� Tuning ����
figure
semilogx([0 Target_Velocity_Range],Normalized_MeanValue_TQD_ON_VelocityTuning,'r','DisPlayName','TQD ON')
hold on
semilogx([0 Target_Velocity_Range],Normalized_MeanValue_TQD_OFF_VelocityTuning,'b','DisPlayName','TQD OFF')
hold on
semilogx([0 Target_Velocity_Range],Normalized_MeanValue_TQD_ON_OFF_VelocityTuning,'g','DisPlayName','TQD ON-OFF')
hold on
semilogx([0 Target_Velocity_Range],Normalized_MeanValue_DS_STMD_VelocityTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Mean Value')
saveas(gcf,'Figures\Velocity-Tuning-MeanValue-2.fig')

%====================== ��¼ʱ�� ===========================%
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Recording finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Recording finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 