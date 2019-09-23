% 2016-11-13
% 函数说明
% 该函数用于展示 Monophasic Filter 


%% Main Function
close all;
% Spatial
MonoPhasicFilter_Sigma = 1.5;
MonoPhasicFilter_Alpha = 3;
MonoPhasicFilter_Theta = [0 45 90 135 180 225 270 315];
MonoPhasicFilter_Num = length(MonoPhasicFilter_Theta);
MonoPhasicFilter_FilterSize = 11;
% 生成 Monphasic Filters (Spatial Field)
[MonoPhasicFilters] = Generalization_MonophasicFilter(MonoPhasicFilter_Sigma,...
                         MonoPhasicFilter_Alpha,MonoPhasicFilter_Theta,...
                         MonoPhasicFilter_FilterSize);
                     
[Monophasic_Filter_M,Monophasic_Filter_N,Monophasic_Filter_H] = size(MonoPhasicFilters);

for k = 1:Monophasic_Filter_H
    figure
    surf(MonoPhasicFilters(:,:,k))
    saveas(gcf,strcat('Figures\Monophasic-Filter-',num2str(k),'.eps'))
end