function [ Output_Maxtrix,Target_Trace_Num_CurrentFrame,Num_Interrupt_Frame] = Find_Target_Trace(Target_Positions_PastFrame,Target_Trace_Num_PastFrame,...
                                                                        Target_Positions_CurrentFrame,Num_Interrupt_Frame,Threshold,Max_Interrupt_Frame_Num)

% ����˵��
% �ú������ڼ�¼������˶��켣

%% Main Function

Output_Maxtrix = zeros(size(Target_Positions_PastFrame));
Possible_Target_Positions = zeros(size(Target_Positions_CurrentFrame));
Possible_Target_Num = 0;


StageValue_Target_Positions_CurrentFrame = Target_Positions_CurrentFrame;

for ii = 1:Target_Trace_Num_PastFrame
    
    Target_Position_Past = Target_Positions_PastFrame(ii,1:2);
    
    [Dist,Ind] = pdist2(StageValue_Target_Positions_CurrentFrame(:,1:2),Target_Position_Past,'euclidean','Smallest',1);
    
    if Num_Interrupt_Frame(ii) < Max_Interrupt_Frame_Num  % ���жϵ�֡��������ֵ���򽫸��˶��켣��Ϊ�жϵĹ켣�����ټ�¼�µĵ�
        if Dist<Threshold
            Output_Maxtrix(ii,:) = Target_Positions_CurrentFrame(Ind,:);
            Possible_Target_Num = Possible_Target_Num + 1;
            Possible_Target_Positions(Possible_Target_Num,:) = Target_Positions_CurrentFrame(Ind,:);
            StageValue_Target_Positions_CurrentFrame(Ind,:) = [-1000,-1000,-1];     % ���õ��ų�����һ���켣�ļ�¼��
            Num_Interrupt_Frame(ii) = 0;                                % ���жϵ�֡��������Ϊ 0
        else
            Output_Maxtrix(ii,1:2) = Target_Positions_PastFrame(ii,1:2);
            Output_Maxtrix(ii,3) = 0;
            Num_Interrupt_Frame(ii) = Num_Interrupt_Frame(ii) +1;
        end
    else
        Num_Interrupt_Frame(ii) = Num_Interrupt_Frame(ii) +1;
    end
    
end

% disp('===========================')
% Output_Maxtrix


[Difference_Set,Difference_Ind] = setdiff(Target_Positions_CurrentFrame(:,1:2),Possible_Target_Positions(1:Possible_Target_Num,1:2),'rows');
Difference_Element_Num = length(Difference_Ind);

if Difference_Element_Num>0

    % �������˶��켣
    Output_Maxtrix((Target_Trace_Num_PastFrame+1):(Target_Trace_Num_PastFrame+Difference_Element_Num),:) = Target_Positions_CurrentFrame(Difference_Ind,:);
    Target_Trace_Num_CurrentFrame = Target_Trace_Num_PastFrame + Difference_Element_Num;
else
    Target_Trace_Num_CurrentFrame = Target_Trace_Num_PastFrame;
end

end

