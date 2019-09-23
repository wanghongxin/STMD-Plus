function [MaxOperation_Output] = MaxOperation(Input,MaxRegionSize,Thres,M,N)

% 该函数用于对输出图像在每一小方块内进行 Max Operation

% Parameter Setting
% Input : 输入图像，大小为 M*N
% MaxRegionSize : 进行 Max Operation 的区域大小 （2*MaxRegionSize） *
% （2*MaxRegionSize）
% Thres  : 给定的阈值，如小于阈值则置为 0
% M,N : 图像的分辨率


MaxOperation_Output = Input;

for rr = 1:M
    
    for cc = 1:N
        
        r1 = max(1,rr-MaxRegionSize);
        r2 = min(M,rr+MaxRegionSize);
        c1 = max(1,cc-MaxRegionSize);
        c2 = min(N,cc+MaxRegionSize);
        
        if Input(rr,cc) < Thres  % 去掉一些较小的值
            MaxOperation_Output(rr,cc) = 0;
        elseif Input(rr,cc)~=max(max(Input(r1:r2,c1:c2)))
            MaxOperation_Output(rr,cc) = 0;
%        elseif Input(rr,cc) == max(max(Input(r1:r2,c1:c2)))
%            MaxOperation_Output(rr,cc) = 100;
        end

    end
    
end