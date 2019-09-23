% 2016-11-05

% ����˵��
% �ú�������չʾ������

%=====================================================================%
% ��ȡ����

clear all;

if ~exist('Clustering_Results','var')
    
    clear all; close all; clc;  
    DS_STMD_Detection_Threshold = 150;
    File_Max = strcat('D:\Matlab\2016-10-01-Small-Field-System\Data\Clustering_Results-Detection-Threshold-',num2str(DS_STMD_Detection_Threshold),'.mat');
    load(File_Max)
    
end

% 
Show_Start_Frame = 1;
Show_End_Frame = 1000;

% ����ͼ���С
Input_Image_M = 250;
Input_Image_N = 500;

NumFrame_Clustering = length(Clustering_Results);
DS_STMD_Directions  = 8;
MarkerEdgeColors = jet(DS_STMD_Directions);
% �����ж��Ƿ����ĳһ������˶���������洢����
IsDirectionExisting = zeros(DS_STMD_Directions,2);

figure
for j = Show_Start_Frame:Show_End_Frame

    for k = 1:DS_STMD_Directions    % Ĭ���� 8 
        
%         if k == 1
%             if Clustering_Results{j}.Direction_1_ClusteringPointsNum >0
%                 X_Clustering = Clustering_Results{j}.Direction_1_ClusteringPoints(:,1);
%                 Y_Clustering = Clustering_Results{j}.Direction_1_ClusteringPoints(:,2);
%                 plot(Y_Clustering,Input_Image_M - X_Clustering+1,'.','color',MarkerEdgeColors(k,:))
%                 % �˴���Ҫע�⣬���� find ����õĵ��������ɾ�������Ͻǣ�1,1����ʼ����
%                 % ������ plot ȷ���ɾ�������½ǣ�1,1����ʼ����
%                 % ��ˣ���Ҫ�ڴ˴��� X_Clustering ��һ��ת������ 
%                 % Input_Image_M - X_Clustering+1
%                 hold on
%                 % CB-1 �����˶�����Ϊ 1 6 7
%                 
%                 % ��¼������
%                 IsDirectionExisting(1,:) = [Y_Clustering(1),Input_Image_M - X_Clustering(1)+1];
%             end
%         end
        
        if k == 2
            if Clustering_Results{j}.Direction_2_ClusteringPointsNum >0
                X_Clustering = Clustering_Results{j}.Direction_2_ClusteringPoints(:,1);
                Y_Clustering = Clustering_Results{j}.Direction_2_ClusteringPoints(:,2);
                plot(Y_Clustering,Input_Image_M - X_Clustering+1,'.','color',MarkerEdgeColors(k,:))
                hold on
                
                IsDirectionExisting(2,:) = [Y_Clustering(1),Input_Image_M - X_Clustering(1)+1];
            end
        end
        
        if k == 3
            if Clustering_Results{j}.Direction_3_ClusteringPointsNum >0
                X_Clustering = Clustering_Results{j}.Direction_3_ClusteringPoints(:,1);
                Y_Clustering = Clustering_Results{j}.Direction_3_ClusteringPoints(:,2);
                plot(Y_Clustering,Input_Image_M - X_Clustering+1,'.','color',MarkerEdgeColors(k,:))
                hold on
                
                IsDirectionExisting(3,:) = [Y_Clustering(1),Input_Image_M - X_Clustering(1)+1];
            end
        end
        if k == 4
            if Clustering_Results{j}.Direction_4_ClusteringPointsNum >0
                X_Clustering = Clustering_Results{j}.Direction_4_ClusteringPoints(:,1);
                Y_Clustering = Clustering_Results{j}.Direction_4_ClusteringPoints(:,2);
                plot(Y_Clustering,Input_Image_M - X_Clustering+1,'.','color',MarkerEdgeColors(k,:))
                hold on
                
                IsDirectionExisting(4,:) = [Y_Clustering(1),Input_Image_M - X_Clustering(1)+1];
            end
        end
        if k == 5
            if Clustering_Results{j}.Direction_5_ClusteringPointsNum >0
                X_Clustering = Clustering_Results{j}.Direction_5_ClusteringPoints(:,1);
                Y_Clustering = Clustering_Results{j}.Direction_5_ClusteringPoints(:,2);
                plot(Y_Clustering,Input_Image_M - X_Clustering+1,'.','color',MarkerEdgeColors(k,:))
                hold on
                
                IsDirectionExisting(5,:) = [Y_Clustering(1),Input_Image_M - X_Clustering(1)+1];
            end
        end
%         
        
%         if k == 6
%             if Clustering_Results{j}.Direction_6_ClusteringPointsNum >0
%                 X_Clustering = Clustering_Results{j}.Direction_6_ClusteringPoints(:,1);
%                 Y_Clustering = Clustering_Results{j}.Direction_6_ClusteringPoints(:,2);
%                 plot(Y_Clustering,Input_Image_M - X_Clustering+1,'.','color',MarkerEdgeColors(k,:))
%                 hold on
%                 
%                 IsDirectionExisting(6,:) = [Y_Clustering(1),Input_Image_M - X_Clustering(1)+1];
%             end
%         end
%         if k == 7
%             if Clustering_Results{j}.Direction_7_ClusteringPointsNum >0
%                 X_Clustering = Clustering_Results{j}.Direction_7_ClusteringPoints(:,1);
%                 Y_Clustering = Clustering_Results{j}.Direction_7_ClusteringPoints(:,2);
%                 plot(Y_Clustering,Input_Image_M - X_Clustering+1,'.','color',MarkerEdgeColors(k,:))
%                 hold on
%                 
%                 IsDirectionExisting(7,:) = [Y_Clustering(1),Input_Image_M - X_Clustering(1)+1];
%             end
%         end
        
        if k == 8
            if Clustering_Results{j}.Direction_8_ClusteringPointsNum >0
                X_Clustering = Clustering_Results{j}.Direction_8_ClusteringPoints(:,1);
                Y_Clustering = Clustering_Results{j}.Direction_8_ClusteringPoints(:,2);
                plot(Y_Clustering,Input_Image_M - X_Clustering+1,'.','color',MarkerEdgeColors(k,:))
                
                IsDirectionExisting(8,:) = [Y_Clustering(1),Input_Image_M - X_Clustering(1)+1];
            end
        end

        
        
        %grid on
    end
    drawnow
    axis([0,500,0,250])
    set(gcf,'Position',[250,250,626,314],'color','w')
    %set(gcf,'Position',[250,250,625,312])
    set(gca,'Position',[0.1 0.1 0.8 0.8]);
    %legend('show','Location','southeast')
    %saveas(gcf,strcat('Figures\Tracking-Result-Thershold-',num2str(DS_STMD_Detection_Threshold),'-',num2str(j),'.jpg'))
    % ���ܲ��� saveas, ���򱣴�ͼƬ��С�޷��� set �е��趨��Сһ��
    imwrite(frame2im(getframe(gcf)),strcat('Figures\Tracking-Result-Background-Noise-Trace-Thershold-',num2str(DS_STMD_Detection_Threshold),'-',num2str(j),'.jpg'))
       
end

% % ���� Legend
% H1 = plot(IsDirectionExisting(1,1)+1000,IsDirectionExisting(1,2)+1000,'*','color',MarkerEdgeColors(1,:));
% 
% H6 = plot(IsDirectionExisting(6,1)+1000,IsDirectionExisting(6,2)+1000,'*','color',MarkerEdgeColors(6,:));
% 
% H7 = plot(IsDirectionExisting(7,1)+1000,IsDirectionExisting(7,2)+1000,'*','color',MarkerEdgeColors(7,:));
% legend([H6,H1,H7],'\theta = 3\pi/4','\theta = \pi','\theta = 5\pi/4')


%%�洢ͼ��
%imwrite(frame2im(getframe(gcf)),strcat('Figures\Tracking-Result-Thershold-',num2str(DS_STMD_Detection_Threshold),'-',num2str(j),'.jpg'))
%close

