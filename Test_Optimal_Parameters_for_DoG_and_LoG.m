% 2016-10-10

% ����˵��
% �ú������ڲ��� DoG �� LoG 
% ��Ҫ��Ϊ������
% Part 1 �� Part 2
% ����ϸ�ڼ�˵������

clear all; clc; close all;

%% Part 1
% �ⲿ����Ҫ���ڲ��Զ���ͬһ��С�����壬��ͬ�߶� ��Sigma�� �� LoG �� DoG ����Ӧ
% �ⲿ�ֿ�������ȷ����ѵĲ���������ȷ����С�����壩

% ��ȡͼ�� ��СΪ 5*5 �ķ���
file = ['D:\Matlab\TestSet-STMD\TestSet-For-Selection-of-LoG-and-DoG-Filter-Parameters\','Size-5-5.jpg'];
I = double(imread(file));

% DoG  (Difference of Gaussian)

KernelType = 1;      % ȷ������ Inhibition Kernel ������    
StartSigma = 0.5;      % ȷ�� Sigma �ķ�Χ
Step = 0.1;
EndSigma = 10;
SigmaRange = StartSigma:Step:EndSigma;
DoGResponse = zeros(length(SigmaRange),1);  % ���ڴ洢 DoG ���֮��ķ�Ӧ
for i = StartSigma:Step:EndSigma;
    % DoG ����ȷ��
    Parameters = zeros(7,1);
    Parameters(1) = 100;                % Kernel Size
    Parameters(2) = i;
    Parameters(3) = 2*Parameters(2);    % Sigma_2 = 2*Sigma_1 Ϊ�� LoG (Normalized) ����ѽ���(Best approximation)
    Parameters(4) = 1;                  % e
    Parameters(5) = 0;                  % rho
    Parameters(6) = 1;                  % A 
    Parameters(7) = 1;                  % B
    
    % ���ú��� Generalization_DS_STMD_InhibitionKernel �������� DoG �����
    [DS_STMD_InhibitionKernel] = Generalization_DS_STMD_InhibitionKernel(Parameters,KernelType);
    
    if i == EndSigma
        disp(i);
        figure
        surf(DS_STMD_InhibitionKernel')
    end
    
    
    % �������
    ConvolutionResponse = conv2(I,DS_STMD_InhibitionKernel,'same');
    % ��¼�������ĵ���Ӧ
    MaxResponse = ConvolutionResponse(130,130);
    DoGResponse(round((i-StartSigma)/Step)+1,1) = MaxResponse;
    
    
    

end
% ��ͼ
figure
plot(SigmaRange,DoGResponse)
xlabel('Scale')
ylabel('DoG Response')
grid on

% LoG (Laplacian of Gaussian)

KernelType = 2;       % ȷ������ Inhibition Kernel ������    
StartSigma = 0.5;       % ȷ�� Sigma �ķ�Χ
Step = 0.1;
EndSigma = 10;
SigmaRange = StartSigma:Step:EndSigma;
LoGResponse = zeros(length(SigmaRange),1);    % ���ڴ洢 DoG ���֮��ķ�Ӧ
for i = StartSigma:Step:EndSigma;
    % LoG ����ȷ��
    Parameters = zeros(4,1);      
    Parameters(1) = 100;               % Kernel Size
    Parameters(2) = i;                 % Sigma
    Parameters(3) = 1;                 % A
    Parameters(4) = 1;                 % B
    
    % ���� LoG �����
    [DS_STMD_InhibitionKernel] = Generalization_DS_STMD_InhibitionKernel(Parameters,KernelType);
    if i == EndSigma
        disp(i);
        figure
        surf(DS_STMD_InhibitionKernel')
    end
    % �������
    ConvolutionResponse = conv2(I,DS_STMD_InhibitionKernel,'same');
    % ��¼�������ĵ���Ӧ
    MaxResponse = ConvolutionResponse(130,130);
    LoGResponse(round((i-StartSigma)/Step)+1,1) = MaxResponse;

end
% ���ƽ��
figure
plot(SigmaRange,LoGResponse)
xlabel('Scale')
ylabel('LoG Response')
grid on

%% Part 2
% �ò������ڲ���ͬһ�߶Ȳ��� (Sigma) �£���ͬ��С�������Ӧ


% DoG (Difference of Gaussian)

KernelType = 1;
% DoG ����ȷ��
Parameters = zeros(7,1);
Parameters(1) = 100;                % Kernel Size
Parameters(2) = 1.5;                % Sigma_1 = 1.5  ���ڴ�СΪ 5*5 ����� Sigma   ��1.5,3.0��
Parameters(3) = 2*Parameters(2);    % Sigma_2 = 2*Sigma_1 Ϊ�� LoG (Normalized) ����ѽ���(Best approximation)
Parameters(4) = 1;                  % e
Parameters(5) = 0;                  % rho
Parameters(6) = 8;                  % A 
Parameters(7) = 25;                  % B

[DS_STMD_InhibitionKernel] = Generalization_DS_STMD_InhibitionKernel(Parameters,KernelType);


DoGResponse = zeros(length(2:16),1);
for i = 2:16
    % ����ͼ�񣬷���Ϊ��СΪ i*i
    file = ['D:\Matlab\TestSet-STMD\TestSet-For-Selection-of-LoG-and-DoG-Filter-Parameters\','Size-',num2str(i),'-',num2str(i),'.jpg'];
    I = double(imread(file));
    % �������
    ConvolutionResponse = conv2(I,DS_STMD_InhibitionKernel,'same');
    % ��¼�������ĵ���Ӧ
    R = floor(i/2);
    MaxResponse = ConvolutionResponse(128+R,128+R);
    DoGResponse(i-1,1) = MaxResponse;

end
% ��ͼ
figure
plot(2:16,DoGResponse)
xlabel('Size')
ylabel('DoG Response')
grid on


% LoG (Laplacian of Gaussian)

KernelType = 2;
% LoG ����ȷ��
Parameters = zeros(4,1);      
Parameters(1) = 100;               % Kernel Size
Parameters(2) = 2;                 % Sigma  ���ڴ�СΪ 5*5 ����� Sigma ��2.0��
Parameters(3) = 1;                 % A
Parameters(4) = 1;                 % B

[DS_STMD_InhibitionKernel] = Generalization_DS_STMD_InhibitionKernel(Parameters,KernelType);

LoGResponse = zeros(length(2:16),1);
for i = 2:16
    % ����ͼ�񣬷���Ϊ��СΪ i*i
    file = ['D:\Matlab\TestSet-STMD\TestSet-For-Selection-of-LoG-and-DoG-Filter-Parameters\','Size-',num2str(i),'-',num2str(i),'.jpg'];
    I = double(imread(file));
    % �������
    ConvolutionResponse = conv2(I,DS_STMD_InhibitionKernel,'same');
    % ��¼�������ĵ���Ӧ
    R = floor(i/2);
    MaxResponse = ConvolutionResponse(128+R,128+R);
    LoGResponse(i-1,1) = MaxResponse;

end
% ��ͼ
figure
plot(2:16,LoGResponse)
xlabel('Scale')
ylabel('LoG Response')
grid on


    







