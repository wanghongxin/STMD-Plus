% 函数说明
% 该函数用于记录目标的真实位置
% 2016-11-18


%% Main
timedLog('Ground Truth Calculation ...')

Is_Show_Obtain_Ground_Truth = 0;

if strcmp(Parameter_File.folderName,'Target-Detection-in-Cluttered-Background')
    
    X_0 = 125;
    Y_0 = 500;
    
    % 生成存储 Ground Truth 的矩阵
    NumFrame_Clustering = Parameter_File.EndFrame-Parameter_File.StartRecordFrame+1;
    Target_Num = 1;
    Ground_Truth = zeros(NumFrame_Clustering,2,Target_Num);
    
    for i = Parameter_File.StartRecordFrame:Parameter_File.EndFrame
        disp(i)
        file = [Parameter_File.folder0,'/',sprintf('%s%04d.tif',Parameter_File.Imagetitle,i)];
        
        I = imread(file);
        Gray_I = rgb2gray(I);
        
        % 计算当前红色标记点的位置
        Time_Factor = (i-20)/Parameter_File.VideoSamplingFrequency;
        X_C = X_0;
        Y_C = Y_0 - round(Parameter_File.TargetVelocity*Time_Factor);
        
        
        Ground_Truth(i-Parameter_File.StartRecordFrame+1,1,1) = X_C;
        Ground_Truth(i-Parameter_File.StartRecordFrame+1,2,1) = Y_C;
        
        if Is_Show_Obtain_Ground_Truth == 1
            imshow(I)
            hold on
            plot(Y_C,X_C,'r*')
            title(num2str(i))
            drawnow
        end
    end
    
elseif strcmp(Parameter_File.folderName,'Cluttered-Background-Curvilinear-Motion')
    
    X_0 = 125;
    Y_0 = 500;
    
    Target_Velocity = Parameter_File.TargetVelocity;
    Trail_Amplitude = Parameter_File.Y_Axis_Amplitude;
    Temproal_Fre_Factor = Parameter_File.Y_Axis_TemporalFrequency;
    
    % 生成存储 Ground Truth 的矩阵
    NumFrame_Clustering = Parameter_File.EndFrame-Parameter_File.StartRecordFrame+1;
    Target_Num = 1;
    Ground_Truth = zeros(NumFrame_Clustering,2,Target_Num);
    SCR_Value = zeros(NumFrame_Clustering,1);
    % Luminance Difference Between Target and Background
    LDTB = zeros(NumFrame_Clustering,1);
    Sigma_Background = zeros(NumFrame_Clustering,1);
    Mu_Target = zeros(NumFrame_Clustering,1);
    Mu_Background = zeros(NumFrame_Clustering,1);
    
    for i = Parameter_File.StartRecordFrame:Parameter_File.EndFrame
        %disp(i)
        
        file = [Parameter_File.folder0,'/',sprintf('%s%04d.tif',Parameter_File.Imagetitle,i)];
        
        I = imread(file);
        Gray_I = rgb2gray(I);
        
        % 计算当前红色标记点的位置
        Time_Factor = (i-20)/Parameter_File.VideoSamplingFrequency;
        X_C = X_0 - round(Trail_Amplitude*sin(2*pi*Time_Factor*Temproal_Fre_Factor));
        Y_C = Y_0 - round(Parameter_File.TargetVelocity*Time_Factor);
        
     
        % Ground Truth (Target)
        Ground_Truth(i-Parameter_File.StartRecordFrame+1,1,1) = X_C;
        Ground_Truth(i-Parameter_File.StartRecordFrame+1,2,1) = Y_C;
        
        % SCR
        Time_Factor_Actual = (i)/Parameter_File.VideoSamplingFrequency;
        X_C_Actual = round(X_0 - Trail_Amplitude*sin(2*pi*Time_Factor_Actual*Temproal_Fre_Factor));
        Y_C_Actual = round(Y_0 - Parameter_File.TargetVelocity*Time_Factor_Actual);
        
        
          % Note (X_C,Y_C,X_C_Actual, Y_C_Actual) 都要改
%         % For CB-1
%         X_C = X_0 - round(Trail_Amplitude*sin(2*pi*Time_Factor*Temproal_Fre_Factor));
%         Y_C = Y_0 - round(Parameter_File.TargetVelocity*Time_Factor);
%         % For CB-2
%         X_C = X_0 + 25 - round(Trail_Amplitude*sin(2*pi*Time_Factor*Temproal_Fre_Factor));
%         Y_C = Y_0 - round(Parameter_File.TargetVelocity*Time_Factor);
        
        
        
        
        
        [SCR_Value(i-Parameter_File.StartRecordFrame+1,1), LDTB(i-Parameter_File.StartRecordFrame+1,1), Sigma_Background(i-Parameter_File.StartRecordFrame+1,1),...
            Mu_Target(i-Parameter_File.StartRecordFrame+1,1),Mu_Background(i-Parameter_File.StartRecordFrame+1,1)]= Calculate_SCR_Value(X_C_Actual,Y_C_Actual,Gray_I,i,Parameter_File.TargetWidth,Parameter_File.TargetWidth);
        

        if Is_Show_Obtain_Ground_Truth == 1
            imshow(I)
            hold on
            % plot(Y_C_Actual,X_C_Actual,'r*')
            plot(Y_C,X_C,'r*')
            % 注意 plot(y,x) 的 x,y 坐标刚好与 I(x,y) 的坐标 x,y 互换了一下
            title(num2str(i))
            drawnow
            
        end
    end
    
    
end

% 对数据进行平滑处理
SCR_Mean_Num = 8;
SCR_Mean_Kernel = ones(1,SCR_Mean_Num)/SCR_Mean_Num;
Conv_SCR_Value = conv(SCR_Value,SCR_Mean_Kernel,'same');
Conv_LDTB = conv(LDTB,SCR_Mean_Kernel,'same');
Conv_Sigma_Background = conv(Sigma_Background,SCR_Mean_Kernel,'same');

% 需要保存的变量
Normalized_LDTB = Conv_LDTB./255;


%%绘图

% figure
% plot(StartFrame:EndFrame,Conv_SCR_Value,'r')
% figure
% plot(StartFrame:EndFrame,Conv_LDTB./255,'b')
% figure
% plot(StartFrame:EndFrame,Conv_Sigma_Background,'b')

% figure
% [hAx,hLine1,hLine2] = plotyy(StartFrame:EndFrame,Conv_Contrast_Tar_Bac,StartFrame:EndFrame,Conv_Sigma_Background);
% 
% ylabel(hAx(1),'Difference') % left y-axis 
% ylabel(hAx(2),'Sigma') % right y-axis



%close 
% 存储数据
file = [Parameter_File.folder_Global,'/','Ground-Truth.mat'];
save(file,'Ground_Truth','NumFrame_Clustering','Target_Num','-v7.3')

file = [Parameter_File.folder_Global,'/','Luminance-Difference-Between-Target-and-Background.mat'];
save(file,'Normalized_LDTB','NumFrame_Clustering','-v7.3')



timeTrain = toc/60; % min
if timeTrain<60
   timedLog(['Ground Truth Calculation finished, time taken: ',num2str(timeTrain),' min'])
else
   timedLog(['Ground Truth Calculation finished, time taken: ',num2str(timeTrain/60), ' hrs'])
end 



