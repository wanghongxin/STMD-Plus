% 2016-11-13


% 函数说明
% 该函数用于读取存储的 Tuning Curve 数据，并展示所有的 Tuning Curves

clear all; close all; clc;
%% Velocity Tuning

Velocity_Tuning_file = ['Data','/','Velocity-Tuning-Data.mat'];
load(Velocity_Tuning_file)

Target_Velocity_Range = [50 100 150 200 250 300 350 400 450 500 550 600 650 700 800 900 1000];
% 对每个 Velocity 记录 VelocityTuning_Frame 帧数据，对这些记录的数据取 Max
MaxValue_TQD_ON_VelocityTuning = max(TQD_ON_Responses_VelocityTuning,[],1);
MaxValue_TQD_OFF_VelocityTuning = max(TQD_OFF_Responses_VelocityTuning,[],1);
MaxValue_TQD_ON_OFF_VelocityTuning = max(TQD_ON_OFF_Responses_VelocityTuning,[],1);
MaxValue_DS_STMD_VelocityTuning = max(DS_STMD_Responses_VelocityTuning,[],1);

% Data Normalization
Normalized_MaxValue_TQD_ON_VelocityTuning = Data_Normalization([0 MaxValue_TQD_ON_VelocityTuning],[0,1]);
Normalized_MaxValue_TQD_OFF_VelocityTuning = Data_Normalization([0 MaxValue_TQD_OFF_VelocityTuning],[0,1]);
Normalized_MaxValue_TQD_ON_OFF_VelocityTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_VelocityTuning],[0,1]);
Normalized_MaxValue_DS_STMD_VelocityTuning = Data_Normalization([0 MaxValue_DS_STMD_VelocityTuning],[0,1]);

% figure
% plot([0 Target_Velocity_Range],Normalized_MaxValue_TQD_ON_VelocityTuning,'r','DisPlayName','TQD ON','linewidth',1)
% hold on
% plot([0 Target_Velocity_Range],Normalized_MaxValue_TQD_OFF_VelocityTuning,'b','DisPlayName','TQD OFF','linewidth',1)
% hold on
% plot([0 Target_Velocity_Range],Normalized_MaxValue_DS_STMD_VelocityTuning,'m','DisPlayName','DS-STMD','linewidth',1)
% grid on
% legend('show')
% title('Velocity Tuning Curves')


figure
plot([0 Target_Velocity_Range],Normalized_MaxValue_TQD_ON_OFF_VelocityTuning,'r','DisPlayName','LPTC','linewidth',1)
hold on
plot([0 Target_Velocity_Range],Normalized_MaxValue_DS_STMD_VelocityTuning,'b','DisPlayName','STMD','linewidth',1)
legend('show')
xlabel('Velocity')
ylabel('Neural Responses')

figure
plot([0 Target_Velocity_Range],Normalized_MaxValue_DS_STMD_VelocityTuning,'m','DisPlayName','DS-STMD','linewidth',1)
legend('show')
title('Velocity Tuning Curves')


%% Width Tuning
Width_Tuning_file = ['Data','/','Width-Tuning-Data.mat'];
load(Width_Tuning_file)

Target_Width_Range = [1 2 3 4 5 6 7 8 9 10 11 12 15 20];
% Method 1
% 对每个 Velocity 记录 VelocityTuning_Frame 帧数据，对这些记录的数据取 Max
MaxValue_TQD_ON_WidthTuning = max(TQD_ON_Responses_WidthTuning,[],1);
MaxValue_TQD_OFF_WidthTuning = max(TQD_OFF_Responses_WidthTuning,[],1);
MaxValue_TQD_ON_OFF_WidthTuning = max(TQD_ON_OFF_Responses_WidthTuning,[],1);
MaxValue_DS_STMD_WidthTuning = max(DS_STMD_Responses_WidthTuning,[],1);

% Data Normalization
Normalized_MaxValue_TQD_ON_WidthTuning = Data_Normalization([0 MaxValue_TQD_ON_WidthTuning],[0,1]);
Normalized_MaxValue_TQD_OFF_WidthTuning = Data_Normalization([0 MaxValue_TQD_OFF_WidthTuning],[0,1]);
Normalized_MaxValue_TQD_ON_OFF_WidthTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_WidthTuning],[0,1]);
Normalized_MaxValue_DS_STMD_WidthTuning = Data_Normalization([0 MaxValue_DS_STMD_WidthTuning],[0,1]);

% figure
% plot([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_WidthTuning,'r','DisPlayName','TQD ON','linewidth',1)
% hold on
% plot([0 Target_Width_Range], Normalized_MaxValue_TQD_OFF_WidthTuning,'b','DisPlayName','TQD OFF','linewidth',1)
% hold on
% plot([0 Target_Width_Range], Normalized_MaxValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD','linewidth',1)
% grid on
% legend('show')
% title('Width Tuning Curves')


figure
plot([0 Target_Width_Range], Normalized_MaxValue_TQD_ON_OFF_WidthTuning,'r','DisPlayName','LPTC','linewidth',1)
hold on
plot([0 Target_Width_Range], Normalized_MaxValue_DS_STMD_WidthTuning,'b','DisPlayName','STMD','linewidth',1)
legend('show')
xlabel('Width')
ylabel('Neural Responses')


figure
plot([0 Target_Width_Range], Normalized_MaxValue_DS_STMD_WidthTuning,'m','DisPlayName','DS-STMD','linewidth',1)
legend('show')
title('Width Tuning Curves')


%% Height Tuning
Height_Tuning_file = ['Data','/','Height-Tuning-Data.mat'];
load(Height_Tuning_file)

Target_Height_Range = [1 2 3 4 5 6 7 8 9 10 11 12 15 20];
% 对每个 Velocity 记录 VelocityTuning_Frame 帧数据，对这些记录的数据取 Max
MaxValue_TQD_ON_HeightTuning = max(TQD_ON_Responses_HeighthTuning,[],1);
MaxValue_TQD_OFF_HeightTuning = max(TQD_OFF_Responses_HeightTuning,[],1);
MaxValue_TQD_ON_OFF_HeightTuning = max(TQD_ON_OFF_Responses_HeightTuning,[],1);
MaxValue_DS_STMD_HeightTuning = max(DS_STMD_Responses_HeightTuning,[],1);

% Data Normalization
Normalized_MaxValue_TQD_ON_HeightTuning = Data_Normalization([0 MaxValue_TQD_ON_HeightTuning],[0,1]);
Normalized_MaxValue_TQD_OFF_HeightTuning = Data_Normalization([0 MaxValue_TQD_OFF_HeightTuning],[0,1]);
Normalized_MaxValue_TQD_ON_OFF_HeightTuning = Data_Normalization([0 MaxValue_TQD_ON_OFF_HeightTuning],[0,1]);
Normalized_MaxValue_DS_STMD_HeightTuning = Data_Normalization([0 MaxValue_DS_STMD_HeightTuning],[0,1]);

% figure
% plot([0 Target_Height_Range],Normalized_MaxValue_TQD_ON_HeightTuning,'r','DisPlayName','TQD ON','linewidth',1)
% hold on
% plot([0 Target_Height_Range],Normalized_MaxValue_TQD_OFF_HeightTuning,'b','DisPlayName','TQD OFF','linewidth',1)
% hold on
% plot([0 Target_Height_Range],Normalized_MaxValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD','linewidth',1)
% grid on
% legend('show')
% title('Height Tuning Curves')

figure
plot([0 Target_Height_Range],Normalized_MaxValue_TQD_ON_OFF_HeightTuning,'r','DisPlayName','LPTC','linewidth',1)
hold on
plot([0 Target_Height_Range],Normalized_MaxValue_DS_STMD_HeightTuning,'b','DisPlayName','STMD','linewidth',1)
legend('show')
xlabel('Height')
ylabel('Neural Responses')

figure
plot([0 Target_Height_Range],Normalized_MaxValue_DS_STMD_HeightTuning,'m','DisPlayName','DS-STMD','linewidth',1)
legend('show')
title('Height Tuning Curves')


%% LDTB Tuning
LDTB_Tuning_file = ['Data','/','Contrast-Tuning-Data.mat'];
load(LDTB_Tuning_file)

Target_Luminance_Range = [0 25 50 75 100 125 150 175 200 225 250];

%% 数据处理
% Method 1
% 对每个 LDTV 记录 ContrastTuning_Frame 帧数据，对这些记录的数据取 Max
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
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_TQD_ON_OFF_ContrastTuning,'r','DisPlayName','LPTC','linewidth',1)
hold on
plot(abs([Target_Luminance_Range, 255]-255)./255,Normalized_MaxValue_DS_STMD_ContrastTuning,'b','DisPlayName','STMD','linewidth',1)
legend('show')
xlabel('LDTB')
ylabel('Neural Responses')

saveas(gcf,'Figures\Contrast-Tuning-MaxValue-DS-STMD.fig')






