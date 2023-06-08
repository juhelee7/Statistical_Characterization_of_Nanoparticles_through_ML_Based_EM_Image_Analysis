function [ind1_re]=all_sumimg(dist_list,idx_all)
for i=1:length(dist_list)
    for j=1:length(dist_list{i})
    line(i,j)=max(dist_list{i}{j});
    end
end
max_line=max(max(line));
img=zeros(round(max_line*50),round(max_line*50));
x_cent=round(length(img(1,:))/2);
y_cent=round(length(img(:,1))/2);
%length(idx_all);
%for i=1:length(ind1{1})
numb=0;pre_numb=0;[N M]=size(img)
ind1_sum=zeros(N,M);ind2_sum=zeros(N,M);ind3_sum=zeros(N,M);ind3_sum=zeros(N,M);ind4_sum=zeros(N,M);
ind5_sum=zeros(N,M);ind6_sum=zeros(N,M);ind7_sum=zeros(N,M);
% for i2=1:max(idx_alla)
%    eval(sprintf('f_idx%d=find(idx_alla==%d)',i2,i2));
% end
%    f_idx1=find(idx_alla==1);
%     %f_idx2=find(idx_all==2);
%     f_idx3=find(idx_alla==3);
%     f_idx4=find(idx_alla==4);
%     f_idx5=find(idx_alla==5);
%     f_idx6=find(idx_alla==6);
%     f_idx7=find(idx_alla==7);
for k=1:length(dist_list)
% for k=1:2   
     k
    for i=1:length(dist_list{k}) 
         ind1_re(:,:,i)=mirkin2shape(dist_list,k,i,img,x_cent,y_cent);
    end    
   numb=numb+i
   pre_numb+1
   idx_alla=idx_all(1,[1+pre_numb:numb]);
    pre_numb=pre_numb+i;
    [N M L]=size(ind1_re(:,:,idx_alla==1));
    if length(find(idx_alla==1)) ~= 0
     ind1_1=ind1_re(:,:,idx_alla==1);
        for i=1:length(find(idx_alla==1))
        ind1_sum=ind1_sum+ind1_1(:,:,i);
        end 
    end   
%    if f_idx3 ~= 0
    if length(find(idx_alla==2)) ~=0
        ind1_2=ind1_re(:,:,idx_alla==2);
        for i=1:length((find(idx_alla==2)))
        ind2_sum=ind2_sum+ind1_2(:,:,i);
        end
    end
    if length(find(idx_alla==3)) ~=0
        ind1_3=ind1_re(:,:,idx_alla==3);
        for i=1:length((find(idx_alla==3)))
        ind3_sum=ind3_sum+ind1_3(:,:,i);
        end
    end
    if length(find(idx_alla==4)) ~=0
        ind1_4=ind1_re(:,:,idx_alla==4);
        for i=1:length((find(idx_alla==4)))
        ind4_sum=ind4_sum+ind1_4(:,:,i);
        end
    end
    if length(find(idx_alla==5)) ~=0
        ind1_5=ind1_re(:,:,idx_alla==5);
        for i=1:length((find(idx_alla==5)))
        ind5_sum=ind5_sum+ind1_5(:,:,i);
        end
    end
     if length(find(idx_alla==6)) ~=0
        ind1_6=ind1_re(:,:,idx_alla==6);
        for i=1:length((find(idx_alla==6)))
        ind6_sum=ind6_sum+ind1_6(:,:,i);
        end
     end
     if length(find(idx_alla==7)) ~=0
        ind1_7=ind1_re(:,:,idx_alla==7);
        for i=1:length(length(find(idx_alla==7)))
        ind7_sum=ind7_sum+ind1_7(:,:,i);
        end
    end
%     [N M]=size(ind1_re(:,:,1));
%     for i1=1:M
%         for i2=1:N
%             if (rem(i1,4)==0)
%                 ind1_re(i2,i1,i)=0;
% %             elseif (rem(i2,3)==0)
% %                 ind1_re(i2,i1,i)=0;
%             end
%         end
%     end
end


%ind2_sum=ind1_2(:,:,1);


figure(1),imshow(255-ind1_sum,[])
figure(2),imshow(255-ind2_sum,[])
figure(7),imshow(255-ind7_sum,[])

figure(3),imshow(255-ind3_sum,[])

figure(4),imshow(255-ind4_sum,[])

figure(5),imshow(255-ind5_sum,[])

figure(6),imshow(255-ind6_sum,[])




