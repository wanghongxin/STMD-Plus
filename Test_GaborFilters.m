% Test zb_filters2.m
% 2016-01-05

clear all; close all; clc;

minFS = 3;
maxFS = 9;
sSFS = 2;

rot = [0 45 90 135];

circularRF = 1;
int_gabor = 0;
useSmooth = 1;

[sqfilters,filtersize,filters]= GaborFilters(minFS, maxFS, sSFS, rot, circularRF, int_gabor, useSmooth);

for i = 1:length(sqfilters)
    MyFilter =  sqfilters{i};
    figure
    surf(MyFilter)
end

