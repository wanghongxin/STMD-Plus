% 2016-11-06
% 函数说明
% 该函数用于展示物体运动轨迹及其所对应的 T1 Outputs




%% Main Function
close all; clc;
% 导入所有的 Contrast Pathway 的数据
if ~exist('All_T1_Neuron_Outputs','var')
    clear all; close all; clc;
    load('Data\All_T1_Neuron_Outputs.mat')
end

% 确定 DS-STMD 的检测阈值,可以调整
DS_STMD_Detection_Threshold = 150;

% 导入在给定阈值下确定的运动轨迹及 Contrast Pathway 数据
file = ['Data','/',strcat('Target-Trace-Threshold-',num2str(DS_STMD_Detection_Threshold),'.mat')];
load(file)
file = ['Data','/',strcat('T1-Neuron-Outputs-Target-Trace-Threshold-',num2str(DS_STMD_Detection_Threshold),'.mat')];
load(file)


% 参数
NumFrame_Clustering = size(Target_Trace,3);
Input_Image_M = 250;
Input_Image_N = 500;
DS_STMD_Directions  = 8;
MarkerEdgeColors = jet(DS_STMD_Directions);

Show_End_Frame_Range = [2:1000];
% T1 Filter 的数目
T1_Neuron_Kernel_Num = 4;
STD_At_Different_Frame_Length = zeros(T1_Neuron_Kernel_Num,length(Show_End_Frame_Range));

for ff = 1:length(Show_End_Frame_Range)

% 确定展示的帧数
Show_Start_Frame = 1;
Show_End_Frame = Show_End_Frame_Range(ff);



% 绘制物体运动轨迹
Plot_Target_Trace = 0;

if Plot_Target_Trace == 1
    figure
    for jstt = Show_Start_Frame:Show_End_Frame
        
        for kstt = 1:Target_Trace_Num(jstt)
            
            X_Pos_STT = Target_Trace(kstt,1,jstt);
            Y_Pos_STT = Target_Trace(kstt,2,jstt);
            Direction_Index_STT = Target_Trace(kstt,3,jstt);
            
            if Direction_Index_STT>0
                plot(Y_Pos_STT,Input_Image_M - X_Pos_STT+1,'*','color',MarkerEdgeColors(Direction_Index_STT,:))
                hold on
                if jstt == Show_End_Frame
                    text(Y_Pos_STT,Input_Image_M - X_Pos_STT+5,num2str(kstt))
                elseif (Target_Trace(kstt,3,jstt+1) == 0) && (Target_Trace(kstt,3,jstt+2) == 0) && (Target_Trace(kstt,3,jstt+3) == 0)
                    text(Y_Pos_STT,Input_Image_M - X_Pos_STT+5,num2str(kstt))
                end
            end
            
        end
        axis([0,500,0,250])
        %grid on
        drawnow
        set(gca,'Position',[0.1 0.3 0.8 0.4]);
        %set(gcf,'Position',[250,250,500,250],'color','w')
        %legend('show','Location','southeast')
        %saveas(gcf,strcat('Figures\Tracking-Result-Thershold-',num2str(DS_STMD_Detection_Threshold),'-',num2str(j),'.jpg'))
        % 不能采用 saveas, 否则保存图片大小无法与 set 中的设定大小一致
        % imwrite(frame2im(getframe(gcf)),strcat('Figures\Tracking-Result-Thershold-',num2str(DS_STMD_Detection_Threshold),'-',num2str(j),'.jpg'))
        
        
    end
end



%====================绘制结果============================%
Plot_T1_Neuron_Outputs_Along_Target_Trace = 1;

if Plot_T1_Neuron_Outputs_Along_Target_Trace == 1

%========================================================================%
    % 对于 CB-1 Target Trace， Threshold 为 150 时， 对应的 kstt 为 34  38 41 43
    % Threshold 为 500 时， 对应的 kstt 为 7 10 11 12 13 14 16
    % Threshold 为 450 时， 对应的 kstt 为 12 13 14 15 16 17 19
    % Threshold 为 400 时， 对应的 kstt 为 13 15 16 17 18 19 21 22
    % Threshold 为 350 时， 对应的 kstt 为 17 19 20 21 22 23 25 26 27
    % Threshold 为 300 时， 对应的 kstt 为 20 22 23 24 25 27 28
    % Threshold 为 250 时， 对应的 kstt 为 23 27 28 29 32
    % Threshold 为 200 时， 对应的 kstt 为 29 31 32 33 36
    % Threshold 为 150 时， 对应的 kstt 为 34 38 41 43
%========================================================================%
    
    % T1 Filter 的数目
    T1_Neuron_Kernel_Num = 4;
    % 生成颜色
    MarkerEdgeColors = jet(T1_Neuron_Kernel_Num);
    
    Target_Trace_Index_Range = [8];
    T1_Neural_Outputs_Index_Range = zeros(T1_Neuron_Kernel_Num,length(Show_Start_Frame:Show_End_Frame));
    T1_Neuron_Output_Direction_Nozero_Index_Range = zeros(1,length(Show_Start_Frame:Show_End_Frame));
    
    for jj = 1:length(Target_Trace_Index_Range)
        
        % 指定目标
        Target_Index = Target_Trace_Index_Range(jj);

        % 寻找 All_Target_Trace_T1_Neuron_Output(Target_Index,T1_Neuron_Kernel_Num +1,:)
        % 中不为零的点。若为零，则说明这一帧没有检测到物体
        Direction_Index = reshape(All_Target_Trace_T1_Neuron_Outputs(Target_Index,T1_Neuron_Kernel_Num+1,Show_Start_Frame:Show_End_Frame),[1 length(Show_Start_Frame:Show_End_Frame)]);
        
        for ii = 1:T1_Neuron_Kernel_Num
            
            T1_Neuron_Output_Direction = All_Target_Trace_T1_Neuron_Outputs(Target_Index,ii,Show_Start_Frame:Show_End_Frame);
            T1_Neuron_Output_Direction = reshape(T1_Neuron_Output_Direction,[1 length(Show_Start_Frame:Show_End_Frame)]);
            
            % 将多段轨迹的 T1 Neural Outputs 累加起来
            T1_Neural_Outputs_Index_Range(ii,:) = T1_Neural_Outputs_Index_Range(ii,:) + T1_Neuron_Output_Direction;
            T1_Neuron_Output_Direction_Nozero_Index_Range = T1_Neuron_Output_Direction_Nozero_Index_Range + Direction_Index;
            
        end
        
    end
    
    % 确定不为零的运动方向  
    No_Zero_Direction = T1_Neuron_Output_Direction_Nozero_Index_Range >0;

    %=================== Convolution ===================================%
    % 均值核
    % 均值个数
    Mean_Num = 8;
    Mean_Kernel = ones(1,Mean_Num)/Mean_Num;
    
    %figure
    for ii =1:T1_Neuron_Kernel_Num
        
        % 模糊处理
        Conv_T1_Neuron_Output_Direction = conv(T1_Neural_Outputs_Index_Range(ii,:).*No_Zero_Direction,Mean_Kernel,'same');
        
        % 计算均值及标准差，最大偏移
        Conv_T1_Neuron_Output_Direction_Nozero = Conv_T1_Neuron_Output_Direction(No_Zero_Direction);
        
        Mean_Conv_T1_Neuron_Output_Direction = mean(Conv_T1_Neuron_Output_Direction_Nozero);
        Std_Conv_T1_Neuron_Output_Direction = std(Conv_T1_Neuron_Output_Direction_Nozero);
        Max_Conv_Deviation_T1_Neuron_Output_Direction = max(abs(Conv_T1_Neuron_Output_Direction_Nozero-Mean_Conv_T1_Neuron_Output_Direction));
        
        % 存储
        STD_At_Different_Frame_Length(ii,ff) = Std_Conv_T1_Neuron_Output_Direction;
        
%         disp('====================  Statistics  (After-Convolution)=====================')
%         disp(strcat('Direction-',num2str(ii),'-Staticas'))
%         disp(strcat('End Frame = ',num2str(Show_End_Frame)))
%         disp(strcat('Mean = ',num2str(Mean_Conv_T1_Neuron_Output_Direction)))
%         disp(strcat('Standard Deviation = ',num2str(Std_Conv_T1_Neuron_Output_Direction)))
%         disp(strcat('Max Deviation = ',num2str(Max_Conv_Deviation_T1_Neuron_Output_Direction)))
        
        
%         plot(Show_Start_Frame:Show_End_Frame,Conv_T1_Neuron_Output_Direction(1:length(Show_Start_Frame:Show_End_Frame)),...
%             'color',MarkerEdgeColors(ii,:),'DisPlayName',strcat('T1 - ',num2str(ii)),'linewidth',1)
%         
%         axis([Show_Start_Frame,Show_End_Frame,-180,180])
%         
%         hold on
        
    end
%   legend('show')
%   xlabel('Frame')
%     legend('show')
%     grid on
%     axis([Show_Start_Frame,Show_End_Frame,-200,200])
%     Direction_Index = reshape(All_Target_Trace_T1_Neuron_Outputs(Target_Index,T1_Neuron_Kernel_Num+1,:),[1 NumFrame_Clustering]);
%     plot(Show_Start_Frame:Show_End_Frame,Direction_Index(Show_Start_Frame:Show_End_Frame),'r*')
end

end


% 绘图
% 改图用于展示轨迹对应的 T1 Neural Outputs 的 STD 随 Frame Length 的变化
figure
for ii =1:T1_Neuron_Kernel_Num
    
    plot(Show_End_Frame_Range,STD_At_Different_Frame_Length(ii,:),'color',MarkerEdgeColors(ii,:),'linewidth',1.0,'DisPlayName',strcat('T1 - ',num2str(ii)))
    hold on
    
end
legend('show')
xlabel('Frame')
ylabel('Standard Deviation')
axis([Show_Start_Frame,Show_End_Frame,0,60])








