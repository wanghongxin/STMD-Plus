% 2016-11-21


clear all

if ~exist('Clustering_Results','var')
    
    clear all; close all; clc;  
    DS_STMD_Detection_Threshold = 150;
    File_Max = strcat('D:\Matlab\2018-04-10-STMD-Plus-ROC-Curve-More-Details\Data\Data-for-DR-FA\CB-1\Velocity\Velocity-250\Target-Trace-Threshold-',num2str(DS_STMD_Detection_Threshold),'.mat');
    load(File_Max)
    
end


% 输入图像大小
Input_Image_M = 250;
Input_Image_N = 500;


NumFrame_Clustering = size(Target_Trace,3);
DS_STMD_Directions  = 8;
MarkerEdgeColors = jet(DS_STMD_Directions);

figure
for jstt = 1:NumFrame_Clustering

    for kstt = 1:Target_Trace_Num(jstt)
        %for kstt = [34  38 41 43]   1:Target_Trace_Num(jstt)
        % 对于 CB-1 Target Trace， Threshold 为 150 时， 对应的 kstt 为 34  38 41 43 
        % Threshold 为 500 时， 对应的 kstt 为 7 10 11 12 13 14 16
        % Threshold 为 450 时， 对应的 kstt 为 12 13 14 15 16 17 19
        % Threshold 为 400 时， 对应的 kstt 为 13 15 16 17 18 19 21 22
        % Threshold 为 350 时， 对应的 kstt 为 17 19 20 21 22 23 25 26 27
        % Threshold 为 300 时， 对应的 kstt 为 20 22 23 24 25 27 28
        % Threshold 为 250 时， 对应的 kstt 为 23 27 28 29 32
        % Threshold 为 200 时， 对应的 kstt 为 29 31 32 33 36
        % Threshold 为 150 时， 对应的 kstt 为 34 38 41 43
        X_Pos_STT = Target_Trace(kstt,1,jstt);
        Y_Pos_STT = Target_Trace(kstt,2,jstt);
        Direction_Index_STT = Target_Trace(kstt,3,jstt);
        if Direction_Index_STT>0
            plot(Y_Pos_STT,Input_Image_M - X_Pos_STT+1,'.','color',MarkerEdgeColors(Direction_Index_STT,:),'MarkerSize',10.0)
            hold on
            %text(Y_Pos_STT,Input_Image_M - X_Pos_STT+10,num2str(kstt))

%             if jstt == NumFrame_Clustering
%                 text(Y_Pos_STT,Input_Image_M - X_Pos_STT+10,num2str(kstt))
%             elseif (Target_Trace(kstt,3,min(jstt+1,NumFrame_Clustering)) == 0) && ...
%                        (Target_Trace(kstt,3,min(jstt+2,NumFrame_Clustering)) == 0) && ...
%                           (Target_Trace(kstt,3,min(jstt+3,NumFrame_Clustering)) == 0)
%                 text(Y_Pos_STT,Input_Image_M - X_Pos_STT+5,num2str(kstt))
%             end
        end
        
    end
    %drawnow

    
    %set(gcf,'Position',[250,250,500,250],'color','w')
    %legend('show','Location','southeast')
    %saveas(gcf,strcat('Figures\Tracking-Result-Thershold-',num2str(DS_STMD_Detection_Threshold),'-',num2str(j),'.jpg'))
    % 不能采用 saveas, 否则保存图片大小无法与 set 中的设定大小一致
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



