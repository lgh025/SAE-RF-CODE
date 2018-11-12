function [output,Pre_Labels,Model,T,output_train]=CC(train_data,train_target,test_data,test_target)
 % Classifier chain (CC) can solve multi-label classification problem. It
 % transform the multi-label problem into several independent single-label
 % problems, and pass information among labels.Datials for (Read, J., et al. 
 % (2009) Classifier chains for multi-label classification, Machine Learning 
 % and Knowledge Discovery in Databases, 254-269.).Here,support vector machine
 % is used.
 
     disp('CC method');
     [num_class,num_test]=size(test_target);
     [num_class,num_train]=size(train_target);
     
     output=zeros(num_class,num_test);
     output_train=zeros(num_class,num_train);
     
     t = 2;
     gamma = 0.2;
     cost = 10;
     str = ['-t ',num2str(t),' -g ',num2str(gamma),' -c ',num2str(cost),'-b 1'];
     
     x=1:num_class;
     % random order
     x=x(randperm(length(x)));
     Model.num=x;
     
     % train
     for i = 1:num_class
        eval(['Model.model_' num2str(i) ' = svmtrain(train_target(x(i),:)'',train_data,str);']);
        train_data=[train_data,train_target(x(i),:)'];
     end          
            
    % test
     train_data_2 = train_data;
     for i = 1:num_class
         % testing set
         eval(['[predict_label, accuracy, dec_values] = svmpredict(test_target(x(i),:)'', test_data, Model.model_' num2str(i) ');']);
         dec_values = dec_values';
         eval(['if(Model.model_' num2str(i) '.Label(1)==1) output(x(i),:) = dec_values(1,:); else output(x(i),:)=-dec_values(1,:); end']);
         for j = 1:num_test
             if output(x(i),j)<0 
                 dec_values(1,j)=-1;
             else
                 dec_values(1,j)=1;
             end;
         end
         test_data = [test_data,dec_values(1,:)'];
         clear dec_values
         % training set
         eval(['[predict_label, accuracy, dec_values] = svmpredict(train_target(x(i),:)'', train_data_2, Model.model_' num2str(i) ');']);
         dec_values = dec_values';
         eval(['if(Model.model_' num2str(i) '.Label(1)==1) output_train(x(i),:) = dec_values(1,:); else output_train(x(i),:)=-dec_values(1,:); end']);
         for j = 1:num_train
             if output_train(x(i),j)<0 
                 dec_values(1,j)=-1;
             else
                 dec_values(1,j)=1;
             end;
         end
         train_data_2 = [train_data_2,dec_values(1,:)'];
         clear dec_values
     end
     
   % just use top criterion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    % get label set
    for i = 1:length(test_data)
        output_i = output(:,i);
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
    
% % use the intersection of top criterion and threshold criterion %%%%%%%%%% 
%    % get T
%    T = getT(output_train,train_target);
%    
%    % get label set
%     for i = 1:length(test_data)
%         output_i = output(:,i);
%         
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
%           prelabel_2(maximum-output_i<T)=1;
%           Pre_Labels(i,:) = prelabel_1 & prelabel_2;
%           
%           Pre_Labels(i,:) = prelabel_1;
%     end
%     
%     Pre_Labels = single(Pre_Labels);
%     Pre_Labels(Pre_Labels==0)=-1;
%     Pre_Labels = Pre_Labels';