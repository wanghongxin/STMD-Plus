% 2016-10-10

% 函数说明
% 该函数用于测试 DoG 及 LoG 
% 主要分为两部分
% Part 1 及 Part 2
% 具体细节及说明见下

clear all; clc; close all;

%% Part 1
% 这部分主要用于测试对于同一大小的物体，不同尺度 （Sigma） 下 LoG 及 DoG 的响应
% 这部分可以用于确定最佳的参数（对于确定大小的物体）

% 读取图像 大小为 5*5 的方块
file = ['D:\Matlab\TestSet-STMD\TestSet-For-Selection-of-LoG-and-DoG-Filter-Parameters\','Size-5-5.jpg'];
I = double(imread(file));

% DoG  (Difference of Gaussian)

KernelType = 1;      % 确定生成 Inhibition Kernel 的类型    
StartSigma = 0.5;      % 确定 Sigma 的范围
Step = 0.1;
EndSigma = 10;
SigmaRange = StartSigma:Step:EndSigma;
DoGResponse = zeros(length(SigmaRange),1);  % 用于存储 DoG 卷积之后的反应
for i = StartSigma:Step:EndSigma;
    % DoG 参数确定
    Parameters = zeros(7,1);
    Parameters(1) = 100;                % Kernel Size
    Parameters(2) = i;
    Parameters(3) = 2*Parameters(2);    % Sigma_2 = 2*Sigma_1 为对 LoG (Normalized) 的最佳近似(Best approximation)
    Parameters(4) = 1;                  % e
    Parameters(5) = 0;                  % rho
    Parameters(6) = 1;                  % A 
    Parameters(7) = 1;                  % B
    
    % 调用函数 Generalization_DS_STMD_InhibitionKernel 用于生成 DoG 卷积核
    [DS_STMD_InhibitionKernel] = Generalization_DS_STMD_InhibitionKernel(Parameters,KernelType);
    
    if i == EndSigma
        disp(i);
        figure
        surf(DS_STMD_InhibitionKernel')
    end
    
    
    % 卷积运算
    ConvolutionResponse = conv2(I,DS_STMD_InhibitionKernel,'same');
    % 记录方块中心的响应
    MaxResponse = ConvolutionResponse(130,130);
    DoGResponse(round((i-StartSigma)/Step)+1,1) = MaxResponse;
    
    
    

end
% 绘图
figure
plot(SigmaRange,DoGResponse)
xlabel('Scale')
ylabel('DoG Response')
grid on

% LoG (Laplacian of Gaussian)

KernelType = 2;       % 确定生成 Inhibition Kernel 的类型    
StartSigma = 0.5;       % 确定 Sigma 的范围
Step = 0.1;
EndSigma = 10;
SigmaRange = StartSigma:Step:EndSigma;
LoGResponse = zeros(length(SigmaRange),1);    % 用于存储 DoG 卷积之后的反应
for i = StartSigma:Step:EndSigma;
    % LoG 参数确定
    Parameters = zeros(4,1);      
    Parameters(1) = 100;               % Kernel Size
    Parameters(2) = i;                 % Sigma
    Parameters(3) = 1;                 % A
    Parameters(4) = 1;                 % B
    
    % 生成 LoG 卷积核
    [DS_STMD_InhibitionKernel] = Generalization_DS_STMD_InhibitionKernel(Parameters,KernelType);
    if i == EndSigma
        disp(i);
        figure
        surf(DS_STMD_InhibitionKernel')
    end
    % 卷积运算
    ConvolutionResponse = conv2(I,DS_STMD_InhibitionKernel,'same');
    % 记录方块中心的响应
    MaxResponse = ConvolutionResponse(130,130);
    LoGResponse(round((i-StartSigma)/Step)+1,1) = MaxResponse;

end
% 绘制结果
figure
plot(SigmaRange,LoGResponse)
xlabel('Scale')
ylabel('LoG Response')
grid on

%% Part 2
% 该部分用于测试同一尺度参数 (Sigma) 下，不同大小物体的响应


% DoG (Difference of Gaussian)

KernelType = 1;
% DoG 参数确定
Parameters = zeros(7,1);
Parameters(1) = 100;                % Kernel Size
Parameters(2) = 1.5;                % Sigma_1 = 1.5  对于大小为 5*5 的最佳 Sigma   （1.5,3.0）
Parameters(3) = 2*Parameters(2);    % Sigma_2 = 2*Sigma_1 为对 LoG (Normalized) 的最佳近似(Best approximation)
Parameters(4) = 1;                  % e
Parameters(5) = 0;                  % rho
Parameters(6) = 8;                  % A 
Parameters(7) = 25;                  % B

[DS_STMD_InhibitionKernel] = Generalization_DS_STMD_InhibitionKernel(Parameters,KernelType);


DoGResponse = zeros(length(2:16),1);
for i = 2:16
    % 读入图像，方块为大小为 i*i
    file = ['D:\Matlab\TestSet-STMD\TestSet-For-Selection-of-LoG-and-DoG-Filter-Parameters\','Size-',num2str(i),'-',num2str(i),'.jpg'];
    I = double(imread(file));
    % 卷积运算
    ConvolutionResponse = conv2(I,DS_STMD_InhibitionKernel,'same');
    % 记录方块中心的响应
    R = floor(i/2);
    MaxResponse = ConvolutionResponse(128+R,128+R);
    DoGResponse(i-1,1) = MaxResponse;

end
% 绘图
figure
plot(2:16,DoGResponse)
xlabel('Size')
ylabel('DoG Response')
grid on


% LoG (Laplacian of Gaussian)

KernelType = 2;
% LoG 参数确定
Parameters = zeros(4,1);      
Parameters(1) = 100;               % Kernel Size
Parameters(2) = 2;                 % Sigma  对于大小为 5*5 的最佳 Sigma （2.0）
Parameters(3) = 1;                 % A
Parameters(4) = 1;                 % B

[DS_STMD_InhibitionKernel] = Generalization_DS_STMD_InhibitionKernel(Parameters,KernelType);

LoGResponse = zeros(length(2:16),1);
for i = 2:16
    % 读入图像，方块为大小为 i*i
    file = ['D:\Matlab\TestSet-STMD\TestSet-For-Selection-of-LoG-and-DoG-Filter-Parameters\','Size-',num2str(i),'-',num2str(i),'.jpg'];
    I = double(imread(file));
    % 卷积运算
    ConvolutionResponse = conv2(I,DS_STMD_InhibitionKernel,'same');
    % 记录方块中心的响应
    R = floor(i/2);
    MaxResponse = ConvolutionResponse(128+R,128+R);
    LoGResponse(i-1,1) = MaxResponse;

end
% 绘图
figure
plot(2:16,LoGResponse)
xlabel('Scale')
ylabel('LoG Response')
grid on


    







