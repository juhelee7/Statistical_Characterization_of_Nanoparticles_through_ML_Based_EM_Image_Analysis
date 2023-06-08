function L02=imposttre(img,n,original_img)
% img : , n : filename, original_img : 

%figure(2),imshow(img);

%[r c]=ginput(2);   % scale
%r=2;c=3; %scale 
bw=3;%temporary
%bw=r(1,1)-r(2,1);

if bw <=0
    bw=-bw;
end
%answer = inputdlg('input scale  :', 'Input', 1, {'0'});
acscale=0.003;%scale temporary
%acscale= str2num( answer{1} );
%scale=acscale/sum(bw); % temporary
%%
scale=0.0979; % x40000, 2048*2048 case
% img=edge(img,'log');
% img=imfill(img,6,'holes');
% imb=bwareafilt(img,[5000 500000]);

ime=img;
[N M]=size(ime);
ImEdge = ones( N+8 , M+8 );
ImEdge( 9:end-8 , 9:end-8 ) = ime( 5:end-4 , 5:end-4 );

[ L num ] = bwlabel( ImEdge);
ImEdge( L==1 ) = 0;
img = ImEdge( 5:end-5 , 5:end-5 );

% imshow(imb);
% imshow(imfill(imdilate(edge(testimg,'log'),se1),6,'holes'));
img(img>0)=1;
img=bwareafilt(logical(img),[50 5000000]);

se1=strel('disk',10);
se=strel('disk',10);

im1=imerode(img,se1);
im2=imdilate(im1,se);
%im3=imfill(im2,'holes');

L01=bwlabel(im2);
countim=max(max(L01));
Cim=L01;
Cim(Cim>0)=1;
im5=0;
tim5=0;
stats = regionprops( L01 ,'EquivDiameter','Perimeter');
for i=1:countim

    Cim=(L01==i);
    if stats(i,1).EquivDiameter/stats(i,1).Perimeter<=0.2
     Cim(Cim>0)=1;
     im4=segmentNP(Cim);
     tim4=1;
    else
          im4=(L01==i);
     tim4=0;
    end
    im5=uint8(im5)+uint8(im4);
    tim5=tim5+tim4;
%     finalimshow(im5);
end
tim5;
%figure(1),imshow(im5,[]);
img=im5;
img(img>0)=1;
L01=bwareafilt(logical(img),[1000 5000000],4);
L01=bwlabel(L01,4);
L02=L01;
L02(L02>0)=1;
% figure(2),imshow(L02/8); hold on
% B=(bwboundaries((L02),'noholes'));
% for k = 1:length(B)
%    boundary = B{k};
%    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
% end
% 
% stats = regionprops( L01 ,'Centroid','EquivDiameter','Perimeter');
%  
%    
%   for l=1:length(stats)
%         CentroidX = stats( l , 1 ).Centroid(1) - 12;
%         CentroidY = stats( l , 1 ).Centroid(2);
% %         k=stats(l,1).Eccentricity/stats(l,1).Perimeter;
%         k=stats(l,1).EquivDiameter/stats(l,1).Perimeter;
%         text(CentroidX,CentroidY,num2str(k),'color','w','fontsize',15);
%   end
% max(max(bwlabel(L01)))
%figure,imshow(label2rgb(L01,'jet','k','shuffle'));
%imshow(im5,[]);
% imshow(im5,[]);
% figure,imshow(im1);figure,imshow(im2);figure,imshow(img);

% imshow(img>=max(max(img)*0.2));
% img0=img;
% img0(img0>0)=1;
% imDel01=img;
%stats01 = regionprops(img0,'Solidity');


% for k = 1:length(stats01)
%   if curv2(L01==k) == 1
%          imDel01(L01 == k) = 0;
%   end
% end
%[L01 num01]= bwlabel(imDel01);

% figure,imshow(imDel01);
max(max(L01));
fn=sprintf('01%s',n);
L01l=label2rgb(L01,'jet','k','shuffle');
%imwrite(L01l,[num2str(n),'.jpg']);

%  exitSel = 1;
% while exitSel == 1   
%     
%    L01=bwlabel(L01);
    stats = regionprops( L01 ,'Centroid','Solidity','MajorAxisLength','MinorAxisLength','Area');
%    k002=L01; 
%    k002(k002>0)=1;
%    figure(6),imshow(L01l);
% %  %   hold on
% %     for l=1:length(stats)
% %         CentroidX = stats( l , 1 ).Centroid(1) - 12;
% %         CentroidY = stats( l , 1 ).Centroid(2);
% %         text(CentroidX,CentroidY,num2str(l),'color','w','fontsize',10);
% %     end
%     %answer = inputdlg('Would You Like to Remove a particle :', 'Input', 1, {'0'});
% 
%     [x,y] = ginputc(1, 'Color', 'r', 'LineWidth', 3)    ;
%     x=uint16(x);
%     y=uint16(y);
%     lremove= L01l(y,x);
%    L01(L01==lremove)=0;
%  %  stats = stats( [1:lremove-1 lremove+1:end] , 1 );
%     if lremove == 0    
%          exitSel = 0;  
%     end
% 
%     
%     %figure(6),imshow(k002);
% end

%L02 = bwlabel(k002);
L02=L01;
L02(L02>1)=1;
%figure(7),imshow(L01l/2);

 % stats = regionprops( L02 ,'Centroid','Solidity','MajorAxisLength','MinorAxisLength');
 
  for l=1:length(stats)
        CentroidX = stats( l , 1 ).Centroid(1) - 12;
        CentroidY = stats( l , 1 ).Centroid(2);
        text(CentroidX,CentroidY,num2str(l),'color','w','fontsize',15);
  end
  


%  exitSel = 1;
%   while exitSel == 1   
% 
%       
% 
%     answer = inputdlg('Would You Like to Save : Yes', 'Input', 1, {'0'});
%     lremove= str2num( answer{1} );
%    
% %    if lremove == 0
%         name='Nanorod';   
% %        [file,path] = uiputfile('*.txt','Save data As'a)
%         file=n;
%         if (file ~=0)
%             fname=sprintf('%d.txt',file);
%              fileID=fopen(fname,'w');
%              fprintf(fileID,'Number\tSolidity\tMajorAxisLength\tMinorAxisLength\tArea\n');
% 
%              for n = 1:length(stats)
% 
%                 fprintf(fileID,'%.0f\t',n);
%                 fprintf(fileID,'%f\t',stats(n,1).Solidity);
%                 fprintf(fileID,'%f\t',stats(n,1).MajorAxisLength*scale);
%                 fprintf(fileID,'%f\t',stats(n,1).MinorAxisLength*scale);
%                 fprintf(fileID,'%f\t',stats(n,1).Area*scale/10);
% 
%                 fprintf(fileID,'\n');
%              end
%              fclose(fileID);
%              
%          else
%          return
%          exitSel = 0;  
%          end
%       end
end
