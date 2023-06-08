function [total_img]=all_sort_7cluster(dist_list,idx_all,cluster7)
for i=1:length(dist_list)
    for j=1:length(dist_list{i})
    line(i,j)=max(dist_list{i}{j});
    end
end
max_line=max(max(line));
img=zeros(round(max_line*50),round(max_line*50));
total_img=zeros(4800,4800);
x_cent=round(length(img(1,:))/2);
y_cent=round(length(img(:,1))/2);
%length(idx_all);
%for i=1:length(ind1{1})
numb=0;pre_numb=0;[N M]=size(img)
ind1_sum=zeros(N,M);ind2_sum=zeros(N,M);ind3_sum=zeros(N,M);ind3_sum=zeros(N,M);ind4_sum=zeros(N,M);
ind5_sum=zeros(N,M);ind6_sum=zeros(N,M);ind7_sum=zeros(N,M);
s_i=1;s_j=1;
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
   page=1;
    if length(find(idx_alla==cluster7)) ~= 0
     ind1_1=ind1_re(:,:,idx_alla==cluster7);
        for i=1:length(find(idx_alla==cluster7))
            if s_i>4801
                s_j=s_j+200;
                s_i=1;
            end
            if s_j==4801
                s_i=1;
                s_j=1;
                page=page+1;
            end
            resize_img=imresize(ind1_1(:,:,i),[200 200]);
            total_img(s_i:s_i+199,s_j:s_j+199,page)=resize_img;
            s_i=s_i+200;
        end 
    end
    
end


%ind2_sum=ind1_2(:,:,1);


%figure(1),imshow(total_img,[])

