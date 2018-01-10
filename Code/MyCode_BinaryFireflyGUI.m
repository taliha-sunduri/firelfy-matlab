function out=MyCode_BinaryFireflyGUI(params)
   rNo=params.rNo;
   rng(rNo)
   tic

   infile=params.infile;
   treeNo=params.treeNo;
   
   % load arff
   [data, relname, nomspec]=arff_read(infile);
   noGenes=length(fieldnames(data))-1;
   noSamples=size(data,2);
   SNames = fieldnames(data);
   noClass=length(SNames);

   % sort genes according to class label
   ClssTemp={data.(SNames{noClass})}';
   Clss=cellstr(ClssTemp);

   [~,sortOrder]=sortrows(Clss,1);
   data=data(sortOrder);

   ClssTemp={data.(SNames{noClass})}';
   Clss=cellstr(ClssTemp);

   % create numeric class labels
   nValues=size(nomspec.(SNames{noClass}),1);
   ord=cellfun(@num2str,num2cell(1:nValues),'uniformoutput',0);
   valueset=nomspec.(SNames{noClass});
   valueset=sort(valueset);
   C=categorical(Clss,valueset,ord);
   Y=str2double(cellstr(C));
   ord=str2double(cellstr(ord))';

   % Get genes
   Genes=zeros(noSamples,noGenes);
   for i=1:noSamples
      for j=1:noGenes
         Genes(i,j)=data(i).(SNames{j});
      end
   end 

   row=size(Genes,1);
   col=size(Genes,2);

   % Apply filtering

   [N D]=size(Genes);
   clear extra_options
   extra_options.importance = 1; 
   model= classRF_train(Genes,Y, treeNo, sqrt(D), extra_options);
   % model.importance;
   % [GH, J]=sortrows(model.importance,-3);
   impG=model.importanceSD;
   impL=size(impG,2);
   [GH, J]=sortrows(model.importanceSD,-impL);
   % subplot(2,1,1);
   % bar(model.importanceSD(:,end));xlabel('feature');ylabel('magnitude');
   % title('Importance Measure');
   jNo=params.jNo;
   J=J(1:jNo);
   thold=numel(J);
   J=J';
   X=zeros(row,thold);
   % finalTrainLabels=cell(nTrn,1);
   for i=1:thold
      X(:,i)=Genes(:,J(i));
     %finalTrainLabels{i,1}=Y{i,1};
   end

   % Apply classification algorithm to get the overall error for training set
   col=size(X,2);
   Mdl = fitcnb(X,Y,'ClassNames',ord);
   CVMdl = crossval(Mdl);
   nbErrAll=kfoldLoss(CVMdl);

   % Variables and parameters
    
    omega=params.omega;             % Importance of classification performance to the number of features selected
    nF=params.nF;             % Number of fireflies 
    gamma=params.gamma;       % Attractiveness parameter
    alpha=params.alpha;       % Environment noise
    alphaCh=params.alphaCh;   % Rate of change of the randomization factor
    beta0=params.beta0;       % Attraction coefficient //b0=0.2 best result: 0.83333. b0=2 best result:0.88333
    %betamin=0.2;             % According to Yang's fndim code
    nItr=params.nItr;         % Number of iterations
    GRow=[1 col];             % Number of genes as row vector; 
    delta=0.05;               % For randomization factor
    showItr=params.showItr;   % Show iteration flag
    
    % Initialize
    
    f.sGenes=[];       % Selected and unselected genes, array of genes
    f.fitFunc=[];      % Fitness function of selected genes
    f.nGen=[];         % Number of selected genes
    f.Gen=[];          % Selected gene subset
    f.innerGen=[];
    f.FCost=[];        % The error rate of classifier

    swarm=repmat(f,nF,1);      % Create swarm
    bF.fitFunc=inf;            % Initialize fitness function
    bfitFunc=zeros(nItr,1);    % Initialize array of (every iteration's) best fitness functions
    bnGen=zeros(nItr,1);       % Initialize array of #selected genes
    
    for i=1:nF
       % Initialize fireflies
       swarm(i).sGenes=(randi([0 1],col,1))';          
       % If sGenes(i)==1 it is a selected feature
       k=find(swarm(i).sGenes==1);
       swarm(i).innerGen=k;
       swarm(i).Gen=J(k);
       n=numel(k);
       swarm(i).nGen=n;
   
       A=zeros(row,n);
       for p=1:n
          c=k(p);
          A(1:row,p)=X(1:row,c);
       end
       Mdl=fitcnb(A,Y,'ClassNames',ord);
       CVMdl=crossval(Mdl);
       nbErr=kfoldLoss(CVMdl);
       swarm(i).FCost=nbErr;
       swarm(i).fitFunc=(1-omega)*(n/col)+omega*(nbErr/nbErrAll);

       if swarm(i).fitFunc<=bF.fitFunc
          bF=swarm(i);
       end
       clear A;
       clear n;
       clear k;
    end

    % Iterations
    
   for itn=1:nItr
       swarmTemp=repmat(f,nF,1);
       for i=1:nF
          swarmTemp(i).fitFunc=inf;
          for j=1:nF
             if swarm(j).fitFunc<swarm(i).fitFunc
                eucDist=norm(swarm(i).sGenes-swarm(j).sGenes)/sqrt(col);
                beta=beta0*exp(-gamma*eucDist^2);
                %beta=(beta0-betamin)*exp(-gamma*eucDist^2)+betamin;
                e=delta*unifrnd(-1,+1,GRow);
                %xTemp.sGenes=swarm(i).sGenes.*(1-beta)+ beta*rand(GRow).*(swarm(j).sGenes-swarm(i).sGenes)+ alpha*e;
                xTemp.sGenes=swarm(i).sGenes+beta*rand(GRow).*(swarm(j).sGenes-swarm(i).sGenes)+alpha*e;
                            
                % Convert to binary values
                xTemp.sGenes=abs(tanh(xTemp.sGenes));
                maxRand=max(xTemp.sGenes);
                minRand=min(xTemp.sGenes);
               
                lngth=length(xTemp.sGenes);
                for tanind=1:lngth
                     rndNum=rand;
                     while (rndNum>maxRand) || (rndNum<minRand)
                        rndNum=rand;
                     end
                     if xTemp.sGenes(tanind)>rndNum
                        xTemp.sGenes(tanind)=1;
                     else
                        xTemp.sGenes(tanind)=0;
                     end
                end
                     
                k=find(xTemp.sGenes==1);
                xTemp.innerGen=k;
                xTemp.Gen=J(k);
                n=numel(k);
                xTemp.nGen=n;
                A=zeros(row,n);
   
                for p=1:n
                   c=k(p);
                   A(1:row,p)=X(1:row,c);
                end
              
                Mdl=fitcnb(A,Y,'ClassNames',ord);
                CVMdl=crossval(Mdl);
                nbErr=kfoldLoss(CVMdl);
                xTemp.FCost=nbErr;
                xTemp.fitFunc=(1-omega)*(n/col)+omega*(nbErr/nbErrAll);
                
                if xTemp.fitFunc<=swarmTemp(i).fitFunc
                    swarmTemp(i)=xTemp;
                    if swarmTemp(i).fitFunc<=bF.fitFunc
                        bF=swarmTemp(i);
                    end
                end
                clear A;
                clear n;
                clear k;
             end % end for main if
          end % end for j loop
       end % end for i loop
       
       swarm=[swarm 
           swarmTemp];%#ok
       [~, sIndx]=sort([swarm.fitFunc]);
       swarm=swarm(sIndx);
       swarm=swarm(1:nF);
    
       % Add the best values to array
       bfitFunc(itn)=bF.fitFunc;
       bnGen(itn)=bF.nGen;
     
       % Display results 
       if showItr==true
          disp([num2str(itn) ': Best Fitness = ' num2str(bfitFunc(itn)) ': FCost = ' num2str(bF.FCost) '#Genes= ' num2str(bnGen(itn))  ' Gene Subset: ' num2str(bF.Gen)]);
       end
       % Change the alpha
       alpha = alpha*alphaCh;
    end % end for iterations
    arr=bF.innerGen;

    sumN=numel(arr);
    finalTrainSet=zeros(row,sumN);
    % finalTrainLabels=cell(nTrn,1);
    for i=1:sumN
       finalTrainSet(:,i)=X(:,arr(i));
       %finalTrainLabels{i,1}=Y{i,1};
    end

    avg=zeros(100,1);
    for i=1:100
       finalMdl=fitcnb(finalTrainSet,Y);
       finalCVMdl=crossval(finalMdl);
       L=kfoldLoss(finalCVMdl);
       avg(i,1)=avg(i,1)+L;
    end
    rAvg=sum(avg);
    rAvg=rAvg/100;
    rAvg=(1-rAvg)*100;
    
    best=min(avg);
    best=(1-best)*100;
    
    % Results
    out.selectedGenes=bF.Gen;
    out.Accuracy=rAvg;
    out.graph=bfitFunc;
    out.best=best;
    toc
end
