function [RecordedData] = Extract_Data_Along_A_Line(I,StartPoint,EndPoint,IsPlot)

% ����˵��
% �ú�����������һ��ȷ����ֱ����ȡ Input Image (I) �ڸ�ֱ���ϵ�����ֵ
% ���磺
% ����ֱ�ߵ����Ϊ ��X_s,Y_s��,�յ�Ϊ ��X_e,Y_e���� X_s = X_e ���� Y_s = Y_e
% Data = I(X_s,Y_s:Y:e) ���� Data = I(X_s:X_e,Y_s)

% ����˵��
% StartPoint = [X_s,Y_s]   ֱ�ߵ����
% EndPoint = [X_e,Y_e]     ֱ�ߵ��յ�
% I                        �����ź� Ĭ�ϴ�СΪ M*N*1

%% Main Function

if StartPoint(1) == EndPoint(1)
    
    RecordedData = I(StartPoint(1),StartPoint(2):EndPoint(2));
    if IsPlot == 1
        figure
        plot(StartPoint(2):EndPoint(2),RecordedData)
        title(strcat('Y = ',num2str(StartPoint(1)),'  X = ',num2str(StartPoint(2)),'-',num2str(EndPoint(2))))
        grid on
    end
    
    
elseif StartPoint(2) == EndPoint(2)
    
    RecordedData = I(StartPoint(1):EndPoint(1),StartPoint(2));
    if IsPlot == 1
        figure
        plot(StartPoint(2):EndPoint(2),RecordedData)
        title(strcat('Y = ',num2str(StartPoint(1)),'-',num2str(EndPoint(1)),'   X = ',num2str(StartPoint(2))))
        grid on
    end

end



















end

