function  [gene fitness] = EM_ga_a(gene,img01,img02,img03,img04,img05,img06,img07,img08,img09,img10,dot01,dot02,dot03,dot04,dot05,dot06,dot07,dot08,dot09,dot10)
p=parpool(4);

% variables

string_size = 18;
mutation_ratio = 0.01;
gene_number = 10;
genertion_number = 10;


% for i = 1:gene_number
%     gene(i,:) = randi([0 1], string_size, 1);
% end


for iter = 1:genertion_number
    
    for num = 1:gene_number
        
        % selection - roulette wheel
        
        k = 3;
        Cw = 0;
        Cb = 1;
        Ci = 0;
        
        % find cost
        for n = 1:gene_number
            Ci = 1 - EM_fitness_sum(gene(n,:),img01,img02,img03,img04,img05,img06,img07,img08,img09,img10,dot01,dot02,dot03,dot04,dot05,dot06,dot07,dot08,dot09,dot10);
            
            if Ci > Cw
                Cw = Ci;
            end
            
            if Ci < Cb
                Cb = Ci;
            end
        end
        
        for n = 1:gene_number
            Ci = 1 - EM_fitness_sum(gene(n,:),img01,img02,img03,img04,img05,img06,img07,img08,img09,img10,dot01,dot02,dot03,dot04,dot05,dot06,dot07,dot08,dot09,dot10);
            f(n,1) = (Cw - Ci) + (Cw - Cb)/(k-1);
        end
        
        sizeGene = length(f);
        sum_of_fitness = 0;
        for i = 1:sizeGene
            sum_of_fitness = sum_of_fitness + f(i);
        end
        
        % find father
        point = randi([0 fix(sum_of_fitness)],1,1);
        sum = 0;
        for i = 1:sizeGene
            sum = sum + f(i);
            if point < sum
                break;
            end
        end
        parent1 = gene(i,:);
        
        % find mother
        point = randi([0 fix(sum_of_fitness)],1,1);
        sum = 0;
        for i = 1:sizeGene
            sum = sum + f(i);
            if point < sum
                break;
            end
        end
        parent2 = gene(i,:);
        
        % Cross-over - 2-points cross-over
        point1 = randi([1 string_size-1],1,1);
        point2 = randi([point1+1 string_size],1,1);
        
        for i = 1:string_size
            if i < point1
                gene_new(num,i) = parent1(1,i);
            elseif point1 <= i && 1 <= point2
                gene_new(num,i) = parent2(1,i);
            else
                gene_new(num,i) = parent1(1,i);
            end
        end
        
        % Mutation
        
        for i = 1:string_size
            if rand < mutation_ratio
                gene_new(num,i) = ~gene_new(num,i);
            end
        end
    end % end of generation
    
    % Replacement
    for num = 1:gene_number
        %old = EM_fitness_sum(gene(num,:),img01,img02,img03,img04,img05,dot01,dot02,dot03,dot04,dot05);
        %new = EM_fitness_sum(gene_new(num,:),img01,img02,img03,img04,img05,dot01,dot02,dot03,dot04,dot05);
        
        %if old < new 
            gene(num,:) = gene_new(num,:);
        %end
    end

    % Calculate Fitness
    fitness_max = 0;
    fitness_sum = 0;
    fitness_avg = 0;
    
    for num = 1:gene_number
        fitness(num) = EM_fitness_sum(gene(num,:),img01,img02,img03,img04,img05,img06,img07,img08,img09,img10,dot01,dot02,dot03,dot04,dot05,dot06,dot07,dot08,dot09,dot10);
        if fitness_max < fitness(num)
            fitness_max = fitness(num);
        end
        fitness_sum = fitness_sum + fitness(num);
    end
    
    fitness_avg = fitness_sum / gene_number;
    
    figure(1)
    subplot(211)
    plot(iter, fitness_avg, '*', iter, fitness_max, 'o');
    grid on;
    hold on;
    xlabel('generation');
    ylabel('fitness');
    title('tracking step by step');
    
    track(iter,1) = fitness_avg;
    track(iter,2) = fitness_max;
    
    % Stop condition
    if fitness_avg >= 18
        break;
    end
delete(p);

end