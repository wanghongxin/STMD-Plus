function [sqfilters,filtersize,filters]= GaborFilters(minFS, maxFS, sSFS, rot, circularRF, int_gabor, useSmooth)
% zb_filters2, to generate a bank of gabor filters.
% Inputs:
%   minFS:      minimum filter size
%   maxFS:      maximum filter size
%   sSFS:       increment of filter size. Filter sizes are minFS:sSFS:maxFS.
%   rot:        a vector that specifies all orientations. e.g. [0 45 90 135].
%   circularRF: whether to use circular receptive field. 1: yes, 0: no. default: 1.
%   int_gabor:  whether to use integer filter values. 1: yes, 0: no. default: 0.
%
% Outputs:
%   sqfilters:  cells, each cell contain a 2d filter.
%   filtersize: vector, each number indicates the corresponding filter size.
%
% usage:
%	[sqfilters,filtersize]= zb_filters2();         % filter sizes = 7:2:39, 4 rot, circular RF, floating point, 
%	[sqfilters,filtersize]= zb_filters2(3,9,2);    % filter sizes = 3:2:9, 4 rot, circular RF, floating point.
%   [sqfilters,filtersize]= zb_filters2(3,9,2,[0 90],1,1);% filter sizes = 3:2:9, 2 rot, circular RF, integer numbers.


if ~exist('minFS','var')
    minFS = 7;
end

if ~exist('maxFS','var')
    maxFS = 39;
end

if ~exist('sSFS','var')
    sSFS = 2;
end

if ~exist('rot','var')
    rot = [0 45 90 135];
end

if ~exist('circularRF','var')
    circularRF = 1;
end

if ~exist('int_gabor','var')
    int_gabor = 0;
end

if ~exist('useSmooth','var')
    useSmooth = 0;
end


%------------Build all filters (of all sizes)
% For details of these parameters, look at Thomas's thesis:
% "Learning a Dictionary of Shape-Components in Visual Cortex: Comparison with Neurons, Humans and Machines" pp155-156
% and his paper "Object Recognition with Features Inspired by Visual Cortex" on CVPR05
% rot 	= [0 45 90 135];
% RF_siz = 7:2:39;			% Thomas used 7:2:39 totally 17 scales, RF stands for "Receptive Field"
% Div 	= 4:-.05:3.2;       % Thomas used 4:-.05:3.2 corresponding to 7:2:39                            
% % in Thomas's MATLAB codes, it is:
% lambda = RF_siz*2./Div;   % [1.4634  2.4691  3.5000  4.5570  5.6410  6.7532]
% sigma  = lambda.*0.8;     % [1.1707  1.9753  2.8000  3.6456  4.5128  5.4026]
% % whereas according to his thesis, it is: (the results are similar)
% sigma  = 0.0036*RF_siz.^2+0.35*RF_siz+0.18; % [1.2624  2.0200  2.8064  3.6216  4.4656  5.3384]
% lambda = sigma./0.8;                        % [1.5780  2.5250  3.5080  4.5270  5.5820  6.6730]

% rot    = [0 45 90 135];
RF_siz = minFS:sSFS:maxFS;

div0 = 4+ ( minFS -7 )/2*(-0.05);
div1 = 4+ ( RF_siz(end) -7 )/2*(-0.05);
div = div0:-0.05*sSFS/2:div1;

lambda = RF_siz*2./div;
sigma  = lambda.*0.8;

G      = 0.3;   			                %0.3; spatial aspect ratio: 0.23 < gamma < 0.92

numFilterSizes   = length(RF_siz);
numSimpleFilters = length(rot);
numFilters       = numFilterSizes*numSimpleFilters;
filtersize       = zeros(numFilters,1);	% vector with filter sizes
filters          = zeros(max(RF_siz)^2,numFilters);

for k = 1:numFilterSizes  
    for r = 1:numSimpleFilters
        theta     = rot(r)*pi/180;
        filtSize  = RF_siz(k);
        center    = ceil(filtSize/2);
        filtSizeL = center-1;
        filtSizeR = filtSize-filtSizeL-1;
        
        f=zeros(filtSize,filtSize);
        for i = -filtSizeL:filtSizeR			% relative row coordinate w.r.t. the center
            for j = -filtSizeL:filtSizeR		% relative col coordinate w.r.t. the center
                X =  i*cos(theta) + j*sin(theta);
                Y = -i*sin(theta) + j*cos(theta);
                E = exp(-(X^2+G^2*Y^2)/(2*sigma(k)^2))*cos(2*pi*X/lambda(k));
                % if (circularRF) && ( sqrt(i^2+j^2)>floor(filtSize/2) )
                if (circularRF) && ( sqrt(i^2+j^2)>filtSize/2 )
                    E = 0;					    % Thomas uses a circular receptive field
                end
                f(i+center,j+center) = E;
            end
        end
        
        f = f - mean(mean(f));
        f = f ./ sqrt(sum(sum(f.^2)));						% normalization. (f-mean)/sd, to make it have zero mean and unit sd
        
        p = numSimpleFilters*(k-1) + r;
        filters(1:filtSize^2,p)=reshape(f,filtSize^2,1);	% reshape the square filter into a column vector
        filtersize(p)=filtSize;
    end
end


% reshape to 2d filters
nFilts = length(filtersize);
sqfilters=cell(1,nFilts);
for i = 1:nFilts
  sqfilters{i} = reshape(filters(1:(filtersize(i)^2),i),filtersize(i),filtersize(i));
end


% smooth first? gabor*(smooth*img) = (gabor*smooth)*img
if useSmooth==1
    szSmoothFilt = 3;
    smoothfilter = ones(szSmoothFilt); % 3x3 averaging filter (box filter)
    smoothfilter = smoothfilter/sum(sum(smoothfilter));
    for i = 1:nFilts
        sqfilters{i} = conv2(sqfilters{i},smoothfilter,'same');
    end
end

% floating point numbers --> integer numbers
if(int_gabor)
    for i=1:length(filtersize)
        center = ceil(filtersize(i)/2);
        f = sqfilters{i};
        f = round(f*100); 
        f(center,center)=f(center,center)+1;
        sqfilters{i}=f;
    end
end


