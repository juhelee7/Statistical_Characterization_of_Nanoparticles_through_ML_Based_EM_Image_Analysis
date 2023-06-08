function [ y ] = EM_fitness_one (x,img,dot01)
% binary -> 10?????? ??????
x(1)=x(1)*8;
x(2)=x(2)*4;
x(3)=x(3)*2;

x(5)=x(5)*16;
x(6)=x(6)*8;
x(7)=x(7)*4;
x(8)=x(8)*2;

x(11)=x(11)*4;
x(12)=x(12)*2;

x(14)=x(14)*4;
x(15)=x(15)*2;


% input ???????? centroid ?????? dot image?? ????    / dot image ?? dot ???? counting
%  50 % ???????? ???? ???? (?????? 0??)
img=255-img;

if sum(x(1:4))==0 && sum(x(1:4))==1 && sum(x(1:4))>11      %%% clear
    
    if x(9)==0;
    img=imclearborder(img,4);
    elseif x(9)==1;
    img=imclearborder(img,8);
    end

elseif sum(x(1:4))==2                                 %%%% clear hist
    
    if x(9)==0;
    img=imclearborder(img,4);
    elseif x(9)==1;
    img=imclearborder(img,8);
    end
    
    img=histeq(img);
        
elseif sum(x(1:4))==3                                    %% clear low 
    
    if x(9)==0;
    img=imclearborder(img,4);
    elseif x(9)==1
    img=imclearborder(img,8);  
    end
    
    S=double(sum(x(5:9))+3);
    img = uint8(conv2( double(img) , ones(S,S)/S^2 , 'same' ));
    
elseif sum(x(1:4))==4                                     % low clear
    
    S=double(sum(x(5:9))+3);
    img = uint8(conv2( double(img) , ones(S,S)/S^2 , 'same' ));
    
    if x(9)==0;
    img=imclearborder(img,4);
    elseif x(9)==1;
    img=imclearborder(img,8);  
    end

elseif sum(x(1:4)) == 5                                     % hist clear
    
    img=histeq(img);
    
    if x(9)==0;
    img=imclearborder(img,4);
    elseif x(9)==1;
    img=imclearborder(img,8);  
    end
    
elseif sum(x(1:4)) == 6                                     % low hist clear
    
    S=double(sum(x(5:9))+3);
    img = uint8(conv2( double(img) , ones(S,S)/S^2 , 'same' ));
    img=histeq(img);
    
    if x(9)==0;
    img=imclearborder(img,4);
    elseif x(9)==1;
    img=imclearborder(img,8);  
    end
    
    
elseif sum(x(1:4)) == 7                                     % low clear hist
    
    S=double(sum(x(5:9))+3);
    img = uint8(conv2( double(img) , ones(S,S)/S^2 , 'same' ));
    if x(9)==0;
    img=imclearborder(img,4);
    elseif x(9)==1;
    img=imclearborder(img,8);  
    end

    img=histeq(img);

elseif sum(x(1:4)) == 8                                %hist low clear
    
    img=histeq(img);
     S=double(sum(x(5:9))+3);
    img = uint8(conv2( double(img) , ones(S,S)/S^2 , 'same' ));
    if x(9)==0;
    img=imclearborder(img,4);
    elseif x(9)==1;
    img=imclearborder(img,8);  
    end
    
elseif sum(x(1:4)) == 9                               %hist clear low
    
        img=histeq(img);


    if x(9)==0;
    img=imclearborder(img,4);
    elseif x(9)==1;
    img=imclearborder(img,8);  
    end
    
     S=double(sum(x(5:9))+3);
    img = uint8(conv2(double (img) , ones(S,S)/S^2 , 'same' ));
elseif sum(x(1:4)) == 10                                %   clear hist low
    
    if x(9)==0;
    img=imclearborder(img,4);
    elseif x(9)==1;
    img=imclearborder(img,8);
    end
    
        img=histeq(img);
    
         S=double(sum(x(5:9))+3);
    img = uint8(conv2(double (img) , ones(S,S)/S^2 , 'same' ));
else%if sum(x(1:4)) == 11                                %   clear low hist
    
    if x(9)==0;
    img=imclearborder(img,4);
    elseif x(9)==1;
    img=imclearborder(img,8);
    end
    
         S=double(sum(x(5:9))+3);
    img = uint8(conv2(double( img) , ones(S,S)/S^2 , 'same' ));
        img=histeq(img);
    
end

%% find particle

sigma = sum(x(11:13))+1 ;
sigma(sigma>5)=2;

if sum(x(14:16))==0 && sum(x(14:16))==5 && sum(x(14:16))==7      %% log
    
    if sum(x(11:13))==0       
         [BW t] = edge(img,'log');
    else
        [BW t] = edge(img,'log',0,sigma);
    end
    
elseif sum(x(14:16))==1                                         % sobel
    
    [BW t] = edge(img,'Sobel');
elseif sum(x(14:16))==2                                       % prewitt
    
    [BW t] = edge(img,'prewitt');

elseif sum(x(14:16))==3                                       % roberts
    
    [BW t] = edge(img,'prewitt');
    
elseif sum(x(14:16))==4                                       % canny
    
    if sum(x(11:13))==0     
         [BW t] = edge(img,'canny');
    else
        [BW t] = edge(img,'canny',0,sigma);
    end
    
else%if sum(x(14:16))==6                                       % zerocross
 
    if sum(x(11:13))==0       
         [BW t] = edge(img,'zerocross');
    else
        [BW t] = edge(img,'zerocross',sigma-1);
    end
 
end


%% closed shapes
imf=x(18)*2+4;
BW_fill_filter = imfill(BW,imf,'holes');
 
%% ???? ???? ?????? 
%BW_fill_filter = bwareafilt(BW_fill, [500 5000000]);
  
%% labeling
L01 = bwlabel(BW_fill_filter);
 
%% find solidity 
  stats01 = regionprops(L01,'Solidity');
%% solidity & curv2
imDel01=BW_fill_filter;

if x(17)==0    
 for k = 1:length(stats01)
     if stats01(k).Solidity <.80
          imDel01( L01 == k ) = 0;
     end
%     if curv2(L01==k) == 1
%         imDel01(L01 == k) = 0;
%     end
 end
else
     for k = 1:length(stats01)
     if stats01(k).Solidity <.90
          imDel01( L01 == k ) = 0;
     end
%     if curv2(L01==k) == 1
%         imDel01(L01 == k) = 0;
%     end
     end    
end

%% ???? labeling
[L01 num01]= bwlabel(imDel01);
% input ???????? centroid ?????? dot image?? ???????? ????????    / dot image ?? dot ???? counting
%  50 % ???????? ???? ???? (?????? 0??)

% dot ?????? labeling

dot01=bwlabel(dot01);

% Centroid ???????? 

 stats01 = regionprops(L01,'Centroid');
%  figure(1),imshow(L01)
%  figure(2),imshow(L02)
%  figure(3),imshow(L03)
%  figure(4),imshow(L04)
%  figure(5),imshow(L05)
%  figure(11),imshow(dot01)
%  figure(12),imshow(dot02)
%  figure(13),imshow(dot03)
%  figure(14),imshow(dot04)
%  figure(15),imshow(dot05)
 %% input ???????? centroid ?????? dot image?? ???????? ?? ???? 
 imcont01=0;
 
 for k1 = 1:length(stats01)
       a=fix(stats01(k1).Centroid);
    if dot01(a(2),a(1))>.0
          imcont01=imcont01+1;
    end
 end   
%  input ???????? centroid ?????? dot image?? ???????? ?????? /  dot image ?? dot ???? counting
%  50 % ???????? ???? ???? (?????? 0??)

fg01=imcont01/length(stats01);
% if fg01>0;
%     fg01=fg01;
% else
%     fg01=0;
% end
if imcont01<=1;
    fg01=0;
end

%input ???????? centroid ?????? dot image?? ???? / input image ??  label?? ???? ????
%  ???? (???? 1)

% if fg01<0.001
%     g01=0;
% else
%     g01=imcont01/length(stats01);
% end
% if fg02<0.001
%     g02=0;
% else
%     g02=imcont02/length(stats02);
% end
% if fg03<0.001
%     g03=0;
% else
%     g03=imcont03/length(stats03);
% end
%  if fg04<0.001
%      g04=0;
%  else
%      g04=imcont04/length(stats04);
%  end
% if fg05<0.001
%     g05=0;
% else
%     g05=imcont05/length(stats05);
% end


y=fg01;

     
end
 
 