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

% Band Pass Filter (Gamma function 1 - Gamma function 2)
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
Parameter_Fun.IsLMCs_LateralInhibition = 0;       %  �Ƿ�Դ�ͨ�˲�����źŽ��в�����
Parameter_Fun.IsTemporalInhibition_LMC = 0;       %  �Ƿ���ʱ���϶��źŽ��о����ʱ���ϵ���ϣ�
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
% Temporal Field (T1 Neurons ��ʱ�򲿷���һ�� Gamma Function)
Parameter_Fun.T1_Neuron_GammaFun_Order = 12;
Parameter_Fun.T1_Neuron_GammaFun_Tau = 20;              % Mu = Order/Tau < 1
Parameter_Fun.T1_Neuron_GammaFun_Outputs = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.T1_Neuron_GammaFun_Order+1);
% Spatial
Parameter_Fun.T1_Neuron_Kernel_Sigma = 1.5;
Parameter_Fun.T1_Neuron_Kernel_Alpha = 3;
Parameter_Fun.T1_Neuron_Kernel_Theta = [0 45 90 135];
Parameter_Fun.T1_Neuron_Kernel_Num = length(Parameter_Fun.T1_Neuron_Kernel_Theta);
Parameter_Fun.T1_Neuron_Kernel_Size = 11;
% ���� T1 Neural Filters (Spatial Field)
[Parameter_Fun.T1_Neurons_Kernels] = Generalize_T1_Neuron_Kernels(Parameter_Fun.T1_Neuron_Kernel_Sigma,...
                         Parameter_Fun.T1_Neuron_Kernel_Alpha,Parameter_Fun.T1_Neuron_Kernel_Theta,...
                         Parameter_Fun.T1_Neuron_Kernel_Size);
                     

% �Ƿ���Ҫ���� Small Target Motion Detection
Parameter_Fun.IsSmallTargetMotionPerception =  1;

% DSTMD (Directionally Selective Small Target Motion Detector)  
% Parameter for Correlation

% Channel Delay 
Parameter_Fun.DSTMD_GammaFun_Order_ON = 3;      % ON Channel �ӳٵĽ���
Parameter_Fun.DSTMD_GammaFun_Tau_ON = 15;       % ON Channel �ӳٵ�ʱ�䳣��   Mu = Order/Tau < 1
Parameter_Fun.DSTMD_GammaFun_Output_ON = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DSTMD_GammaFun_Order_ON+1);  % ���ڴ洢 ON Channel �ӳٵ����

Parameter_Fun.DSTMD_GammaFun_Order_OFF_1 = 5;      % ��һ�� OFF Channel �ӳٵĽ���
Parameter_Fun.DSTMD_GammaFun_Tau_OFF_1 = 25;       % ��һ�� OFF Channel �ӳٵ�ʱ�䳣��   Mu = Order/Tau < 1
Parameter_Fun.DSTMD_GammaFun_Output_OFF_1 = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DSTMD_GammaFun_Order_OFF_1+1);  % ���ڴ洢 OFF Channel �ӳٵ����

Parameter_Fun.DSTMD_GammaFun_Order_OFF_2 = 8;      % �ڶ��� OFF Channel �ӳٵĽ���
Parameter_Fun.DSTMD_GammaFun_Tau_OFF_2 = 40;       % �ڶ��� OFF Channel �ӳٵ�ʱ�䳣��   Mu = Order/Tau < 1
Parameter_Fun.DSTMD_GammaFun_Output_OFF_2 = zeros(Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DSTMD_GammaFun_Order_OFF_2+1);  % ���ڴ洢 OFF Channel �ӳٵ����

% Channel Correlation
Parameter_Fun.DSTMD_Dist = 3;                      % DS-STMD Channel Correlation ʱ�������ص�֮��ľ���
Parameter_Fun.DSTMD_Directions = 8;   

% DSTMD Inhibition Kernel
% Inhibition Kernel ����ѡȡ
% KernerlType = 1   DoG
% KernerlType = 2   LoG
Parameter_Fun.DSTMD_KernelType = 1;
Parameter_Fun.Parameters_DSTMD_InhibitionKernel = Generalization_Parameters_DSTMD_InhibitionKernel(Parameter_Fun.DSTMD_KernelType);
% ���ɲ����ƺ�
[Parameter_Fun.DSTMD_InhibitionKernel] = Generalization_DSTMD_InhibitionKernel(Parameter_Fun.Parameters_DSTMD_InhibitionKernel,Parameter_Fun.DSTMD_KernelType);
% Lateral Inhibition Kernel (Along Theta Axis)
[Parameter_Fun.DSTMD_InhibitionKernel_Theta_Axis] = Generalization_InhibitionKernel_Along_Theta_Axis(Parameter_Fun.DSTMD_Directions);


% �Ƿ񱣴�����
Parameter_Fun.IsRecordData = 1;
Parameter_Fun.IsSaveData = 1;
