% 2016-11-06
% ����˵��
% �ú�������չʾ�����˶��켣����Ӧ�� T1 Neuron Outputs


timedLog('Start Recording T1 Neuron Outputs for Each Target Trace...')
%% Main Function

if ~exist('Target_Trace','var')
    File_Trace = [Parameter_File.folder_Global,'/',strcat('Target-Trace-Threshold-',num2str(DSTMD_Detection_Threshold),'.mat')];
    load(File_Trace)
end

% ���û�б��� All_T1_Output����������
if ~exist('All_T1_Neuron_Outputs','var')
    if ~exist(strcat(Parameter_File.folder_Global,'\','All_T1_Neuron_Outputs.mat'),'file')
        
        % clear all; close all; clc;
        File_T1 = strcat(Parameter_File.folder_Global,'\','Recorded-Data.mat');
        load(File_T1)
        % ������ȡ T1_Neuron_Output�������䱣���� All_T1_Output ��
        NumFrame_Clustering = length(RecordedData);
        All_T1_Neuron_Outputs = cell(1,NumFrame_Clustering);
        
        for j_m = 1:NumFrame_Clustering
            
            All_T1_Neuron_Outputs{j_m} = RecordedData{j_m}.T1_Neuron_Outputs;
            
        end
        % �������ı���
        clearvars RecordedData
        
        File = strcat(Parameter_File.folder_Global,'\','All_T1_Neuron_Outputs.mat');
        save(File,'All_T1_Neuron_Outputs','-v7.3')
    else
        load(strcat(Parameter_File.folder_Global,'\','All_T1_Neuron_Outputs.mat'))
    end
end


% ��ÿ���˶��켣����ȡ��Ӧ�� T1 Neuron Outputs
% T1 Neuron Kernel �ĸ�����Ĭ��Ϊ 4
T1_Neuron_Kernel_Num = 4;
% ���ɴ洢 T1 Neural Outputs �ľ���
All_Target_Trace_T1_Neuron_Outputs = zeros(Possible_Target_Num,T1_Neuron_Kernel_Num+1,NumFrame_Clustering);
% ȡƽ��ֵ�������С
Mean_Region = 0;    % 0 Ϊ��ȡ��ֵ

for ii = 1:NumFrame_Clustering
    
    for j_m = 1:Target_Trace_Num(ii)
        
        if Target_Trace(j_m,3,ii)>0
            % ȷ���� i ֡ʱ���� j �������λ������
            Target_Position = Target_Trace(j_m,1:2,ii);
            % ��ȡ��ǰ�� Monophasic Outputs
            Current_T1_Neuron_Outputs = All_T1_Neuron_Outputs{ii};
            
            if Mean_Region == 0
                Corresponding_T1_Neuron_Outputs = Current_T1_Neuron_Outputs(Target_Position(1),Target_Position(2),:);
            elseif Mean_Region > 0
                Corresponding_T1_Neuron_Outputs = mean(mean(Current_T1_Neuron_Outputs(Target_Position(1)-Mean_Region:Target_Position(1)+Mean_Region,...
                    Target_Position(2)-Mean_Region:Target_Position(2)+Mean_Region,:)));
            end
            
            % ��¼����
            All_Target_Trace_T1_Neuron_Outputs(j_m,1:T1_Neuron_Kernel_Num,ii) = reshape(Corresponding_T1_Neuron_Outputs,[1 T1_Neuron_Kernel_Num]);
            All_Target_Trace_T1_Neuron_Outputs(j_m,T1_Neuron_Kernel_Num+1,ii) = Target_Trace(j_m,3,ii);
        else
            All_Target_Trace_T1_Neuron_Outputs(j_m,1:T1_Neuron_Kernel_Num,ii) = zeros(1,T1_Neuron_Kernel_Num);
            All_Target_Trace_T1_Neuron_Outputs(j_m,T1_Neuron_Kernel_Num+1,ii) = Target_Trace(j_m,3,ii);
        end
        
    end
    
end

% �洢����
file = [Parameter_File.folder_Global,'/',strcat('T1-Neuron-Outputs-Target-Trace-Threshold-',num2str(DSTMD_Detection_Threshold),'.mat')];
save(file,'All_Target_Trace_T1_Neuron_Outputs','DSTMD_Detection_Threshold','-v7.3')

% ����������ڼ���һ���켣�����ͳ����
Statics_Num = 3;
All_Target_Trace_Statistics = zeros(Possible_Target_Num,T1_Neuron_Kernel_Num,Statics_Num);
All_Target_Trace_Statistics_After_Conv = zeros(Possible_Target_Num,T1_Neuron_Kernel_Num,Statics_Num);

for kk = 1:max(Target_Trace_Num)
    
    % Ѱ�� All_Target_Trace_Monophasic_Output(Target_Index,MonoPhasicFilter_Num+1,:)
    % �в�Ϊ��ĵ㡣��Ϊ�㣬��˵����һ֡û�м�⵽����
    Direction_Index = reshape(All_Target_Trace_T1_Neuron_Outputs(kk,T1_Neuron_Kernel_Num+1,:),[1 NumFrame_Clustering]);
    Direction_Scale = Direction_Index>0;
    % ��ֵ��
    % ��ֵ����
    Mean_Num = 8;
    Mean_Kernel = ones(1,Mean_Num)/Mean_Num;
    
    for ii = 1:T1_Neuron_Kernel_Num
        
        T1_Neuron_Output_Direction = All_Target_Trace_T1_Neuron_Outputs(kk,ii,:);
        T1_Neuron_Output_Direction = reshape(T1_Neuron_Output_Direction,[1 NumFrame_Clustering]);
        T1_Neuron_Output_Direction = T1_Neuron_Output_Direction.*Direction_Scale;
        
        % �����ֵ����׼����ƫ��
        Index_Nozero = Direction_Index>0;
        T1_Neuron_Output_Direction_Nozero = T1_Neuron_Output_Direction(Index_Nozero);
        
        Mean_T1_Neuron_Output_Direction = mean(T1_Neuron_Output_Direction_Nozero);
        Std_T1_Neuron_Output_Direction = std(T1_Neuron_Output_Direction_Nozero);
        Max_Deviation_T1_Neuron_Output_Direction = max(abs(T1_Neuron_Output_Direction_Nozero-Mean_T1_Neuron_Output_Direction));
        % �洢
        All_Target_Trace_Statistics(kk,ii,1) = Mean_T1_Neuron_Output_Direction;
        All_Target_Trace_Statistics(kk,ii,2) = Std_T1_Neuron_Output_Direction;
        All_Target_Trace_Statistics(kk,ii,3) = Max_Deviation_T1_Neuron_Output_Direction;
        % ȡ��ֵ
        Conv_T1_Neuron_Output_Direction = conv(T1_Neuron_Output_Direction,Mean_Kernel,'same');
        
        % �����ֵ����׼����ƫ��
        Conv_T1_Neuron_Output_Direction_Nozero = Conv_T1_Neuron_Output_Direction(Index_Nozero);
        
        Mean_Conv_T1_Neuron_Output_Direction = mean(Conv_T1_Neuron_Output_Direction_Nozero);
        Std_Conv_T1_Neuron_Output_Direction = std(Conv_T1_Neuron_Output_Direction_Nozero);
        Max_Conv_Deviation_T1_Neuron_Output_Direction = max(abs(Conv_T1_Neuron_Output_Direction_Nozero-Mean_Conv_T1_Neuron_Output_Direction));
        % �洢
        All_Target_Trace_Statistics_After_Conv(kk,ii,1) = Mean_Conv_T1_Neuron_Output_Direction;
        All_Target_Trace_Statistics_After_Conv(kk,ii,2) = Std_Conv_T1_Neuron_Output_Direction;
        All_Target_Trace_Statistics_After_Conv(kk,ii,3) = Max_Conv_Deviation_T1_Neuron_Output_Direction; 
    end  
end

% �洢����
file = [Parameter_File.folder_Global,'/',strcat('Target_Trace_Statistics-',num2str(DSTMD_Detection_Threshold),'.mat')];
save(file,'All_Target_Trace_Statistics','All_Target_Trace_Statistics_After_Conv','-v7.3')




timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Recording T1 Neuron Outputs for Each Target Trace finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Recording T1 Neuron Outputs for Each Target Trace finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 




%% ���ƽ��
% �Ƿ���ƽ��
Plot_T1_Neuron_Outputs_Along_Target_Trace = 0;

if Plot_T1_Neuron_Outputs_Along_Target_Trace == 1
    
    % ָ��Ŀ��
    Target_Index = 1;
    % T1 Neuron Convolution Kernel ����Ŀ
    T1_Neuron_Kernel_Num = 4;
    % ������ɫ
    MarkerEdgeColors = jet(T1_Neuron_Kernel_Num);
    % չʾ����ʼ֡��
    Show_Start_Frame = 1;
    Show_End_Frame = 1000;
    
    % Ѱ�� All_Target_Trace_Monophasic_Output(Target_Index,MonoPhasicFilter_Num+1,:)
    % �в�Ϊ��ĵ㡣��Ϊ�㣬��˵����һ֡û�м�⵽����
    Direction_Index = reshape(All_Target_Trace_T1_Neuron_Outputs(Target_Index,T1_Neuron_Kernel_Num+1,:),[1 NumFrame_Clustering]);
    Direction_Scale = Direction_Index>0;
    
    % ��ֵ��
    % ��ֵ����
    Mean_Num = 8;
    Mean_Kernel = ones(1,Mean_Num)/Mean_Num;
    
    clc; close all;
    figure
    for ii = 1:T1_Neuron_Kernel_Num
        
        T1_Neuron_Output_Direction = All_Target_Trace_T1_Neuron_Outputs(Target_Index,ii,:);
        T1_Neuron_Output_Direction = reshape(T1_Neuron_Output_Direction,[1 NumFrame_Clustering]);
        T1_Neuron_Output_Direction = T1_Neuron_Output_Direction.*Direction_Scale;
        
        % �����ֵ����׼����ƫ��
        Index_Nozero = Direction_Index>0;
        T1_Neuron_Output_Direction_Nozero = T1_Neuron_Output_Direction(Index_Nozero);
        
        Mean_T1_Neuron_Output_Direction = mean(T1_Neuron_Output_Direction_Nozero);
        Std_T1_Neuron_Output_Direction = std(T1_Neuron_Output_Direction_Nozero);
        Max_Deviation_T1_Neuron_Output_Direction = max(abs(T1_Neuron_Output_Direction_Nozero-Mean_T1_Neuron_Output_Direction));
        
        %     disp('====================  Statistics =====================')
        %     disp(strcat('Direction-',num2str(i),'-Staticas'))
        %
        %     disp(strcat('Mean = ',num2str(Mean_Monophasic_Output_Direction)))
        %     disp(strcat('Standard Deviation = ',num2str(Std_Monophasic_Output_Direction)))
        %     disp(strcat('Max Deviation = ',num2str(Max_Deviation_Monophasic_Output_Direction)))
        
        % ��ͼ
        
        %     plot(Show_Start_Frame:Show_End_Frame,Monophasic_Output_Direction(Show_Start_Frame:Show_End_Frame),...
        %         'color',MarkerEdgeColors(i,:),'linewidth',1)     % 'DisPlayName',strcat('Monophasic Outputs-',num2str(i)))
        
        %=================== Convolution ===================================%
        % ȡ��ֵ
        Conv_T1_Neuron_Output_Direction = conv(T1_Neuron_Output_Direction,Mean_Kernel,'same');
        
        % �����ֵ����׼����ƫ��
        Conv_T1_Neuron_Output_Direction_Nozero = Conv_T1_Neuron_Output_Direction(Index_Nozero);
        
        Mean_Conv_T1_Neuron_Output_Direction = mean(Conv_T1_Neuron_Output_Direction_Nozero);
        Std_Conv_T1_Neuron_Output_Direction = std(Conv_T1_Neuron_Output_Direction_Nozero);
        Max_Conv_Deviation_T1_Neuron_Output_Direction = max(abs(Conv_T1_Neuron_Output_Direction_Nozero-Mean_Conv_T1_Neuron_Output_Direction));
        
        disp('====================  Statistics  (After-Convolution)=====================')
        disp(strcat('Direction-',num2str(ii),'-Staticas'))
        
        disp(strcat('Mean = ',num2str(Mean_Conv_T1_Neuron_Output_Direction)))
        disp(strcat('Standard Deviation = ',num2str(Std_Conv_T1_Neuron_Output_Direction)))
        disp(strcat('Max Deviation = ',num2str(Max_Conv_Deviation_T1_Neuron_Output_Direction)))
        
        
        plot(Show_Start_Frame:Show_End_Frame,Conv_T1_Neuron_Output_Direction(Show_Start_Frame:Show_End_Frame),...
            'color',MarkerEdgeColors(ii,:),'DisPlayName',strcat('T1 Neuron Outputs-',num2str(ii)),'linewidth',1)
        
        
        hold on
        
    end
    %legend('show')
    grid on
    axis([Show_Start_Frame,Show_End_Frame,-200,200])
    %Direction_Index = reshape(All_Target_Trace_Monophasic_Output(Target_Index,MonoPhasicFilter_Num+1,:),[1 NumFrame_Clustering]);
    % plot(Show_Start_Frame:Show_End_Frame,Direction_Index(Show_Start_Frame:Show_End_Frame),'r*')
end

