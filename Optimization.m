function Swarm=Optimization(Swarm,distances,c1,c2,demand,maxStorage,time_distances,maxTime,serviceTime)
c=c1+c2;
X=2/(abs(2-c-sqrt((c^2)-4*c)));

pbest=Swarm;
pbestdistance=zeros(1,length(Swarm));
for i=1:length(Swarm)
    pbestdistance(i)=F(pbest{i},distances);
end
[gbestdistance,b]=min(pbestdistance);
gbest=pbest{b};
velocity={};

   iterations=1;
   

for i=1:length(Swarm)
    velocity{iterations,i}=zeros(1,length(demand)-1);
end

while iterations<100
   %%

    r1=rand;
    r2=rand;


    
inv="no";
    z=transform(gbest,inv,demand,maxStorage,time_distances,maxTime,serviceTime);
  for i=1:length(Swarm)
   
   inv="no";
x=transform(Swarm{i},inv,demand,maxStorage,time_distances,maxTime,serviceTime);
y=transform(pbest{i},inv,demand,maxStorage,time_distances,maxTime,serviceTime);

    velocity{iterations+1,i}=X*(velocity{iterations,i}+c1*r1*(y-x)+c2*r2*(z-x));
    
   x=x+velocity{iterations+1,i};
   inv="yes";
   Swarm{i}=transform(x,inv,demand,maxStorage,time_distances,maxTime,serviceTime); 
  end
  %%
  inv="yes";
  for i=1:length(Swarm)
    if F(Swarm{i},distances)<pbestdistance(i)
        pbest{i}=Swarm{i};
        pbestdistance(i)=F(Swarm{i},distances);
    end
  end
  [candidatedistance,candidate]=min(pbestdistance);
  if candidatedistance<gbestdistance 
      gbestdistance=candidatedistance;
      gbest=pbest{candidate};
  end
  
  
  
      

  iterations=iterations+1;    

end

end
      
      
      
      
      
      
      
    