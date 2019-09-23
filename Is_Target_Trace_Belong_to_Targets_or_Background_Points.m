function [Is_Small_Moving_Target] = Is_Target_Trace_Belong_to_Targets_or_Background_Points(Potential_Target_Position,Index_Std_Target,Background_Motion_Direction)
% 函数说明


%% Main Function

% 判断物体的运动方向是否与背景运动方向一致
% 在这里，我们认为如果物体的运动方向与背景运动方向相差小于或等于 45 度，则认为方向一致

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

% 判断
% 若标准差有很大变化，则视为小物体
if Index_Std_Target == 1
    Is_Small_Moving_Target = 1;
end


if Index_Std_Target == 0
    % 若标准差变化不大，且运动方向与背景运动方向存在差异，则判断为小物体
    if Is_Target_Moving_With_Background == 0
        Is_Small_Moving_Target = 1;
    elseif Is_Target_Moving_With_Background == 1
        % 若标准差变化不大，且运动方向与背景运动方向相同，则视为背景
        Is_Small_Moving_Target = 0;
    end
end

end

