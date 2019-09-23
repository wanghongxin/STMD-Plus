% 2016-11-18


% 函数说明
% 该函数用于计算检测正确率及错误率


timedLog('Start Calcualte Detection Rate and False Alarm Rate...')
%% Main Function

%clear all; close all; clc;

if ~exist('Target_Trace','var')
    % 导入物体轨迹的相关数据
    File = strcat(Parameter_File.folder_Global,'\Target-Trace-Threshold-',num2str(DS_STMD_Detection_Threshold),'.mat');
    load(File)
end

% 总帧数
NumFrame_Clustering = length(Target_Trace_Num);

% 导入物体轨迹的相关统计量
if ~exist('All_Target_Trace_Statistics_After_Conv','var')
    File = [Parameter_File.folder_Global,'/',strcat('Target_Trace_Statistics-',num2str(DS_STMD_Detection_Threshold),'.mat')];
    load(File)
end

% 判断运动轨迹的 Monnophasic Outputs 的标准差是否大于阈值
Std_Threshold = 20;
Max_Target_Trace_Num = Target_Trace_Num(NumFrame_Clustering);
[Index_Std_Target] = Obtain_Index_Target_Trace_Std_Larger_Than_Threshold(All_Target_Trace_Statistics_After_Conv,Max_Target_Trace_Num,Std_Threshold);

% Ground Truth
if ~exist('Ground_Truth','var')
    if ~exist(strcat(Parameter_File.folder_Global,'\','Ground-Truth.mat'),'file')
        Claculate_Ground_Truth_Target_Positions
    else
        File = [Parameter_File.folder_Global,'/','Ground-Truth.mat'];
        load(File)
    end  
end

% 若物体坐标与检测点的距离小于 Distance_Threshold, 则视为物体被检测到
Distance_Threshold = 8;
% 背景的运动方向
Background_Motion_Direction = 2;
% 
Detected_Target_Num_DS_STMD = 0;
False_Positive_Num_DS_STMD= 0;
Detected_Target_Num_System = 0;
False_Positive_Num_System= 0;

for kk = 1:NumFrame_Clustering
    
    Detected_Target_Num_DS_STMD_Each_Frame = 0;
    Detected_Target_Num_System_Each_Frame = 0;
    
    All_Potential_Target_Position_Each_Frame_DS_STMD = zeros(Target_Num,3);
    Potential_Target_Num_Each_Frame_DS_STMD = 0;
    All_Potential_Target_Position_Each_Frame_System = zeros(Target_Num,3);
    Potential_Target_Num_Each_Frame_System = 0;
    
    for jj = 1:Target_Num
        
        % 获取物体 jj 在第 kk 帧的真实坐标 
        Target_Position_X = Ground_Truth(kk,1,jj);
        Target_Position_Y = Ground_Truth(kk,2,jj);
        
        % Current Frame Detected Points
        Target_Num_CurrentFrame = Target_Trace_Num(1,kk);
        Index_Detected_Points = (Target_Trace(1:Target_Num_CurrentFrame,3,kk)>0);
        Num_Detected_Points = sum(Index_Detected_Points);
        Detected_Points_Position = Target_Trace(Index_Detected_Points,:,kk);
        Index_Std_Detected_Target = Index_Std_Target(Index_Detected_Points);

        
        % 计算所有检测与物体的距离
        [Smallest_Dist,Smallest_Index] = pdist2(Detected_Points_Position(:,1:2),[Target_Position_X,Target_Position_Y],'euclidean','Smallest',1);
        Potential_Target_Position = Detected_Points_Position(Smallest_Index,:);
        
        if Smallest_Dist<Distance_Threshold
            All_Potential_Target_Position_Each_Frame_DS_STMD(jj,:) = Potential_Target_Position;
            
            Detected_Target_Num_DS_STMD = Detected_Target_Num_DS_STMD +1;
            Detected_Target_Num_DS_STMD_Each_Frame = Detected_Target_Num_DS_STMD_Each_Frame + 1;
            
            [Is_Small_Moving_Target] = Is_Target_Trace_Belong_to_Targets_or_Background_Points(Potential_Target_Position,...
                                                                   Index_Std_Detected_Target(Smallest_Index),Background_Motion_Direction);

            if Is_Small_Moving_Target
                All_Potential_Target_Position_Each_Frame_System(jj,:) = Potential_Target_Position;
                
                Detected_Target_Num_System = Detected_Target_Num_System +1;
                Detected_Target_Num_System_Each_Frame = Detected_Target_Num_System_Each_Frame + 1;
            end
        end

    end

    False_Positive_Num_DS_STMD = False_Positive_Num_DS_STMD + (Num_Detected_Points-Detected_Target_Num_DS_STMD_Each_Frame);
    
    [Difference_Set,Difference_Ind] = setdiff(Detected_Points_Position(:,1:2),All_Potential_Target_Position_Each_Frame_System(1:Detected_Target_Num_System_Each_Frame,1:2),'rows');
    Difference_Element_Num = length(Difference_Ind);
    
    Background_Point_Index = zeros(Difference_Element_Num,1);
    
    for jj = 1:Difference_Element_Num
        
        [Is_Small_Moving_Target] = Is_Target_Trace_Belong_to_Targets_or_Background_Points(Detected_Points_Position(Difference_Ind(jj),:),...
                                                                   Index_Std_Detected_Target(Difference_Ind(jj)),Background_Motion_Direction);
        Background_Point_Index(jj) = 1-Is_Small_Moving_Target;
    end
    %Background_Point_Index
    False_Positive_Num_System = False_Positive_Num_System + (Num_Detected_Points-Detected_Target_Num_System_Each_Frame-sum(Background_Point_Index));

end


Detection_Rate_DS_STMD =  Detected_Target_Num_DS_STMD/(Target_Num*NumFrame_Clustering);
Detection_Rate_System =  Detected_Target_Num_System/(Target_Num*NumFrame_Clustering);
False_Alarm_Rate_DS_STMD = False_Positive_Num_DS_STMD/NumFrame_Clustering;
False_Alarm_Rate_System = False_Positive_Num_System/NumFrame_Clustering;


timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Calcualting Detection Rate and False Alarm Rate finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Calcualting Detection Rate and False Alarm Rate finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 

