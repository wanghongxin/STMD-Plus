function [Is_Small_Moving_Target] = Is_Target_Trace_Belong_to_Targets_or_Background_Points(Potential_Target_Position,Index_Std_Target,Background_Motion_Direction)
% ����˵��


%% Main Function

% �ж�������˶������Ƿ��뱳���˶�����һ��
% �����������Ϊ���������˶������뱳���˶��������С�ڻ���� 45 �ȣ�����Ϊ����һ��

Target_Motion_Direction = Potential_Target_Position(3);

Is_Target_Moving_With_Background = 0;


if (Background_Motion_Direction == 1) && ((Target_Motion_Direction == 1)||(Target_Motion_Direction == 6)||(Target_Motion_Direction == 7))
    Is_Target_Moving_With_Background = 1;  
end
    

if (Background_Motion_Direction == 2 )&& ((Target_Motion_Direction == 2)||(Target_Motion_Direction == 5)||(Target_Motion_Direction == 8))
    Is_Target_Moving_With_Background = 1;  
end

if (Background_Motion_Direction == 3 )&& ((Target_Motion_Direction == 3)||(Target_Motion_Direction == 5)||(Target_Motion_Direction == 6))
    Is_Target_Moving_With_Background = 1;  
end

if (Background_Motion_Direction == 4 )&& ((Target_Motion_Direction == 4)||(Target_Motion_Direction == 7)||(Target_Motion_Direction == 8))
    Is_Target_Moving_With_Background = 1;  
end

% �ж�
% ����׼���кܴ�仯������ΪС����
if Index_Std_Target == 1
    Is_Small_Moving_Target = 1;
end


if Index_Std_Target == 0
    % ����׼��仯�������˶������뱳���˶�������ڲ��죬���ж�ΪС����
    if Is_Target_Moving_With_Background == 0
        Is_Small_Moving_Target = 1;
    elseif Is_Target_Moving_With_Background == 1
        % ����׼��仯�������˶������뱳���˶�������ͬ������Ϊ����
        Is_Small_Moving_Target = 0;
    end
end

end

