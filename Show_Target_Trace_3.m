% 2016-11-21


clear all; clc;

%% ESTMD
Is_Show_ESTMD_Detected_Result = 0;
if Is_Show_ESTMD_Detected_Result == 1
    if ~exist('Clustering_Results','var')
        
        %clear all; close all; clc;
        ESTMD_Detection_Threshold = 5;
        File_Max = strcat('D:\Matlab\2018-04-12-STMD-Modeling-ROC-Curve\Data-Journal-Paper-1\Data-for-DR-FA\CB-1\Velocity\Velocity-250\Clustering_Results-ESTMD-Detection-Threshold-',num2str(ESTMD_Detection_Threshold),'.mat');
        load(File_Max)
        
    end
    
    
    % ����ͼ���С
    Input_Image_M = 250;
    Input_Image_N = 500;
    
    
    NumFrame_Clustering = length(Clustering_Results);
    
    
    figure
    for jstt = 1:NumFrame_Clustering
        
        Position_Frame = Clustering_Results{jstt}.Clustering_Points_Matrix;
        Detected_Point_Num_Frame = Clustering_Results{jstt}.Clustering_Detected_Object_Num;
        
        
        plot(Position_Frame(1:Detected_Point_Num_Frame,2,:),Input_Image_M - Position_Frame(1:Detected_Point_Num_Frame,1,:)+1,'.','color','k','Markersize',10.0)
        hold on
        
        
    end
    
    set(gca,'Position',[0.15 0.25 0.8 0.4]);
    grid on
    axis([0,500,0,250])
    set(gca,'XTick',[0:100:500]);
    set(gca,'YTick',[0:125:250]);
    xlabel('\boldmath $x$ \textbf{(pixel)}','Interpreter','latex')
    ylabel('\boldmath $y$ \textbf{(pixel)}','Interpreter','latex')
    set(gca,'FontName','Times New Roman','FontWeight','bold','FontSize',20);
end

%% DSTMD

clear all; clc;

if ~exist('Clustering_Results','var')
    
    %clear all; close all; clc;
    DSTMD_Detection_Threshold = 150;
    File_Max = strcat('D:\Matlab\2018-04-10-STMD-Plus-ROC-Curve-More-Details\Data\Data-for-DR-FA\CB-1\Size\Size-5\Target-Trace-Threshold-',num2str(DSTMD_Detection_Threshold),'.mat');
    load(File_Max)
    
end

Input_Image_M = 250;
Input_Image_N = 500;

NumFrame_Clustering = size(Target_Trace,3);
DS_STMD_Directions  = 8;
MarkerEdgeColors = jet(DS_STMD_Directions);

figure
for jstt = 1:NumFrame_Clustering
    
    for kstt = [34 38 41 43]
        % setdiff([1:Target_Trace_Num(jstt)],[34 38 41 43])
        %for kstt = [34  38 41 43]   1:Target_Trace_Num(jstt)
        % ���� CB-1 Target Trace�� Threshold Ϊ 150 ʱ�� ��Ӧ�� kstt Ϊ 34  38 41 43
        % Threshold Ϊ 500 ʱ�� ��Ӧ�� kstt Ϊ 7 10 11 12 13 14 16
        % Threshold Ϊ 450 ʱ�� ��Ӧ�� kstt Ϊ 12 13 14 15 16 17 19
        % Threshold Ϊ 400 ʱ�� ��Ӧ�� kstt Ϊ 13 15 16 17 18 19 21 22
        % Threshold Ϊ 350 ʱ�� ��Ӧ�� kstt Ϊ 17 19 20 21 22 23 25 26 27
        % Threshold Ϊ 300 ʱ�� ��Ӧ�� kstt Ϊ 20 22 23 24 25 27 28
        % Threshold Ϊ 250 ʱ�� ��Ӧ�� kstt Ϊ 23 27 28 29 32
        % Threshold Ϊ 200 ʱ�� ��Ӧ�� kstt Ϊ 29 31 32 33 36
        % Threshold Ϊ 150 ʱ�� ��Ӧ�� kstt Ϊ 34 38 41 43
        X_Pos_STT = Target_Trace(kstt,1,jstt);
        Y_Pos_STT = Target_Trace(kstt,2,jstt);
        Direction_Index_STT = Target_Trace(kstt,3,jstt);
        if Direction_Index_STT>0
            plot(Y_Pos_STT,Input_Image_M - X_Pos_STT+1,'.','color',MarkerEdgeColors(Direction_Index_STT,:),'Markersize',10.0)
            hold on
        end
        
    end
    %drawnow
    
    
    %set(gcf,'Position',[250,250,500,250],'color','w')
    %legend('show','Location','southeast')
    %saveas(gcf,strcat('Figures\Tracking-Result-Thershold-',num2str(DS_STMD_Detection_Threshold),'-',num2str(j),'.jpg'))
    % ���ܲ��� saveas, ���򱣴�ͼƬ��С�޷��� set �е��趨��Сһ��
    % imwrite(frame2im(getframe(gcf)),strcat('Figures\Tracking-Result-Thershold-',num2str(DS_STMD_Detection_Threshold),'-',num2str(j),'.jpg'))
    
    
end

set(gca,'Position',[0.15 0.25 0.8 0.4]);
grid on
axis([0,500,0,250])
set(gca,'XTick',[0:100:500]);
set(gca,'YTick',[0:125:250]);
xlabel('\boldmath $x$ \textbf{(pixel)}','Interpreter','latex')
ylabel('\boldmath $y$ \textbf{(pixel)}','Interpreter','latex')
set(gca,'FontName','Times New Roman','FontWeight','bold','FontSize',20);



