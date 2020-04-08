% 2016-11-18


% ����˵��
% �ú������ڼ�������ȷ�ʼ�������


timedLog('Start Calcualte Detection Rate and False Alarm Rate...')
%% Main Function

%clear all; close all; clc;

if ~exist('Target_Trace','var')
    % ��������켣���������
    File = strcat(Parameter_File.folder_Global,'\Target-Trace-Threshold-',num2str(DSTMD_Detection_Threshold),'.mat');
    load(File)
end

% ��֡��
NumFrame_Clustering = length(Target_Trace_Num);

% ��������켣�����ͳ����
if ~exist('All_Target_Trace_Statistics_After_Conv','var')
    File = [Parameter_File.folder_Global,'/',strcat('Target_Trace_Statistics-',num2str(DSTMD_Detection_Threshold),'.mat')];
    load(File)
end

% �ж��˶��켣�� T1 Outputs �ı�׼���Ƿ������ֵ
Std_Threshold = 20;
Max_Target_Trace_Num = Target_Trace_Num(NumFrame_Clustering);
[Index_Std_Target] = Obtain_Index_Target_Trace_Std_Larger_Than_Threshold(All_Target_Trace_Statistics_After_Conv,Max_Target_Trace_Num,Std_Threshold);

% Ground Truth
if ~exist('Ground_Truth','var')
    File = [Parameter_File.folder0,'/','Ground-Truth.mat'];
    load(File)
end

% ���������������ľ���С�� Distance_Threshold, ����Ϊ���屻��⵽
Distance_Threshold = 8;
% �������˶�����
Background_Motion_Direction = 2;
% 
Detected_Target_Num_DSTMD = 0;
False_Positive_Num_DSTMD= 0;
Detected_Target_Num_STMD_Plus = 0;
False_Positive_Num_STMD_Plus= 0;

for kk = 1:NumFrame_Clustering
    
    Detected_Target_Num_DSTMD_Each_Frame = 0;
    Detected_Target_Num_STMD_Plus_Each_Frame = 0;
    
    All_Potential_Target_Position_Each_Frame_DSTMD = zeros(Target_Num,3);
    Potential_Target_Num_Each_Frame_DSTMD = 0;
    All_Potential_Target_Position_Each_Frame_STMD_Plus = zeros(Target_Num,3);
    Potential_Target_Num_Each_Frame_STMD_Plus = 0;
    
    for jj = 1:Target_Num
        
        % ��ȡ���� jj �ڵ� kk ֡����ʵ���� 
        Target_Position_X = Ground_Truth(kk+StartRecordFrame-1,1,jj);
        Target_Position_Y = Ground_Truth(kk+StartRecordFrame-1,2,jj);
        
        % Current Frame Detected Points
        Target_Num_CurrentFrame = Target_Trace_Num(1,kk);
        Index_Detected_Points = (Target_Trace(1:Target_Num_CurrentFrame,3,kk)>0);
        Num_Detected_Points = sum(Index_Detected_Points);
        Detected_Points_Position = Target_Trace(Index_Detected_Points,:,kk);
        Index_Std_Detected_Target = Index_Std_Target(Index_Detected_Points);

        
        % �������м��������ľ���
        [Smallest_Dist,Smallest_Index] = pdist2(Detected_Points_Position(:,1:2),[Target_Position_X,Target_Position_Y],'euclidean','Smallest',1);
        Potential_Target_Position = Detected_Points_Position(Smallest_Index,:);
        
        if Smallest_Dist<Distance_Threshold
            All_Potential_Target_Position_Each_Frame_DSTMD(jj,:) = Potential_Target_Position;
            
            Detected_Target_Num_DSTMD = Detected_Target_Num_DSTMD +1;
            Detected_Target_Num_DSTMD_Each_Frame = Detected_Target_Num_DSTMD_Each_Frame + 1;
            
            [Is_Small_Moving_Target] = Is_Target_Trace_Belong_to_Targets_or_Background_Points(Potential_Target_Position,...
                                                                   Index_Std_Detected_Target(Smallest_Index),Background_Motion_Direction);

            if Is_Small_Moving_Target
                All_Potential_Target_Position_Each_Frame_STMD_Plus(jj,:) = Potential_Target_Position;
                
                Detected_Target_Num_STMD_Plus = Detected_Target_Num_STMD_Plus +1;
                Detected_Target_Num_STMD_Plus_Each_Frame = Detected_Target_Num_STMD_Plus_Each_Frame + 1;
            end
        end

    end

    False_Positive_Num_DSTMD = False_Positive_Num_DSTMD + (Num_Detected_Points-Detected_Target_Num_DSTMD_Each_Frame);
    
    [Difference_Set,Difference_Ind] = setdiff(Detected_Points_Position(:,1:2),All_Potential_Target_Position_Each_Frame_STMD_Plus(1:Detected_Target_Num_STMD_Plus_Each_Frame,1:2),'rows');
    Difference_Element_Num = length(Difference_Ind);
    
    Background_Point_Index = zeros(Difference_Element_Num,1);
    
    for jj = 1:Difference_Element_Num
        
        [Is_Small_Moving_Target] = Is_Target_Trace_Belong_to_Targets_or_Background_Points(Detected_Points_Position(Difference_Ind(jj),:),...
                                                                   Index_Std_Detected_Target(Difference_Ind(jj)),Background_Motion_Direction);
        Background_Point_Index(jj) = 1-Is_Small_Moving_Target;
    end
    %Background_Point_Index
    False_Positive_Num_STMD_Plus = False_Positive_Num_STMD_Plus + (Num_Detected_Points-Detected_Target_Num_STMD_Plus_Each_Frame-sum(Background_Point_Index));

end


Detection_Rate_DSTMD =  Detected_Target_Num_DSTMD/(Target_Num*NumFrame_Clustering);
Detection_Rate_STMD_Plus =  Detected_Target_Num_STMD_Plus/(Target_Num*NumFrame_Clustering);
False_Alarm_Rate_DSTMD = False_Positive_Num_DSTMD/NumFrame_Clustering;
False_Alarm_Rate_STMD_Plus = False_Positive_Num_STMD_Plus/NumFrame_Clustering;


timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Calcualting Detection Rate and False Alarm Rate finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Calcualting Detection Rate and False Alarm Rate finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 

