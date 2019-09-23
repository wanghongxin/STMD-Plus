function [X,Y,Z] = Projecting_3D_Matrix_to_Two_Dimensional_Plane(InputSignal,IsRound,IsPlot,Threshold)

% ����˵��
% �ú������ڽ���ά����Ͷ�䵽��άƽ����

% ����˵��
% InputSignal     �������ά����
% IsRound         �Ƿ�� Z ��ȡ��
% IsPlot          �Ƿ��ͼ
% Threshold       �� Z ���趨һ����ֵ��ֻ��������ֵ�ĵ�ͶӰ����άƽ��

%% Main Function

% Ѱ�ҷ���Ԫ
[X,Y,Z] = find(InputSignal);

% Ѱ�Ҵ��� Threshold �ĵ�
Index = Z>Threshold;

X = X(Index);
Y = Y(Index);
Z = Z(Index);

% �� Z ȡ��
if IsRound == 1
    % �� Z ȡ��
    Z = round(Z);
end

% ��ͼ
if IsPlot == 1
    % ����ֵת��Ϊ�ַ���
    Z = num2str(Z);
    figure
    plot(X,Y,'r*')
    %text(X,Y,cellstr(Z))
    text(X,Y,Z)
    axis([0,250,0,500])
    grid on
end


end

