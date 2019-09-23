function [DS_STMD_InhibitionKernel] = Generalization_DS_STMD_InhibitionKernel(Parameters,KernelType)

% ����˵��




%% Main Function
if KernelType == 1
    %--------------------------------------------%
    % �ú����������� DS-STMD �Ĳ������ƾ����, DoG ��ʽ
    % W(x,y) = A*[g_1(x,y)] - B[-g_1(x,y)]    % [x]   max(x,0)
    % g_1 = G_1(x,y) - e*G_2(x,y) - rho

    % ����˵��
    % KernelSize  Inhibition Kernel �Ĵ�С��һ��Ϊ����
    % Sigma1      Gauss ���� 1 �� Sigma
    % Sigma2      Gauss ���� 2 �� Sigma
    % e           ���� e
  %----------------------------------------------%    
    KernelSize = Parameters(1);
    Sigma1 = Parameters(2);
    Sigma2 = Parameters(3);
    e = Parameters(4);
    rho = Parameters(5);
    A = Parameters(6);
    B = Parameters(7);
  
   % ������˴�С����Ϊ����
   Flag = mod(KernelSize,2);
   if Flag == 0
       KernelSize = KernelSize +1;
   end

   % ȷ������˵�����
   CenX = round(KernelSize/2);
   CenY = round(KernelSize/2);
   % ��������
   [X,Y] = meshgrid(1:KernelSize,1:KernelSize);
   % ����ƽ��
   ShiftX = X-CenX;
   ShiftY = Y-CenY;

  % ���� Gauss ���� 1 �� 2
   Gauss1 = (1/(2*pi*Sigma1^2))*exp(-(ShiftX.*ShiftX + ShiftY.*ShiftY)/(2*Sigma1^2));
   Gauss2 = (1/(2*pi*Sigma2^2))*exp(-(ShiftX.*ShiftX + ShiftY.*ShiftY)/(2*Sigma2^2));

   % ���� DoG, ����˹�������
   DoG_Filter = Gauss1 - e*Gauss2 - rho;

   % max(x,0)  
   Positive_Component = (abs(DoG_Filter) + DoG_Filter)*0.5;
   Negative_Component = (abs(DoG_Filter) - DoG_Filter)*0.5;
   % Inhibition Kernel

   DS_STMD_InhibitionKernel = A*Positive_Component - B*Negative_Component;
   
elseif KernelType == 2
    
    KernelSize = Parameters(1);
    Sigma = Parameters(2);
    A = Parameters(3);
    B = Parameters(4);
    
    Flag = mod(KernelSize,2);
    if Flag == 0
        KernelSize = KernelSize +1;
    end

   % ȷ������˵�����
   CenX = round(KernelSize/2);
   CenY = round(KernelSize/2);
   % ��������
   [X,Y] = meshgrid((-CenX:CenX),(-CenY:CenY));
   
   % ���ɾ����
    LoGFilter = 1/(pi*Sigma^4)*(1-(X.^2+Y.^2)/(2*Sigma^2)).*exp(-(X.^2+Y.^2)/(2*Sigma^2));
    
    % Normalization (����)
    LoGFilter = Sigma^2*LoGFilter;
    
    % max(x,0)  
   Positive_Component = (abs(LoGFilter) + LoGFilter)*0.5;
   Negative_Component = (abs(LoGFilter) - LoGFilter)*0.5;
   % Inhibition Kernel

   DS_STMD_InhibitionKernel = A*Positive_Component - B*Negative_Component;
    
    
    
    
end
   
   
   




end

