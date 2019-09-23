function [CurrentY,PastY,PastX] = Exponential_1st_Order_LowPassFilter(CurrentX,PastX,PastY,Alpha,T,IsNormalized)

%% ����˵��
% �ú������ڼ���ָ����һ�׵�ͨ�˲����������Y��
% h(t) = (1/a)*exp(-t/a) or exp(-t/a)

% IsNormalized    ��Ϊ 1���� h(t) = (1/a)*exp(-t/a)
%                 ��Ϊ 0���� h(t) = exp(-t/a)
% CurrentX        ��ǰ�˲����������ź�  X[n]
% PastX           �˲���֮ǰ�������ź�  X[n-1]
% CurrentY        ��ǰ�˲���������ź�  Y[n]
% PastY           �˲���֮ǰ������ź�  Y[n-1]
% Alpha               ָ����������
% T               ����Ƶ�ʣ�Ĭ��ֵΪ 1


%% Main Function

c = 2/T;

% ����
if IsNormalized == 1
    A = 1/(1+Alpha*c);
    B = (1-Alpha*c)/(1+Alpha*c);
    CurrentY = A*CurrentX + A*PastX - B*PastY;
    
elseif IsNormalized == 0
    A = Alpha/(1+Alpha*c);
    B = (1-Alpha*c)/(1+Alpha*c);
    CurrentY = A*CurrentX + A*PastX - B*PastY;
end
% ����
PastX = CurrentX;
PastY = CurrentY;



end

