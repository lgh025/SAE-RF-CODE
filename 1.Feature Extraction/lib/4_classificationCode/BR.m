function [Outputs,Pre_Labels,Model,T,Outputs_train]=BR(train_data,train_target,test_data,test_target)
 % Binary relevance (BR) can solve multi-label classification problem. It
 % transform the multi-label problem into several independent single-label
 % problems.Datials for (Boutell, M.R., et al. (2004) Learning multi-label 
 % scene classification, Pattern recognition, 37, 1757-1771.). Here,
 % support vector machine is used.
     
     disp('BR method');
     [~,num_train]=size(train_target);
     [num_class,num_test]=size(test_target);
     
     Outputs=zeros(num_class,num_test);
     Outputs_train = zeros(num_class,num_train);

               
     for i=1:num_class   
        c = 2.^[-5:1:10];  
        g = 2.^[-5:1:2];  
        acc_cv = zeros(length(c),length(g));
        % Brute force grid search
        for m=1:length(c),
         tic;
         for n=1:length(g),
            options = ['-c ' num2str(c(m)) ' -g ' num2str(g(n)) '-v 10'];
            model_b= svmtrain( train_target(i,:)', train_data, options);
            [predict_b, accuracy_b, dec_values_b] = svmpredict(test_target(i,:)', test_data, model_b);
            acc_cv(m,n)=accuracy_b(1);
         end
         toc
         disp([m length(c)]);
        end

           [a row] = max(acc_cv);
           [a col] = max(a);
           row = row(col);

         str= ['-c ' num2str(c(row)) ' -g ' num2str(g(col)) ' -b 1'];
         model=svmtrain(train_target(i,:)',train_data,str);
         
          % predict testing set
         [predict_label, accuracy, dec_values] = svmpredict(test_target(i,:)', test_data, model);
         dec_values=dec_values';
         if(model.Label(1)==1)
             Outputs(i,:)=dec_values(1,:);
         else
             Outputs(i,:)=-dec_values(1,:);
         end
         
         % predict training set
         [predict_label, accuracy, dec_values] = svmpredict(train_target(i,:)', train_data, model);        
         dec_values=dec_values';
         if(model.Label(1)==1)
             Outputs_train(i,:)=dec_values(1,:);
         else
             Outputs_train(i,:)=-dec_values(1,:);
         end
         
         
         if i==1
             Model.Cytopl=model;
         end
         if i==2
             Model.ER=model;
         end
         if i==3
             Model.Golgi=model;
         end
         if i==4
             Model.Lyso=model;
         end
         if i==5
             Model.Mito=model;
         end
         if i==6
             Model.Nucleus=model;
         end
         if i==7
             Model.Vesi=model;
         end
     end
 
   % just use top criterion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     for i = 1:length(test_data)
        output_i = Outputs(:,i);  
        prelabel_1 = -zeros(1,7);
        [maximum,index]=max(output_i);
         % Top criterion
         if(max(output_i) <= 0) 
             prelabel_1(index)=1;
         else
             prelabel_1(output_i>0)=1;
         end
         Pre_Labels(i,:) = prelabel_1; 
     end
    Pre_Labels = single(Pre_Labels);
    Pre_Labels(Pre_Labels==0)=-1;
    Pre_Labels = Pre_Labels';
    T = 1.0;
  
% use the intersection of top criterion and threshold criterion %%%%%%%%%%
%    % get T
%    T = getT(Outputs_train,train_target);
%    
%    % get label set
%      for i = 1:length(test_data)
%         output_i = Outputs(:,i);  
%         prelabel_1 = -zeros(1,7);
%         prelabel_2 = -zeros(1,7);
% 
%         [maximum,index]=max(output_i);
%          % Top criterion
%          if(max(output_i) <= 0) 
%              prelabel_1(index)=1;
%          else
%              prelabel_1(output_i>0)=1;
%          end
% 
%           % using threshold
%          prelabel_2(maximum-output_i<T)=1;
%          Pre_Labels(i,:) = prelabel_1 & prelabel_2;
% 
%          Pre_Labels(i,:) = prelabel_1;      
%      end
%     Pre_Labels = single(Pre_Labels);
%     Pre_Labels(Pre_Labels==0)=-1;
%     Pre_Labels = Pre_Labels';