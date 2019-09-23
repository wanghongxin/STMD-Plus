% 2016-10-19

% ����˵��
% �ú�������������������Ĳ��������� High Pass Filter�� Lateral Inhibition Mechanism,
% Monophasic Neurons, TQD and DS-STMD

%% Parameter Setting
% Image Parameters
% Initialization
Parameter_Fun.file = [Parameter_File.folder0,'/',sprintf('%s%04d.tif',Parameter_File.Imagetitle,1)];
I = rgb2gray(imread(Parameter_Fun.file));
[Parameter_Fun.M,Parameter_Fun.N] = size(I);

% Gauss Blur
Parameter_Fun.GaussFilter = fspecial('gaussian',3,1);

% High Pass Filter (Gamma function 1 - Gamma function 2)
% Comment: High-pass Filter �Ĳ���ѡ��Ϊ :
% Gamma Function 1 : Order = 3    Tau = 5
% Gamma Function 2 : Order = 18   Tau = 30

% Parameters for Gamma Function 1
Parameter_Fun.GammaFun1_Order = 2;
Parameter_Fun.GammaFun1_Tau = 3;              % Mu = Order/Tau < 1
Parameter_Fun.GammaFun1_Output = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.GammaFun1_Order+1);
% Parameters for Gamma Function 2
Parameter_Fun.GammaFun2_Order = 6;
Parameter_Fun.GammaFun2_Tau = 9;              % Mu = Order/Tau < 1
Parameter_Fun.GammaFun2_Output = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.GammaFun2_Order+1);


% Large Monopolar Cells (LMCs) Lateral Inhibition Mechanism
Parameter_Fun.IsLMCs_LateralInhibition = 1;       %  �Ƿ�Ը�ͨ�˲�����źŽ��в�����
Parameter_Fun.IsTemporalInhibition_LMC = 1;       %  �Ƿ���ʱ���϶��źŽ��о����ʱ���ϵ���ϣ�
% LMCs �����ƵĿռ��򲿷֣�������� Difference of Gaussians
Parameter_Fun.LMCs_KernelSize = 13;
Parameter_Fun.LMCs_Sigma1 = 1.5;
Parameter_Fun.LMCs_Sigma2 = 3.0;
Parameter_Fun.LMCs_SpatialInhibitionKernel = DoGFilter(Parameter_Fun.LMCs_KernelSize,Parameter_Fun.LMCs_Sigma1,Parameter_Fun.LMCs_Sigma2);
% LMCs �����Ƶ�ʱ���򲿷�
Parameter_Fun.LMCs_W1_PastY = zeros(Parameter_Fun.M,Parameter_Fun.N);
Parameter_Fun.LMCs_W1_PastX = zeros(Parameter_Fun.M,Parameter_Fun.N);
Parameter_Fun.LMCs_W1_Alpha = 3;
Parameter_Fun.LMCs_W2_PastY = zeros(Parameter_Fun.M,Parameter_Fun.N);
Parameter_Fun.LMCs_W2_PastX = zeros(Parameter_Fun.M,Parameter_Fun.N);
Parameter_Fun.LMCs_W2_Alpha = 9;


% T1 Neuron = Amacrine Cell 1 -Amacrine Cell 2 
% Amacrine Cell �ľ����Ϊ��˹�˺�����T1 ��Ԫ�ľ����Ϊ������˹�˺����Ĳ� (��άƽ��)
% �� T1 ��Ԫ��ȣ� LMCs �ľ����Ϊ���� Gamma �����Ĳ� ��ʱ���ϣ�
% ��������ֱ������ T1 ��Ԫ�ľ����
Parameter_Fun.Is_Add_Contrast_Pathway = 1;          % �Ƿ����� Contrast Pathway
Parameter_Fun.Is_T1_Neurons_Temporal_Delay = 0;  % �Ƿ����� T1 ��Ԫ��ʱ�Ӳ���
% Temporal Field (Monophasic Neurons ��ʱ�򲿷���һ�� Gamma Function)
Parameter_Fun.T1_Neuron_GammaFun_Order = 12;
Parameter_Fun.T1_Neuron_GammaFun_Tau = 20;              % Mu = Order/Tau < 1
Parameter_Fun.T1_Neuron_GammaFun_Outputs = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.T1_Neuron_GammaFun_Order+1);
% Spatial
Parameter_Fun.T1_Neuron_Kernel_Sigma = 1.5;
Parameter_Fun.T1_Neuron_Kernel_Alpha = 3;
Parameter_Fun.T1_Neuron_Kernel_Theta = [0 45 90 135];
Parameter_Fun.T1_Neuron_Kernel_Num = length(Parameter_Fun.T1_Neuron_Kernel_Theta);
Parameter_Fun.T1_Neuron_Kernel_Size = 11;
% ���� Monphasic Filters (Spatial Field)
[Parameter_Fun.T1_Neurons_Kernels] = Generalize_T1_Neuron_Kernels(Parameter_Fun.T1_Neuron_Kernel_Sigma,...
                         Parameter_Fun.T1_Neuron_Kernel_Alpha,Parameter_Fun.T1_Neuron_Kernel_Theta,...
                         Parameter_Fun.T1_Neuron_Kernel_Size);
                     

% �Ƿ���Ҫ��� Wide-Field Motion 
Parameter_Fun.IsWideFieldMotionPerception =  1;       % TQD Correlation
% Max Operation
Parameter_Fun.IsMaxOperation = 0;             % �Ƿ���� MaxOperation
Parameter_Fun.IsMex = 1;                      % �Ƿ���� MaxOperation_mex 
Parameter_Fun.MexOperation = 1;               % �Ƿ���Ҫ Mex ���� ע���� Mex
Parameter_Fun.MaxRegion_Size = 7;             % ���������СΪ 2*MaxRegion_Size���� 15*15
Parameter_Fun.MaxOperation_Thres = 0;


% TQD (Two Quadrant Detector) --- Channel Correlation (Time Delay)
Parameter_Fun.TQD_GammaFun_Order = 5;
Parameter_Fun.TQD_GammaFun_Tau = 15;             % Mu = Order/Tau < 1
Parameter_Fun.TQD_GammaFun_Output_ON = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.TQD_GammaFun_Order+1);
Parameter_Fun.TQD_GammaFun_Output_OFF = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.TQD_GammaFun_Order+1);
Parameter_Fun.TQD_Dist = 3;   % Distance Between Two Pixels (Elementary Motion Detector)
Parameter_Fun.TQD_Directions = 4;      % �ؼ���������� EMD ����� ��ˮƽ����ֱ��


% �Ƿ���Ҫ���� Small Target Motion Detection
Parameter_Fun.IsSmallTargetMotionPerception =  1;

% DS-STMD (Directionally Selective Small Target Motion Detector)  
% Parameter for Correlation

% Channel Delay 
Parameter_Fun.DS_STMD_GammaFun_Order_ON = 3;      % ON Channel �ӳٵĽ���
Parameter_Fun.DS_STMD_GammaFun_Tau_ON = 15;       % ON Channel �ӳٵ�ʱ�䳣��   Mu = Order/Tau < 1
Parameter_Fun.DS_STMD_GammaFun_Output_ON = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_GammaFun_Order_ON+1);  % ���ڴ洢 ON Channel �ӳٵ����

Parameter_Fun.DS_STMD_GammaFun_Order_OFF_1 = 5;      % ��һ�� OFF Channel �ӳٵĽ���
Parameter_Fun.DS_STMD_GammaFun_Tau_OFF_1 = 25;       % ��һ�� OFF Channel �ӳٵ�ʱ�䳣��   Mu = Order/Tau < 1
Parameter_Fun.DS_STMD_GammaFun_Output_OFF_1 = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_GammaFun_Order_OFF_1+1);  % ���ڴ洢 OFF Channel �ӳٵ����

Parameter_Fun.DS_STMD_GammaFun_Order_OFF_2 = 8;      % �ڶ��� OFF Channel �ӳٵĽ���
Parameter_Fun.DS_STMD_GammaFun_Tau_OFF_2 = 40;       % �ڶ��� OFF Channel �ӳٵ�ʱ�䳣��   Mu = Order/Tau < 1
Parameter_Fun.DS_STMD_GammaFun_Output_OFF_2 = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_GammaFun_Order_OFF_2+1);  % ���ڴ洢 OFF Channel �ӳٵ����

% Channel Correlation
Parameter_Fun.DS_STMD_Dist = 3;                      % DS-STMD Channel Correlation ʱ�������ص�֮��ľ���
Parameter_Fun.DS_STMD_Directions = 8;   

% DS-STMD Inhibition Kernel
% Inhibition Kernel ����ѡȡ
% KernerlType = 1   DoG
% KernerlType = 2   LoG
Parameter_Fun.DS_STMD_KernelType = 1;
Parameter_Fun.Parameters_DS_STMD_InhibitionKernel = Generalization_Parameters_DS_STMD_InhibitionKernel(Parameter_Fun.DS_STMD_KernelType);
% ���ɲ����ƺ�
[Parameter_Fun.DS_STMD_InhibitionKernel] = Generalization_DS_STMD_InhibitionKernel(Parameter_Fun.Parameters_DS_STMD_InhibitionKernel,Parameter_Fun.DS_STMD_KernelType);

% Lateral Inhibition Kernel (Along Theta Axis)
[Parameter_Fun.DS_STMD_InhibitionKernel_Theta_Axis] = Generalization_InhibitionKernel_Along_Theta_Axis(Parameter_Fun.DS_STMD_Directions);

% �Ƿ������������ÿһ���������ڿռ�����չʾ,չʾ���һ֡�Ķ�Ӧ�����
Parameter_Fun.Is_Show_Neural_Outputs_Along_A_Line = 1;

% �Ƿ񱣴�����
Parameter_Fun.IsRecordData = 1;
Parameter_Fun.Is_Show_Recorded_Data_in_Temporal_Field = 0;      % �Ƿ�չʾһ�����ص�����¼������ʱ��ı仯
Parameter_Fun.IsSaveData = 1;


