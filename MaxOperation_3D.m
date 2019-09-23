function [OutputMatrix] = MaxOperation_3D(Input,MaxRegionSize,Thres,M,N,H)


% 该函数用于对三维矩阵做三维的 Max Operation
% 现在 X-Y 平面上的小区域内做 Max (区域范围为 -MaxRegionSize:MaxRegionSize,-MaxRegionSize:MaxRegionSize)
% 若 MaxRegionSize = 0, 则沿 Z 轴方向进行 Max
% 若为 Z 轴方向最大值，则不变；反之，则置为零


%% Main Function

OutputMatrix = Input;


for rr = 1:M
    for cc = 1:N
        
        r1 = max(1,rr-MaxRegionSize);
        r2 = min(M,rr+MaxRegionSize);
        c1 = max(1,cc-MaxRegionSize);
        c2 = min(N,cc+MaxRegionSize);
        
        for hh = 1:H
            
            if Input(rr,cc,hh) < Thres  % 去掉一些较小的值
                OutputMatrix(rr,cc,hh) = 0;
            elseif Input(rr,cc,hh)~=max(max(max(Input(r1:r2,c1:c2,:))))
                OutputMatrix(rr,cc,hh) = 0;
            end
            
        end
    end
end





% % 沿 Z 轴取最大
% for i = 1:M
%     for j = 1:N
%         
%         DirectionValue_Max = max(OutputMatrix(i,j,:));
%         for k = 1:H
%             
%             if OutputMatrix(i,j,k) ~= DirectionValue_Max
%                 OutputMatrix(i,j,k) = 0;
%             end
%             
%         end
%     end
% end





end

