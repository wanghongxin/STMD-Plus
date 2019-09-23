% ����˵��
% �ú������ڹ������壨��Ҫ�Ǳ��������˶��ٶ�


%% Main Function

clear all; close all; clc;

%% ���ڵ����������Ƶ�����������С���ٶȣ��Աȶȣ������ٶȣ��˶������

% Parameters for Input Image Sequence

folderName = 'Velocity-Estimation';    % 'Target-Detection-in-Cluttered-Background';
BackgroundType = 'ClutteredBackground';                      %  ClutteredBackground or WhiteBackground
TargetNum = 'SingleTarget';
TargetWidth = 5;
TargetHeight = 5;
TargetVelocity = 40;
TargetLuminance = 0;
BackgroundVelocity = 50;
MotionMode = 'OppositeDirection';                 % OppositeDirection, SameDirection, NoRelativeMotion, BackgroundStationary
VideoSamplingFrequency = 1000;                         % Default Value : 1 kHz

% Path of Input Image Sequence
folder0 = ['D:\Matlab\TestSet-STMD\',folderName,'\',BackgroundType,'-',TargetNum,'-TargetWidth-',num2str(TargetWidth),'-TargetHeight-',num2str(TargetHeight),...
             '-TargetVelocity-',num2str(TargetVelocity),'-TargetLuminance-',num2str(TargetLuminance),'-BackgroundVelocity-',num2str(BackgroundVelocity),'-',MotionMode,...
             '-SamplingFrequency-',num2str(VideoSamplingFrequency)];

% Title of Input Image Sequence
Imagetitle = 'Synthetic-Stimuli';

% Start and end frame of input image sequence
StartFrame = 1;
EndFrame = 1000;

% 
IsManualCalculation = 0;
IsTracking = 1;

%============================ Part 1 ====================================%
if IsManualCalculation == 1
    
    figure
    file = [folder0,'/',sprintf('%s%04d.tif',Imagetitle,1)];
    I = imread(file);
    imshow(I)
    figure
    file = [folder0,'/',sprintf('%s%04d.tif',Imagetitle,100)];
    I = imread(file);
    imshow(I)

end

% Conclusion: ����ó���������� 5.7 


%============================Part 2========================================%

if IsTracking == 1
    
    % ��ɫ��ǵ��ʼλ��
    X_0 = 125;
    Y_0 = 104;
    % ��ɫ��ǵ㣨Red Star�����ٶȣ�pixel/second��
    V_RS = BackgroundVelocity;

    figure 
    for i = StartFrame:EndFrame
        
        file = [folder0,'/',sprintf('%s%04d.tif',Imagetitle,i)];
    
        I = imread(file);
    
        % ���㵱ǰ��ɫ��ǵ��λ��
        X_C = X_0;
        Y_C = Y_0 + round((V_RS/VideoSamplingFrequency)*(i-StartFrame+1));

        imshow(I)
        hold on 
        plot(Y_C,X_C,'r*')
        title(num2str(i))
        drawnow
    end

end







