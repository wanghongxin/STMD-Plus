function [MaxOperation_Output] = MaxOperation(Input,MaxRegionSize,Thres,M,N)

% �ú������ڶ����ͼ����ÿһС�����ڽ��� Max Operation

% Parameter Setting
% Input : ����ͼ�񣬴�СΪ M*N
% MaxRegionSize : ���� Max Operation �������С ��2*MaxRegionSize�� *
% ��2*MaxRegionSize��
% Thres  : ��������ֵ����С����ֵ����Ϊ 0
% M,N : ͼ��ķֱ���


MaxOperation_Output = Input;

for rr = 1:M
    
    for cc = 1:N
        
        r1 = max(1,rr-MaxRegionSize);
        r2 = min(M,rr+MaxRegionSize);
        c1 = max(1,cc-MaxRegionSize);
        c2 = min(N,cc+MaxRegionSize);
        
        if Input(rr,cc) < Thres  % ȥ��һЩ��С��ֵ
            MaxOperation_Output(rr,cc) = 0;
        elseif Input(rr,cc)~=max(max(Input(r1:r2,c1:c2)))
            MaxOperation_Output(rr,cc) = 0;
%        elseif Input(rr,cc) == max(max(Input(r1:r2,c1:c2)))
%            MaxOperation_Output(rr,cc) = 100;
        end

    end
    
end