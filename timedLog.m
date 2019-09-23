function timedLog(str)

c = clock;
h = sprintf('%02.0f',c(4)) ;
m = sprintf('%02.0f',c(5)) ;
s = sprintf('%02.0f',c(6)) ;
timeStr = [ h ':' m ':' s ];

d = date;
ddmmm = d(1:6);

dateClock = [ '[', ddmmm, ']', ' ', '[', timeStr,'] : ' ];

str = [dateClock,str];
disp(str);

end