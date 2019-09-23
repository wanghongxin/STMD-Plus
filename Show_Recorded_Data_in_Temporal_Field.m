
% 函数说明
% 该函数用于在时间域（Temporal Field）上展示由函数 DataRecorded.m 所记录的数据

% 依赖关系
% 该函数需要调用 DataRecorded.m
% 主函数中的 IsRecordData 应当设为 1  IsRecordData = 1;


%close all;
%% Main Function
PlotStratFrame_TemporalField = 1;
PlotEndFrame_TemporalField = EndFrame - StartRecordFrame+1;
% M = 250;          % M 及 N 为图像大小 （默认值为 250*500）
% N = 500;
% TargetVelocity = 100;

% 计算 cell RecordedData 的长度
Num = length(RecordedData);

% % 生成存储数据的矩阵
% All_InputImage = zeros(M,N,Num);
All_HighPassFilter_Output = zeros(M,N,Num);
All_LMCs_Inhibition_Output = zeros(M,N,Num);
All_LMCs_Inhibition_Output_NT = zeros(M,N,Num);

% % Model Outptut
All_TQD_Correlation_Component_ON = zeros(M,N,Num);
All_TQD_Correlation_Component_OFF = zeros(M,N,Num);
All_DS_STMD_LateralInhibitionOutput = zeros(M,N,Num);
All_DS_STMD_CorrelationOutput = zeros(M,N,Num);

% % % 确定最佳时延参数
% All_ON_Channel = zeros(M,N,Num);
% All_OFF_Channel = zeros(M,N,Num);
% % 
% % All_MaxOperation_ON_Output = zeros(M,N,Num);
% % All_MaxOperation_OFF_Output = zeros(M,N,Num);
% % 
% All_TQD_Delayed_ON_Channel = zeros(M,N,Num);
% All_TQD_Delayed_OFF_Channel = zeros(M,N,Num);
% 
% All_DS_STMD_Delayed_ON_Channel = zeros(M,N,Num);
% All_DS_STMD_Delayed_OFF_Channel_1 = zeros(M,N,Num);
% All_DS_STMD_Delayed_OFF_Channel_2 = zeros(M,N,Num);

% 提取 cell RecordedData  中的各项数据
for k = PlotStratFrame_TemporalField:PlotEndFrame_TemporalField
    
%      % 确定最佳的高通滤波参数
%      All_InputImage(:,:,k) = RecordedData{k}.BluredImage;
     All_HighPassFilter_Output(:,:,k) = RecordedData{k}.HighPassFilter_Output;
     All_LMCs_Inhibition_Output(:,:,k) = RecordedData{k}.LMCs_Inhibition_Output;
     All_LMCs_Inhibition_Output_NT(:,:,k) = RecordedData{k}.LMCs_Inhibition_Output_NT;

       % Model Output
       StageValue =  RecordedData{k}.TQD_Correlation_Component_ON;
       All_TQD_Correlation_Component_ON(:,:,k) = StageValue(:,:,2);
    
       StageValue =  RecordedData{k}.TQD_Correlation_Component_OFF;
       All_TQD_Correlation_Component_OFF(:,:,k) = StageValue(:,:,2);     % 对于 White Background  1； 对于 Cluttered Background 2
    
       StageValue =  RecordedData{k}.DS_STMD_LateralInhibitionOutput;
       All_DS_STMD_LateralInhibitionOutput(:,:,k) = StageValue(:,:,1);
       
       StageValue =  RecordedData{k}.DS_STMD_CorrelationOutput;
       All_DS_STMD_CorrelationOutput(:,:,k) = StageValue(:,:,1);

%      % 确定最佳时延参数
%      All_ON_Channel(:,:,k) = RecordedData{k}.ON_Channel;
%      All_OFF_Channel(:,:,k) = RecordedData{k}.OFF_Channel;
%      
%      if IsMaxOperation == 1
%          All_MaxOperation_ON_Output(:,:,k) = RecordedData{k}.MaxOperation_ON_Output;
%          All_MaxOperation_OFF_Output(:,:,k) = RecordedData{k}.MaxOperation_OFF_Output;
%      end
%      
%      All_TQD_Delayed_ON_Channel(:,:,k) = RecordedData{k}.TQD_Delayed_ON_Channel;
%      All_TQD_Delayed_OFF_Channel(:,:,k) = RecordedData{k}.TQD_Delayed_OFF_Channel;
%      
%      All_DS_STMD_Delayed_ON_Channel(:,:,k) = RecordedData{k}.DS_STMD_Delayed_ON_Channel;
%      All_DS_STMD_Delayed_OFF_Channel_1(:,:,k) = RecordedData{k}.DS_STMD_Delayed_OFF_Channel_1; 
%      All_DS_STMD_Delayed_OFF_Channel_2(:,:,k) = RecordedData{k}.DS_STMD_Delayed_OFF_Channel_2; 

end




% 确定需要展示数据的像素点
X_0 = 125;
% 只需要确定 Y_0 即可    Y_0 = (TargetVelocity/1000)*200    Note: 根据情况确定
Y_0 = 500-round((TargetVelocity/VideoSamplingFrequency)*(350+StartRecordFrame));                
%Y_0 = 352;
% 将数据转化为向量

% %=========== 下列代码可用于测试最佳的高通滤波及 LMCs Inhibition 参数 ==================%
% % Input Image
% SinglePixel_InputImage = All_InputImage(X_0,Y_0,:);
% SinglePixel_InputImage = reshape(SinglePixel_InputImage,Num,1);
% 
% High-Pass Filter Output
SinglePixel_HighPassFilter_Output = All_HighPassFilter_Output(X_0,Y_0,:);
SinglePixel_HighPassFilter_Output = reshape(SinglePixel_HighPassFilter_Output,Num,1);

%LMCs Lateral Inhibition Mechanism Output
SinglePixel_LMCs_Inhibition_Output = All_LMCs_Inhibition_Output(X_0,Y_0,:);
SinglePixel_LMCs_Inhibition_Output = reshape(SinglePixel_LMCs_Inhibition_Output,Num,1);

%LMCs Lateral Inhibition Mechanism Output(不包含时域部分)
SinglePixel_LMCs_Inhibition_Output_NT = All_LMCs_Inhibition_Output_NT(X_0,Y_0,:);
SinglePixel_LMCs_Inhibition_Output_NT = reshape(SinglePixel_LMCs_Inhibition_Output_NT,Num,1);
% 
% figure
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_InputImage,'b','DisPlayName','Luminance')
% hold on
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_HighPassFilter_Output,'r','DisPlayName','High-pass Filter Output')
% grid on 
% legend('show')
% title('Temporal Field')
figure
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_HighPassFilter_Output,'r','DisPlayName','High-pass Filter Output')
hold on
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_LMCs_Inhibition_Output,'b','DisPlayName','LMCs Outputs')
hold on
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_LMCs_Inhibition_Output_NT,'m','DisPlayName','LMCs Outputs (NT)')
grid on 
legend('show')
title('Temporal Field')

% %========================== Model Output ============================================%
% TQD Correlation Output ON Component
SinglePixel_TQD_Correlation_Component_ON = All_TQD_Correlation_Component_ON(X_0,Y_0,:);
SinglePixel_TQD_Correlation_Component_ON = reshape(SinglePixel_TQD_Correlation_Component_ON,Num,1);
figure
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_TQD_Correlation_Component_ON,'r','DisPlayName','TQD Correlation Component ON')
grid on 
legend('show')
title('TQD Correlation Component ON')


% TQD Correlation Output OFF Component
SinglePixel_TQD_Correlation_Component_OFF = All_TQD_Correlation_Component_OFF(X_0,Y_0,:);
SinglePixel_TQD_Correlation_Component_OFF = reshape(SinglePixel_TQD_Correlation_Component_OFF,Num,1);
figure
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_TQD_Correlation_Component_OFF,'b','DisPlayName','TQD Correlation Component OFF')
grid on 
legend('show')
title('TQD Correlation Component OFF')

% DS-STMD Correlation Output
SinglePixel_DS_STMD_LateralInhibitionOutput = All_DS_STMD_LateralInhibitionOutput(X_0,Y_0,:);
SinglePixel_DS_STMD_LateralInhibitionOutput = reshape(SinglePixel_DS_STMD_LateralInhibitionOutput,Num,1);
figure
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_DS_STMD_LateralInhibitionOutput,'m','DisPlayName','DS-STMD Correlation Output')
grid on 
legend('show')
title('DS-STMD Correlation Output')

% DS-STMD Correlation Output
SinglePixel_DS_STMD_CorrelationOutput = All_DS_STMD_CorrelationOutput(X_0,Y_0,:);
SinglePixel_DS_STMD_CorrelationOutput = reshape(SinglePixel_DS_STMD_CorrelationOutput,Num,1);
figure
plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_DS_STMD_CorrelationOutput,'m','DisPlayName','DS-STMD Correlation Output Before Inhibition')
grid on 
legend('show')
title('DS-STMD Correlation Output Before Inhibition')










% % ========================下列代码可用于确定最佳的时延常数=================%
% % 这里的 +TQD_Dist 或 -TQD_Dist 应当根据背景的运动方向来选择，在我们的数据集中，对于 Cluttered Backgroud
% % 选择 -TQD_Dist， 对于 White Background 选择 +TQD_Dist
% if strcmp(MotionMode,'BackgroundStationary')
%     TQD_Pixel_Dist = TQD_Dist;
% elseif strcmp(MotionMode,'OppositeDirection')
%     TQD_Pixel_Dist = -TQD_Dist;
% end
% % 此处默认白背景下，物体向左运动
% % 混杂背景下，背景向右运动
% 
% % ON and OFF
% SinglePixel_ON_Channel = All_ON_Channel(X_0,Y_0,:);
% SinglePixel_ON_Channel = reshape(SinglePixel_ON_Channel,Num,1);
% 
% SinglePixel_OFF_Channel = All_OFF_Channel(X_0,Y_0,:);
% SinglePixel_OFF_Channel = reshape(SinglePixel_OFF_Channel,Num,1);
% 
% 
% if IsMaxOperation == 1
%     % ON and OFF Channel After Max Operation
%     SinglePixel_MaxOperation_ON_Output = All_MaxOperation_ON_Output(X_0,Y_0,:);
%     SinglePixel_MaxOperation_ON_Output = reshape(SinglePixel_MaxOperation_ON_Output,Num,1);
%     
%     SinglePixel_MaxOperation_OFF_Output = All_MaxOperation_OFF_Output(X_0,Y_0,:);
%     SinglePixel_MaxOperation_OFF_Output = reshape(SinglePixel_MaxOperation_OFF_Output,Num,1);
%     
%     SinglePixel_MaxOperation_ON_Output_2 = All_MaxOperation_ON_Output(X_0,Y_0+TQD_Pixel_Dist,:);
%     SinglePixel_MaxOperation_ON_Output_2 = reshape(SinglePixel_MaxOperation_ON_Output_2,Num,1);
%     
%     SinglePixel_MaxOperation_OFF_Output_2 = All_MaxOperation_OFF_Output(X_0,Y_0+TQD_Pixel_Dist,:);
%     SinglePixel_MaxOperation_OFF_Output_2 = reshape(SinglePixel_MaxOperation_OFF_Output_2,Num,1);
% end
% 
% % TQD
% % ON
% % 这里的 +TQD_Dist 或 -TQD_Dist 应当根据背景的运动方向来选择，在我们的数据集中，对于 Cluttered Backgroud
% % 选择 -TQD_Dist， 对于 White Background 选择 +TQD_Dist
% SinglePixel_All_TQD_Delayed_ON_Channel = All_TQD_Delayed_ON_Channel(X_0,Y_0+TQD_Pixel_Dist,:);
% SinglePixel_All_TQD_Delayed_ON_Channel = reshape(SinglePixel_All_TQD_Delayed_ON_Channel,Num,1);
% % OFF
% SinglePixel_All_TQD_Delayed_OFF_Channel = All_TQD_Delayed_OFF_Channel(X_0,Y_0+TQD_Pixel_Dist,:);
% SinglePixel_All_TQD_Delayed_OFF_Channel = reshape(SinglePixel_All_TQD_Delayed_OFF_Channel,Num,1);
% 
% 
% MarkerEdgeColors = jet(4);
% figure
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_ON_Channel,'color',MarkerEdgeColors(1,:),'DisPlayName','ON Channel')
% hold on 
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_OFF_Channel,'color',MarkerEdgeColors(2,:),'DisPlayName','OFF Channel')
% hold on
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_All_TQD_Delayed_ON_Channel,'color',MarkerEdgeColors(3,:),'DisPlayName','TQD Delayed Channel ON')
% hold on 
% plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_All_TQD_Delayed_OFF_Channel,'color',MarkerEdgeColors(4,:),'DisPlayName','TQD Delayed Channel OFF')
% grid on 
% legend('show')
% title('ON and OFF Channels')
% if IsMaxOperation == 1
%     MarkerEdgeColors = jet(8);
%     figure
%     plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_ON_Channel,'color',MarkerEdgeColors(1,:),'DisPlayName','ON Channel')
%     hold on
%     plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_OFF_Channel,'color',MarkerEdgeColors(2,:),'DisPlayName','OFF Channel')
%     hold on
%     plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_MaxOperation_ON_Output,'color',MarkerEdgeColors(3,:),'DisPlayName','ON Channel After Max')
%     hold on
%     plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_MaxOperation_OFF_Output,'color',MarkerEdgeColors(4,:),'DisPlayName','OFF Channel After Max')
%     grid on
%     legend('show')
%     title('ON and OFF Channels')
%     figure
%     plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_MaxOperation_ON_Output,'color',MarkerEdgeColors(3,:),'DisPlayName','ON Channel After Max')
%     hold on
%     plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_MaxOperation_OFF_Output,'color',MarkerEdgeColors(4,:),'DisPlayName','OFF Channel After Max')
%     hold on
%     plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_MaxOperation_ON_Output_2,'color',MarkerEdgeColors(5,:),'DisPlayName','ON Channel After Max-2')
%     hold on
%     plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_MaxOperation_OFF_Output_2,'color',MarkerEdgeColors(6,:),'DisPlayName','OFF Channel After Max-2')
%     hold on
%     plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_All_TQD_Delayed_ON_Channel,'color',MarkerEdgeColors(7,:),'DisPlayName','TQD Delayed Channel ON')
%     hold on
%     plot(PlotStratFrame_TemporalField:PlotEndFrame_TemporalField,SinglePixel_All_TQD_Delayed_OFF_Channel,'color',MarkerEdgeColors(8,:),'DisPlayName','TQD Delayed Channel OFF')
%     grid on
%     legend('show')
%     title('ON and OFF Channels')
% end
% 
% % DS-STMD
% %这里的 +DS_STMD_Dist 或 +DS_STMD_Dist 应当根据物体运动方向来选择，在我们的数据集中，对于 Cluttered Backgroud
% % 选择 +DS_STMD_Dist， 对于 White Background 选择 +DS_STMD_Dist
% % 这里默认小物体始终向左运动
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