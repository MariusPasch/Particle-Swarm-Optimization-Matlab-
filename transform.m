function y=transform(x,inv,demand,maxStorage,time_distances,maxTime,serviceTime)
if inv=="yes"
    %% Invert = Yes
    B=sort(x);
    A=[1:length(x)];
    for i=1:length(x)
        I(i)=A(x(i)==B);
    end
    I=I+1;
    y=[];
    y(1)=1;
    j=2;
    k=0;
    routetime=0;
    for i=1:length(x)
        if or((sum(demand(y(k+1:end)))+demand(I(i)))>maxStorage,(routetime+time_distances(y(end),I(i))+serviceTime)>maxTime) 
            k=length(y);
            y(k+1)=1;
            y(k+2)=I(i);
            j=3;
            routetime=time_distances(1,I(i))+serviceTime;
        else
            routetime=routetime+time_distances(y(end),I(i))+serviceTime;
            y(k+j)=I(i);
            j=j+1;
        end
    end
else
    %% Invert = No
    x=x(x~=1);
    w=max(x);
    y=x./w;
end
end