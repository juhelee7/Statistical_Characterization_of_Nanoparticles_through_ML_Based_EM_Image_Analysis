%%naive bayes classification
% Make species
for i=1:1492
    if i<=373
    species1{i}='Solidity';
    elseif i<=746
    species1{i}='Majoraxis';
    elseif i<=1119
    species1{i}='Minoraxis';
    else
    species1{i}='Area';
    end
end
% %naive bayes data
% nbdata1=data1(:,1);
% nbdata1=[nbdata1;data1(:,2)];
% nbdata1=[nbdata1;data1(:,3)];
% nbdata1=[nbdata1;data1(:,4)];
% 
% %normalize and KDF
% nbGau=fitcnb(nbdata1,species1);
% 
% cp = cvpartition(species1,'KFold',10)
% nbKD=fitcnb(nbdata1,species1,'DistributionNames','kernel','Kernel','box');

%% kmeans clustering
%add AR
data1_w=[data1,data1(:,2)./data1(:,3)];
idx=kmeans(data1_w(:,5),3);
figure(1),plotmatrix(data1_w(idx==1,:),'r.')
figure(2),plotmatrix(data1_w(idx==2,:),'g.')
figure(3),plotmatrix(data1_w(idx==3,:),'b.')
figure(4),plotmatrix(data1_w(idx==4,:),'m.')
figure(5),plotmatrix(data1_w(idx==5,:),'k.')

sumdata_w=[sumdata,sumdata(:,2)./sumdata(:,3)];
idx=kmeans(sumdata_w,5);
figure(1),plotmatrix(sumdata(idx==1,:),'r.')
figure(2),plotmatrix(sumdata(idx==2,:),'g.')
figure(3),plotmatrix(sumdata(idx==3,:),'b.')
figure(4),plotmatrix(sumdata(idx==4,:),'m.')
figure(5),plotmatrix(sumdata(idx==5,:),'k.')

%% ind_sum clustering
[N M l]=size(ind_rot);
ind_rot1=zeros(N,M);ind_rot2=zeros(N,M);ind_rot3=zeros(N,M);
ind_rot4=zeros(N,M);ind_rot5=zeros(N,M);
for i=1:length(data1(:,1))
    if idx(i)==1
        ind_rot1=ind_rot1+ind_rot(:,:,i);
    elseif idx(i)==2
        ind_rot2=ind_rot2+ind_rot(:,:,i);
    elseif idx(i)==3
        ind_rot3=ind_rot3+ind_rot(:,:,i);
    elseif idx(i)==4
        ind_rot4=ind_rot4+ind_rot(:,:,i);
    else
        ind_rot5=ind_rot5+ind_rot(:,:,i);
    end
end


%% visualization
rng default; % For reproducibility
opts = statset('Display','final');
[idx,C] = kmeans(X,3,'Distance','cityblock',...
    'Replicates',5,'Options',opts);
figure;
plot(X(idx==1,1),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),'b.','MarkerSize',12)
hold on
plot(X(idx==3,1),'b.','MarkerSize',12)
title 'Cluster Assignments'
hold off

%% easyFFT clustering
Xangle_ratio=[];Xnonzero=[];
for i=1:length(dist_list(:,1));
    k(i,:)=interp1(a,dist_list(i,:)'-mean(dist_list(i,:)),0:6:360,'spline');
    [X(i,:),phase(i,:)]=easyFFT([1:1:61;k(i,:)],10);
    X=abs(X);
    X1=sort(X(i,:),'descend');
    Xmax=find(X(i,:)==X1(1,1));
    Xnonzero=length(X(i,:))-length(find(X(i,:)==0))
    if X1(1,2)==0
       X2max=Xmax;
       Xangle_ratio(:,i)=[Xmax 1 Xnonzero];
    else
       X2max=find(X(i,:)==X1(1,2));
       Xangle_ratio(:,i)=[Xmax X1(1,1)/X1(1,2) Xnonzero];
    end
    
end

%% easyFFT clustering Exam + classification
Xangle_ratio=[];Xnonzero=[];idx=[];X=[];
L03=bwlabel(L02w2);
stats = regionprops( L03 ,'Centroid','MajorAxisLength','MinorAxisLength','Solidity','Area');
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
    AR=stats(i,1).MajorAxisLength(1)/stats(i,1).MinorAxisLength(1);
    %clustering
%     if Xnonzero > 15
%         idx(i)=1;
    if Xmax-1 ==2
        if AR > 1.2
            idx(i)=2;
        else
            idx(i)=1;
        end
    elseif Xmax-1 ==3
        idx(i)=3;
    elseif Xmax-1 ==4
        idx(i)=4;
    else
        idx(i)=5;
    end
   
end
%colormapping
for l=1:length(stats)
        L03(L03==l)=idx(l);    
end


L03l=label2rgb(L03,'jet','k');
imshow(L03l*0.9);
for l=1:length(stats)
        CentroidX = stats( l , 1 ).Centroid(1) - 12;
        CentroidY = stats( l , 1 ).Centroid(2);
%         text(CentroidX,CentroidY+20,num2str(round(stats(l,1).Area)),'color','g','fontsize',13);
%         text(CentroidX,CentroidY,num2str(round(stats(l,1).MinorAxisLength)),'color','g','fontsize',13);
%         text(CentroidX,CentroidY-20,num2str(round(stats(l,1).Area/((stats(l,1).MinorAxisLength/2)^2*3.141592),2)),'color','g','fontsize',13);
        text(CentroidX,CentroidY,num2str(idx(l)),'color','w','fontsize',15);

end

%% make data
for i=1:length(stats)
    data_first(i,1)=stats(i,1).Solidity;
    data_first(i,2)=stats(i,1).MajorAxisLength;
    data_first(i,3)=stats(i,1).MinorAxisLength;
    data_first(i,4)=stats(i,1).Area;
    data_first(i,5)=stats(i,1).MajorAxisLength/stats(i,1).MinorAxisLength;
end
figure(1),plotmatrix(data_first(idx==1,:),'r.')
figure(2),plotmatrix(data_first(idx==2,:),'g.')
figure(3),plotmatrix(data_first(idx==3,:),'b.')
figure(3),plotmatrix(data_first(idx==4,:),'b.')

%% show

L03=bwlabel(L02ww);
 stats = regionprops( L03 ,'Centroid');
imshow(L02ww/5);
for l=1:length(stats)
        CentroidX = stats( l , 1 ).Centroid(1) - 12;
        CentroidY = stats( l , 1 ).Centroid(2);
        text(CentroidX,CentroidY+15,num2str(Xangle_ratio(3,l)),'color','w','fontsize',13);
        text(CentroidX,CentroidY-15,num2str(Xangle_ratio(1,l)-1),'color','w','fontsize',13);
        text(CentroidX,CentroidY-45,num2str(l),'color','w','fontsize',13);

end
  

