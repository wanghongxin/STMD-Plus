% ����˵��
% �ú������ڵ��� Main.m����¼ TQD �� DS-STMD �� Velocity Tuning ����

clear all; close all; clc;

%% ���ڵ����������Ƶ�����������С���ٶȣ��Աȶȣ������ٶȣ��˶������
Test_VelocityTuning = 0;     % ������ Velocity Tuning Curve
Test_WidthTuning = 0; 
Test_HeightTuning = 1; 

% ����һ֡��ʼ��¼���� ��EndFrame - VelocityTuning_Frame��
HeightTuning_Frame = 20;

% ȷ�������ٶȵı仯��Χ
Target_Height_Range = [1 2 3 4 5 6 7 8 9 10 11 12 15 20];

% �������ڴ洢 TQD �� DS-STMD ��Ӧ�ľ���
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
    TargetVelocity = 250;         % ȷ�������˶��ٶ�
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
    
    TQD_ON_Responses_HeightTuning_EachStep = zeros(HeightTuning_Frame,1);
    TQD_OFF_Responses_HeightTuning_EachStep = zeros(HeightTuning_Frame,1);
    TQD_ON_OFF_Responses_HeightTuning_EachStep = zeros(HeightTuning_Frame,1);
    DS_STMD_Responses_HeightTuning_EachStep = zeros(HeightTuning_Frame,1);


    %% ���� Main.m �ļ����� Input Image Sequence
      
    Main
    
    %% ��¼ TQD �� DS-STMD ����Ӧ
    TQD_ON_Responses_HeighthTuning(:,k) = TQD_ON_Responses_HeightTuning_EachStep;
    TQD_OFF_Responses_HeightTuning(:,k) = TQD_OFF_Responses_HeightTuning_EachStep;
    TQD_ON_OFF_Responses_HeightTuning(:,k) = TQD_ON_OFF_Responses_HeightTuning_EachStep;
    DS_STMD_Responses_HeightTuning(:,k) = DS_STMD_Responses_HeightTuning_EachStep;

end

% �洢��¼������
file = ['Data','/','Height-Tuning-Data.mat'];
save(file,'TQD_ON_Responses_HeighthTuning','TQD_OFF_Responses_HeightTuning','TQD_ON_OFF_Responses_HeightTuning','DS_STMD_Responses_HeightTuning','-v7.3')


%% ���ݴ���
% Method 1
% ��ÿ�� Velocity ��¼ VelocityTuning_Frame ֡���ݣ�����Щ��¼������ȡ Max
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
% ����ͼƬ
saveas(gcf,'Figures\Height-Tuning-MaxValue.fig')

figure
plot([0 Target_Height_Range],Normalized_MaxValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
saveas(gcf,'Figures\Height-Tuning-MaxValue-DS-STMD.fig')



%---------------------- X (log)------------------------%
% �� X ��ȡ���������»��� Tuning ����
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
% ����ͼƬ
saveas(gcf,'Figures\Height-Tuning-MaxValue-2.fig')

% Method 2
% ��ÿ�� Velocity ��¼ VelocityTuning_Frame ֡���ݣ�����Щ��¼������ȡ Mean
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
% ����ͼƬ
saveas(gcf,'Figures\Height-Tuning-MeanValue.fig')



figure
plot([0 Target_Height_Range],Normalized_MeanValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD')
grid on
legend('Mean Value')
saveas(gcf,'Figures\Height-Tuning-MeanValue-DS-STMD.fig')

%---------------------- X (log)------------------------%
% �� X ��ȡ���������»��� Tuning ����
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
% ����ͼƬ
saveas(gcf,'Figures\Height-Tuning-MeanValue-2.fig')


%====================== ��¼ʱ�� ===========================%
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Recording finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Recording finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 