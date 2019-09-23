function [LoGFilter] = LoGFilter(KernelSize,Sigma)

% �ú����������� LoG ���ƾ����

% ������˴�С����Ϊ����
Flag = mod(KernelSize,2);
if Flag == 0
    KernelSize = KernelSize +1;
end

% ȷ������˵�����
CenX = round(KernelSize/2);
CenY = round(KernelSize/2);
% ��������

[X,Y] = meshgrid((-CenX:CenX),(-CenY:CenY));

% ���ɾ���� ���˴�û�����򻯣�
LoGFilter = 1/(pi*Sigma^4)*(1-(X.^2+Y.^2)/(2*Sigma^2)).*exp(-(X.^2+Y.^2)/(2*Sigma^2));





