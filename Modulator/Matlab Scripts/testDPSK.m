
x=0;
phase = 0;

for i=1:30
    [tmp, phase] = modDPSK(0,phase,50,i);
    x = [x tmp];
end

plot(x)