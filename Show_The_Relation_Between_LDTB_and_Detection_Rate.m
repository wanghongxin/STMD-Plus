% 函数说明
% 该函数用于展示 LDTB (Luminance Difference Between Target and Background)
% 与是否检测到物体之间的关系

clear all; close all; clc;


% 读取文件
% LDTB
file = ['Data','/','Luminance-Difference-Between-Target-and-Background.mat'];
load(file)


% 是否检测到物体 (需要给定阈值)
DS_STMD_Detection_Threshold = 450;
T1_Neuron_Kernel_Num = 4;

file = ['Data','/',strcat('T1-Neuron-Outputs-Target-Trace-Threshold-',num2str(DS_STMD_Detection_Threshold),'.mat')];
load(file)


%% Main

% 确定展示的帧数
Show_Start_Frame = 1;
Show_End_Frame = 1000;


% 对于 CB-1 Target Trace， Threshold 为 150 时， 对应的 kstt 为 34  38 41 43
% Threshold 为 500 时， 对应的 kstt 为 7 10 11 12 13 14 16
% Threshold 为 450 时， 对应的 kstt 为 12 13 14 15 16 17 19
% Threshold 为 400 时， 对应的 kstt 为 13 15 16 17 18 19 21 22
% Threshold 为 350 时， 对应的 kstt 为 17 19 20 21 22 23 25 26 27
% Threshold 为 300 时， 对应的 kstt 为 20 22 23 24 25 27 28
% Threshold 为 250 时， 对应的 kstt 为 23 27 28 29 32
% Threshold 为 200 时， 对应的 kstt 为 29 31 32 33 36
% Threshold 为 150 时， 对应的 kstt 为 34 38 41 43
% 指定目标
Target_Index = [12 13 14 15 16 17 19];

Is_Target_Detected = zeros(1,length(Show_Start_Frame:Show_End_Frame));

for i = 1:length(Target_Index)
    
    
    Target_Index_Each_Step = Target_Index(i);
    
    % 寻找 All_Target_Trace_T1_Neuron_Output(Target_Index,T1_Neuron_Kernel_Num +1,:)
    % 中不为零的点。若为零，则说明这一帧没有检测到物体
    Direction_Index = reshape(All_Target_Trace_T1_Neuron_Outputs(Target_Index_Each_Step,T1_Neuron_Kernel_Num+1,Show_Start_Frame:Show_End_Frame),[1 length(Show_Start_Frame:Show_End_Frame)]);

    Is_Target_Detected = Is_Target_Detected + Direction_Index;
    
end


Is_Target_Detected = Is_Target_Detected >0;
%Is_Target_Detected = abs((Is_Target_Detected - 0.5) + 0.25);
% 绘图
% figure
% plot(Show_Start_Frame:Show_End_Frame,Normalized_LDTB(Show_Start_Frame:Show_End_Frame),'b')
% hold on
% plot(Show_Start_Frame:Show_End_Frame,Is_Target_Detected(Show_Start_Frame:Show_End_Frame),'r.')

% 输出检测正确率
Detection_Rate = sum(Is_Target_Detected(:))/length(Is_Target_Detected);

disp('===================================')
disp(Detection_Rate)
disp('===================================')
%axis([Show_Start_Frame,Show_End_Frame,0,1])

figure
[hAx,hLine1,hLine2] = plotyy(Show_Start_Frame:Show_End_Frame,Normalized_LDTB(Show_Start_Frame:Show_End_Frame),Show_Start_Frame:Show_End_Frame,Is_Target_Detected(Show_Start_Frame:Show_End_Frame));
set(hAx(1),'ycolor',[0 0 1]);                % 设置左轴颜色    
set(get(hAx(1),'YLabel'),'Str','LDTB') % 设置左轴Label
set(hAx(2),'ycolor',[1 0 0]);                % 设置右轴颜色
set(get(hAx(1),'XLabel'),'Str','Frame') % 设置X轴Label
set(hLine1,'color',[0 0 1],'LineStyle','-','linewidth',1.0)
set(hLine2,'color',[1 0 0],'LineStyle','.','linewidth',1.0)

% 所有帧
All_Frame = Show_Start_Frame:Show_End_Frame;

% 将检测到的帧数提取出来
Detected_Frame = All_Frame(Is_Target_Detected);
figure
plot(Show_Start_Frame:Show_End_Frame,Normalized_LDTB(Show_Start_Frame:Show_End_Frame),'b')
hold on
plot(Detected_Frame,Normalized_LDTB(Is_Target_Detected),'r.')
xlabel('Frame')
ylabel('LDTB')











