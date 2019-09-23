function [ RecordedData ] = DataRecording(Photoreceptors_Outptut,LMCs_High_Pass_Output,...
                                            LMCs_Inhibition_Output,LMCs_Inhibition_Output_NT,...
                                              T1_Neuron_Outputs,...
                                                ON_Channel,OFF_Channel,...
                                                   MaxOperation_ON_Output, MaxOperation_OFF_Output,...
                                                     TQD_Correlation_Component_ON,TQD_Correlation_Component_OFF,...
                                                        DS_STMD_CorrelationOutput,DS_STMD_LateralInhibitionOutput,...
                                                          TQD_Delayed_ON_Channel,TQD_Delayed_OFF_Channel,...
                                                            DS_STMD_Delayed_ON_Channel,DS_STMD_Delayed_OFF_Channel_1,DS_STMD_Delayed_OFF_Channel_2,...
                                                              DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis,...
                                                                StartRecordFrame,i,RecordedData)

%% ����˵��
% StartFrame    ��ʼ��¼���ݵ�֡��
% i             ��ʱ���ڴ����֡��
% BluredImage   ģ��֮���ͼ��
% HighPassFilter_Output   ��ͨ�˲������
% TQD_Correlation_Component_ON       TQD (Two Quadrant Detector) �� ON Hand Correlation
% TQD_Correlation_Component_OFF      TQD (Two Quadrant Detector) �� OFF Handl Correlation
% DS_STMD_CorrelationOutput          DS-STMD model Corelation Output (Triple Correlator Output)
% DS_STMD_LateralInhibitionOutput    DS-STMD model Outputs after Lateral Inhibition 

%% Main Function

Index = i - StartRecordFrame +1;
% % %========= ���д�������ȷ����Ѹ�ͨ�˲����� LMCs Inhibition ����===============%
% % ģ��֮���ͼ��
% RecordedData{Index}.BluredImage = BluredImage;
% 
% % ��ͨ�˲������ (High-pass filter)
% RecordedData{Index}.HighPassFilter_Output = HighPassFilter_Output;
% % 
% % LMCs Lateral Inhibition Mechanism ֮������
% RecordedData{Index}.LMCs_Inhibition_Output = LMCs_Inhibition_Output;
% % 
% % LMCs Lateral Inhibition Mechanism ֮������ (������ʱ�򲿷� Temopral Part)
% RecordedData{Index}.LMCs_Inhibition_Output_NT = LMCs_Inhibition_Output_NT;

%%======================= ��¼ģ����� ====================================%

% T1 Neuron Outputs
RecordedData{Index}.T1_Neuron_Outputs = T1_Neuron_Outputs;

% STMD Neuron Outputs (DS-STMD Theta Inhibition Mechanism Outputs)
RecordedData{Index}.DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis = DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis;

% % LPTC Neuron Outputs (TQD Correlation Outputs)
% RecordedData{Index}.LPTC_Outputs = TQD_Correlation_Component_ON + TQD_Correlation_Component_OFF;




% % TQD (Two Quadrant Detector) �� ON channel Correlation
% RecordedData{Index}.TQD_Correlation_Component_ON = TQD_Correlation_Component_ON;
% 
% % TQD (Two Quadrant Detector) �� OFF channel Correlation
% RecordedData{Index}.TQD_Correlation_Component_OFF = TQD_Correlation_Component_OFF;



% % DS-STMD model Outputs after Lateral Inhibition 
% RecordedData{Index}.DS_STMD_LateralInhibitionOutput = DS_STMD_LateralInhibitionOutput;

% % % DS-STMD model Corelation Output (Triple Correlator Output)
% RecordedData{Index}.DS_STMD_CorrelationOutput = DS_STMD_CorrelationOutput;

% % %======================= ���д��������ȷ��ģ������ʱ�ӳ���======================%
% % ON and OFF Channels
% RecordedData{Index}.ON_Channel = ON_Channel;
% RecordedData{Index}.OFF_Channel = OFF_Channel;
% 
% % ON and OFF Channels After Max Operation 
% RecordedData{Index}.MaxOperation_ON_Output = MaxOperation_ON_Output;
% RecordedData{Index}.MaxOperation_OFF_Output = MaxOperation_OFF_Output;
% 
% % TQD ON Hand
% RecordedData{Index}.TQD_Delayed_ON_Channel = TQD_Delayed_ON_Channel;
% % TQD OFF��Hand
% RecordedData{Index}.TQD_Delayed_OFF_Channel = TQD_Delayed_OFF_Channel;
% 
% % DS-STMD Channel Delay
% RecordedData{Index}.DS_STMD_Delayed_ON_Channel = DS_STMD_Delayed_ON_Channel;
% RecordedData{Index}.DS_STMD_Delayed_OFF_Channel_1 = DS_STMD_Delayed_OFF_Channel_1;
% RecordedData{Index}.DS_STMD_Delayed_OFF_Channel_2 = DS_STMD_Delayed_OFF_Channel_2;


end

