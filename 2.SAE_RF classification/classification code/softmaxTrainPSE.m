function [softmaxModel] = softmaxTrainPSE(inputSize, numClasses, lambda, inputData, labels, options)
%softmaxTrain Train a softmax model with the given parameters on the given
% data. Returns softmaxOptTheta, a vector containing the trained parameters
% for the model.
%
% inputSize: the size of an input vector x^(i)
% numClasses: the number of classes 
% lambda: weight decay parameter
% inputData: an N by M matrix containing the input data, such that
%            inputData(:, c) is the cth input
% labels: M by 1 matrix containing the class labels for the
%            corresponding inputs. labels(c) is the class label for
%            the cth input
% options (optional): options
%   options.maxIter: number of iterations to train for

if ~exist('options', 'var')
    options = struct;
end

if ~isfield(options, 'maxIter')
    options.maxIter = 200;
end

% initialize parameters
% theta = 0.005 * randn(numClasses * inputSize, 1);
theta = 0.005 * rand(numClasses * inputSize, 1);

% Use minFunc to minimize the function
% addpath minFunc/
% options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost
%                           % function. Generally, for minFunc to work, you
%                           % need a function pointer with two outputs: the
%                           % function value and the gradient. In our problem,
%                           % softmaxCost.m satisfies this.
% minFuncOptions.display = 'on';

[softmaxOptTheta, cost] = softmaxCostPSE(theta, ...
                                   numClasses, inputSize, lambda, ...
                                   inputData, labels);                                   
                               
                          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[R,Q] = size(inputData);
%PSO 优化
D =numClasses * inputSize; %问题维数
bounds = [-1, 1]; %初始范围
xl=-1;
xh=1;
Vmax = 2; %最大速度
popsize = 40; %种群规模
eranum = 40; %最大迭代次数
w = 0.82; %惯性权重
c1 = 2; %学习因子1
c2 = 2; %学习因子2
fmax=1;
fmin=0;
A0=1;
Amin=0;
aa=0.9;
c=0.9;
% ee=0.3;
r0=0.99;
friend=20;

    
        
    

%初始化种群
for i = 1:popsize
    x(i,:) = (rand(1,D)-0.5)*(bounds(2)-bounds(1));
    v(i,:) = (rand(1,D)-0.5)*Vmax;
    r(i)=rand;
    bk(i)=rand;
    ee(i)=(rand-0.5)*2;
   A(i)=A0;
   f(i)=fmin;
%    IW = reshape(x(1:hiddenSizeL1 * inputSize), hiddenSizeL1, inputSize);
end

popx = x;%单个粒子历史最优位置
x2=x';
bestvalue = zeros(1,popsize);%单个粒子历史最优适应值
BestPopx = x(1,:);%群体历史最优解对应位置
[softmaxOptTheta, cost] = softmaxCostPSE(x2(:,1), ...
                                   numClasses, inputSize, lambda, ...
                                   inputData, labels);    
Trace = cost;%群体历史最优解
i = 1;
while i <= eranum
    %计算适应值,更新各粒子的最优位置、最优值和群体历史最优位置、最优值
    for j = 1:popsize
        [softmaxOptTheta, cost] = softmaxCostPSE(x2(:,j), ...
                                   numClasses, inputSize, lambda, ...
                                   inputData, labels);   
        value(j) = cost;
        if value(j)<bestvalue(j)
            bestvalue(j) = value(j);
            popx(j,:) = x(j,:);
        end
        if value(j)<Trace
            Trace = value(j);
            BestPopx = x(j,:);
        end
    end
    
    %更新粒子的位置和速度
%      Asum=0;
%     for j = 1:popsize
%          f(j)=(340/(340-v(j,1)))*((340+v(j,1))/340)*f(j);
%         if (f(j)<0)
%             f(j)=0;
%         end
%        if (f(j)>=1)
%             f(j)=1;
%         end
% %         f(j)=fmin+(fmax-fmin)*rand;
%         v(j,:)=w*v(j,:)+( BestPopx-x(j,:))*f(j);
% %     v(j,:)=w*v(j,:)+( BestPopx-x(j,:))*f(j);
%     x(j,:)=0.9*x(j,:)+v(j,:);
%     for k=1:1:D
%     if (x(j,k)<xl)
%             x(j,k)=xl;
%         end
%         if (x(j,k)>xh)
%             x(j,k)=xh;
%         end
%         end
    Asum=0;
    for j = 1:popsize
        f(j)=fmin+(fmax-fmin)*rand;
        v(j,:)=w*v(j,:)+( BestPopx-x(j,:))*f(j);
%     v(j,:)=w*v(j,:)+( BestPopx-x(j,:))*f(j);
    x(j,:)=0.9*x(j,:)+v(j,:);
    for k=1:1:D
    if (x(j,k)<xl)
            x(j,k)=xl;
        end
        if (x(j,k)>xh)
            x(j,k)=xh;
        end
        end
%         m = rand;
%         n = rand;
%         v(j,:) = w*v(j,:) + c1*m*(popx(j,:)-x(j,:)) + c2*n*(BestPopx-x(j,:));
%         x(j,:) = x(j,:) + v(j,:);
Asum=Asum+A(j);
    end
%----------------------------------------------------------增加
   nf1=0;
    for j=1:popsize
%     nf1=0;
    xc=0;
    At=0;
%     for h=1:popsize
       
       if(rand>r(j))
       nf1=nf1+1;
%        xc=xc+x(h,:);
%        At=At+A(h);
        Xi(nf1,:)=x(j,:)+ee(j)*(Asum/popsize);
        X2=Xi';
       end
%     end
%     if(nf1>1)
%      xc=xc/nf1;
%      At1=At/nf1;
%      if((fitness(xc, D))<(fitness(x(j,:), D)))
% %         Xinext1=Xi+ee*At1;%step*(Xc-Xi)/norm(Xc-Xi);
%          x(j,:)=x(j,:)+ee(j)*At1;                   %+rand*step*(Xc-Xi)/norm(Xc-Xi);
% %           else
% %        Xinext1=x(j,:);
%      end
%      
%     end
    end
     for j=1:popsize
%     
%         if (fitness(x(j,:), D)<Trace)
%          BestPopx =x(j,:);
%          Trace=fitness(x(j,:), D);
%          %        A(i)=a*(A(i))^k;
% %        r(i)=r(i)*(1-exp(-c*k));%要搜到最优解才更新
%         end
x2=x';
[softmaxOptTheta, COST] = softmaxCostPSE(x2(:,j), ...
                                   numClasses, inputSize, lambda, ...
                                   inputData, labels);   
     if((rand<A(j)) &(COST<Trace))
         BestPopx =x(j,:);
         Trace=COST;
            A(j)=aa*(A(j))^(i);
           r(j)=r(j)*(1-exp(-c*i));%要搜到最优解才更新
%         Xinext2=Xi+ee*A(i);
   end
     end
    
     for j = 1:nf1
         [softmaxOptTheta23, cost] = softmaxCostPSE(X2(:,j), ...
                                   numClasses, inputSize, lambda, ...
                                   inputData, labels);   
        value1(j) = cost;
            if value1(j)<Trace
            Trace = value1(j);
%             BestPopx = Xi(j,:);
            softmaxOptTheta=softmaxOptTheta23;
            end
     end
%--------------------------------------------------------------------------------
i = i+1
    gen(i)=i;
    min(i)=Trace;
end
% Fold softmaxOptTheta into a nicer format
softmaxModel.optTheta = reshape(softmaxOptTheta, numClasses, inputSize);
softmaxModel.inputSize = inputSize;
softmaxModel.numClasses = numClasses;
                          
end                          
