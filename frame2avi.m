% 2016-11-14
% ����˵��
% �ú������ںϳ���Ƶ

clear all; close all; clc;

% %======================= ���� Tracking Result ����Ƶ====================%
DS_STMD_Detection_Threshold = 150;
Image_Title_Tracking_Result = strcat('Videos\Target-Trace-Threshold-',num2str(DS_STMD_Detection_Threshold));

NumFrames = 1000;

% 'MPEG-4' ����ָ�������Ƶ��ʽ
WriterObj=VideoWriter(Image_Title_Tracking_Result,'MPEG-4');   

WriterObj.FrameRate = 50;
open(WriterObj);

for i = 1:NumFrames        % n_frames��ʾͼ��֡������
    
    frame=imread(strcat('Figures\Tracking-Result-Target-Trace-Thershold-',num2str(DS_STMD_Detection_Threshold),'-',num2str(i),'.jpg'));       %  ��ȡͼ�񣬷��ڱ���frame��
    
    %frame = imresize(frame,0.5);
    writeVideo(WriterObj,frame);     % ��frame�ŵ�����WriterObj��
    
end
close(WriterObj);



% %====================== ����������Ƶ ===============================%
% 
% folderName = 'Cluttered-Background-Curvilinear-Motion';    % 'Target-Detection-in-Cluttered-Background';
% 
% BackgroundType = 'CB-1';                               % 1 ��ʾ���ӱ�����2 ��ʾ��Ϊ�ɾ��ı����� 0 ��ʾ�ޱ���
% TargetNum = 'SingleTarget';
% TargetWidth = 5;
% TargetHeight = 5;
% TargetVelocity = 250;
% TargetLuminance = 0;
% BackgroundVelocity = 250;
% MotionMode = 'OppositeDirection';                 % OppositeDirection, SameDirection, NoRelativeMotion, BackgroundStationary
% Y_Axis_Amplitude = 15;
% Y_Axis_TemporalFrequency = 2;
% VideoSamplingFrequency = 1000;                         % Default Value : 1 kHz
% 
% % Path of Input Image Sequence
% folder0 = ['D:\Matlab\TestSet-STMD\',folderName,'\',BackgroundType,'-',TargetNum,'-TargetWidth-',num2str(TargetWidth),'-TargetHeight-',num2str(TargetHeight),...
%     '-TargetVelocity-',num2str(TargetVelocity),'-TargetLuminance-',num2str(TargetLuminance),'-BackgroundVelocity-',num2str(BackgroundVelocity),'-',MotionMode,'-Amp-',...
%     num2str(Y_Axis_Amplitude),'-TemFre-',num2str(Y_Axis_TemporalFrequency),'-SamplingFrequency-',num2str(VideoSamplingFrequency)];
%          
% Imagetitle = 'Synthetic-Stimuli';
% 
% % ����������Ƶ������
% Image_Title_Input_Video = 'Videos\Input-Video-Curvilinear-Motion';
% 
% WriterObj_2=VideoWriter(Image_Title_Input_Video,'MPEG-4');   
% 
% WriterObj_2.FrameRate = 50;
% open(WriterObj_2);
% 
% StratFrame = 300;
% EndFrame = 1300;
% 
% %figure
% 
% for i = StratFrame:EndFrame       % n_frames��ʾͼ��֡������
%     
%     file = [folder0,'/',sprintf('%s%04d.tif',Imagetitle,i)];
%     Original_Image=imread(file);       %  ��ȡͼ�񣬷��ڱ���frame��
%     %Original_Image = imresize(Original_Image,[500,1000]);
%     
%     
%     %Tracking_Result_frame=imread(strcat('Figures\Tracking-Result-Thershold-',num2str(DS_STMD_Detection_Threshold),'-',num2str(i-StratFrame+1),'.jpg')); 
%     %Tracking_Result_frame = imresize(Tracking_Result_frame,[500,1000]);
%     %subplot(1,2,1)
% %     imshow(Original_Image)
% %     subplot(1,2,2)
% %     imshow(Tracking_Result_frame)
% %     set(gcf,'Position',[250,250,1000,250],'color','w')
%     
%     drawnow
%     
%     %frame = imresize(frame,0.5);
%     %writeVideo(WriterObj_2,frame2im(getframe(gcf)));     % ��frame�ŵ�����WriterObj��
%     writeVideo(WriterObj_2,Original_Image);     % ��frame�ŵ�����WriterObj��
% 
%     
% end
% close 
% close(WriterObj_2);







