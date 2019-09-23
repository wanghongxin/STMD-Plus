% 2016-10-01
% Main.m
% ����˵��
% �ú�������ʵ��ģ�͵���Ҫ���ܣ����� Wide-field Motion Perception and Small Target Motion
% Perception

%% ����Ϊ������

    
%figure

for i = Parameter_File.StartFrame:Parameter_File.EndFrame
    
    %======================  Retina Layer =============================%
    file = [Parameter_File.folder0,'/',sprintf('%s%04d.tif',Parameter_File.Imagetitle,i)];
    
    I = imread(file);
    OriginalImage = I;
    % Green Channel
    I = double(rgb2gray(I));
    %I = double(I(:,:,2));   
   
    % Photoreceptors (Gauss Filter,Spatial Filter)
    Photoreceptors_Outptut = conv2(I,Parameter_Fun.GaussFilter,'same');
    %GaussBluredImage = Photoreceptors_Outptut;
    
    %========================  Lamina Layer ===========================%
    
    % Motion Pathway
    % Large Monopolar Cells
    % High-pass Filter (Gamma function 1 - Gamma function 2)
    [LMCs_High_Pass_Output,Parameter_Fun.GammaFun1_Output,Parameter_Fun.GammaFun2_Output] = LMCs_HighPassFilter_GammaDiff(Photoreceptors_Outptut,Parameter_Fun.GammaFun1_Output,Parameter_Fun.GammaFun1_Tau,Parameter_Fun.GammaFun1_Order,...
                                                        Parameter_Fun.GammaFun2_Output,Parameter_Fun.GammaFun2_Tau,Parameter_Fun.GammaFun2_Order);
                                                                                            
                                                    
     % LMC(Large Monopolar Cells) Lateral Inhibition Mechanism
     % �Ƿ�Ը�ͨ�˲�����źŽ��в�����
     if Parameter_Fun.IsLMCs_LateralInhibition == 1   
         [LMCs_Inhibition_Output,LMCs_Inhibition_Output_NT,Parameter_Fun.LMCs_W1_PastY,Parameter_Fun.LMCs_W1_PastX,Parameter_Fun.LMCs_W2_PastY,Parameter_Fun.LMCs_W2_PastX] = LMCs_LateralInhibitionMechanism(LMCs_High_Pass_Output,...
                                             Parameter_Fun.LMCs_SpatialInhibitionKernel,Parameter_Fun.LMCs_W1_PastY,Parameter_Fun.LMCs_W1_PastX,Parameter_Fun.LMCs_W1_Alpha,...
                                             Parameter_Fun.LMCs_W2_PastY,Parameter_Fun.LMCs_W2_PastX,Parameter_Fun.LMCs_W2_Alpha,Parameter_Fun.IsTemporalInhibition_LMC); 
     else
         LMCs_Inhibition_Output = LMCs_High_Pass_Output;
         LMCs_Inhibition_Output_NT = LMCs_High_Pass_Output;
     end
     
     
     % Contrast Pathway
     % Amacrine Cells and T1 Neurons
     
     % �Ƿ��� Contrast Pathway
     if Parameter_Fun.Is_Add_Contrast_Pathway == 1
         
         if Parameter_Fun.Is_T1_Neurons_Temporal_Delay == 1
             [T1_Neuron_Outputs,T1_Neuron_GammaFun_Outputs] = T1_Neuron_Function(Photoreceptors_Outptut,T1_Neuron_GammaFun_Outputs,...
                 Parameter_Fun.T1_Neuron_GammaFun_Tau,Parameter_Fun.T1_Neuron_GammaFun_Order,Parameter_Fun.T1_Neurons_Kernels,Parameter_Fun.T1_Neuron_Kernel_Num,Parameter_Fun.M,Parameter_Fun.N);
%              % Directional Cell Responses = Biphasic Neuron Outputs + Monophasic Neuron Outputs
%              DirectionalCell_Responses = repmat(LMCs_Inhibition_Output,[1,1,MonoPhasicFilter_Num]) + MonophasicNeuron_Output;
         else
             [T1_Neuron_Outputs] = T1_Neuron_Function_2(Photoreceptors_Outptut,Parameter_Fun.T1_Neurons_Kernels,Parameter_Fun.T1_Neuron_Kernel_Num,Parameter_Fun.M,Parameter_Fun.N);
         end
         
     end
     
    %========================== Medulla Layer ============================%
    
    % ON and OFF Channel Separation
     ON_Channel = (abs(LMCs_Inhibition_Output)+LMCs_Inhibition_Output)*0.5;
     OFF_Channel = (abs(LMCs_Inhibition_Output)-LMCs_Inhibition_Output)*0.5;

     %=============== Wide-field Motion Perception ======================% 
     
     if Parameter_Fun.IsWideFieldMotionPerception == 1
    % Max Operation
     if Parameter_Fun.IsMaxOperation == 1
        % ���� Max Operation 
        if Parameter_Fun.IsMex == 1
            % ���� Mex ��࣬�� for ѭ���� C++ ʵ��
            if Parameter_Fun.MexOperation == 1
                timedLog('Building mex function: MaxOperation_mex ...');  
                % ���� MaxOperation.m
                codegen MaxOperation -args {HighPassFilter_Output,MaxRegion_Size,MaxOperation_Thres,M,N} -o MaxOperation_mex
                timedLog('Building mex function is completed.');
                Parameter_Fun.MexOperation = 0;
                [MaxOperation_ON_Output] = MaxOperation_mex(ON_Channel,Parameter_Fun.MaxRegion_Size,Parameter_Fun.MaxOperation_Thres,Parameter_Fun.M,Parameter_Fun.N);
                [MaxOperation_OFF_Output] = MaxOperation_mex(OFF_Channel,Parameter_Fun.MaxRegion_Size,Parameter_Fun.MaxOperation_Thres,Parameter_Fun.M,Parameter_Fun.N);
            else
                [MaxOperation_ON_Output] = MaxOperation_mex(ON_Channel,Parameter_Fun.MaxRegion_Size,Parameter_Fun.MaxOperation_Thres,Parameter_Fun.M,Parameter_Fun.N);
                [MaxOperation_OFF_Output] = MaxOperation_mex(OFF_Channel,Parameter_Fun.MaxRegion_Size,Parameter_Fun.MaxOperation_Thres,Parameter_Fun.M,Parameter_Fun.N);        
            end
        else
             % ������ Mex ��࣬ ֱ���� Matlab �н��� Max Operation
                [MaxOperation_ON_Output] = MaxOperation(ON_Channel,Parameter_Fun.MaxRegion_Size,Parameter_Fun.MaxOperation_Thres,Parameter_Fun.M,Parameter_Fun.N);
                [MaxOperation_OFF_Output] = MaxOperation(OFF_Channel,Parameter_Fun.MaxRegion_Size,Parameter_Fun.MaxOperation_Thres,Parameter_Fun.M,Parameter_Fun.N);
        end
    else 
        % ������ Max Operation, �Խ�������Ϊ MaxOperation_ON_Output�� MaxOperation_OFF_Output
        MaxOperation_ON_Output = ON_Channel;
        MaxOperation_OFF_Output = OFF_Channel; 
    end
                         
     % Single Hand Two Quadrant Motion Detector  (TQD)
    [TQD_Correlation_Component_ON,TQD_Correlation_Component_OFF,Parameter_Fun.TQD_GammaFun_Output_ON,Parameter_Fun.TQD_GammaFun_Output_OFF] = ...
                          SingleHand_TwoQuadrantDetector(MaxOperation_ON_Output,MaxOperation_OFF_Output,Parameter_Fun.TQD_GammaFun_Output_ON,Parameter_Fun.TQD_GammaFun_Output_OFF,...
                          Parameter_Fun.TQD_GammaFun_Tau,Parameter_Fun.TQD_GammaFun_Order,Parameter_Fun.TQD_Dist,Parameter_Fun.TQD_Directions,Parameter_Fun.M,Parameter_Fun.N);
     
     TQD_Delayed_ON_Channel = Parameter_Fun.TQD_GammaFun_Output_ON(:,:,Parameter_Fun.TQD_GammaFun_Order+1);
     TQD_Delayed_OFF_Channel = Parameter_Fun.TQD_GammaFun_Output_OFF(:,:,Parameter_Fun.TQD_GammaFun_Order+1);             
     end
    
    %================== Small Target Motion Perception ===================%
    % DS-STMD
    if Parameter_Fun.IsSmallTargetMotionPerception == 1;
       [DS_STMD_LateralInhibitionOutput,DS_STMD_CorrelationOutput,Parameter_Fun.DS_STMD_GammaFun_Output_ON,Parameter_Fun.DS_STMD_GammaFun_Output_OFF_1,Parameter_Fun.DS_STMD_GammaFun_Output_OFF_2] = ...
                           DS_STMD_MotionDetector(ON_Channel,OFF_Channel,...
                           Parameter_Fun.DS_STMD_GammaFun_Order_ON,Parameter_Fun.DS_STMD_GammaFun_Tau_ON,Parameter_Fun.DS_STMD_GammaFun_Output_ON,...
                           Parameter_Fun.DS_STMD_GammaFun_Order_OFF_1,Parameter_Fun.DS_STMD_GammaFun_Tau_OFF_1,Parameter_Fun.DS_STMD_GammaFun_Output_OFF_1,...
                           Parameter_Fun.DS_STMD_GammaFun_Order_OFF_2,Parameter_Fun.DS_STMD_GammaFun_Tau_OFF_2,Parameter_Fun.DS_STMD_GammaFun_Output_OFF_2,...
                           Parameter_Fun.DS_STMD_Dist,Parameter_Fun.DS_STMD_Directions,Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_InhibitionKernel);
         % �ӳٺ�� ON and OFF ͨ��             
        DS_STMD_Delayed_ON_Channel = Parameter_Fun.DS_STMD_GammaFun_Output_ON(:,:,Parameter_Fun.DS_STMD_GammaFun_Order_ON+1);
        DS_STMD_Delayed_OFF_Channel_1 = Parameter_Fun.DS_STMD_GammaFun_Output_OFF_1(:,:,Parameter_Fun.DS_STMD_GammaFun_Order_OFF_1+1);
        DS_STMD_Delayed_OFF_Channel_2 = Parameter_Fun.DS_STMD_GammaFun_Output_OFF_2(:,:,Parameter_Fun.DS_STMD_GammaFun_Order_OFF_2+1);               
    end
    
    
    %==============  Inhibition Mechanism Along Theta Axis ==============%
    
    [DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis] = DS_STMD_Lateral_Inhibition_Mechanism_Along_Theta_Axis(DS_STMD_LateralInhibitionOutput,...
                                                                                    Parameter_Fun.DS_STMD_InhibitionKernel_Theta_Axis,Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DS_STMD_Directions);
    

    %======================== ���չʾ ==============================%
    
%      if i == EndFrame 
%          figure
%          surf(HighPassFilter_Output')
%          title('High Pass Filter Output')
%          figure
%          surf(LMCs_Inhibition_Output')
%          title('LMCs Inhibition Output')
%          figure
%          surf(ON_Channel')
%          title('ON Channel')
%          figure
%          surf(OFF_Channel')
%          title('OFF Channel')
%          figure
%          surf(MaxOperation_ON_Output')
%          title('ON Channel Max Operation')
%          figure
%          surf(MaxOperation_OFF_Output')
%          title('OFF Channel Max Operation')
%          
%          for j = 1:DS_STMD_Directions
%              figure
%              surf(DS_STMD_CorrelationOutput(:,:,j)')
%              title(strcat('DS-STMD Model Output (Before Inhibition)-- ',num2str(j)))
%          end
%          
%          for j = 1:DS_STMD_Directions
%              figure
%              surf(DS_STMD_LateralInhibitionOutput(:,:,j)')
%              title(strcat('DS-STMD Model Output -- ',num2str(j)))
%          end
% 
%      end
%     
%     
%     


%     % �Ƿ������������ÿһ���������ڿռ�����չʾ,չʾ���һ֡�Ķ�Ӧ�����
%     if Is_Show_Neural_Outputs_Along_A_Line
%         if i == EndFrame
%             % ����ֱ��չʾģ���ڲ�ͬ�׶ε����
%             Show_Neural_Outputs_Along_A_Line
%         end
%     end
    
    
                       
    
    %=======================���ݼ�¼���洢==========================%
    
    % ��ʾ���ڴ����֡��
    disp(i);

    % Velocity Tuning 
    % ��¼ TQD �� DS-STMD �����
    if Parameter_File.Test_VelocityTuning == 1    
        if i> (EndFrame - VelocityTuning_Frame)
            % ȷ���洢��λ��
            Index_VelocityTuning = i-(EndFrame-VelocityTuning_Frame);
            % TQD Response  (TQD_ON_Responses_VelocityTuning_EachStep, TQD_OFF_Responses_VelocityTuning_EachStep �� DS_STMD_Responses_VelocityTuning_EachStep
            % �ں��� TopFunction_VelocityTuning.m �и���)
            TQD_ON_Responses_VelocityTuning_EachStep(Index_VelocityTuning) = max(TQD_Correlation_Component_ON(125,:,1));
            TQD_OFF_Responses_VelocityTuning_EachStep(Index_VelocityTuning) = max(TQD_Correlation_Component_OFF(125,:,1));
            TQD_ON_OFF_Responses_VelocityTuning_EachStep(Index_VelocityTuning) = max(TQD_Correlation_Component_ON(125,:,1)+TQD_Correlation_Component_OFF(125,:,1));
            DS_STMD_Responses_VelocityTuning_EachStep(Index_VelocityTuning) = max(DS_STMD_LateralInhibitionOutput(125,:,1));
        end
    end
    
    % Width Tuning
    % ��¼ TQD �� DS-STMD �����
    if Parameter_File.Test_WidthTuning == 1
        if i> (Parameter_File.EndFrame - WidthTuning_Frame)
            % ȷ���洢��λ��
            Index_WidthTuning = i-(Parameter_File.EndFrame-WidthTuning_Frame);
            % TQD Response  (TQD_ON_Responses_WidthTuning_EachStep, TQD_OFF_Responses_WidthTuning_EachStep �� DS_STMD_Responses_WidthTuning_EachStep
            % �ں��� TopFunction_WidthTuning.m �и���)
            TQD_ON_Responses_WidthTuning_EachStep(Index_WidthTuning) = max(TQD_Correlation_Component_ON(125,:,1));
            TQD_OFF_Responses_WidthTuning_EachStep(Index_WidthTuning) = max(TQD_Correlation_Component_OFF(125,:,1));
            TQD_ON_OFF_Responses_WidthTuning_EachStep(Index_WidthTuning) = max(TQD_Correlation_Component_ON(125,:,1)+TQD_Correlation_Component_OFF(125,:,1));
            DS_STMD_Responses_WidthTuning_EachStep(Index_WidthTuning) = max(DS_STMD_LateralInhibitionOutput(125,:,1));
        end
    end
    
    % Height Tuning
    % ��¼ TQD �� DS-STMD �����
    if Parameter_File.Test_HeightTuning == 1
        if i> (Parameter_File.EndFrame - HeightTuning_Frame)
            % ȷ���洢��λ��
            Index_HeightTuning = i-(Parameter_File.EndFrame-HeightTuning_Frame);
            % TQD Response  (TQD_ON_Responses_HeightTuning_EachStep, TQD_OFF_Responses_HeightTuning_EachStep �� DS_STMD_Responses_HeightTuning_EachStep
            % �ں��� TopFunction_HeightTuning.m �и���)
            TQD_ON_Responses_HeightTuning_EachStep(Index_HeightTuning) = max(TQD_Correlation_Component_ON(125,:,1));
            TQD_OFF_Responses_HeightTuning_EachStep(Index_HeightTuning) = max(TQD_Correlation_Component_OFF(125,:,1));
            TQD_ON_OFF_Responses_HeightTuning_EachStep(Index_HeightTuning) = max(TQD_Correlation_Component_ON(125,:,1)+TQD_Correlation_Component_OFF(125,:,1));
            DS_STMD_Responses_HeightTuning_EachStep(Index_HeightTuning) = max(DS_STMD_LateralInhibitionOutput(125,:,1));
        end
    end
    
    
    % Contrast Tuning
    % ��¼ TQD �� DS-STMD �����
    if Parameter_File.Test_ContrastTuning == 1
        if i> (Parameter_File.EndFrame - ContrastTuning_Frame)
            % ȷ���洢��λ��
            Index_ContrastTuning = i-(Parameter_File.EndFrame-ContrastTuning_Frame);
            % TQD Response  (TQD_ON_Responses_ContrastTuning_EachStep, TQD_OFF_Responses_ContrastTuning_EachStep �� DS_STMD_Responses_ContrastTuning_EachStep
            % �ں��� TopFunction_ContrastTuning.m �и���)
            TQD_ON_Responses_ContrastTuning_EachStep(Index_ContrastTuning) = max(TQD_Correlation_Component_ON(125,:,1));
            TQD_OFF_Responses_ContrastTuning_EachStep(Index_ContrastTuning) = max(TQD_Correlation_Component_OFF(125,:,1));
            TQD_ON_OFF_Responses_ContrastTuning_EachStep(Index_ContrastTuning) = max(TQD_Correlation_Component_ON(125,:,1)+TQD_Correlation_Component_OFF(125,:,1));
            DS_STMD_Responses_ContrastTuning_EachStep(Index_ContrastTuning) = max(DS_STMD_LateralInhibitionOutput(125,:,1));
        end
    end
    
    
    
    
    
        
    
    % ��¼����
    if Parameter_Fun.IsRecordData == 1  && (i >= Parameter_File.StartRecordFrame)
        % ���ɴ洢���ݵ� cell
        if i == Parameter_File.StartRecordFrame
            RecordedData = cell(Parameter_File.EndFrame-Parameter_File.StartRecordFrame+1,1);
        end
        
        % ���� DataRecording.m ��¼����
        [ RecordedData ] = DataRecording(Photoreceptors_Outptut,LMCs_High_Pass_Output,...
                              LMCs_Inhibition_Output,LMCs_Inhibition_Output_NT,...
                              T1_Neuron_Outputs,...
                              ON_Channel,OFF_Channel,...
                              MaxOperation_ON_Output, MaxOperation_OFF_Output,...
                              TQD_Correlation_Component_ON,TQD_Correlation_Component_OFF,...
                              DS_STMD_CorrelationOutput,DS_STMD_LateralInhibitionOutput,...
                              TQD_Delayed_ON_Channel,TQD_Delayed_OFF_Channel,...
                              DS_STMD_Delayed_ON_Channel,DS_STMD_Delayed_OFF_Channel_1,DS_STMD_Delayed_OFF_Channel_2,...
                              DS_STMD_Outputs_After_Inhibition_Along_Theta_Axis,...
                              Parameter_File.StartRecordFrame,i,RecordedData);
                   
        if (i == Parameter_File.EndFrame) && (Parameter_Fun.Is_Show_Recorded_Data_in_Temporal_Field == 1)
            Show_Recorded_Data_in_Temporal_Field
        end
    end
    
    % ��������
    if Parameter_Fun.IsSaveData == 1
        % �����������һ֡ʱ��������
        if i == Parameter_File.EndFrame
            file = [Parameter_File.folder_Global,'/','Recorded-Data.mat'];
            StartFrame = Parameter_File.StartFrame;
            EndFrame = Parameter_File.EndFrame;
            StartRecordFrame = Parameter_File.StartRecordFrame;
            save(file,'RecordedData','StartFrame','EndFrame','StartRecordFrame','-v7.3')
        end
    end
    

       
    
%=========================== End ===================================%    
end    

