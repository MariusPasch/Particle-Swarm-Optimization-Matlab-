function x=one_one_exchange(x,distances,time_distances,maxTime,serviceTime,demand,maxStorage,aces)
aces(end)=aces(end)+1;
allroutes={};
for i=1:length(aces)-1
    allroutes{i}=x(aces(i):aces(i+1)-1);
end

for R=1:length(allroutes)
    T=zeros(length(allroutes),2);
    C="incomplete";
for i=1:length(allroutes)
    arc=0;
    for j=2:length(allroutes{i})
        if arc <distances(allroutes{i}(j-1),allroutes{i}(j))
            arc=distances(allroutes{i}(j-1),allroutes{i}(j));
            position=j;
        end
        if position~=2 && position~=length(allroutes{i})
            if distances(allroutes{i}(position-2),allroutes{i}(position-1))>distances(allroutes{i}(position),allroutes{i}(position+1))
                position=position-1;
            end
        end
        T(i,1)=position;
        T(i,2)=F(allroutes{i},distances);
    end
end
    
    for k=1:length(allroutes)
        if k~=R
            newcost_1=F([allroutes{R}(1:T(R,1)-1) allroutes{k}(T(k,1)) allroutes{R}(T(R,1)+1:end)],distances);
            newcost_2=F([allroutes{k}(1:T(k,1)-1) allroutes{R}(T(R,1)) allroutes{k}(T(k,1)+1:end)],distances);
          if newcost_1+newcost_2<T(R,2)+T(k,2)
                if F([allroutes{R}(1:T(R,1)-1) allroutes{k}(T(k,1)) allroutes{R}(T(R,1)+1:end)],time_distances,serviceTime)<=maxTime ...
                        && F([allroutes{k}(1:T(k,1)-1) allroutes{R}(T(R,1)) allroutes{k}(T(k,1)+1:end)],time_distances,serviceTime)<=maxTime ...
                        && sum(demand([allroutes{R}(1:T(R,1)-1) allroutes{k}(T(k,1)) allroutes{R}(T(R,1)+1:end)]))<=maxStorage ...
                        && sum(demand([allroutes{k}(1:T(k,1)-1) allroutes{R}(T(R,1)) allroutes{k}(T(k,1)+1:end)]))<=maxStorage
                    temp=allroutes{R}(T(R,1));
                    allroutes{R}=[allroutes{R}(1:T(R,1)-1) allroutes{k}(T(k,1)) allroutes{R}(T(R,1)+1:end)];
                    allroutes{k}=[allroutes{k}(1:T(k,1)-1) temp allroutes{k}(T(k,1)+1:end)];
                    C="complete";
                end
            end
        end
    end
    
    if C=="incomplete"
        o=0;
          while o<=25
              while 1
              rt=randi(length(allroutes));
              node=randi(length(allroutes{rt})-1);
              node=node+1;
              if rt~=R && node~=T(R,1)
                  break;
              end
              end
             
            newcost_1=F([allroutes{R}(1:T(R,1)-1) allroutes{rt}(node) allroutes{R}(T(R,1)+1:end)],distances);
            newcost_2=F([allroutes{rt}(1:node-1) allroutes{R}(T(R,1)) allroutes{rt}(node+1:end)],distances);
            if newcost_1+newcost_2<T(R,2)+T(rt,2)
                if F([allroutes{R}(1:T(R,1)-1) allroutes{rt}(node) allroutes{R}(T(R,1)+1:end)],time_distances,serviceTime)<=maxTime ...
                        && F([allroutes{rt}(1:node-1) allroutes{R}(T(R,1)) allroutes{rt}(node+1:end)],time_distances,serviceTime)<=maxTime ...
                        && sum(demand([allroutes{R}(1:T(R,1)-1) allroutes{rt}(node) allroutes{R}(T(R,1)+1:end)]))<=maxStorage ...
                        && sum(demand([allroutes{rt}(1:node-1) allroutes{R}(T(R,1)) allroutes{rt}(node+1:end)]))<=maxStorage
                    
                    temp=allroutes{R}(T(R,1));
                    allroutes{R}=[allroutes{R}(1:T(R,1)-1) allroutes{rt}(node) allroutes{R}(T(R,1)+1:end)];
                    allroutes{rt}=[allroutes{rt}(1:node-1) temp allroutes{rt}(node+1:end)];
                    break;
                end
            end
            o=o+1;
          end
    end
end
x=[];
for i=1:length(allroutes)
    x(end+1:length(x)+length(allroutes{i}))=allroutes{i};
end

end