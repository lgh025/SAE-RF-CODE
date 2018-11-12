function g = class_number(input)
% give id to each class
if strcmp(input,'Cytoplasm')
    g=1;
   else 
       if strcmp(input,'ER')
        g=2;
       else                        
         if strcmp(input,'Golgi_apparatus')                           
           g=3;                            
         else   
             if strcmp(input,'Lysosome')
               g=4;
             else
               if strcmp(input, 'Mitochondria')                             
                 g=5;
               else                             
                if strcmp(input,'Nucleus')                               
                  g=6;                                  
                else                              
                 if strcmp(input,'Vesicles')                                  
                   g=7;
                 else
              error( 'please input the correct class.');
          end
         end
       end
     end
   end
 end
end
end




