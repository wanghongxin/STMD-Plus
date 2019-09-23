function [OutputMatrix] = MaxOperation_3D(Input,MaxRegionSize,Thres,M,N,H)


% �ú������ڶ���ά��������ά�� Max Operation
% ���� X-Y ƽ���ϵ�С�������� Max (����ΧΪ -MaxRegionSize:MaxRegionSize,-MaxRegionSize:MaxRegionSize)
% �� MaxRegionSize = 0, ���� Z �᷽����� Max
% ��Ϊ Z �᷽�����ֵ���򲻱䣻��֮������Ϊ��


%% Main Function

OutputMatrix = Input;


for rr = 1:M
    for cc = 1:N
        
        r1 = max(1,rr-MaxRegionSize);
        r2 = min(M,rr+MaxRegionSize);
        c1 = max(1,cc-MaxRegionSize);
        c2 = min(N,cc+MaxRegionSize);
        
        for hh = 1:H
            
            if Input(rr,cc,hh) < Thres  % ȥ��һЩ��С��ֵ
                OutputMatrix(rr,cc,hh) = 0;
            elseif Input(rr,cc,hh)~=max(max(max(Input(r1:r2,c1:c2,:))))
                OutputMatrix(rr,cc,hh) = 0;
            end
            
        end
    end
end





% % �� Z ��ȡ���
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

