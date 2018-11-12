function [outputs,T] = getScores(classifierpath,features,cmethod,class)

load(classifierpath,'idx_sda','traindata','model','T');

[traindata,features] = featnorm( traindata, features);
features = double(features*2-1);
features=features(:,idx_sda);
outputs=zeros(class,1);

%  Predict
if (strcmp( cmethod, 'BR'))
    c=1;
    [a, b, dec_values] = svmpredict(c, features, model.Cytopl);
     if(model.Cytopl.Label(1)==1)
        outputs(1)=dec_values;
     else
        outputs(1)=-dec_values;
     end


    [a, b, dec_values] = svmpredict(c, features, model.ER);
     if(model.ER.Label(1)==1)
        outputs(2)=dec_values;
     else
        outputs(2)=-dec_values;
     end
    [a, b, dec_values] = svmpredict(c, features, model.Golgi);
     if(model.Golgi.Label(1)==1)
        outputs(3)=dec_values;
     else
        outputs(3)=-dec_values;
     end
    [a, b, dec_values] = svmpredict(c, features, model.Lyso);
     if(model.Lyso.Label(1)==1)
        outputs(4)=dec_values;
     else
        outputs(4)=-dec_values;
     end
    [a, b, dec_values] = svmpredict(c, features, model.Mito);
     if(model.Mito.Label(1)==1)
        outputs(5)=dec_values;
     else
        outputs(5)=-dec_values;
     end
    [a, b, dec_values] = svmpredict(c, features, model.Nucleus);
     if(model.Nucleus.Label(1)==1)
        outputs(6)=dec_values;
     else
        outputs(6)=-dec_values;
     end
    [a, b, dec_values] = svmpredict(c, features, model.Vesi);
     if(model.Vesi.Label(1)==1)
        outputs(7)=dec_values;
     else
        outputs(7)=-dec_values;
     end
end

if (strcmp( cmethod, 'CC'))
    order=model.num;
    c=1; 
    for i = 1:class
        eval(['[a,b,dec_values] = svmpredict(c, features, model.model_' num2str(i) ');']);
        eval(['if(model.model_' num2str(i) '.Label(1)==1) outputs(order(' num2str(i) '))=dec_values; else outputs(order(' num2str(i) '))=-dec_values; end']);
        eval(['if outputs(order(' num2str(i) '))<0 dec_values=-1; else dec_values=1; end']); 
        features=[features,dec_values];
    end
end

 return