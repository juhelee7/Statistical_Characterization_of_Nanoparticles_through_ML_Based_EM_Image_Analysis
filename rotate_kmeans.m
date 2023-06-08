function [oind_rot_cell ]=rotate_kmeans(img_cell)
%% for ind1=1:length(img_cell)
 for ind1=101:153
img=img_cell{ind1}; % cell struture
%img=img_cell;  % if not cell structure
ind1
scale=0.0979; % x40000, 2048*2048 case
[N M]=size(img);
L01 = bwlabel(img);
countim=max(max(L01));
stats = regionprops(L01,'Orientation','Centroid','MajorAxisLength','MinorAxisLength','Area');
for i=1:countim
    maj_a(i)=(stats(:,1).MajorAxisLength);
    min_a(i)=(stats(:,1).MinorAxisLength);
end
maj=round(max(maj_a));minr=round(max(min_a));
%% size up
ImEdge=zeros(N+maj*2,M+maj*2);
ImEdge(maj+1:end-maj,maj+1:end-maj)= L01;
L01=ImEdge;
%%
% L01(L01>0)=1;
% L01=bwlabel(L01);
% stats = regionprops(L01,'Orientation','Centroid','MajorAxisLength','MinorAxisLength');
ind_rot=[];
for i=1:countim
    cent=zeros(2,1);instats=[];rotimg=[];
%     indivimage(:,:,i)=(L01==i);
    rotimg=imrotate(L01==i,-stats(i,1).Orientation);%,'bilinear','crop');
    rotimg=bwlabel(rotimg);
    instats=regionprops(rotimg,'Centroid','MajorAxisLength');
    cent=instats.Centroid;
%    instats.MajorAxisLength
%    stats(i).MajorAxisLength
    ind_rot(:,:,i,ind1)=imcrop(rotimg,[cent(1)-maj*0.75 cent(2)-minr*1.5 round(maj*1.5) round(minr*3)]);
%     ind_rot(:,:,i,ind1)=imcrop(rotimg,[(round(cent(1))-round(maj*0.75)) (round(cent(2))-round(minr*1.5)) round(maj*1.5) round(minr*3)]);
     oind_rot_cell{ind1}{:,i}=bwperim(ind_rot(:,:,i,ind1));
% remove odd number    
%     for i1=1:round(maj*1.5)
%         for i2=1:round(minr*3)
%             if (rem(i1,2)==0)
%                 ind_rot(i2,i1,i)=0;
%             elseif (rem(i2,2)==0)
%                 ind_rot(i2,i1,i)=0;
%             end
%         end
%     end 
%%    oind_rot_r(:,:,i,ind1)=imresize(ind_rot(:,:,i,ind1),[53 104]);
%     Hogind(i)=HOG(oind_rot(:,:,i));
%     L0r=bwlabel(rind_rot(:,:,i));
%     rstats=regionprops(L0r,'Centroid');
%     for li=1:length(rstats)
%         dind_rot(round(rstats(li).Centroid(1)),round(rstats(li).Centroid(2)),i)=1;
%     end
    
%% Mirkin Method
% xtemp=[]; ytemp=[]; Perim=[];const_x=[];nor_k=[];L02 = bwlabel(img);
% for j=1:length(stats)
%    %Define centroid and perimeter
%    xtemp = [xtemp stats(j).Centroid(1)];
%    ytemp = [ytemp stats(j).Centroid(2)];
%    Perim =  bwperim(L02==j,8);
%    
%    %%% x,y coord of perim
%    [Xlist,Ylist] = find(Perim);
% %   const_x=360/length(Xlist);   
% %   d=zeros(size(Xlist));
% %   angle=zeros(size(Xlist));
%    
%     %%%Go around the perimeter and calculate d and theta
%     %%%ytemp and xtemp are centroid coord for this shape
%    %%%xsus and ysus give x and y distance from the centroid to
%    %%%the edge
% %   k=0;
%     d=[];angle=[];
%    for k=1:length(Xlist)
% %    if length(Xlist)>360
% %    for h=1:length(Xlist)
% %         k=round(h*const_x);
% %         if k<=0
% %             k=1;
% %         else k>360
% %             k=360;
% %         end
% %       xsus = ytemp(end)+ytemp(end)-Xlist(k);
% %       ysus = xtemp(end)+xtemp(end)-Ylist(k);
%       %[junk index] = min((Xlist-xsus).^2+(Ylist-ysus).^2);
%       %xtemp and ytemp are centroid, Xlist and Ylist are list
%       %of points on perimeter --> xtemp(end) and ytemp(end)
%       d(k) = sqrt((Xlist(k)-ytemp(end)).^2+(Ylist(k)-xtemp(end)).^2)*scale;
%       angle(k) = atan2(Xlist(k)-ytemp(end),Ylist(k)-xtemp(end))./pi.*180;
%    end
% 
%      for l=1:360
%         ind=dsearchn(angle',l-180);
%         dist(l)=d(ind);
%     end
%     if j==1
%         dist_list=dist;
%     else
%         dist_list=[dist_list;dist];
%     end
%     %%fft
%     abfft(j,:)=abs(fft(dist_list(j,:)));
%     maxfft(j)=max(abfft(j,350:360));
% end
% 
%     
% end
% %L01(L01>0)=1;
% figure,imshow(L01/4);
%   for l=1:length(stats)
%         CentroidX = stats( l , 1 ).Centroid(1) - 12;
%         CentroidY = stats( l , 1 ).Centroid(2);
% %        text(CentroidX,CentroidY,num2str(round(maxfft(l))),'color','w','fontsize',10);
% %        text(CentroidX,CentroidY,num2str(l),'color','w','fontsize',10);
%         text(CentroidX,CentroidY,num2str(stats(l,1).MajorAxisLength./stats(l,1).MinorAxisLength),'color','w','fontsize',10);
%   end  
end
end
%rotate
%imshow(imcrop(rotimg,[cent(1)-maj/2*1.1 cent(2)-minr/2*1.1 maj minr]));