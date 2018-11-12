function preTable = getLabelset(outputs,criway,cons,sita)

switch criway
    case 1
        % Top criterion
         preTable = -ones(size(outputs));
         for i = 1:size(outputs,2)
            output = outputs(:,i);
            [~,index]=max(output);
             if(max(output) <= 0) 
                 preTable(index,i) = 1;
             else
                 preTable(output>0,i) = 1;
             end 
         end
         
    case 2
        % Dynamic criterion
        cons = sum(cons)/length(cons);
        sita = sum(sita)/length(sita);
        preTable = -ones(size(outputs));
        for i = 1:size(outputs,2)
            output = outputs(:,i);
            [maxi,index]=max(output);
            if(max(output) <= 0) 
                 preTable(index,i) = 1;
            else
                 preTable(output>cons,i) = 1;
                 preTable(output>=maxi*sita,i) = 1;
            end 
        end
end
    