%%percentage: dilonei to pososto ton kombon poy tha epilegontai tyxaia.

function x=particles(percentage,N,distances,demand,maxStorage,time_distances,maxTime,serviceTime)
x=[];
unused=2:N;
routetime=0;
x(1)=1;
[~,node]=min(distances(1,unused));
node=unused(node);
x(2)=node;
routes(1)=2;
unused=unused(node~=unused);

while ~isempty(unused)
    p=rand;
    if p<=percentage
        node=unused(randi(length(unused)));
    else
       selection=zeros(1,2)*inf;
       for i=1:length(x)
           [dist,node]=min(distances(x(i),unused));
           node=unused(node);
           if dist<selection(1)
               selection(1)=dist;
               selection(2)=node;
           end
       end
    end
       violating=[];
       distance=inf;
       position=zeros(1,2);
       while 1
        for i=1:length(routes)
            if sum(i==violating)==1
              
            else
                for j=2:routes(i)
                newdistance=distances(x(sum(routes(1:i-1))+j-1),node)...
                           +distances(node,x(sum(routes(1:i-1))+j))...
                           -distances(x(sum(routes(1:i-1))+j-1),x(sum(routes(1:i-1))+j));
                if newdistance<distance
                    distance=newdistance;
                    position(1)=i;
                    position(2)=j-1;
                end
                end
            end
        end
        if length(x)~=sum(routes(1:position(1)-1))+position(2)
            if or(distances(x(sum(routes(1:position(1)-1))+position(2)),node)>distances(x(sum(routes(1:position(1)))),node),...
                  distances(node,x(sum(routes(1:position(1)-1))+position(2)+1))>distances(x(sum(routes(1:position(1)))),node))
              %%An to cik h to ckj einai megalytero toy c(telos->k) tote na prostethei sto telos tis diadromis        
                position(1)=i;
                position(2)=routes(i);
            end
        end
            if sum(demand([x(sum(routes(1:position(1)-1))+1:sum(routes(1:position(1)))) node]))<=maxStorage
                if F([x(sum(routes(1:position(1)-1))+1:sum(routes(1:position(1)-1))+position(2))...
                        node ...
                        x(sum(routes(1:position(1)-1))+position(2)+1:sum(routes(1:position(1))))],time_distances,serviceTime)...
                        <=maxTime
                    
                    x=[x(1:sum(routes(1:position(1)-1))+position(2)) node x(sum(routes(1:position(1)-1))+position(2)+1:end)];
                    routes(position(1))=routes(position(1))+1;
                    break;
                else
                    violating(end+1)=position(1);
                end
            else
                violating(end+1)=position(1);
            end
            if length(violating)==length(routes)
                    x(end+1:end+2)=[1 node];
                    routes(end+1)=2;
                    break;
            end
       end
unused=unused(unused~=node);
end
end

    
       
                
                
                
                
                
