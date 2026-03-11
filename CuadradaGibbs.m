t=(0:0.01:10)';
s=0;
for i=1:2:21
s= s+sin(i.*t)/i;
if i<21
    plot(t,s)
    hold on
else
    plot(t,s,'LineWidth',2)
    hold off
end
end