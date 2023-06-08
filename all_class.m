function [idx data]=all_class(img_cell,dist_list_cell)
for ind1=1:length(img_cell);
    ind1
    cdata=img_cell{ind1};dist_listw=[];
    dist_list=(dist_list_cell{ind1});
    for di=1:length(dist_list_cell{ind1})
        if di==1
            dist_listw=dist_list{1};
        else
            dist_listw=[dist_listw;dist_list{di}];
        end
    end
Xangle_ratio=[];Xnonzero=[];X=[];
L03=bwlabel((cdata));
a=1:1:360;
stats = regionprops( L03 ,'Centroid','MajorAxisLength','MinorAxisLength','Solidity','Area');
length(dist_listw(:,1))
for i=1:length(dist_listw(:,1));
    k(i,:)=interp1(a,dist_listw(i,:)'-mean(dist_listw(i,:)),0:6:360,'spline');
    [X(i,:),phase(i,:)]=easyFFT([1:1:61;k(i,:)],20);
    X=abs(X);
    X1=sort(X(i,:),'descend');
    Xmax=find(X(i,:)==X1(1,1));
    Xnonzero=length(X(i,:))-length(find(X(i,:)==0));
    if X1(1,2)==0
        if X(i,5)*X(i,4) ==0
           X2max=Xmax;
           Xangle_ratio(:,i)= [Xmax 1 Xnonzero 1]; 
        else
            X2max=Xmax;
            Xangle_ratio(:,i)= [Xmax 1 Xnonzero X(i,5)/X(i,4)]; 
        end
       
    else
        if X(i,5)*X(i,4) ==0
          X2max=find(X(i,:)==X1(1,2));
          Xangle_ratio(:,i)=[Xmax X1(1,1)/X1(1,2) Xnonzero 1];
        else
          X2max=find(X(i,:)==X1(1,2));
          Xangle_ratio(:,i)=[Xmax X1(1,1)/X1(1,2) Xnonzero X(i,5)/X(i,4)];
        end
    end
    AR=[];
    MajorAxisLength=cat(1,stats(i,1).MajorAxisLength);
    MinorAxisLength=cat(1,stats(i,1).MinorAxisLength);
    AR=MajorAxisLength/MinorAxisLength;
    %clustering
%     if Xnonzero > 15
%         idx(i)=1;
    if Xmax-1 ==2
        if AR > 1.2
            idx{ind1}(i)=2;
        else
            idx{ind1}(i)=1;
        end
    elseif Xmax-1 ==3
        if ((stats(i,1).MinorAxisLength)^2*3.14)/stats(i,1).Area > 4
            idx{ind1}(i)=3;
        else
            idx{ind1}(i)=1;
        end
    elseif Xmax-1 ==4
        idx{ind1}(i)=4;
    else
        idx{ind1}(i)=1;
    end
   
end
% %colormapping
% for l=1:length(stats)
%         L03(L03==l)=idx{ind1}(l);    
% end
% length(stats)

% L03l=label2rgb(L03,'jet','k');
%imshow(L03l*0.9);
% for l=1:length(stats)
%         CentroidX = stats( l , 1 ).Centroid(1) - 12;
%         CentroidY = stats( l , 1 ).Centroid(2);
% %         text(CentroidX,CentroidY+20,num2str(round(stats(l,1).Area)),'color','g','fontsize',13);
% %         text(CentroidX,CentroidY,num2str(round(stats(l,1).MinorAxisLength)),'color','g','fontsize',13);
% %         text(CentroidX,CentroidY-20,num2str(round(stats(l,1).Area/((stats(l,1).MinorAxisLength/2)^2*3.141592),2)),'color','g','fontsize',13);
%         text(CentroidX,CentroidY,num2str(idx{ind}(l)),'color','w','fontsize',15);
% 
% end
scale=0.0979; % x40000, 2048*2048 case
for n=1:length(stats)
    data{ind1}(n,1)=stats(n,1).Solidity;
    data{ind1}(n,2)=stats(n,1).MajorAxisLength*scale;
    data{ind1}(n,3)=stats(n,1).MinorAxisLength*scale;
    data{ind1}(n,4)=stats(n,1).Area*scale/10;
    data{ind1}(n,5)=data{ind1}(n,2)/data{ind1}(n,3);
end
end