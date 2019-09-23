function [Target_Positions,Target_Num] = Extract_Clustered_Points_PerFrame(Clustering_Results)


% 函数说明
% 该函数用于将每一帧的聚类结果整合在一块，输出一个坐标矩阵

%% Main Function

Target_Num = Clustering_Results.Direction_1_ClusteringPointsNum + Clustering_Results.Direction_2_ClusteringPointsNum + Clustering_Results.Direction_3_ClusteringPointsNum +...
              Clustering_Results.Direction_4_ClusteringPointsNum + Clustering_Results.Direction_5_ClusteringPointsNum + Clustering_Results.Direction_6_ClusteringPointsNum +...
              Clustering_Results.Direction_7_ClusteringPointsNum + Clustering_Results.Direction_8_ClusteringPointsNum;
         
         
Target_Positions = zeros(Target_Num,3);



%============================================================%
Target_Ind = 0;

if Clustering_Results.Direction_1_ClusteringPointsNum>0
    Target_Positions(Target_Ind+1:Clustering_Results.Direction_1_ClusteringPointsNum,1:2) = Clustering_Results.Direction_1_ClusteringPoints;
    Target_Positions(Target_Ind+1:Clustering_Results.Direction_1_ClusteringPointsNum,3) = ones(Clustering_Results.Direction_1_ClusteringPointsNum,1);
    Target_Ind = Target_Ind+Clustering_Results.Direction_1_ClusteringPointsNum;
end

if Clustering_Results.Direction_2_ClusteringPointsNum>0
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_2_ClusteringPointsNum,1:2) = Clustering_Results.Direction_2_ClusteringPoints;
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_2_ClusteringPointsNum,3) = 2*ones(Clustering_Results.Direction_2_ClusteringPointsNum,1);
    Target_Ind = Target_Ind+Clustering_Results.Direction_2_ClusteringPointsNum;
end

if Clustering_Results.Direction_3_ClusteringPointsNum>0
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_3_ClusteringPointsNum,1:2) = Clustering_Results.Direction_3_ClusteringPoints;
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_3_ClusteringPointsNum,3) = 3*ones(Clustering_Results.Direction_3_ClusteringPointsNum,1);
    Target_Ind = Target_Ind+Clustering_Results.Direction_3_ClusteringPointsNum;
end
    
if Clustering_Results.Direction_4_ClusteringPointsNum>0
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_4_ClusteringPointsNum,1:2) = Clustering_Results.Direction_4_ClusteringPoints;
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_4_ClusteringPointsNum,3) = 4*ones(Clustering_Results.Direction_4_ClusteringPointsNum,1);
    Target_Ind = Target_Ind+Clustering_Results.Direction_4_ClusteringPointsNum;
end    


if Clustering_Results.Direction_5_ClusteringPointsNum>0
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_5_ClusteringPointsNum,1:2) = Clustering_Results.Direction_5_ClusteringPoints;
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_5_ClusteringPointsNum,3) = 5*ones(Clustering_Results.Direction_5_ClusteringPointsNum,1);
    Target_Ind = Target_Ind+Clustering_Results.Direction_5_ClusteringPointsNum;
end    


if Clustering_Results.Direction_6_ClusteringPointsNum>0
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_6_ClusteringPointsNum,1:2) = Clustering_Results.Direction_6_ClusteringPoints;
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_6_ClusteringPointsNum,3) = 6*ones(Clustering_Results.Direction_6_ClusteringPointsNum,1);
    Target_Ind = Target_Ind+Clustering_Results.Direction_6_ClusteringPointsNum;
end    

if Clustering_Results.Direction_7_ClusteringPointsNum>0
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_7_ClusteringPointsNum,1:2) = Clustering_Results.Direction_7_ClusteringPoints;
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_7_ClusteringPointsNum,3) = 7*ones(Clustering_Results.Direction_7_ClusteringPointsNum,1);
    Target_Ind = Target_Ind+Clustering_Results.Direction_7_ClusteringPointsNum;
end    

if Clustering_Results.Direction_8_ClusteringPointsNum>0
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_8_ClusteringPointsNum,1:2) = Clustering_Results.Direction_8_ClusteringPoints;
    Target_Positions(Target_Ind+1:Target_Ind+Clustering_Results.Direction_8_ClusteringPointsNum,3) = 8*ones(Clustering_Results.Direction_8_ClusteringPointsNum,1);
    %Target_Ind = Target_Ind+Clustering_Results.Direction_8_ClusteringPointsNum;
end    
    


end

