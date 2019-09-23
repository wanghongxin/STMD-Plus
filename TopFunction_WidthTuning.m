% ����˵��
% �ú������ڵ��� Main.m����¼ TQD �� DS-STMD �� Velocity Tuning ����

clear all; close all; clc;

%% ���ڵ����������Ƶ�����������С���ٶȣ��Աȶȣ������ٶȣ��˶������
Test_VelocityTuning = 0;     % ������ Velocity Tuning Curve
Test_WidthTuning = 1; 
Test_HeightTuning = 0;
% ����һ֡��ʼ��¼���� ��EndFrame - VelocityTuning_Frame��
WidthTuning_Frame = 20;

% ȷ�������ٶȵı仯��Χ
Target_Width_Range = [1 2 3 4 5 6 7 8 9 10 11 12 15 20];


% �������ڴ洢 TQD �� DS-STMD ��Ӧ�ľ���
TQD_ON_Responses_WidthTuning = zeros(WidthTuning_Frame,length(Target_Width_Range));
TQD_OFF_Responses_WidthTuning = zeros(WidthTuning_Frame,length(Target_Width_Range));
TQD_ON_OFF_Responses_WidthTuning = zeros(WidthTuning_Frame,length(Target_Width_Range));
DS_STMD_Responses_WidthTuning = zeros(WidthTuning_Frame,length(Target_Width_Range));

tic;
timedLog('Start Record Width Tuning Curve ...')

for k = 1:length(Target_Width_Range)
    
    disp('======================================')
    disp(strcat('Target Width =  ',num2str(Target_Width_Range(k))))
    
    % Parameters for Input Image Sequence
    folderName = 'Width-Tuning';                     % 'Target-Detection-in-Cluttered-Background';
    BackgroundType = 'WhiteBackground';                 %  ClutteredBackground or WhiteBackground
    TargetNum = 'SingleTarget';
    TargetWidth = Target_Width_Range(k);
    TargetHeight = 5;
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
    
    TQD_ON_Responses_WidthTuning_EachStep = zeros(WidthTuning_Frame,1);
    TQD_OFF_Responses_WidthTuning_EachStep = zeros(WidthTuning_Frame,1);
    TQD_ON_OFF_Responses_WidthTuning_EachStep = zeros(WidthTuning_Frame,1);
    DS_STMD_Responses_WidthTuning_EachStep = zeros(WidthTuning_Frame,1);


    %% ���� Main.m �ļ����� Input Image Sequence
      
    Main
    
    %% ��¼ TQD �� DS-STMD ����Ӧ
    TQD_ON_Responses_WidthTuning(:,k) = TQD_ON_Responses_WidthTuning_EachStep;
    TQD_OFF_Responses_WidthTuning(:,k) = TQD_OFF_Responses_WidthTuning_EachStep;
    TQD_ON_OFF_Responses_WidthTuning(:,k) = TQD_ON_OFF_Responses_WidthTuning_EachStep;
    DS_STMD_Responses_WidthTuning(:,k) = DS_STMD_Responses_WidthTuning_EachStep;

end

% �洢��¼������
file = ['Data','/','Width-Tuning-Data.mat'];
save(file,'TQD_ON_Responses_WidthTuning','TQD_OFF_Responses_WidthTuning','TQD_ON_OFF_Responses_WidthTuning','DS_STMD_Responses_WidthTuning','-v7.3')

%% ���ݴ���
% Method 1
% ��ÿ�� Velocity ��¼ VelocityTuning_Frame ֡���ݣ�����Щ��¼������ȡ Max
MaxValue_TQD_ON_WidthTuning = max(TQD_ON_Responses_WidthTuning,[],1);
MaxValue_TQD_OFF_WidthTuning = max(TQD_OFF_Responses_WidthTuning,[],1);
MaxValue_TQD_ON_OFF_WidthTuning = max(TQD_ON_OFF_Responses_WidthTuning,[],1);
MaxValue_DS_STMD_WidthTuning = max(DS_STMD_Responses_WidthTuning,[],1);

% Data Normalization
Normalized_MaxValue_TQD_ON_WidthTuning = Data_Normalization([0 MaxValue_TQD_ON_WidthTuning],[0,1]);
Normalized_MaxValue_TQD_OFF_WidthTuning = Data_Normalization([0 MaxValue_TQD_OFF_WidthTuning],[0,1]);
Normalized_MaxValue_TQD_ON_OFF_WidthTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_WidthTuning],[0,1]);
Normalized_MaxValue_DS_STMD_WidthTuning = Data_Normalization([0 MaxValue_DS_STMD_WidthTuning],[0,1]);

figure
plot([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_WidthTuning,'r','DisPlayName','TQD ON')
hold on
plot([0 Target_Width_Range], Normalized_MaxValue_TQD_OFF_WidthTuning,'b','DisPlayName','TQD OFF')
hold on
plot([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_OFF_WidthTuning,'g','DisPlayName','TQD ON-OFF')
hold on
plot([0 Target_Width_Range], Normalized_MaxValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
% ����ͼƬ
saveas(gcf,'Figures\Width-Tuning-MaxValue.fig')


figure
plot([0 Target_Width_Range], Normalized_MaxValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
saveas(gcf,'Figures\Width-Tuning-MaxValue-DS-STMD.fig')


%---------------------- X (log)------------------------%
% �� X ��ȡ���������»��� Tuning ����
figure
semilogx([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_WidthTuning,'r','DisPlayName','TQD ON')
hold on
semilogx([0 Target_Width_Range], Normalized_MaxValue_TQD_OFF_WidthTuning,'b','DisPlayName','TQD OFF')
hold on
semilogx([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_OFF_WidthTuning,'g','DisPlayName','TQD ON-OFF')
hold on
semilogx([0 Target_Width_Range], Normalized_MaxValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Max Value')
% ����ͼƬ
saveas(gcf,'Figures\Width-Tuning-MaxValue-2.fig')

% Method 2
% ��ÿ�� Velocity ��¼ VelocityTuning_Frame ֡���ݣ�����Щ��¼������ȡ Mean
MeanValue_TQD_ON_WidthTuning = mean(TQD_ON_Responses_WidthTuning,1);
MeanValue_TQD_OFF_WidthTuning = mean(TQD_OFF_Responses_WidthTuning,1);
MeanValue_TQD_ON_OFF_WidthTuning = mean(TQD_ON_OFF_Responses_WidthTuning,1);
MeanValue_DS_STMD_WidthTuning = mean(DS_STMD_Responses_WidthTuning,1);

% Data Normalization
Normalized_MeanValue_TQD_ON_WidthTuning = Data_Normalization([0 MeanValue_TQD_ON_WidthTuning],[0,1]);
Normalized_MeanValue_TQD_OFF_WidthTuning = Data_Normalization([0 MeanValue_TQD_OFF_WidthTuning],[0,1]);
Normalized_MeanValue_TQD_ON_OFF_WidthTuning = Data_Normalization([0 MeanValue_TQD_ON_OFF_WidthTuning],[0,1]);
Normalized_MeanValue_DS_STMD_WidthTuning = Data_Normalization([0 MeanValue_DS_STMD_WidthTuning],[0,1]);

figure
plot([0 Target_Width_Range],Normalized_MeanValue_TQD_ON_WidthTuning,'r','DisPlayName','TQD ON')
hold on
plot([0 Target_Width_Range],Normalized_MeanValue_TQD_OFF_WidthTuning,'b','DisPlayName','TQD OFF')
hold on
plot([0 Target_Width_Range],Normalized_MeanValue_TQD_ON_OFF_WidthTuning,'g','DisPlayName','TQD ON-OFF')
hold on
plot([0 Target_Width_Range],Normalized_MeanValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Mean Value')
% ����ͼƬ
saveas(gcf,'Figures\Width-Tuning-MeanValue.fig')


figure
plot([0 Target_Width_Range],Normalized_MeanValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Mean Value')
saveas(gcf,'Figures\Width-Tuning-MeanValue-DS-STMD.fig')




%---------------------- X (log)------------------------%
% �� X ��ȡ���������»��� Tuning ����
figure
semilogx([0 Target_Width_Range],Normalized_MeanValue_TQD_ON_WidthTuning,'r','DisPlayName','TQD ON')
hold on
semilogx([0 Target_Width_Range],Normalized_MeanValue_TQD_OFF_WidthTuning,'b','DisPlayName','TQD OFF')
hold on
semilogx([0 Target_Width_Range],Normalized_MeanValue_TQD_ON_OFF_WidthTuning,'g','DisPlayName','TQD ON-OFF')
hold on
semilogx([0 Target_Width_Range],Normalized_MeanValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD')
grid on
legend('show')
title('Mean Value')
% ����ͼƬ
saveas(gcf,'Figures\Width-Tuning-MeanValue-2.fig')


%====================== ��¼ʱ�� ===========================%
timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Recording finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Recording finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 