function plots(x,y,routes)

s = scatter(x(2:end),y(2:end),'*');
s.LineWidth = 0.6;
s.MarkerEdgeColor = 'b';

hold on
s1=scatter(x(1),y(1),500,'x');
s1.LineWidth = 1;
s1.MarkerEdgeColor = 'r';

l=1:length(routes);
aces=l(routes==1);
aces(end+1)=length(routes)+1;
hold on 
for i=1:length(aces)-1        
hold on    
s2=plot(x([routes(aces(i):aces(i+1)-1)]),y([routes(aces(i):aces(i+1)-1)]))
end



end