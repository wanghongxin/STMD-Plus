
% ����˵��
% �ú�����������һ��ȷ����ֱ��չʾ Input Image (I) �ڸ�ֱ���ϲ�ͬ��Ԫ�����
% ���磺
% ����ֱ�ߵ����Ϊ ��X_s,Y_s��,�յ�Ϊ ��X_e,Y_e���� X_s = X_e ���� Y_s = Y_e
% Data = I(X_s,Y_s:Y:e) ���� Data = I(X_s:X_e,Y_s)

%% ���������˵��
% ��ͼ�ε�λ�ü���С��������,��λΪ���ף���СΪ W cm�� H cm��ͼ���������Ϊ��Px,Py��cm ��ʾ���µ�����ʾ�����߽� Px cm�����²�߽� Py cm
% set(gcf,'unit','centimeters','position',[Px Py W H])

% ����������ͼ����figure����ռ�ı�����ǰ����ֵ��ʾλ�ã�������ֵ��ʾ��С
%set(gca,'Position',[0.1 0.5 0.8 0.25]);


%% Main Function
close all;
%===================== ���� X ��չʾ ==========================%
% ȷ����ͼ���ƽ���� X ������ߵ���㼰�յ�
X_Line = 125;

StartPoint = [X_Line,1];
EndPoint = [X_Line,500];


%% Part One

%  ����ͼ�񼰸�˹ģ�����ͼ��
[OriginalImage_Recorded_Data_XLine] = Extract_Data_Along_A_Line(OriginalImage,StartPoint,EndPoint,0);
[Photoreceptors_Recorded_Data_XLine] = Extract_Data_Along_A_Line(Photoreceptors_Outptut,StartPoint,EndPoint,0);


% ��ȡ��ͨ�˲�����LMCs �����ƣ�����ʱ�򲿷֣���LMCs �����ƣ�������ʱ�򲿷֣�NT�������
[LMCs_High_Pass_Output_Recorded_Data_XLine] = Extract_Data_Along_A_Line(LMCs_High_Pass_Output,StartPoint,EndPoint,0);
[LMCs_Inhibition_Output_Recorded_Data_XLine] = Extract_Data_Along_A_Line(LMCs_Inhibition_Output,StartPoint,EndPoint,0);

% û��ʱ���򲿷ֵĲ����� (NTs)
[LMCs_Inhibition_Output_NT_Recorded_Data_XLine] = Extract_Data_Along_A_Line(LMCs_Inhibition_Output_NT,StartPoint,EndPoint,0);


figure
plot(StartPoint(2):EndPoint(2),OriginalImage_Recorded_Data_XLine,'color','b','linewidth',1.0)
axis([0,500,0,255])
set(gca,'Position',[0.1 0.5 0.8 0.2]);
title('Input Image')

figure
plot(StartPoint(2):EndPoint(2),Photoreceptors_Recorded_Data_XLine,'color','m','linewidth',1.0)
axis([0,500,0,255])
set(gca,'Position',[0.1 0.5 0.8 0.2]);
title('Photoreceptor Outputs')

figure
plot(StartPoint(2):EndPoint(2),LMCs_Inhibition_Output_Recorded_Data_XLine,'color','r','linewidth',1.0)
axis([0,500,-21,21])
set(gca,'Position',[0.1 0.5 0.8 0.2]);
title('LMC Outputs')



%% Part Two
% % ��ȡ T1 Neuron Outputs �� X ���ֵ
% if Is_Add_Contrast_Pathway == 1
%     
%     T1_Neuron_Outputs_Xline = cell(T1_Neuron_Kernel_Num,1);
%     
%     for j = 1:T1_Neuron_Kernel_Num
%         T1_Neuron_Outputs_Xline{j} = Extract_Data_Along_A_Line(T1_Neuron_Outputs(:,:,j),StartPoint,EndPoint,0);
%     end
%         
%     % �� T1 Neurons ������ֱ�����ڲ�ͬ�� figure ��
%     figure
%     MarkerEdgeColors = jet(T1_Neuron_Kernel_Num);
%     for j = 1:T1_Neuron_Kernel_Num
%         plot(StartPoint(2):EndPoint(2),T1_Neuron_Outputs_Xline{j},'color',MarkerEdgeColors(j,:),'DisPlayName',strcat('T1 Neuron Outputs Com - ',num2str(j)))
%         hold on
%     end
%     grid on
%     title('T1 Neuron Outputs')
%     legend('show')
%     
% end


%% Part Three
% ON and OFF Channel
% ��ȡ����
[ON_Channel_Recorded_Data_XLine] = Extract_Data_Along_A_Line(ON_Channel,StartPoint,EndPoint,0);
[OFF_Channel_Recorded_Data_XLine] = Extract_Data_Along_A_Line(OFF_Channel,StartPoint,EndPoint,0);

% figure
% plot(StartPoint(2):EndPoint(2),ON_Channel_Recorded_Data_XLine,'color','b','linewidth',1.0)
% axis([0,500,0,21])
% set(gca,'Position',[0.1 0.5 0.8 0.20])
% title('Tm3 Outputs')
% 
% figure
% plot(StartPoint(2):EndPoint(2),OFF_Channel_Recorded_Data_XLine,'color','r','linewidth',1.0)
% axis([0,500,0,21])
% set(gca,'Position',[0.1 0.5 0.8 0.20])
% title('Tm2 Outputs')


%% Part Four
% չʾ Max Operation ֮��� ON and OFF Channels
if IsMaxOperation == 1
    
    [MaxOperation_ON_Channel_Recorded_Data_XLine] = Extract_Data_Along_A_Line(MaxOperation_ON_Output,StartPoint,EndPoint,0);
    [MaxOperation_OFF_Channel_Recorded_Data_XLine] = Extract_Data_Along_A_Line(MaxOperation_ON_Output,StartPoint,EndPoint,0);

    figure
    plot(StartPoint(2):EndPoint(2),MaxOperation_ON_Channel_Recorded_Data_XLine,'r','DisPlayName','ON Channel (Max)')
    hold on
    plot(StartPoint(2):EndPoint(2),MaxOperation_OFF_Channel_Recorded_Data_XLine,'b','DisPlayName','OFF Channel (Max)')
    grid on
    legend('show')
    title('ON and OFF Channels (Max Operation)')
end

%% Part Five
% չʾ Two-Quandrant Detector �����

% TQD Delayed Channels
TQD_Delayed_ON_Channel_Xline = Extract_Data_Along_A_Line(TQD_Delayed_ON_Channel,StartPoint,EndPoint,0);
TQD_Delayed_OFF_Channel_Xline = Extract_Data_Along_A_Line(TQD_Delayed_OFF_Channel,StartPoint,EndPoint,0);

% figure
% plot(StartPoint(2):EndPoint(2),TQD_Delayed_ON_Channel_Xline,'color','b','linewidth',1.0)
% axis([0,500,0,21])
% set(gca,'Position',[0.1 0.5 0.8 0.20]);
% title('Mi1 Output (n = 5, \tau = 15)')
% 
% figure
% plot(StartPoint(2):EndPoint(2),TQD_Delayed_OFF_Channel_Xline,'color','r','linewidth',1.0)
% axis([0,500,0,21])
% set(gca,'Position',[0.1 0.5 0.8 0.20]);
% title('Tm1 Output (n = 5, \tau = 15)')


% ���ĸ���ͼ�ŵ�ͬһ��ͼ��
figure

subplot(4,1,1)
plot(StartPoint(2):EndPoint(2),ON_Channel_Recorded_Data_XLine,'color','r','linewidth',1.0)
axis([0,500,0,21])
title('Tm3 Outputs')

subplot(4,1,2)
plot(StartPoint(2):EndPoint(2),TQD_Delayed_ON_Channel_Xline,'color','g','linewidth',1.0)
axis([0,500,0,21])
title('Mi1 Output (n = 5, \tau = 15)')

subplot(4,1,3)
plot(StartPoint(2):EndPoint(2),OFF_Channel_Recorded_Data_XLine,'color','b','linewidth',1.0)
axis([0,500,0,21])
title('Tm2 Outputs')

subplot(4,1,4)
plot(StartPoint(2):EndPoint(2),TQD_Delayed_OFF_Channel_Xline,'color','m','linewidth',1.0)
axis([0,500,0,21])
title('Tm1 Output (n = 5, \tau = 15)')







% ON Hand
TQD_Correlation_Component_ON_Xline = cell(TQD_Directions,1);
for j = 1:TQD_Directions
    TQD_Correlation_Component_ON_Xline{j} = Extract_Data_Along_A_Line(TQD_Correlation_Component_ON(:,:,j),StartPoint,EndPoint,0);
end

% figure
% MarkerEdgeColors = jet(TQD_Directions);
% for j = 1:TQD_Directions
%     plot(StartPoint(2):EndPoint(2),TQD_Correlation_Component_ON_Xline{j},'color',MarkerEdgeColors(j,:),'DisPlayName',strcat('TQD ON Hand - ',num2str(j)),'linewidth',1.0)
%     hold on 
% end
% grid on
% set(gca,'Position',[0.1 0.5 0.8 0.25]);
% title('TQD Correlation Outputs ON Component')
% 
% 
% OFF Hand
TQD_Correlation_Component_OFF_Xline = cell(TQD_Directions,1);
for j = 1:TQD_Directions
    TQD_Correlation_Component_OFF_Xline{j} = Extract_Data_Along_A_Line(TQD_Correlation_Component_OFF(:,:,j),StartPoint,EndPoint,0);
end
% 
% figure
% MarkerEdgeColors = jet(TQD_Directions);
% for j = 1:TQD_Directions
%     plot(StartPoint(2):EndPoint(2),TQD_Correlation_Component_OFF_Xline{j},'color',MarkerEdgeColors(j,:),'DisPlayName',strcat('TQD OFF Hand - ',num2str(j)),'linewidth',1.0)
%     hold on 
% end
% grid on
% set(gca,'Position',[0.1 0.5 0.8 0.25]);
% title('TQD Correlation Outputs OFF Component')


% ON + OFF

figure
MarkerEdgeColors = jet(TQD_Directions);
for j = 1:TQD_Directions
    plot(StartPoint(2):EndPoint(2),TQD_Correlation_Component_ON_Xline{j}+TQD_Correlation_Component_OFF_Xline{j},'color',MarkerEdgeColors(j,:),'linewidth',1.0)
    hold on 
end
axis([0,500,0,425])
legend('\psi = \pi','\psi = 0','\psi = \pi/2','\psi = 3\pi/2')
set(gca,'Position',[0.1 0.1 0.8 0.45]);
title('LPTC Outputs')


%% Part Six
% չʾ DS-STMD Model �����

% Delayed Channel
DS_STMD_Delayed_ON_Channel_Xline = Extract_Data_Along_A_Line(DS_STMD_Delayed_ON_Channel,StartPoint,EndPoint,0);
DS_STMD_Delayed_OFF_Channel_1_Xline = Extract_Data_Along_A_Line(DS_STMD_Delayed_OFF_Channel_1,StartPoint,EndPoint,0);
DS_STMD_Delayed_OFF_Channel_2_Xline = Extract_Data_Along_A_Line(DS_STMD_Delayed_OFF_Channel_2,StartPoint,EndPoint,0);


% figure
% plot(StartPoint(2):EndPoint(2),DS_STMD_Delayed_ON_Channel_Xline,'color','b','DisPlayName','Delayed ON Channel','linewidth',1.0)
% axis([0,500,0,21])
% set(gca,'Position',[0.1 0.5 0.8 0.20]);
% title('Mi1 Output (n = 3, \tau = 15)')
% 
% figure
% plot(StartPoint(2):EndPoint(2),DS_STMD_Delayed_OFF_Channel_1_Xline,'color','r','DisPlayName','Delayed OFF Channel - 1','linewidth',1.0)
% axis([0,500,0,21])
% set(gca,'Position',[0.1 0.5 0.8 0.20]);
% title('Tm1 Output (n = 5, \tau = 25)')
% 
% figure
% plot(StartPoint(2):EndPoint(2),DS_STMD_Delayed_OFF_Channel_2_Xline,'color','m','DisPlayName','Delayed OFF Channel - 2','linewidth',1.0)
% axis([0,500,0,21])
% set(gca,'Position',[0.1 0.5 0.8 0.20]);
% title('Tm1 Output (n = 8, \tau = 40)')




% ���ĸ���ͼ�ŵ�ͬһ��ͼ��

figure
subplot(4,1,1)
plot(StartPoint(2):EndPoint(2),ON_Channel_Recorded_Data_XLine,'color','r','linewidth',1.0)
axis([0,500,0,21])
title('Tm3 Outputs')

subplot(4,1,2)
plot(StartPoint(2):EndPoint(2),DS_STMD_Delayed_ON_Channel_Xline,'color','g','DisPlayName','Delayed ON Channel','linewidth',1.0)
axis([0,500,0,21])
title('Mi1 Output (n = 3, \tau = 15)')

subplot(4,1,3)
plot(StartPoint(2):EndPoint(2),DS_STMD_Delayed_OFF_Channel_1_Xline,'color','b','DisPlayName','Delayed OFF Channel - 1','linewidth',1.0)
axis([0,500,0,21])
title('Tm1 Output (n = 5, \tau = 25)')

subplot(4,1,4)
plot(StartPoint(2):EndPoint(2),DS_STMD_Delayed_OFF_Channel_2_Xline,'color','m','DisPlayName','Delayed OFF Channel - 2','linewidth',1.0)
axis([0,500,0,21])
title('Tm1 Output (n = 8, \tau = 40)')

% % ������ǰ
% DS_STMD_CorrelationOutput_Xline = cell(DS_STMD_Directions,1);
% for j = 1:DS_STMD_Directions
%     DS_STMD_CorrelationOutput_Xline{j} = Extract_Data_Along_A_Line(DS_STMD_CorrelationOutput(:,:,j),StartPoint,EndPoint,0);
% end
% 
% figure
% MarkerEdgeColors = jet(DS_STMD_Directions);
% for j = 1:DS_STMD_Directions
%     plot(StartPoint(2):EndPoint(2),DS_STMD_CorrelationOutput_Xline{j},'color',MarkerEdgeColors(j,:),'DisPlayName',strcat('DS-STMD Correlation Output - ',num2str(j)),'linewidth',1.0)
%     hold on 
% end
% grid on
% legend('show')
% title('DS-STMD Correlation Outputs (Before Inhibition)')
% 
% % �����ƺ�
% DS_STMD_LateralInhibitionOutput_Xline = cell(DS_STMD_Directions,1);
% for j = 1:DS_STMD_Directions
%     DS_STMD_LateralInhibitionOutput_Xline{j} = Extract_Data_Along_A_Line(DS_STMD_LateralInhibitionOutput(:,:,j),StartPoint,EndPoint,0);
% end
% 
% figure
% MarkerEdgeColors = jet(DS_STMD_Directions);
% for j = 1:DS_STMD_Directions
%     plot(StartPoint(2):EndPoint(2),DS_STMD_LateralInhibitionOutput_Xline{j},'color',MarkerEdgeColors(j,:),'DisPlayName',strcat('DS-STMD Output - ',num2str(j)),'linewidth',1.0)
%     hold on 
% end
% 
% grid on
% legend('show')
% title('DS-STMD Correlation Outputs (After Inhibition)')



% չʾ���� Theta Direction ���ƺ�����
% Outputs_After_Inhibition_Along_Theta_Axis

DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis_Xline = cell(DS_STMD_Directions,1);
for j = 1:DS_STMD_Directions
    DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis_Xline{j} = Extract_Data_Along_A_Line(DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis(:,:,j),StartPoint,EndPoint,0);
end

figure
MarkerEdgeColors = jet(DS_STMD_Directions);
for j = 1:DS_STMD_Directions
    plot(StartPoint(2):EndPoint(2),DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis_Xline{j},'color',MarkerEdgeColors(j,:),'linewidth',1.0)
    hold on
end 
legend('\theta = \pi','\theta = 0','\theta = \pi/2','\theta = 3\pi/2','\theta = \pi/4','\theta = 3\pi/4','\theta = 5\pi/4','\theta = 7\pi/4')
axis([0,500,0,550])
set(gca,'Position',[0.1 0.1 0.8 0.45]);
title('STMD Neuron Outputs, E(x,y,t;\theta)')






% %% 
% %========================= �� Y ��չʾ ==================================%
% 
% 
% 
% %========================= OFF Signal ==================================%
% % ȷ��Ҫչʾ�� X ������
% [OFF_Y,OFF_X] = find(HighPassFilter_Output == min(HighPassFilter_Output(:)));
% Presentation_X = min(OFF_X);
% StartPoint = [1,Presentation_X];
% EndPoint = [250,Presentation_X];
% 
% % ��ȡ����
% [HPF_Recorded_Data_YLine] = Extract_Data_Along_A_Line(HighPassFilter_Output,StartPoint,EndPoint,0);
% [LMCs_Recorded_Data_YLine] = Extract_Data_Along_A_Line(LMCs_Inhibition_Output,StartPoint,EndPoint,0);
% % û��ʱ���򲿷ֵĲ�����
% [LMCs_Recorded_Data_YLine_NT] = Extract_Data_Along_A_Line(LMCs_Inhibition_Output_NT,StartPoint,EndPoint,0);
% 
% % ��ͼ
% figure
% plot(StartPoint(1):EndPoint(1),HPF_Recorded_Data_YLine,'r','DisPlayName','High-pass Filter Output')
% hold on
% plot(StartPoint(1):EndPoint(1),LMCs_Recorded_Data_YLine,'b','DisPlayName','LMCs Inhibition Output')
% hold on
% plot(StartPoint(1):EndPoint(1),LMCs_Recorded_Data_YLine_NT,'g','DisPlayName','LMCs Inhibition Output (NT)')
% title(strcat('X = ',num2str(StartPoint(2)),'   Y = ',num2str(StartPoint(1)),' : ',num2str(EndPoint(1))))
% ylabel('OFF Signal')
% grid on
% legend('show')
% 
% % ========================= ON Signal ==================================%
% % ȷ��Ҫչʾ�� X ������
% [ON_Y,ON_X] = find(HighPassFilter_Output == max(HighPassFilter_Output(:)));
% Presentation_X = min(ON_X);
% StartPoint = [1,Presentation_X];
% EndPoint = [250,Presentation_X];
% 
% % ��ȡ����
% [HPF_Recorded_Data_YLine] = Extract_Data_Along_A_Line(HighPassFilter_Output,StartPoint,EndPoint,0);
% [LMCs_Recorded_Data_YLine] = Extract_Data_Along_A_Line(LMCs_Inhibition_Output,StartPoint,EndPoint,0);
% % û��ʱ���򲿷ֵĲ�����
% [LMCs_Recorded_Data_YLine_NT] = Extract_Data_Along_A_Line(LMCs_Inhibition_Output_NT,StartPoint,EndPoint,0);
% 
% % ��ͼ
% figure
% plot(StartPoint(1):EndPoint(1),HPF_Recorded_Data_YLine,'r','DisPlayName','High-pass Filter Output')
% hold on
% plot(StartPoint(1):EndPoint(1),LMCs_Recorded_Data_YLine,'b','DisPlayName','LMCs Inhibition Output')
% hold on
% plot(StartPoint(1):EndPoint(1),LMCs_Recorded_Data_YLine_NT,'g','DisPlayName','LMCs Inhibition Output (NT)')
% title(strcat('X = ',num2str(StartPoint(2)),'   Y = ',num2str(StartPoint(1)),' : ',num2str(EndPoint(1))))
% ylabel('ON Signal')
% grid on
% legend('show')
% 
% 
