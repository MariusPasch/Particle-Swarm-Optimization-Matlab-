function y=Three_Opt_1_1_exchange(x,distances,time_distances,maxTime,serviceTime,demand,maxStorage)
%% Eyresi ton orion ton diadromon. 
%%Briskontai oles oi theseis pou periexoun 1(diladi tin apothiki). 
%%O kathe assos orizei tin arxi tis trexoysas diadromis eno o epomenos to telos tis. 
%%Sto dianysma apothikeyontai oi theseis sto dianysma diadromon (x) ton asson. 

y=[];
l=1:length(x);   
aces=l(x==1);
aces(end+1)=length(x);   %prostithetai ena akoma stoixeio (to telos toy dianysmatos) to opoia tha dilonei to telos tis teleytaias diadromis.
x=one_one_exchange(x,distances,time_distances,maxTime,serviceTime,demand,maxStorage,aces);
%% Arxi ton epanalipseon toy algorithmoy three opt se kathe diadromi
l=1:length(x);   
aces=l(x==1);
aces(end+1)=length(x);
for i=1:length(aces)-1   
    if i==length(aces)-1
        route=x(aces(i):end);   %i teleytaia diadromi teleionei stin teleytaia thesi toy dianysmatos symperilambanomenis aytis.
    else
        
%%Arxikopoiiseis ton metabliton poy tha xrisimopoiithoyn se kathe epanalipsi.
route=x(aces(i):aces(i+1)-1);
    end
bestroutedistance=0;

for j=2:length(route)
    bestroutedistance=bestroutedistance+distances(j-1,j);
end
bestroute=route;

%% Efarmogi toy 3-opt mono gia diadromes mikoys megalyteroy toy 5.

if length(route)>=4

arcCut=zeros(1,3);   %sto arcCut tha topothetithoyn ta toksa poy tha kopoyn. Apothikeyontai oi protoi se siera komboi toy toksoy. 
while any(arcCut==0) || length(arcCut)~=length(unique(arcCut))
    arcCut=randi((length(route)-1),[1,3]);
end

 [~,b]=sort(arcCut(:));   %topothetoyntai se ayksoysa symfona me ti seira toys sti diadromi ta toska poy tha kopoyn.
 arcCut=arcCut(b);
 
 %% Eyresi kalyteroy syndyasmoy ton kommation tis diadromis meta ti diagrafi ton tokson.
 
 N={};   %ston N pinaka tha topothetithoyn ta dianysmata poy prokyptoyn meta tin diagrafi ton tokson sti diadromi.
 start=[1 route(2:arcCut(1))];
      %ston M pinaka topothetoyntai ta anastrofa dianysmata ektos to proto poy arxizei apo tin apothiki kai exei mia mono fora.
 for j=2:3
     N{1,j-1}=route(arcCut(j-1)+1:arcCut(j));
 end
 N{1,end+1}=route(arcCut(j)+1:end);
for j=1:3
    N{2,j}=flip(N{1,j});
end
k_past=[];
j_past=[];
iterations=0;
 while  iterations<=20       %size(k_past,1)<=24 
     newroute=[];
     newroute=start;
     k_array=[1 2 3];
     j_array=[1 2];
     m=1;
     while ~isempty(k_array)
         k = k_array(randi(length(k_array)));
         j = j_array(randi(length(j_array)));
         k_array=k_array(k~=k_array);
         k_cmbns(m)=k;
         j_cmbns(m)=j;
         m=m+1;
     end
     
     if ~isempty(k_array) && all(ismember(k_cmbns,k_past,'rows')==1) && all(ismember(j_cmbns,j_past,'rows')==1)
      continue;   
     else
         newroute=[start N{j_cmbns(1),k_cmbns(1)} N{j_cmbns(2),k_cmbns(2)} N{j_cmbns(3),k_cmbns(3)}];
         k_past(end+1,:)=k_cmbns;
         j_past(end+1,:)=j_cmbns;

     routetime=F(newroute,time_distances,serviceTime);
     routedistance=F(newroute,distances);
          if routetime<=maxTime
                    if routedistance<bestroutedistance
                        bestroutedistance=routedistance;
                        bestroute=newroute;
                    end
          end
iterations=iterations+1;
     end    
 
 end
 
elseif length(route)==3
    bestroute=[];
    bestroute(1)=1;
    route=route(2:end);
       [~,b]=min(distances(1,route(1:end)));
   bestroute(2)=route(b);
   bestroute(3)=route(1:length(route)~=b);
end
    
if i==length(aces)-1
        y(aces(i):aces(i+1))=bestroute;
    else
y(aces(i):aces(i+1)-1)=bestroute;
    end

end
end

        