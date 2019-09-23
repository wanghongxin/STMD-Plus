function [ Index_Std_Target ] = Obtain_Index_Target_Trace_Std_Larger_Than_Threshold(All_Target_Trace_Statistics_After_Conv,Max_Target_Trace_Num,Std_Threshold)

% 函数说明


%% Main Function

Target_Trace_Max_Std = max(All_Target_Trace_Statistics_After_Conv(1:Max_Target_Trace_Num,:,2),[],2);

% 判断标准差是否大于阈值
Index_Std_Target = Target_Trace_Max_Std>=Std_Threshold;
%Index_Std_Background_Points = Target_Trace_Max_Std<Std_Threshold


end

