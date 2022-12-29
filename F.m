%%fitness Function
function fitness=F(x,distances,serviceTime)
fitness=0;
if nargin==2
for i=2:length(x)
    if x(i)~=1
        fitness=fitness+distances(x(i-1),x(i));
    end
end
else
 for i=2:length(x)
    if x(i)~=1
        fitness=fitness+distances(x(i-1),x(i))+serviceTime;
    end
 end
end
end
        