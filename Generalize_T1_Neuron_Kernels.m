function [ Filters ] = Generalize_T1_Neuron_Kernels(Sigma,Alpha,Theta,FilterSize)



% Ref: Construction and Evaluation of an Integrated Dynamical Model of
% Visual Motion Perception

% ����˵��
% �ú����������� Ref �� Eq.(2) �Ŀռ��˲���
% ����
% Filter  = G(x-a*cos,y-a*sin)-G(x+a*cos,y+a*sin)
% Ҳ���������ἰ�� T1 ��Ԫ�ľ����

% ����˵��
% FilterSize        �˲�����С
% Alpha             Eq.2 �и�˹�����������˲������ĵľ���
% Theta             �˲�����ƫת�Ƕȣ�Ĭ��Ϊ�Ƕȣ� �� 0,45,90,135,180...
% Sigma             ��˹������ Sigma 

% ���ڴ�СΪ 5*5 �����壬 
% FilterSize = 11
% Sigma = 1.5
% Alpha = 3
% Theta = [0 45 90 135 180 225 270 315]

%% Main Function

% ���˲�����СΪż������ǿ������Ϊ����
if mod(FilterSize,2) == 0
    FilterSize = FilterSize + 1;
end
% �Ƕ�ת��Ϊ����
Theta = Theta*pi/180;

% ȷ���˲����ĸ���
FilterNum = length(Theta);

% ���ڴ洢���ɵ��˲���
Filters = zeros(FilterSize,FilterSize,FilterNum);

% 
[Y,X] = meshgrid(-floor(FilterSize/2):floor(FilterSize/2),-floor(FilterSize/2):floor(FilterSize/2));

for k = 1:FilterNum
    
    % ȷ��������˹����������
    X1 = X - Alpha*cos(Theta(k));
    Y1 = Y - Alpha*sin(Theta(k));
    X2 = X + Alpha*cos(Theta(k));
    Y2 = Y + Alpha*sin(Theta(k));
    
    % ����������˹����
    Gauss1 = (1/(2*pi*Sigma^2))*(exp(-(X1.^2+Y1.^2)./(2*Sigma^2)));
    Gauss2 = (1/(2*pi*Sigma^2))*(exp(-(X2.^2+Y2.^2)./(2*Sigma^2)));
    
    % Filter = Gauss1 - Gauss2;
    Filters(:,:,k) = Gauss1 - Gauss2;
    
end



end

