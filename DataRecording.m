function [ RecordedData ] = DataRecording(Photoreceptors_Outptut,LMCs_Band_Pass_Output,T1_Neuron_Outputs,...
                                                ON_Channel,OFF_Channel,...
                                                        DSTMD_CorrelationOutput,DSTMD_LateralInhibitionOutput,...
                                                            DSTMD_Delayed_ON_Channel,DSTMD_Delayed_OFF_Channel_1,DSTMD_Delayed_OFF_Channel_2,...
                                                              DSTMD_Outputs_After_Inhibition_Along_Theta_Axis,...
                                                                StartRecordFrame,i,RecordedData)

%% ����˵��
% StartFrame    ��ʼ��¼���ݵ�֡��
% i             ��ʱ���ڴ����֡��
% BluredImage   ģ��֮���ͼ��
% HighPassFilter_Output   ��ͨ�˲������
% TQD_Correlation_Component_ON       TQD (Two Quadrant Detector) �� ON Hand Correlation
% TQD_Correlation_Component_OFF      TQD (Two Quadrant Detector) �� OFF Handl Correlation
% DSTMD_CorrelationOutput          DSTMD model Corelation Output (Triple Correlator Output)
% DSTMD_LateralInhibitionOutput    DSTMD model Outputs after Lateral Inhibition 

%% Main Function

Index = i - StartRecordFrame +1;
% % %========= ���д�������ȷ����Ѹ�ͨ�˲����� LMCs Inhibition ����===============%
% % ģ��֮���ͼ��
% RecordedData{Index}.BluredImage = BluredImage;
% 
% % ��ͨ�˲������ (Band-pass filter)
% RecordedData{Index}.BandPassFilter_Output = BandPassFilter_Output;
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
RecordedData{Index}.DSTMD_Outputs_After_Inhibition_Along_Theta_Axis = DSTMD_Outputs_After_Inhibition_Along_Theta_Axis;







end

