function [y] = EM_fitness_sum (x,img01,img02,img03,img04,img05,img06,img07,img08,img09,img10,dot01,dot02,dot03,dot04,dot05,dot06,dot07,dot08,dot09,dot10)

parfor j=1:4
   if j==1
       [w(j)]=EM_fitness_one(x,img01,dot01);
       [w(j)]=EM_fitness_one(x,img02,dot02);
   elseif j==2
       [w(j)]=EM_fitness_one(x,img03,dot03);
       [w(j)]=EM_fitness_one(x,img04,dot04);
       [w(j)]=EM_fitness_one(x,img05,dot05);
   elseif j==3
       [w(j)]=EM_fitness_one(x,img06,dot06);
       [w(j)]=EM_fitness_one(x,img07,dot07);
   elseif j==4
       [w(j)]=EM_fitness_one(x,img08,dot08);       
       [w(j)]=EM_fitness_one(x,img09,dot09);
       [w(j)]=EM_fitness_one(x,img10,dot10);
   end
end

%y=fix(sum(w)/5)
% [w]=EM_fitness_one(x,img01,dot01);
% [w]=EM_fitness_one(x,img02,dot02);
% [w]=EM_fitness_one(x,img03,dot03);
% [w]=EM_fitness_one(x,img04,dot04);
% [w]=EM_fitness_one(x,img05,dot05);
% [w]=EM_fitness_one(x,img06,dot06);
% [w]=EM_fitness_one(x,img07,dot07);
% [w]=EM_fitness_one(x,img08,dot08);       
% [w]=EM_fitness_one(x,img09,dot09);
% [w]=EM_fitness_one(x,img10,dot10);
y=sum(w)/10;
end
