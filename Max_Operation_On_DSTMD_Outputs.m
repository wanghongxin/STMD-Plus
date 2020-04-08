% ����˵��
% ���� Main.m �������� DSTMD ��������������ά�� Max ������ֻ������һ�μ���
%
% 2016-11-18


%% ��ȡ����
file = [Parameter_File.folder_Global,'/','Max_Operation_DSTMD_Outputs.mat'];

if ~exist(file,'file')
    if ~exist('DSTMD_Outputs_After_Inhibition_Along_Theta_Axis_All','var')
        
        if ~exist(strcat(Parameter_File.folder_Global,'\','DSTMD_Outputs_After_Inhibition_Along_Theta_Axis_All.mat'),'file')
            
            if ~exist('RecordedData','var')
                File_Max = [Parameter_File.folder_Global,'\','Recorded-Data.mat'];
                load(File_Max)
            end
            
            NumFrame_Clustering = length(RecordedData);
            DSTMD_Outputs_After_Inhibition_Along_Theta_Axis_All = cell(1,NumFrame_Clustering);
            
            for j = 1:NumFrame_Clustering
                
                DSTMD_Outputs_After_Inhibition_Along_Theta_Axis_All{j} = RecordedData{j}.DSTMD_Outputs_After_Inhibition_Along_Theta_Axis;
                
            end
            
            File = strcat(Parameter_File.folder_Global,'\','DSTMD_Outputs_After_Inhibition_Along_Theta_Axis_All.mat');
            save(File,'DSTMD_Outputs_After_Inhibition_Along_Theta_Axis_All','-v7.3')
            
            %clearvars -except DSTMD_Outputs_After_Inhibition_Along_Theta_Axis_All
            clearvars RecordedData
        else
            File = strcat(Parameter_File.folder_Global,'\','DSTMD_Outputs_After_Inhibition_Along_Theta_Axis_All.mat');
            load(File)
        end
    end
    
    
    
    %%
    
    % ��ȡ�������
    % ��¼��֡��
    NumFrame_Clustering = length(DSTMD_Outputs_After_Inhibition_Along_Theta_Axis_All);
    % ͼ���С�� DS-STMD �ķ���
    [M_Clustering,N_Clustering,H_Clustering] = size(DSTMD_Outputs_After_Inhibition_Along_Theta_Axis_All{1});
    MexOperation = 1;
    MaxRegionSize = 5;
    Max_Threshold = 10;
    % ���ڴ洢 Max Operation ������
    Max_Operation_DSTMD_Outputs = cell(1,NumFrame_Clustering);
    
    tic;
    timedLog('Start Max Operation on DSTMD Outputs ...')
    for j = 1:NumFrame_Clustering
        
        
        
        % Max Operation (Along Theta Axis)
        MaxOperation_Input = DSTMD_Outputs_After_Inhibition_Along_Theta_Axis_All{j};
        Is_Mex_Max = 0;
        if Is_Mex_Max ==1
            if MexOperation == 1
                timedLog('Building mex function: MaxOperation_3D_mex ...');
                % ȥ����С����Ӧ
                MaxOperation_Input(MaxOperation_Input<Max_Threshold) = 0;
                % ���� MaxOperation_3D.m
                codegen MaxOperation_3D -args {MaxOperation_Input,MaxRegionSize,M_Clustering,N_Clustering,H_Clustering} -o MaxOperation_3D_mex
                timedLog('Building mex function is completed.');
                MexOperation = 0;
                [ModelOutputs] = MaxOperation_3D_mex(MaxOperation_Input,MaxRegionSize,M_Clustering,N_Clustering,H_Clustering);
            else
                % ȥ����С����Ӧ
                MaxOperation_Input(MaxOperation_Input<Max_Threshold) = 0;
                [ModelOutputs] = MaxOperation_3D_mex(MaxOperation_Input,MaxRegionSize,M_Clustering,N_Clustering,H_Clustering);
            end
        else            
            % ȥ����С����Ӧ
            MaxOperation_Input(MaxOperation_Input<Max_Threshold) = 0;
            [ModelOutputs] = MaxOperation_3D(MaxOperation_Input,MaxRegionSize,M_Clustering,N_Clustering,H_Clustering);
        end
        
        
        Max_Operation_DSTMD_Outputs{j} = ModelOutputs;
        
        disp(j)
    end
    
    clearvars DSTMD_Outputs_After_Inhibition_Along_Theta_Axis_All
    
    file = [Parameter_File.folder_Global,'/','Max_Operation_DSTMD_Outputs.mat'];
    save(file,'Max_Operation_DSTMD_Outputs','StartFrame','EndFrame','StartRecordFrame','NumFrame_Clustering','M_Clustering','N_Clustering','H_Clustering','-v7.3')
    
    
    timeTrain = toc/60; % min
    if timeTrain<60
        timedLog(['Max Operation on DSTMD Outputs finished, time taken: ',num2str(timeTrain),' min'])
    else
        timedLog(['Max Operation on DSTMD Outputs finished, time taken: ',num2str(timeTrain/60), ' hrs'])
    end
    
    
else
    load(file)
end