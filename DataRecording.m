function [ RecordedData ] = DataRecording(Photoreceptors_Outptut,LMCs_Band_Pass_Output,T1_Neuron_Outputs,...
                                                ON_Channel,OFF_Channel,...
                                                        DSTMD_CorrelationOutput,DSTMD_LateralInhibitionOutput,...
                                                            DSTMD_Delayed_ON_Channel,DSTMD_Delayed_OFF_Channel_1,DSTMD_Delayed_OFF_Channel_2,...
                                                              DSTMD_Outputs_After_Inhibition_Along_Theta_Axis,...
                                                                StartRecordFrame,i,RecordedData)

%% 函数说明
% StartFrame    开始记录数据的帧数
% i             此时正在处理的帧数
% BluredImage   模糊之后的图像
% HighPassFilter_Output   高通滤波器输出
% TQD_Correlation_Component_ON       TQD (Two Quadrant Detector) 的 ON Hand Correlation
% TQD_Correlation_Component_OFF      TQD (Two Quadrant Detector) 的 OFF Handl Correlation
% DSTMD_CorrelationOutput          DSTMD model Corelation Output (Triple Correlator Output)
% DSTMD_LateralInhibitionOutput    DSTMD model Outputs after Lateral Inhibition 

%% Main Function

Index = i - StartRecordFrame +1;
% % %========= 下列代码用于确定最佳高通滤波器及 LMCs Inhibition 参数===============%
% % 模糊之后的图像
% RecordedData{Index}.BluredImage = BluredImage;
% 
% % 带通滤波器输出 (Band-pass filter)
% RecordedData{Index}.BandPassFilter_Output = BandPassFilter_Output;
% % 
% % LMCs Lateral Inhibition Mechanism 之后的输出
% RecordedData{Index}.LMCs_Inhibition_Output = LMCs_Inhibition_Output;
% % 
% % LMCs Lateral Inhibition Mechanism 之后的输出 (不包含时域部分 Temopral Part)
% RecordedData{Index}.LMCs_Inhibition_Output_NT = LMCs_Inhibition_Output_NT;

%%======================= 记录模型输出 ====================================%

% T1 Neuron Outputs
RecordedData{Index}.T1_Neuron_Outputs = T1_Neuron_Outputs;

% STMD Neuron Outputs (DS-STMD Theta Inhibition Mechanism Outputs)
RecordedData{Index}.DSTMD_Outputs_After_Inhibition_Along_Theta_Axis = DSTMD_Outputs_After_Inhibition_Along_Theta_Axis;







end

