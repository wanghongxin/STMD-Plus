% ����˵��
% �ú������ڼ�¼ Detection Rate and False Alarm Rate ���ߣ��ڲ�ͬ�� LDTB�� Size and
% Velocity �µ������˶�


clear all; close all; clc;

%% Main
Is_DR_FA_LDTB = 0;
Is_DR_FA_Size = 0;
Is_DR_FA_Velocity = 1;
Is_DR_FA_BackgroundVelocity = 0;

% ���� DS-STMD �ļ����ֵ
DS_STMD_Detection_Threshold_Range = [1000:-25:50,45:-5:10,9:-1:1];
Num_Detection_Threshold = length(DS_STMD_Detection_Threshold_Range);

%% LDTB (Luminance Difference Between Target and Background)
if Is_DR_FA_LDTB == 1
    LDTB_Range = [15 25 40 50 65 75];
    
    % ���ڴ洢 Detection Rate �� False Alarm Rate
    All_DS_STMD_Detection_Rate_LDTB = zeros(length(LDTB_Range),Num_Detection_Threshold);
    All_DS_STMD_False_Alarm_LDTB = zeros(length(LDTB_Range),Num_Detection_Threshold);
    All_Visual_System_Detection_Rate_LDTB = zeros(length(LDTB_Range),Num_Detection_Threshold);
    All_Visual_System_False_Alarm_LDTB = zeros(length(LDTB_Range),Num_Detection_Threshold);
    
    
    MarkerEdgeColors = jet(length(LDTB_Range));
    
    figure
    for i_LDTB = 1:length(LDTB_Range)
        
        
        % ��ȡ�ļ��У����� Main.m ����������Ƶ
        Read_In_Folder_Name_LDTB
        
        % �� DS-STMD ��������������ά�� Max ������ֻ������һ�μ���
        Max_Operation_On_DS_STMD_Outputs
        
        for j_LDTB = 1:Num_Detection_Threshold
            
            % ȷ�� DS-STMD �����ֵ
            DS_STMD_Detection_Threshold = DS_STMD_Detection_Threshold_Range(j_LDTB);
            
            disp('=====================================================')
            disp(strcat('Luminance Between Target and Background = ', num2str(LDTB_Range(i_LDTB))))
            disp(strcat('Detection Threshold = ',num2str(DS_STMD_Detection_Threshold)))
            
            
            % ���ú��� Clustering_Detected_Points.m ���о�������
            Clustering_Detected_Points
            
            
            % �Ծ���Ľ�����з�������¼�˶��켣
            Recording_Target_Trace
            
            % ���ڼ�¼��չʾ�˶��켣����Ӧ�� T1 Neuron Outputs
            % չʾ�����켣�������Ҫ�� Show_Monophasic_Outputs_Along_Target_Trace.m ��ָ��
            Show_T1_Neuron_Outputs_Along_Target_Trace
            
            % ��¼ Ground Truth
            if ~exist('Ground_Truth','var')
                if ~exist(strcat(Parameter_File.folder_Global,'/','Ground-Truth.mat'),'file')
                    Calculate_Ground_Truth_Target_Positions
                else
                    load([Parameter_File.folder_Global,'/','Ground-Truth.mat'])
                end
            end
            
            % ���ڼ����㷨����ȷ��
            Calculate_Detection_Accuracy_and_False_Alarm
            
            All_DS_STMD_Detection_Rate_LDTB(i_LDTB,j_LDTB) = Detection_Rate_DS_STMD;
            All_DS_STMD_False_Alarm_LDTB(i_LDTB,j_LDTB) = False_Alarm_Rate_DS_STMD;
            All_Visual_System_Detection_Rate_LDTB(i_LDTB,j_LDTB) = Detection_Rate_System;
            All_Visual_System_False_Alarm_LDTB(i_LDTB,j_LDTB) = False_Alarm_Rate_System;
            
            
        end
        
        % ѭ�� i_LDTB ʱ���������¼�¼ Ground_Truth
        
        clearvars Ground_Truth All_T1_Neuron_Outputs  Max_Operation_DS_STMD_Outputs
        
        % ��ͼ
        
        plot(All_DS_STMD_False_Alarm_LDTB(i_LDTB,:),All_DS_STMD_Detection_Rate_LDTB(i_LDTB,:),'color',MarkerEdgeColors(i_LDTB,:),'LineStyle','-','Marker','>','DisPlayName',strcat('DS-STMD-LDTB-',num2str(LDTB_Range(i_LDTB))),'linewidth',1)
        hold on
        plot(All_Visual_System_False_Alarm_LDTB(i_LDTB,:),All_Visual_System_Detection_Rate_LDTB(i_LDTB,:),'color',MarkerEdgeColors(i_LDTB,:),'LineStyle','-','Marker','o','DisPlayName',strcat('Visual-System-LDTB-',num2str(LDTB_Range(i_LDTB))),'linewidth',1)
        hold on
        
    end
    
    legend('show')
    axis([0,25,0,1])
    xlabel('False Alarm Rate')
    ylabel('Detection Rate')
    
    
    % �洢����
    file = ['Data\Data-for-DR-FA\',Parameter_File.BackgroundType,'\LDTB\','Detection-Rate-False-Alarm-Rate.mat'];
    save(file,'DS_STMD_Detection_Threshold_Range','All_DS_STMD_Detection_Rate_LDTB','All_DS_STMD_False_Alarm_LDTB','All_Visual_System_Detection_Rate_LDTB','All_Visual_System_False_Alarm_LDTB','-v7.3')
    
end

%% Size
if Is_DR_FA_Size == 1
    
    Size_Range = [1000];
    
    % ���ڴ洢 Detection Rate �� False Alarm Rate
    All_DS_STMD_Detection_Rate_Size = zeros(length(Size_Range),Num_Detection_Threshold);
    All_DS_STMD_False_Alarm_Size = zeros(length(Size_Range),Num_Detection_Threshold);
    All_Visual_System_Detection_Rate_Size = zeros(length(Size_Range),Num_Detection_Threshold);
    All_Visual_System_False_Alarm_Size = zeros(length(Size_Range),Num_Detection_Threshold);
    
    
    MarkerEdgeColors = jet(length(Size_Range));
    
    figure
    for i_Size = 1:length(Size_Range)
        
        
        % ��ȡ�ļ��У����� Main.m ����������Ƶ
        Read_In_Folder_Name_Size
        
        % �� DS-STMD ��������������ά�� Max ������ֻ������һ�μ���
        Max_Operation_On_DS_STMD_Outputs
        
        for j_Size = 1:Num_Detection_Threshold
            
            % ȷ�� DS-STMD �����ֵ
            DS_STMD_Detection_Threshold = DS_STMD_Detection_Threshold_Range(j_Size);
            
            disp('=====================================================')
            disp(strcat('Target Size = ', num2str(Size_Range(i_Size))))
            disp(strcat('Detection Threshold = ',num2str(DS_STMD_Detection_Threshold)))
            
            
            % ���ú��� Clustering_Detected_Points.m ���о�������
            Clustering_Detected_Points
            
            
            % �Ծ���Ľ�����з�������¼�˶��켣
            Recording_Target_Trace
            
            % ���ڼ�¼��չʾ�˶��켣����Ӧ�� T1 Neuron Outputs
            % չʾ�����켣�������Ҫ�� Show_Monophasic_Outputs_Along_Target_Trace.m ��ָ��
            Show_T1_Neuron_Outputs_Along_Target_Trace
            
            % ��¼ Ground Truth
            if ~exist('Ground_Truth','var')
                if ~exist(strcat(Parameter_File.folder_Global,'/','Ground-Truth.mat'),'file')
                    Calculate_Ground_Truth_Target_Positions
                else
                    load([Parameter_File.folder_Global,'/','Ground-Truth.mat'])
                end
            end
            
            % ���ڼ����㷨����ȷ��
            Calculate_Detection_Accuracy_and_False_Alarm
            
            All_DS_STMD_Detection_Rate_Size(i_Size,j_Size) = Detection_Rate_DS_STMD;
            All_DS_STMD_False_Alarm_Size(i_Size,j_Size) = False_Alarm_Rate_DS_STMD;
            All_Visual_System_Detection_Rate_Size(i_Size,j_Size) = Detection_Rate_System;
            All_Visual_System_False_Alarm_Size(i_Size,j_Size) = False_Alarm_Rate_System;
            
            
        end
        
        % ѭ�� i_Size ʱ���������¼�¼ Ground_Truth
        clearvars Ground_Truth All_T1_Neuron_Outputs Max_Operation_DS_STMD_Outputs
        
        %��ͼ
        
        plot(All_DS_STMD_False_Alarm_Size(i_Size,:),All_DS_STMD_Detection_Rate_Size(i_Size,:),'color',MarkerEdgeColors(i_Size,:),'LineStyle','-','Marker','>','DisPlayName',strcat('DS-STMD-Size-',num2str(Size_Range(i_Size))),'linewidth',1)
        hold on
        plot(All_Visual_System_False_Alarm_Size(i_Size,:),All_Visual_System_Detection_Rate_Size(i_Size,:),'color',MarkerEdgeColors(i_Size,:),'LineStyle','-','Marker','o','DisPlayName',strcat('Visual-System-Size-',num2str(Size_Range(i_Size))),'linewidth',1)
        hold on
        
    end
    
    legend('show')
    axis([0,25,0,1])
    xlabel('False Alarm Rate')
    ylabel('Detection Rate')
    
    
    % �洢����
    file = ['Data\Data-for-DR-FA\',Parameter_File.BackgroundType,'\Size\','Detection-Rate-False-Alarm-Rate.mat'];
    save(file,'DS_STMD_Detection_Threshold_Range','All_DS_STMD_Detection_Rate_Size','All_DS_STMD_False_Alarm_Size','All_Visual_System_Detection_Rate_Size','All_Visual_System_False_Alarm_Size','-v7.3')
    
end

%% Velocity
if Is_DR_FA_Velocity == 1
    
    Velocity_Range = [250];
    
    % ���ڴ洢 Detection Rate �� False Alarm Rate
    All_DS_STMD_Detection_Rate_Velocity = zeros(length(Velocity_Range),Num_Detection_Threshold);
    All_DS_STMD_False_Alarm_Velocity = zeros(length(Velocity_Range),Num_Detection_Threshold);
    All_Visual_System_Detection_Rate_Velocity = zeros(length(Velocity_Range),Num_Detection_Threshold);
    All_Visual_System_False_Alarm_Velocity = zeros(length(Velocity_Range),Num_Detection_Threshold);
    
    
    MarkerEdgeColors = jet(length(Velocity_Range));
    
    figure
    for i_Velocity = 1:length(Velocity_Range)
        
        
        % ��ȡ�ļ��У����� Main.m ����������Ƶ
        Read_In_Folder_Name_Velocity
        
        % �� DS-STMD ��������������ά�� Max ������ֻ������һ�μ���
        Max_Operation_On_DS_STMD_Outputs
        
        for j_Velocity = 1:Num_Detection_Threshold
            
            % ȷ�� DS-STMD �����ֵ
            DS_STMD_Detection_Threshold = DS_STMD_Detection_Threshold_Range(j_Velocity);
            
            disp('=====================================================')
            disp(strcat('Target Velocity = ', num2str(Velocity_Range(i_Velocity))))
            disp(strcat('Detection Threshold = ',num2str(DS_STMD_Detection_Threshold)))
            
            
            % ���ú��� Clustering_Detected_Points.m ���о�������
            Clustering_Detected_Points
            
            
            % �Ծ���Ľ�����з�������¼�˶��켣
            Recording_Target_Trace
            
            % ���ڼ�¼��չʾ�˶��켣����Ӧ�� T1 Neuron Outputs
            % չʾ�����켣�������Ҫ�� Show_Monophasic_Outputs_Along_Target_Trace.m ��ָ��
            Show_T1_Neuron_Outputs_Along_Target_Trace
            
            % ��¼ Ground Truth
            if ~exist('Ground_Truth','var')
                if ~exist(strcat(Parameter_File.folder_Global,'/','Ground-Truth.mat'),'file')
                    Calculate_Ground_Truth_Target_Positions
                else
                    load([Parameter_File.folder_Global,'/','Ground-Truth.mat'])
                end
            end
            
            % ���ڼ����㷨����ȷ��
            Calculate_Detection_Accuracy_and_False_Alarm
            
            All_DS_STMD_Detection_Rate_Velocity(i_Velocity,j_Velocity) = Detection_Rate_DS_STMD;
            All_DS_STMD_False_Alarm_Velocity(i_Velocity,j_Velocity) = False_Alarm_Rate_DS_STMD;
            All_Visual_System_Detection_Rate_Velocity(i_Velocity,j_Velocity) = Detection_Rate_System;
            All_Visual_System_False_Alarm_Velocity(i_Velocity,j_Velocity) = False_Alarm_Rate_System;
            
            
        end
        
        % ѭ�� i_Velocity ʱ���������¼�¼ Ground_Truth
        clearvars Ground_Truth All_T1_Neuron_Outputs Max_Operation_DS_STMD_Outputs
        
        % ��ͼ
        
        plot(All_DS_STMD_False_Alarm_Velocity(i_Velocity,:),All_DS_STMD_Detection_Rate_Velocity(i_Velocity,:),'color',MarkerEdgeColors(i_Velocity,:),'LineStyle','-','Marker','>','DisPlayName',strcat('DS-STMD-Velocity-',num2str(Velocity_Range(i_Velocity))),'linewidth',1)
        hold on
        plot(All_Visual_System_False_Alarm_Velocity(i_Velocity,:),All_Visual_System_Detection_Rate_Velocity(i_Velocity,:),'color',MarkerEdgeColors(i_Velocity,:),'LineStyle','-','Marker','o','DisPlayName',strcat('Visual-System-Velocity-',num2str(Velocity_Range(i_Velocity))),'linewidth',1)
        hold on
        
    end
    
    legend('show')
    axis([0,25,0,1])
    xlabel('False Alarm Rate')
    ylabel('Detection Rate')
    
    
    % �洢����
    file = ['Data\Data-for-DR-FA\',Parameter_File.BackgroundType,'\Velocity\','Detection-Rate-False-Alarm-Rate.mat'];
    save(file,'DS_STMD_Detection_Threshold_Range','All_DS_STMD_Detection_Rate_Velocity','All_DS_STMD_False_Alarm_Velocity','All_Visual_System_Detection_Rate_Velocity','All_Visual_System_False_Alarm_Velocity','-v7.3')
    
end


%% Varying Background Velocity
if Is_DR_FA_BackgroundVelocity == 1
    
    BackgroundVelocity_Range = [100 150 250 300 350 450 500];
    
    % ���ڴ洢 Detection Rate �� False Alarm Rate
    All_DS_STMD_Detection_Rate_BackgroundVelocity = zeros(length(BackgroundVelocity_Range),Num_Detection_Threshold);
    All_DS_STMD_False_Alarm_BackgroundVelocity = zeros(length(BackgroundVelocity_Range),Num_Detection_Threshold);
    All_Visual_System_Detection_Rate_BackgroundVelocity = zeros(length(BackgroundVelocity_Range),Num_Detection_Threshold);
    All_Visual_System_False_Alarm_BackgroundVelocity = zeros(length(BackgroundVelocity_Range),Num_Detection_Threshold);
    
    
    MarkerEdgeColors = jet(length(BackgroundVelocity_Range));
    
    figure
    for i_BackgroundVelocity = 1:length(BackgroundVelocity_Range)
        
        
        % ��ȡ�ļ��У����� Main.m ����������Ƶ
        Read_In_Folder_Name_BackgroundVelocity
        
        % �� DS-STMD ��������������ά�� Max ������ֻ������һ�μ���
        Max_Operation_On_DS_STMD_Outputs
        
        for j_BackgroundVelocity = 1:Num_Detection_Threshold
            
            % ȷ�� DS-STMD �����ֵ
            DS_STMD_Detection_Threshold = DS_STMD_Detection_Threshold_Range(j_BackgroundVelocity);
            
            disp('=====================================================')
            disp(strcat('Background Velocity = ', num2str(BackgroundVelocity_Range(i_BackgroundVelocity))))
            disp(strcat('Detection Threshold = ',num2str(DS_STMD_Detection_Threshold)))
            
            
            % ���ú��� Clustering_Detected_Points.m ���о�������
            Clustering_Detected_Points
            
            
            % �Ծ���Ľ�����з�������¼�˶��켣
            Recording_Target_Trace
            
            % ���ڼ�¼��չʾ�˶��켣����Ӧ�� T1 Neuron Outputs
            % չʾ�����켣�������Ҫ�� Show_Monophasic_Outputs_Along_Target_Trace.m ��ָ��
            Show_T1_Neuron_Outputs_Along_Target_Trace
            
            % ��¼ Ground Truth
            if ~exist('Ground_Truth','var')
                if ~exist(strcat(Parameter_File.folder_Global,'/','Ground-Truth.mat'),'file')
                    Calculate_Ground_Truth_Target_Positions
                else
                    load([Parameter_File.folder_Global,'/','Ground-Truth.mat'])
                end
            end
            
            % ���ڼ����㷨����ȷ��
            Calculate_Detection_Accuracy_and_False_Alarm
            
            All_DS_STMD_Detection_Rate_BackgroundVelocity(i_BackgroundVelocity,j_BackgroundVelocity) = Detection_Rate_DS_STMD;
            All_DS_STMD_False_Alarm_BackgroundVelocity(i_BackgroundVelocity,j_BackgroundVelocity) = False_Alarm_Rate_DS_STMD;
            All_Visual_System_Detection_Rate_BackgroundVelocity(i_BackgroundVelocity,j_BackgroundVelocity) = Detection_Rate_System;
            All_Visual_System_False_Alarm_BackgroundVelocity(i_BackgroundVelocity,j_BackgroundVelocity) = False_Alarm_Rate_System;
            
            
        end
        
        % ѭ�� i_LDTB ʱ���������¼�¼ Ground_Truth
        
        clearvars Ground_Truth All_T1_Neuron_Outputs  Max_Operation_DS_STMD_Outputs
        
        % ��ͼ
        
        plot(All_DS_STMD_False_Alarm_BackgroundVelocity(i_BackgroundVelocity,:),All_DS_STMD_Detection_Rate_BackgroundVelocity(i_BackgroundVelocity,:),'color',MarkerEdgeColors(i_BackgroundVelocity,:),'LineStyle','-','Marker','>','DisPlayName',strcat('DS-STMD-BGV-',num2str(BackgroundVelocity_Range(i_BackgroundVelocity))),'linewidth',1)
        hold on
        plot(All_Visual_System_False_Alarm_BackgroundVelocity(i_BackgroundVelocity,:),All_Visual_System_Detection_Rate_BackgroundVelocity(i_BackgroundVelocity,:),'color',MarkerEdgeColors(i_BackgroundVelocity,:),'LineStyle','-','Marker','o','DisPlayName',strcat('Visual-System-BGV-',num2str(BackgroundVelocity_Range(i_BackgroundVelocity))),'linewidth',1)
        hold on
        
    end
    
    legend('show')
    axis([0,25,0,1])
    xlabel('False Alarm Rate')
    ylabel('Detection Rate')
    
    
    % �洢����
    file = ['Data\Data-for-DR-FA\Varying-Background-Velocity\',Parameter_File.BackgroundType,'\',Parameter_File.MotionMode,'\Background-Velocity\','Detection-Rate-False-Alarm-Rate.mat'];
    save(file,'DS_STMD_Detection_Threshold_Range','All_DS_STMD_Detection_Rate_BackgroundVelocity','All_DS_STMD_False_Alarm_BackgroundVelocity','All_Visual_System_Detection_Rate_BackgroundVelocity','All_Visual_System_False_Alarm_BackgroundVelocity','-v7.3')
    
end


% dos('shutdown -s')








