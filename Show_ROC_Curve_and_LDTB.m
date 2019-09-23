% 函数说明
% 该函数用于记录 Detection Rate and False Alarm Rate 曲线，在不同的 LDTB， Size and
% Velocity 下的物体运动


clear all; close all; clc;

%% Main
Is_Show_DR_FA_LDTB = 0;
Is_Show_DR_FA_Size = 0;
Is_Show_DR_FA_Velocity = 1;


% 确定输入的图像背景类型
BackgroundType = 'CB-3';



%% LDTB (Luminance Difference Between Target and Background)
if Is_Show_DR_FA_LDTB == 1
    
    
    LDTB_Range = [0 25 50];
    %MarkerEdgeColors = jet(length(LDTB_Range));
    MarkerEdgeColors = [1 0 0;0 1 0;0 0 1];
    % 导入 Detection Rate and False Alarm Rate
    file = ['Data\Data-for-DR-FA\',BackgroundType,'\LDTB\','Detection-Rate-False-Alarm-Rate.mat'];
    load(file)
    
    figure
    for i_LDTB = 1:length(LDTB_Range)
        
        plot(All_DS_STMD_False_Alarm_LDTB(i_LDTB,:),All_DS_STMD_Detection_Rate_LDTB(i_LDTB,:),'color',MarkerEdgeColors(i_LDTB,:),'LineStyle','-','Marker','>','DisPlayName',strcat('DS-STMD-',num2str(LDTB_Range(i_LDTB))),'linewidth',1)
        hold on
        plot(All_Visual_System_False_Alarm_LDTB(i_LDTB,:),All_Visual_System_Detection_Rate_LDTB(i_LDTB,:),'color',MarkerEdgeColors(i_LDTB,:),'LineStyle','-','Marker','o','DisPlayName',strcat('FVS-',num2str(LDTB_Range(i_LDTB))),'linewidth',1)
        hold on
    end
    legend('show')
    axis([0,35,0,1])
    grid on
    xlabel('False Alarm Rate')
    ylabel('Detection Rate')
    
    %------------------------------------------%
    % LDTB

    
    figure
    for i_LDTB = 1:length(LDTB_Range)
        
        TargetLuminance = LDTB_Range(i_LDTB);
        folder_LDTB = ['Data\Data-for-DR-FA\',BackgroundType,'\LDTB\','LDTB-',num2str(TargetLuminance)];
        file = [folder_LDTB,'/','Luminance-Difference-Between-Target-and-Background.mat'];
        load(file)
        
        plot(1:length(Normalized_LDTB),Normalized_LDTB,'color',MarkerEdgeColors(i_LDTB,:),'DisPlayName',strcat('LDTB-',num2str(LDTB_Range(i_LDTB))),'linewidth',1)
        hold on

    end
    axis([0 1000 0 0.65])
    grid on
    legend('show')
    xlabel('Frame')
    ylabel('LDTB')
    
       
end




%% Size

if Is_Show_DR_FA_Size == 1
    
    Size_Range = [3 5 8];
    %MarkerEdgeColors = jet(length(Size_Range));
    MarkerEdgeColors = [1 0 0;0 1 0;0 0 1];
    % 导入 Detection Rate and False Alarm Rate
    file = ['Data\Data-for-DR-FA\',BackgroundType,'\Size\','Detection-Rate-False-Alarm-Rate.mat'];
    load(file)
    
    figure
    for i_Size = 1:length(Size_Range)
        
        plot(All_DS_STMD_False_Alarm_Size(i_Size,:),All_DS_STMD_Detection_Rate_Size(i_Size,:),'color',MarkerEdgeColors(i_Size,:),'LineStyle','-','Marker','>','DisPlayName',strcat('DS-STMD-',num2str(Size_Range(i_Size))),'linewidth',1)
        hold on
        plot(All_Visual_System_False_Alarm_Size(i_Size,:),All_Visual_System_Detection_Rate_Size(i_Size,:),'color',MarkerEdgeColors(i_Size,:),'LineStyle','-','Marker','o','DisPlayName',strcat('FVS-',num2str(Size_Range(i_Size))),'linewidth',1)
        hold on
        
    end
    
    legend('show')
    axis([0,35,0,1])
    grid on
    xlabel('False Alarm Rate')
    ylabel('Detection Rate')
    
    %------------------------------------------%
    % LDTB
    
    figure
    for i_Size = 1:length(Size_Range)
        
        TargetSize = Size_Range(i_Size);
        folder_LDTB = ['Data\Data-for-DR-FA\',BackgroundType,'\Size\','Size-',num2str(TargetSize)];
        file = [folder_LDTB,'/','Luminance-Difference-Between-Target-and-Background.mat'];
        load(file)
        
        plot(1:length(Normalized_LDTB),Normalized_LDTB,'color',MarkerEdgeColors(i_Size,:),'DisPlayName',strcat('Size-',num2str(Size_Range(i_Size))),'linewidth',1)
        hold on
        
    end
    axis([0 1000 0 0.65])
    grid on
    legend('show')
    xlabel('Frame')
    ylabel('LDTB')
      
end




%% Velocity

if Is_Show_DR_FA_Velocity == 1
    
    Velocity_Range = [250];
    %MarkerEdgeColors = jet(length(Velocity_Range));
    MarkerEdgeColors = [1 0 0;0 1 0;0 0 1];
    % 导入 Detection Rate and False Alarm Rate
    file = ['Data\Data-for-DR-FA\',BackgroundType,'\Velocity\','Detection-Rate-False-Alarm-Rate.mat'];
    load(file)
    
    figure
    for i_Velocity = 1:length(Velocity_Range)
        
        plot(All_DS_STMD_False_Alarm_Velocity(i_Velocity,:),All_DS_STMD_Detection_Rate_Velocity(i_Velocity,:),'color',MarkerEdgeColors(i_Velocity,:),'LineStyle','-','Marker','>','DisPlayName',strcat('DS-STMD-',num2str(Velocity_Range(i_Velocity))),'linewidth',1)
        hold on
        plot(All_Visual_System_False_Alarm_Velocity(i_Velocity,:),All_Visual_System_Detection_Rate_Velocity(i_Velocity,:),'color',MarkerEdgeColors(i_Velocity,:),'LineStyle','-','Marker','o','DisPlayName',strcat('FVS-',num2str(Velocity_Range(i_Velocity))),'linewidth',1)
        hold on
        
    end
    
    legend('show')
    axis([0,35,0,1])
    grid on
    xlabel('False Alarm Rate')
    ylabel('Detection Rate')
    
    %------------------------------------------%
    % LDTB
    
    figure
    for i_Velocity = 1:length(Velocity_Range)
        
        TargetVelocity = Velocity_Range(i_Velocity);
        folder_LDTB = ['Data\Data-for-DR-FA\',BackgroundType,'\Velocity\','Velocity-',num2str(TargetVelocity)];
        file = [folder_LDTB,'/','Luminance-Difference-Between-Target-and-Background.mat'];
        load(file)
        
        plot(1:length(Normalized_LDTB),Normalized_LDTB,'color',MarkerEdgeColors(i_Velocity,:),'DisPlayName',strcat('Velocity-',num2str(Velocity_Range(i_Velocity))),'linewidth',1)
        hold on
        
    end
    axis([0 1000 0 0.65])
    grid on
    legend('show')
    xlabel('Frame')
    ylabel('LDTB')
      
end





