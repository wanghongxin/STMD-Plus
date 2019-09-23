

% ����˵��
% �ú����� Show_Recorded_Data_in_Temporal_Field.m �Ĳ��ִ���
% ��Ҫ���ڵ���չʾ�����ص�λ�ã�չʾ���ݵȵ�


%% Main Function
% if exist('RecordedData','var')
%     clear RecordedData
% end

close all;


% ȷ����Ҫչʾ���ݵ����ص�
X_0 = 57;
% ֻ��Ҫȷ�� Y_0 ����    Y_0 = (TargetVelocity/1000)*200    Note: �������ȷ��
% Y_0 = 500-round((TargetVelocity/VideoSamplingFrequency)*(300+StartRecordFrame));                
Y_0 = 352;
% ������ת��Ϊ����

% %=========== ���д�������ڲ�����ѵĸ�ͨ�˲��� LMCs Inhibition ���� ==================%
% % Input Image
% SinglePixel_InputImage = All_InputImage(X_0,Y_0,:);
% SinglePixel_InputImage = reshape(SinglePixel_InputImage,Num,1);
% 
% % High-Pass Filter Output
% SinglePixel_HighPassFilter_Output = All_HighPassFilter_Output(X_0,Y_0,:);
% SinglePixel_HighPassFilter_Output = reshape(SinglePixel_HighPassFilter_Output,Num,1);
% 
% %LMCs Lateral Inhibition Mechanism Output
% SinglePixel_LMCs_Inhibition_Output = All_LMCs_Inhibition_Output(X_0,Y_0,:);
% SinglePixel_LMCs_Inhibition_Output = reshape(SinglePixel_LMCs_Inhibition_Output,Num,1);
% 
% %LMCs Lateral Inhibition Mechanism Output(������ʱ�򲿷�)
% SinglePixel_LMCs_Inhibition_Output_NT = All_LMCs_Inhibition_Output_NT(X_0,Y_0,:);
% SinglePixel_LMCs_Inhibition_Output_NT = reshape(SinglePixel_LMCs_Inhibition_Output_NT,Num,1);

% figure
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_InputImage,'k','DisPlayName','Luminance')
% hold on
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_HighPassFilter_Output,'r','DisPlayName','High-pass Filter Output')
% grid on 
% legend('show')
% title('Temporal Field')
% figure
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_HighPassFilter_Output,'r','DisPlayName','High-pass Filter Output')
% hold on
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_LMCs_Inhibition_Output,'b','DisPlayName','LMCs Outputs')
% hold on
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_LMCs_Inhibition_Output_NT,'m','DisPlayName','LMCs Outputs (NT)')
% grid on 
% legend('show')
% title('Temporal Field')

% %========================== Model Output ============================================%
% % TQD Correlation Output ON Component
% SinglePixel_TQD_Correlation_Component_ON = All_TQD_Correlation_Component_ON(X_0,Y_0,:);
% SinglePixel_TQD_Correlation_Component_ON = reshape(SinglePixel_TQD_Correlation_Component_ON,Num,1);
% figure
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_TQD_Correlation_Component_ON,'r','DisPlayName','TQD Correlation Component ON')
% grid on 
% legend('show')
% title('TQD Correlation Component ON')
% 
% 
% % TQD Correlation Output OFF Component
% SinglePixel_TQD_Correlation_Component_OFF = All_TQD_Correlation_Component_OFF(X_0,Y_0,:);
% SinglePixel_TQD_Correlation_Component_OFF = reshape(SinglePixel_TQD_Correlation_Component_OFF,Num,1);
% figure
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_TQD_Correlation_Component_OFF,'b','DisPlayName','TQD Correlation Component OFF')
% grid on 
% legend('show')
% title('TQD Correlation Component OFF')

% % DS-STMD Correlation Output
% SinglePixel_DS_STMD_LateralInhibitionOutput = All_DS_STMD_LateralInhibitionOutput(X_0,Y_0,:);
% SinglePixel_DS_STMD_LateralInhibitionOutput = reshape(SinglePixel_DS_STMD_LateralInhibitionOutput,Num,1);
% figure
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_DS_STMD_LateralInhibitionOutput,'m','DisPlayName','DS-STMD Correlation Output')
% grid on 
% legend('show')
% title('DS-STMD Correlation Output')

% ========================���д��������ȷ����ѵ�ʱ�ӳ���=================%
% ON and OFF
SinglePixel_ON_Channel = All_ON_Channel(X_0,Y_0,:);
SinglePixel_ON_Channel = reshape(SinglePixel_ON_Channel,Num,1);

SinglePixel_OFF_Channel = All_OFF_Channel(X_0,Y_0,:);
SinglePixel_OFF_Channel = reshape(SinglePixel_OFF_Channel,Num,1);

% % ON and OFF Channel After Max Operation
SinglePixel_MaxOperation_ON_Output = All_MaxOperation_ON_Output(X_0,Y_0,:);
SinglePixel_MaxOperation_ON_Output = reshape(SinglePixel_MaxOperation_ON_Output,Num,1);

SinglePixel_MaxOperation_OFF_Output = All_MaxOperation_OFF_Output(X_0,Y_0,:);
SinglePixel_MaxOperation_OFF_Output = reshape(SinglePixel_MaxOperation_OFF_Output,Num,1);

% ����� +TQD_Dist �� -TQD_Dist Ӧ�����ݱ������˶�������ѡ�������ǵ����ݼ��У����� Cluttered Backgroud
% ѡ�� -TQD_Dist�� ���� White Background ѡ�� +TQD_Dist
if strcmp(MotionMode,'BackgroundStationary')
    TQD_Pixel_Dist = TQD_Dist;
elseif strcmp(MotionMode,'OppositeDirection')
    TQD_Pixel_Dist = -TQD_Dist;
end
% �˴�Ĭ�ϰױ����£����������˶�
% ���ӱ����£����������˶�

SinglePixel_MaxOperation_ON_Output_2 = All_MaxOperation_ON_Output(X_0,Y_0+TQD_Pixel_Dist,:);
SinglePixel_MaxOperation_ON_Output_2 = reshape(SinglePixel_MaxOperation_ON_Output_2,Num,1);

SinglePixel_MaxOperation_OFF_Output_2 = All_MaxOperation_OFF_Output(X_0,Y_0+TQD_Pixel_Dist,:);
SinglePixel_MaxOperation_OFF_Output_2 = reshape(SinglePixel_MaxOperation_OFF_Output_2,Num,1);

% TQD
% ON
SinglePixel_All_TQD_Delayed_ON_Channel = All_TQD_Delayed_ON_Channel(X_0,Y_0+TQD_Pixel_Dist,:);
SinglePixel_All_TQD_Delayed_ON_Channel = reshape(SinglePixel_All_TQD_Delayed_ON_Channel,Num,1);
% OFF
SinglePixel_All_TQD_Delayed_OFF_Channel = All_TQD_Delayed_OFF_Channel(X_0,Y_0+TQD_Pixel_Dist,:);
SinglePixel_All_TQD_Delayed_OFF_Channel = reshape(SinglePixel_All_TQD_Delayed_OFF_Channel,Num,1);
% 
% 
figure
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_ON_Channel,'color','r','DisPlayName','ON Channel')
hold on 
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_OFF_Channel,'color','b','DisPlayName','OFF Channel')
grid on 
legend('show')
title('ON and OFF Channels')
% MarkerEdgeColors = jet(4);
% figure
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_ON_Channel,'color',MarkerEdgeColors(1,:),'DisPlayName','ON Channel')
% hold on 
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_OFF_Channel,'color',MarkerEdgeColors(2,:),'DisPlayName','OFF Channel')
% hold on
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_MaxOperation_ON_Output,'color',MarkerEdgeColors(3,:),'DisPlayName','ON Channel After Max')
% hold on 
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_MaxOperation_OFF_Output,'color',MarkerEdgeColors(4,:),'DisPlayName','OFF Channel After Max')
% grid on 
% legend('show')
% title('ON and OFF Channels')


figure
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_ON_Channel,'color','r','DisPlayName','ON Channel')
hold on 
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_MaxOperation_ON_Output,'color','b','DisPlayName','ON Channel After Max')
hold on
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_All_TQD_Delayed_ON_Channel,'color','m','DisPlayName','TQD Delayed Channel ON')
grid on 
legend('show')
title('ON and OFF Channels')

figure
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_OFF_Channel,'color','r','DisPlayName','OFF Channel')
hold on 
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_MaxOperation_OFF_Output,'color','b','DisPlayName','OFF Channel After Max')
hold on
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_MaxOperation_ON_Output_2,'color',MarkerEdgeColors(5,:),'DisPlayName','ON Channel After Max-2')
% hold on 
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_MaxOperation_OFF_Output_2,'color',MarkerEdgeColors(6,:),'DisPlayName','OFF Channel After Max-2')
% hold on
% hold on 
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_All_TQD_Delayed_OFF_Channel,'color','m','DisPlayName','TQD Delayed Channel OFF')
grid on 
legend('show')
title('ON and OFF Channels')

% % DS-STMD
% SinglePixel_All_DS_STMD_Delayed_ON_Channel = All_DS_STMD_Delayed_ON_Channel(X_0,Y_0+DS_STMD_Dist,:);
% SinglePixel_All_DS_STMD_Delayed_ON_Channel = reshape(SinglePixel_All_DS_STMD_Delayed_ON_Channel,Num,1);
% 
% 
% SinglePixel_DS_STMD_Delayed_OFF_Channel_1 = All_DS_STMD_Delayed_OFF_Channel_1(X_0,Y_0,:);
% SinglePixel_DS_STMD_Delayed_OFF_Channel_1 = reshape(SinglePixel_DS_STMD_Delayed_OFF_Channel_1,Num,1);
% 
% SinglePixel_DS_STMD_Delayed_OFF_Channel_2 = All_DS_STMD_Delayed_OFF_Channel_2(X_0,Y_0+DS_STMD_Dist,:);
% SinglePixel_DS_STMD_Delayed_OFF_Channel_2 = reshape(SinglePixel_DS_STMD_Delayed_OFF_Channel_2,Num,1);
% 
% MarkerEdgeColors = jet(5);
% figure
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_ON_Channel,'color',MarkerEdgeColors(1,:),'DisPlayName','ON Channel')
% hold on 
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_OFF_Channel,'color',MarkerEdgeColors(2,:),'DisPlayName','OFF Channel')
% hold on 
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_All_DS_STMD_Delayed_ON_Channel,'color',MarkerEdgeColors(3,:),'DisPlayName','DS-STMD Delay Channel ON')
% hold on 
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_DS_STMD_Delayed_OFF_Channel_1,'color',MarkerEdgeColors(4,:),'DisPlayName','DS-STMD Delay Channel OFF 1')
% hold on 
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_DS_STMD_Delayed_OFF_Channel_2,'color',MarkerEdgeColors(5,:),'DisPlayName','DS-STMD Delay Channel OFF 2')
% grid on 
% legend('show')
% title('DS-STMD ON and OFF')