% 2016-10-01
% Main.m
% 函数说明
% 该函数用于实现模型的主要功能，包括 Wide-field Motion Perception and Small Target Motion
% Perception

%% 以下为主函数


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
    % Band-pass Filter (Gamma function 1 - Gamma function 2)
    [LMCs_Band_Pass_Output,Parameter_Fun.GammaFun1_Output,Parameter_Fun.GammaFun2_Output] = LMCs_BandPassFilter_GammaDiff(Photoreceptors_Outptut,Parameter_Fun.GammaFun1_Output,Parameter_Fun.GammaFun1_Tau,Parameter_Fun.GammaFun1_Order,...
        Parameter_Fun.GammaFun2_Output,Parameter_Fun.GammaFun2_Tau,Parameter_Fun.GammaFun2_Order);
    
    
    % LMC(Large Monopolar Cells) Lateral Inhibition Mechanism
    % 是否对高通滤波后的信号进行侧抑制
    if Parameter_Fun.IsLMCs_LateralInhibition == 1
        [LMCs_Inhibition_Output,LMCs_Inhibition_Output_NT,Parameter_Fun.LMCs_W1_PastY,Parameter_Fun.LMCs_W1_PastX,Parameter_Fun.LMCs_W2_PastY,Parameter_Fun.LMCs_W2_PastX] = LMCs_LateralInhibitionMechanism(LMCs_Band_Pass_Output,...
            Parameter_Fun.LMCs_SpatialInhibitionKernel,Parameter_Fun.LMCs_W1_PastY,Parameter_Fun.LMCs_W1_PastX,Parameter_Fun.LMCs_W1_Alpha,...
            Parameter_Fun.LMCs_W2_PastY,Parameter_Fun.LMCs_W2_PastX,Parameter_Fun.LMCs_W2_Alpha,Parameter_Fun.IsTemporalInhibition_LMC);
    else
        LMCs_Inhibition_Output = LMCs_Band_Pass_Output;
        LMCs_Inhibition_Output_NT = LMCs_Band_Pass_Output;
    end
    
    
    % Contrast Pathway
    % Amacrine Cells and T1 Neurons
    
    % 是否考虑 Contrast Pathway
    if Parameter_Fun.Is_Add_Contrast_Pathway == 1
        
        if Parameter_Fun.Is_T1_Neurons_Temporal_Delay == 1
            [T1_Neuron_Outputs,T1_Neuron_GammaFun_Outputs] = T1_Neuron_Function(Photoreceptors_Outptut,T1_Neuron_GammaFun_Outputs,...
                Parameter_Fun.T1_Neuron_GammaFun_Tau,Parameter_Fun.T1_Neuron_GammaFun_Order,Parameter_Fun.T1_Neurons_Kernels,Parameter_Fun.T1_Neuron_Kernel_Num,Parameter_Fun.M,Parameter_Fun.N);
        else
            [T1_Neuron_Outputs] = T1_Neuron_Function_2(Photoreceptors_Outptut,Parameter_Fun.T1_Neurons_Kernels,Parameter_Fun.T1_Neuron_Kernel_Num,Parameter_Fun.M,Parameter_Fun.N);
        end
        
    end
    
    %========================== Medulla Layer ============================%
    
    % ON and OFF Channel Separation
    ON_Channel = (abs(LMCs_Inhibition_Output)+LMCs_Inhibition_Output)*0.5;
    OFF_Channel = (abs(LMCs_Inhibition_Output)-LMCs_Inhibition_Output)*0.5;
    
    
    %================== Small Target Motion Perception ===================%
    % DSTMD
    if Parameter_Fun.IsSmallTargetMotionPerception == 1
        [DSTMD_LateralInhibitionOutput,DSTMD_CorrelationOutput,Parameter_Fun.DSTMD_GammaFun_Output_ON,Parameter_Fun.DSTMD_GammaFun_Output_OFF_1,Parameter_Fun.DSTMD_GammaFun_Output_OFF_2] = ...
            DSTMD_MotionDetector(ON_Channel,OFF_Channel,...
            Parameter_Fun.DSTMD_GammaFun_Order_ON,Parameter_Fun.DSTMD_GammaFun_Tau_ON,Parameter_Fun.DSTMD_GammaFun_Output_ON,...
            Parameter_Fun.DSTMD_GammaFun_Order_OFF_1,Parameter_Fun.DSTMD_GammaFun_Tau_OFF_1,Parameter_Fun.DSTMD_GammaFun_Output_OFF_1,...
            Parameter_Fun.DSTMD_GammaFun_Order_OFF_2,Parameter_Fun.DSTMD_GammaFun_Tau_OFF_2,Parameter_Fun.DSTMD_GammaFun_Output_OFF_2,...
            Parameter_Fun.DSTMD_Dist,Parameter_Fun.DSTMD_Directions,Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DSTMD_InhibitionKernel);
        % 延迟后的 ON and OFF 通道
        DSTMD_Delayed_ON_Channel = Parameter_Fun.DSTMD_GammaFun_Output_ON(:,:,Parameter_Fun.DSTMD_GammaFun_Order_ON+1);
        DSTMD_Delayed_OFF_Channel_1 = Parameter_Fun.DSTMD_GammaFun_Output_OFF_1(:,:,Parameter_Fun.DSTMD_GammaFun_Order_OFF_1+1);
        DSTMD_Delayed_OFF_Channel_2 = Parameter_Fun.DSTMD_GammaFun_Output_OFF_2(:,:,Parameter_Fun.DSTMD_GammaFun_Order_OFF_2+1);
    end
    
    
    %==============  Inhibition Mechanism Along Theta Axis ==============%
    
    [DSTMD_Outputs_After_Inhibition_Along_Theta_Axis] = DSTMD_Lateral_Inhibition_Mechanism_Along_Theta_Axis(DSTMD_LateralInhibitionOutput,...
        Parameter_Fun.DSTMD_InhibitionKernel_Theta_Axis,Parameter_Fun.M,Parameter_Fun.N,Parameter_Fun.DSTMD_Directions);
    
    
    %=======================数据记录，存储==========================%
    
    % 显示正在处理的帧数
    disp(i);
    
    % 记录数据
    if Parameter_Fun.IsRecordData == 1  && (i >= Parameter_File.StartRecordFrame)
        % 生成存储数据的 cell
        if i == Parameter_File.StartRecordFrame
            RecordedData = cell(Parameter_File.EndFrame-Parameter_File.StartRecordFrame+1,1);
        end
        
        % 调用 DataRecording.m 记录数据
        [ RecordedData ] = DataRecording(Photoreceptors_Outptut,LMCs_Band_Pass_Output,T1_Neuron_Outputs,...
            ON_Channel,OFF_Channel,...
            DSTMD_CorrelationOutput,DSTMD_LateralInhibitionOutput,...
            DSTMD_Delayed_ON_Channel,DSTMD_Delayed_OFF_Channel_1,DSTMD_Delayed_OFF_Channel_2,...
            DSTMD_Outputs_After_Inhibition_Along_Theta_Axis,...
            Parameter_File.StartRecordFrame,i,RecordedData);
        
    end
    
    % 保存数据
    if Parameter_Fun.IsSaveData == 1
        % 当处理完最后一帧时保存数据
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

