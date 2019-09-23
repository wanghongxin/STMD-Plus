% 2016-11-14

% ����˵��
% �ú������ڶ� DS-STMD �����������ڸ�����ֵ�½��о���
% ���ţ����ھ�����������Ӧ���˶��켣
% ��󣬶��ض����˶��켣�����Ӧ�� Monophasic Outputs


%% Main Function
clear all; close all; clc;

% �� DS-STMD ��������������ά�� Max ������ֻ������һ�μ���
if ~exist('Max_Operation_DS_STMD_Outputs','var')
    if ~exist('Data\Max_Operation_DS_STMD_Outputs.mat','file')
        Max_Operation_On_DS_STMD_Outputs
    else
        load('Data\Max_Operation_DS_STMD_Outputs.mat')
    end
end

% ���� DS-STMD �ļ����ֵ
DS_STMD_Detection_Threshold_Range = 500:-25:50;
Num_Detection_Threshold = length(DS_STMD_Detection_Threshold_Range);

% ���ڴ洢 Detection Rate �� False Alarm Rate
All_DS_STMD_Detection_Rate = zeros(1,Num_Detection_Threshold);
All_DS_STMD_False_Alarm = zeros(1,Num_Detection_Threshold);
All_Visual_System_Detection_Rate = zeros(1,Num_Detection_Threshold);
All_Visual_System_False_Alarm = zeros(1,Num_Detection_Threshold);


for ll = 1:Num_Detection_Threshold
    
    % �� DS-STMD ��������о���
    % �� DS-STMD �������Ҫ���ȸ�����ֵ Detection_Threshold
    
    % ȷ�������ֵ ��DS-STMD Model��
    DS_STMD_Detection_Threshold = DS_STMD_Detection_Threshold_Range(ll);
    
    disp('=====================================================')
    disp(strcat('Detection Threshold = ',num2str(DS_STMD_Detection_Threshold)))
    % ���ú��� Clustering_Detected_Points.m ���о�������
    Clustering_Detected_Points
    
    
    % �Ծ���Ľ�����з�������¼�˶��켣
    
    Recording_Target_Trace
    
    
%     % ����չʾ���������˶��켣
%     close all;
%     Show_Clustering_Results

%     Show_Target_Trace

    
    % ����չʾ�˶��켣����Ӧ�� T1 Neuron Outputs
    % չʾ�����켣�������Ҫ�� Show_Monophasic_Outputs_Along_Target_Trace.m ��ָ��
    Show_T1_Neuron_Outputs_Along_Target_Trace

    
    % ���ڼ����㷨����ȷ��
    Calculate_Detection_Accuracy_and_False_Alarm
    
    All_DS_STMD_Detection_Rate(ll) = Detection_Rate_DS_STMD;
    All_DS_STMD_False_Alarm(ll) = False_Alarm_Rate_DS_STMD;
    All_Visual_System_Detection_Rate(ll) = Detection_Rate_System;
    All_Visual_System_False_Alarm(ll) = False_Alarm_Rate_System;
    
end

% ���� False Alarm �� Detection Rate ������ͼ

figure
plot(All_DS_STMD_False_Alarm,All_DS_STMD_Detection_Rate,'r>-','DisPlayName','DS-STMD','linewidth',1)
hold on
plot(All_Visual_System_False_Alarm,All_Visual_System_Detection_Rate,'bo-','DisPlayName','Visual-System','linewidth',1)
legend('show')
grid on
axis([0,25,0,1])
xlabel('False Alarm Rate')
ylabel('Detection Rate')

% �洢����
file = ['Data','/','Detection-Rate-False-Alarm-Rate.mat'];
save(file,'DS_STMD_Detection_Threshold_Range','All_DS_STMD_Detection_Rate','All_DS_STMD_False_Alarm','All_Visual_System_Detection_Rate','All_Visual_System_False_Alarm','-v7.3')





