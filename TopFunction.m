% ����˵��
% �ú������ڼ�¼ Detection Rate and False Alarm Rate ���ߣ��ڲ�ͬ�� LDTB�� Size and
% Velocity �µ������˶�

clear all; close all; clc;

%% Main
% ���� DSTMD �ļ����ֵ
DSTMD_Detection_Threshold_Range = [1e5:-1e4:2e4,1e4:-1e3:2e3,1e3:-1e2:1e2];
Num_Detection_Threshold = length(DSTMD_Detection_Threshold_Range);

% ���ڴ洢 Detection Rate �� False Alarm Rate
All_DSTMD_Detection_Rate_Velocity = zeros(1,Num_Detection_Threshold);
All_DSTMD_False_Alarm_Velocity = zeros(1,Num_Detection_Threshold);
All_STMD_Plus_Detection_Rate_Velocity = zeros(1,Num_Detection_Threshold);
All_STMD_Plus_False_Alarm_Velocity = zeros(1,Num_Detection_Threshold);


%% ��ȡ�ļ��У����� Main.m ����������Ƶ
Read_In_Folder_Name

%% �� DSTMD ��������������ά�� Max ������ֻ������һ�μ���
Max_Operation_On_DSTMD_Outputs

for j_Velocity = 1:Num_Detection_Threshold
    
    % ȷ�� DS-STMD �����ֵ
    DSTMD_Detection_Threshold = DSTMD_Detection_Threshold_Range(j_Velocity);
    
    disp('=====================================================')
    disp(strcat('Detection Threshold = ',num2str(DSTMD_Detection_Threshold)))
    
    
    % ���ú��� Clustering_Detected_Points.m ���о�������
    Clustering_Detected_Points
    
    
    % �Ծ���Ľ�����з�������¼�˶��켣
    Recording_Target_Trace
    
    % ���ڼ�¼��չʾ�˶��켣����Ӧ�� T1 Neuron Outputs
    % չʾ�����켣�������Ҫ�� Show_Monophasic_Outputs_Along_Target_Trace.m ��ָ��
    Show_T1_Neuron_Outputs_Along_Target_Trace
    
    % ��¼ Ground Truth
    if ~exist('Ground_Truth','var')
        load([Parameter_File.folder0,'/','Ground-Truth.mat'])
    end
    
    % ���ڼ����㷨����ȷ��
    Calculate_Detection_Accuracy_and_False_Alarm
    
    All_DSTMD_Detection_Rate_Velocity(1,j_Velocity) = Detection_Rate_DSTMD;
    All_DSTMD_False_Alarm_Velocity(1,j_Velocity) = False_Alarm_Rate_DSTMD;
    All_STMD_Plus_Detection_Rate_Velocity(1,j_Velocity) = Detection_Rate_STMD_Plus;
    All_STMD_Plus_False_Alarm_Velocity(1,j_Velocity) = False_Alarm_Rate_STMD_Plus;
    
    
end

% ѭ�� i_Velocity ʱ���������¼�¼ Ground_Truth
clearvars Ground_Truth All_T1_Neuron_Outputs Max_Operation_DSTMD_Outputs

% ��ͼ

plot(All_DSTMD_False_Alarm_Velocity(1,:),All_DSTMD_Detection_Rate_Velocity(1,:),'color','r','LineStyle','-','Marker','>','DisPlayName','DSTMD','linewidth',1)
hold on
plot(All_STMD_Plus_False_Alarm_Velocity(1,:),All_STMD_Plus_Detection_Rate_Velocity(1,:),'color','b','LineStyle','-','Marker','o','DisPlayName','STMD Plus','linewidth',1)
hold on


legend('show')
axis([0,25,0,1])
xlabel('False Alarm Rate')
ylabel('Detection Rate')


% �洢����
file = [Parameter_File.folder_Global,'\','Detection-Rate-False-Alarm-Rate.mat'];
save(file,'DSTMD_Detection_Threshold_Range','All_DSTMD_Detection_Rate_Velocity','All_DSTMD_False_Alarm_Velocity','All_STMD_Plus_Detection_Rate_Velocity','All_STMD_Plus_False_Alarm_Velocity','-v7.3')


