%% Paschalidis Marios 
% AM: 2015010115
% Ylopoiisi Particle Swarm Optimization
% O parakato kodikas graftike se 2018a ekdosi matlab, gia tixon syntaktika lathi epikoinoniste mazi mou



%% Particle Swarm Optimization
clc;
clear all;
close all;

fileID = fopen('E3.txt','r');
data=fscanf(fileID,'%d');
fclose(fileID);

N=data(1);
maxStorage=data(2);
maxTime=data(3);
serviceTime=data(4);
coordinates=data(5:(3*(N+1)+1));
distances=zeros(N);
for i=1:N-1
    for j=N:-1:i
       distances(i,j)=sqrt(((coordinates(3*(i-1)+2))-(coordinates(3*(j-1)+2)))^2+((coordinates(3*(i-1)+3))-(coordinates(3*(j-1)+3)))^2);
       distances(j,i)=distances(i,j);
    end
end

for i=1:N
    distances(i,i)=inf;
end
time_distances=distances;
demand=zeros(1,N);
for i=1:2:N*2
    demand(1+(i-1)/2)=data((3*(N+1)+2)+i);
end
 Solutions=10;
 x=zeros(1,N);
 y=x;
for i=1:N
    x(i)=coordinates(3*(i-1)+2);
    y(i)=coordinates(3*(i-1)+3);
end
fitness=zeros(Solutions,4);
%%
Swarm={};
percentage=0.3;
for i=1:Solutions
    Swarm{i}=particles(percentage,N,distances,demand,maxStorage,time_distances,maxTime,serviceTime);
   fitness(i,1)=F(Swarm{i},distances);
figure(i)
plots(x,y,Swarm{i});
end




%%
for i=1:Solutions
Swarm{i}=Three_Opt_1_1_exchange(Swarm{i},distances,time_distances,maxTime,serviceTime,demand,maxStorage);
fitness(i,2)=F(Swarm{i},distances);
 figure(10+i)
 plots(x,y,Swarm{i});
end


%%
c1=2;
c2=2000;
Swarm=Optimization(Swarm,distances,c1,c2,demand,maxStorage,time_distances,maxTime,serviceTime);



for i=1:Solutions

fitness(i,3)=F(Swarm{i},distances);
figure(20+i)
plots(x,y,Swarm{i});
    
end

%%
final=Swarm;
for i=1:Solutions
for j=1:20
    final{i}=Three_Opt_1_1_exchange(final{i},distances,time_distances,maxTime,serviceTime,demand,maxStorage);
fitness(i,4)=F(final{i},distances);
end
end
dist=inf;
for i=1:10
if dist>F(final{i},distances)
best=i;
dist=F(final{i},distances);
end
end
figure()
plots(x,y,final{best});
title("TELIKH PROTEINOMENH LYSH")
fprintf("Mesh synoliki apostasi ton arxikon lyseon = %d\n\n",sum(fitness(:,1))/Solutions);
fprintf("Mesh beltiosi tis synolikis apostasis ton arxikon lyseon apo ton 3-OPT = %d\n\n",sum(fitness(:,1)-fitness(:,2))/Solutions);
fprintf("Mesh beltiosi tis synolikis apostasis ton lyseon toy 3-OPT,\n apo ton algorithmo beltistopoihsis sminoys = %d\n\n",sum(fitness(:,2)-fitness(:,3))/Solutions);
fprintf("Mesh synoliki apostasi ton telikon lyseon = %d\n\n",sum(fitness(:,4))/Solutions);
fprintf("Synoliki apostasi TELIKHS PROTEINOMENHS LYSHS = %d\n\n",F(final{best},distances));