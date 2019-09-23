function [linestyles,MarkerEdgeColors,Markers]= generate_line_styles(n)


% generate the space of linestyles, MarkerEdgeColors,Markers

basic_linestyles = cellstr(char('-',':','-.','--'));
basic_Markers    = cellstr(char('o','x','+','*','s','d','v','^','<','>','p','h','.'));
MarkerEdgeColors = jet(n);
linestyles       = repmat(basic_linestyles,ceil(n/4),1);
Markers          = repmat(basic_Markers,ceil(n/13),1);

end



