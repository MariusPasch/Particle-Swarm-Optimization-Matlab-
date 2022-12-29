function y=route_number_reduction(x,distances,demand,maxStorage,time_distances,maxTime,serviceTime)
y=x;
z=y;
finish="no";

I=1:length(x);
aces=I(x==1);
aces(end+1)=length(x)+1;
allroutes={};
for i=1:length(aces)-1
    allroutes{i}=x(aces(i):aces(i+1)-1);
        routesize(i)=length(allroutes{i});
end
[~,p]=sort(routesize);
temp=allroutes;
k=0;
while k<=length(routesize)-1
[~,select]=min(p);
nodes=allroutes{select}(2:end);
j=0;

allroutes={};
for i=1:length(temp)
if i~=select
allroutes{i-j}=temp{i};
else 
    j=1;
end
end
iterations=0;
[~,q]=sort(routesize(1:length(routesize)~=select));
while ~isempty(nodes) && iterations<=50 && ~isempty(q)
    
    [~,i]=min(q);
    diff=inf;

    for j=1:length(nodes)

        if and(maxStorage-sum(demand(allroutes{i}))-demand(nodes(j))>=0 ...
            ,maxStorage-sum(demand(allroutes{i}))-demand(nodes(j))<diff)
        
        diff=maxStorage-sum(demand(allroutes{i}))-demand(nodes(j));
        s=j;
        end
    end
    if diff~=inf
        distance=inf;
        for j=2:length(allroutes{i})-1
            if distance<distances(allroutes{i}(j-1),nodes(s)) ...
                    +distances(nodes(s),allroutes{i}(j))
                
                distance=distances(allroutes{i}(j-1),nodes(s)) ...
                    +distances(nodes(s),allroutes{i}(j));
                position=j-1;
            end
        end

        if distances(allroutes{i}(end),nodes(s))<distance/2
            allroutes{i}(end+1)=nodes(s);
        else
            allroutes{i}=[allroutes{i}(1:position) nodes(s) allroutes{i}(position+1:end)];
        end
        
        if F(allroutes{i},time_distances,serviceTime)<=maxTime
        nodes=nodes(nodes~=nodes(s));
        else
            iterations=iterations+1;
            temp1=allroutes{i};
            temp1=temp1(temp1~=nodes(s));
            allroutes{i}=temp1;
            q=q(q~=i);
        end
    else
        iterations=iterations+1;
        q=q(q~=i);
    end
end
if or(iterations>50,~isempty(nodes))
    allroutes=temp;
else
y=[];

for i=1:length(allroutes)
    y=[y allroutes{i}];
end

break;
end
k=k+1;
p=p(p~=select);
end
if finish=="yes"
    
elseif k==length(routesize)-1
    y=z;
    
end
end

