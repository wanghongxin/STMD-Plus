% 2016-11-05

% 函数说明
% 该函数用于实现对于 DSTMD 输出结果的聚类
% 对于 DSTMD 模型经过方向抑制后的结果 Outputs_After_Inhibition_Along_Theta_Axis，
% 首先沿 Z 轴进行 Max 操作，寻求运动方向
% 然后对 Max 操作后的结果进行聚类


% 导入变量 Max_Operation_DS_STMD_Outputs
if ~exist('Max_Operation_DSTMD_Outputs','var')
    file = [Parameter_File.folder_Global,'/','Max_Operation_DSTMD_Outputs.mat'];
    load(file)
end


% 生成存储聚类结果的 cell
NumFrame_Clustering = length(Max_Operation_DSTMD_Outputs);
Clustering_Results = cell(1,NumFrame_Clustering);

tic;
timedLog('Start Clustering...')
for j = 1:NumFrame_Clustering
    
    
    ModelOutputs = Max_Operation_DSTMD_Outputs{j};
    
    for k = 1:H_Clustering
        
        % 寻找大于阈值的点
        [IndX,IndY] = find(ModelOutputs(:,:,k)>DSTMD_Detection_Threshold);
        % 去掉一些边界点
        NIndY = IndY(IndY>5&IndY<(N_Clustering-5)&IndX>5&IndX<(M_Clustering-5));
        NIndX = IndX(IndY>5&IndY<(N_Clustering-5)&IndX>5&IndX<(M_Clustering-5));
        
        % 判断是否是空集，若不是空集，调用 DBSCAN.m 进行聚类
        if ~isempty(NIndY)
            % 若距离小于 5, 则判断为一类
            epsilon = 3;
            MinPts = 1;
            IDX = DBSCAN([NIndX,NIndY],epsilon,MinPts);
        else
            IDX = 0;
        end
        
%========================================================================%
% 根据方向存储聚类结果
% 存储聚类的结果，默认 H_Clustering = 8
        
        % Direction 1
        if k == 1
            % 判断聚类数目是否大于 0
            Cluster_Num = max(IDX);
            if Cluster_Num>0  
                % 若大于 0，则计算每类的类中心
                Cluster_Center = zeros(Cluster_Num,2);               
                for l=1:Cluster_Num     
                    % 计算类中心
                    Clustering_X = NIndX(IDX==l);
                    Clustering_Y = NIndY(IDX==l);
                    Cluster_Center_X = round(mean(Clustering_X));
                    Cluster_Center_Y = round(mean(Clustering_Y));
                    Cluster_Center(l,:) = [Cluster_Center_X,Cluster_Center_Y];
                end  
                % 存储类中心
                Clustering_Results{j}.Direction_1_ClusteringPoints = Cluster_Center;
                Clustering_Results{j}.Direction_1_ClusteringPointsNum = Cluster_Num;
            else
                % 若小于 0 ,则判断为没有输出
                Clustering_Results{j}.Direction_1_ClusteringPoints = [-1,-1];
                Clustering_Results{j}.Direction_1_ClusteringPointsNum = 0;
            end
        end
        
        % Direction 2
        if k == 2
            Cluster_Num = max(IDX);
            if Cluster_Num>0  
                Cluster_Center = zeros(Cluster_Num,2);               
                for l=1:Cluster_Num                
                    Clustering_X = NIndX(IDX==l);
                    Clustering_Y = NIndY(IDX==l);
                    Cluster_Center_X = round(mean(Clustering_X));
                    Cluster_Center_Y = round(mean(Clustering_Y));
                    Cluster_Center(l,:) = [Cluster_Center_X,Cluster_Center_Y];
                end
                
                Clustering_Results{j}.Direction_2_ClusteringPoints = Cluster_Center;
                Clustering_Results{j}.Direction_2_ClusteringPointsNum = Cluster_Num;
            else
                Clustering_Results{j}.Direction_2_ClusteringPoints = [-1,-1];
                Clustering_Results{j}.Direction_2_ClusteringPointsNum = 0;
            end

        end    
        
        % Direction 3
        if k == 3
            Cluster_Num = max(IDX);
            if Cluster_Num>0  
                Cluster_Center = zeros(Cluster_Num,2);               
                for l=1:Cluster_Num                
                    Clustering_X = NIndX(IDX==l);
                    Clustering_Y = NIndY(IDX==l);
                    Cluster_Center_X = round(mean(Clustering_X));
                    Cluster_Center_Y = round(mean(Clustering_Y));
                    Cluster_Center(l,:) = [Cluster_Center_X,Cluster_Center_Y];
                end  
                Clustering_Results{j}.Direction_3_ClusteringPoints = Cluster_Center;
                Clustering_Results{j}.Direction_3_ClusteringPointsNum = Cluster_Num;
            else
                Clustering_Results{j}.Direction_3_ClusteringPoints = [-1,-1];
                Clustering_Results{j}.Direction_3_ClusteringPointsNum = 0;
            end
        end      
        
        % Direction 4
        if k == 4
            Cluster_Num = max(IDX);
            if Cluster_Num>0  
                Cluster_Center = zeros(Cluster_Num,2);               
                for l=1:Cluster_Num                
                    Clustering_X = NIndX(IDX==l);
                    Clustering_Y = NIndY(IDX==l);
                    Cluster_Center_X = round(mean(Clustering_X));
                    Cluster_Center_Y = round(mean(Clustering_Y));
                    Cluster_Center(l,:) = [Cluster_Center_X,Cluster_Center_Y];
                end  
                Clustering_Results{j}.Direction_4_ClusteringPoints = Cluster_Center;
                Clustering_Results{j}.Direction_4_ClusteringPointsNum = Cluster_Num;
            else
                Clustering_Results{j}.Direction_4_ClusteringPoints = [-1,-1];
                Clustering_Results{j}.Direction_4_ClusteringPointsNum = 0;
            end
           
        end  
        
        % Direction 5
        if k == 5
            Cluster_Num = max(IDX);
            if Cluster_Num>0  
                Cluster_Center = zeros(Cluster_Num,2);               
                for l=1:Cluster_Num                
                    Clustering_X = NIndX(IDX==l);
                    Clustering_Y = NIndY(IDX==l);
                    Cluster_Center_X = round(mean(Clustering_X));
                    Cluster_Center_Y = round(mean(Clustering_Y));
                    Cluster_Center(l,:) = [Cluster_Center_X,Cluster_Center_Y];
                end  
                Clustering_Results{j}.Direction_5_ClusteringPoints = Cluster_Center;
                Clustering_Results{j}.Direction_5_ClusteringPointsNum = Cluster_Num;
            else
                Clustering_Results{j}.Direction_5_ClusteringPoints = [-1,-1];
                Clustering_Results{j}.Direction_5_ClusteringPointsNum = 0;
            end
            

        end  
        
        
        % Direction 6
        if k == 6
            Cluster_Num = max(IDX);
            if Cluster_Num>0  
                Cluster_Center = zeros(Cluster_Num,2);               
                for l=1:Cluster_Num                
                    Clustering_X = NIndX(IDX==l);
                    Clustering_Y = NIndY(IDX==l);
                    Cluster_Center_X = round(mean(Clustering_X));
                    Cluster_Center_Y = round(mean(Clustering_Y));
                    Cluster_Center(l,:) = [Cluster_Center_X,Cluster_Center_Y];
                end  
                Clustering_Results{j}.Direction_6_ClusteringPoints = Cluster_Center;
                Clustering_Results{j}.Direction_6_ClusteringPointsNum = Cluster_Num;
                
            else
                Clustering_Results{j}.Direction_6_ClusteringPoints = [-1,-1];
                Clustering_Results{j}.Direction_6_ClusteringPointsNum = 0;
            end

        end 
        
        
        % Direction 7
        if k == 7
            Cluster_Num = max(IDX);
            if Cluster_Num>0  
                Cluster_Center = zeros(Cluster_Num,2);               
                for l=1:Cluster_Num                
                    Clustering_X = NIndX(IDX==l);
                    Clustering_Y = NIndY(IDX==l);
                    Cluster_Center_X = round(mean(Clustering_X));
                    Cluster_Center_Y = round(mean(Clustering_Y));
                    Cluster_Center(l,:) = [Cluster_Center_X,Cluster_Center_Y];
                end  
                
                Clustering_Results{j}.Direction_7_ClusteringPoints = Cluster_Center;
                Clustering_Results{j}.Direction_7_ClusteringPointsNum = Cluster_Num;
            else
                Clustering_Results{j}.Direction_7_ClusteringPoints = [-1,-1];
                Clustering_Results{j}.Direction_7_ClusteringPointsNum = 0;     
            end
           
        end
        
        
        % Direction 8
        if k == 8
            Cluster_Num = max(IDX);
            if Cluster_Num>0  
                Cluster_Center = zeros(Cluster_Num,2);               
                for l=1:Cluster_Num                
                    Clustering_X = NIndX(IDX==l);
                    Clustering_Y = NIndY(IDX==l);
                    Cluster_Center_X = round(mean(Clustering_X));
                    Cluster_Center_Y = round(mean(Clustering_Y));
                    Cluster_Center(l,:) = [Cluster_Center_X,Cluster_Center_Y];
                end  
                Clustering_Results{j}.Direction_8_ClusteringPoints = Cluster_Center;
                Clustering_Results{j}.Direction_8_ClusteringPointsNum = Cluster_Num;
            else
                Clustering_Results{j}.Direction_8_ClusteringPoints = [-1,-1];
                Clustering_Results{j}.Direction_8_ClusteringPointsNum = 0;                
            end
        end       
        
        
    end
    
    
end


file = [Parameter_File.folder_Global,'/',strcat('Clustering_Results-Detection-Threshold-',num2str(DSTMD_Detection_Threshold),'.mat')];
save(file,'StartFrame','EndFrame','StartRecordFrame','Clustering_Results','DSTMD_Detection_Threshold','-v7.3')




timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Clustering finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Clustering finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 

         