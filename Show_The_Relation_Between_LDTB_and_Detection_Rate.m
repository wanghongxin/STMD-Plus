% ����˵��
% �ú�������չʾ LDTB (Luminance Difference Between Target and Background)
% ���Ƿ��⵽����֮��Ĺ�ϵ

clear all; close all; clc;


% ��ȡ�ļ�
% LDTB
file = ['Data','/','Luminance-Difference-Between-Target-and-Background.mat'];
load(file)


% �Ƿ��⵽���� (��Ҫ������ֵ)
DS_STMD_Detection_Threshold = 450;
T1_Neuron_Kernel_Num = 4;

file = ['Data','/',strcat('T1-Neuron-Outputs-Target-Trace-Threshold-',num2str(DS_STMD_Detection_Threshold),'.mat')];
load(file)


%% Main

% ȷ��չʾ��֡��
Show_Start_Frame = 1;
Show_End_Frame = 1000;


% ���� CB-1 Target Trace�� Threshold Ϊ 150 ʱ�� ��Ӧ�� kstt Ϊ 34  38 41 43
% Threshold Ϊ 500 ʱ�� ��Ӧ�� kstt Ϊ 7 10 11 12 13 14 16
% Threshold Ϊ 450 ʱ�� ��Ӧ�� kstt Ϊ 12 13 14 15 16 17 19
% Threshold Ϊ 400 ʱ�� ��Ӧ�� kstt Ϊ 13 15 16 17 18 19 21 22
% Threshold Ϊ 350 ʱ�� ��Ӧ�� kstt Ϊ 17 19 20 21 22 23 25 26 27
% Threshold Ϊ 300 ʱ�� ��Ӧ�� kstt Ϊ 20 22 23 24 25 27 28
% Threshold Ϊ 250 ʱ�� ��Ӧ�� kstt Ϊ 23 27 28 29 32
% Threshold Ϊ 200 ʱ�� ��Ӧ�� kstt Ϊ 29 31 32 33 36
% Threshold Ϊ 150 ʱ�� ��Ӧ�� kstt Ϊ 34 38 41 43
% ָ��Ŀ��
Target_Index = [12 13 14 15 16 17 19];

Is_Target_Detected = zeros(1,length(Show_Start_Frame:Show_End_Frame));

for i = 1:length(Target_Index)
    
    
    Target_Index_Each_Step = Target_Index(i);
    
    % Ѱ�� All_Target_Trace_T1_Neuron_Output(Target_Index,T1_Neuron_Kernel_Num +1,:)
    % �в�Ϊ��ĵ㡣��Ϊ�㣬��˵����һ֡û�м�⵽����
    Direction_Index = reshape(All_Target_Trace_T1_Neuron_Outputs(Target_Index_Each_Step,T1_Neuron_Kernel_Num+1,Show_Start_Frame:Show_End_Frame),[1 length(Show_Start_Frame:Show_End_Frame)]);

    Is_Target_Detected = Is_Target_Detected + Direction_Index;
    
end


Is_Target_Detected = Is_Target_Detected >0;
%Is_Target_Detected = abs((Is_Target_Detected - 0.5) + 0.25);
% ��ͼ
% figure
% plot(Show_Start_Frame:Show_End_Frame,Normalized_LDTB(Show_Start_Frame:Show_End_Frame),'b')
% hold on
% plot(Show_Start_Frame:Show_End_Frame,Is_Target_Detected(Show_Start_Frame:Show_End_Frame),'r.')

% ��������ȷ��
Detection_Rate = sum(Is_Target_Detected(:))/length(Is_Target_Detected);

disp('===================================')
disp(Detection_Rate)
disp('===================================')
%axis([Show_Start_Frame,Show_End_Frame,0,1])

figure
[hAx,hLine1,hLine2] = plotyy(Show_Start_Frame:Show_End_Frame,Normalized_LDTB(Show_Start_Frame:Show_End_Frame),Show_Start_Frame:Show_End_Frame,Is_Target_Detected(Show_Start_Frame:Show_End_Frame));
set(hAx(1),'ycolor',[0 0 1]);                % ����������ɫ    
set(get(hAx(1),'YLabel'),'Str','LDTB') % ��������Label
set(hAx(2),'ycolor',[1 0 0]);                % ����������ɫ
set(get(hAx(1),'XLabel'),'Str','Frame') % ����X��Label
set(hLine1,'color',[0 0 1],'LineStyle','-','linewidth',1.0)
set(hLine2,'color',[1 0 0],'LineStyle','.','linewidth',1.0)

% ����֡
All_Frame = Show_Start_Frame:Show_End_Frame;

% ����⵽��֡����ȡ����
Detected_Frame = All_Frame(Is_Target_Detected);
figure
plot(Show_Start_Frame:Show_End_Frame,Normalized_LDTB(Show_Start_Frame:Show_End_Frame),'b')
hold on
plot(Detected_Frame,Normalized_LDTB(Is_Target_Detected),'r.')
xlabel('Frame')
ylabel('LDTB')











