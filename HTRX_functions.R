## Model-agnostic fnuctions for model fitting and R^2
themodel<- function(formula,data,usebinary,clean=TRUE,...){
  ## Model fitting
  ## The "usebinary" flag allows us to choose which model we use
  ## If it is 0 we use regular "lm"
  ## If it is >1 we use logistic regression via glm
  ## If it is 1 we use logistic regression via fastglm (its third method)
  ## Note that this was checked by running an analysis with its other approaches 
  ##and choosing one that was both fast and accurate when too many features were provided
  if(usebinary==0){
        model=lm(formula=formula,data=data,...)
    }else if(usebinary>1){
        model=glm(formula=formula,data=data,family=binomial(link='logit'),...)
    }else{
        require("fastglm")
        data=cbind("(Intercept)"=1,data)
        tout=which(colnames(data)=="outcome")
        model=fastglm(x=as.matrix(data[,-tout]),y=data[,"outcome"],
                       family=binomial(link='logit'),method=3,...)
    }
    if(clean){
        ## Remove additional things that the "predict" method does not need
        if(!is(model,"lm")) model$residuals=NULL;  ##this will affect AIC and BIC used for "lm"
        model$fitted.values=NULL
        model$weights=NULL
        model$data=NULL
        model$y=NULL
        model$prior.weights=NULL
        model$linear.predictors=NULL
    }
    return(model)
}

myR2 <- function(pred,y,usebinary=1){
  if(usebinary==0){
    return(1-sum((y-pred)^2)/sum((y-mean(y))^2))
  }else{
    ## McFadden R^2 in test
    ## NOTE: We use a NULL which the mean.
    loglik_model <- sum(-log(1+exp(pred))+y*pred)
    pred_null=log(mean(y)/(1-mean(y)))
    loglik_null <- sum(-log(1+exp(pred_null))+y*pred_null)
    return(1-loglik_model/loglik_null)
  }
}

mypredict<-function(model,newdata){
    ## Prediction method that is model agnostic
    ## Returns elements as the "predict" function but allows fastglm input
    if(is(model,"fastglm")){
        tcol=names(model$coefficients)
        newdata=cbind("(Intercept)"=1,newdata)
        pred=predict(model,newdata=as.matrix(newdata[,tcol]))
    }else{
        pred=predict(model,newdata=newdata)
    }
    pred
}

myrss<-function(model,obs,newdata){
    ## R^2 evaluation via the predction and computation 
    vals=cbind(obs=obs,pred=mypredict(model,newdata))

    if(is(model,"glm") || is(model,"fastglm")){
        ret=myR2(vals[,2],vals[,1])
    }else{
        ret=1-sum(apply(vals,1,diff)^2)/sum((vals[,"obs"]-mean(vals[,"obs"]))^2)
    }
    ret
}

make_snp<-function(SNP1,SNP2){
    ## Make a SNP feature matrix
    ## Convenience function to use the same format for making a SNP matrix from two haplotype matrices
    SNP1+SNP2
}


make_htr<-function(SNP1,SNP2,rareremove=FALSE,rare_threshold=0.001){
    ## Make a HTR feature matrix
    n=n_total=dim(SNP1)[1]
    nsnp=dim(SNP1)[2]
    ## HTR
    combinations=expand.grid(lapply(1:nsnp,function(x)c(0,1)))
    HTR_matrix <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))
    HTR_matrix2 <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))
    
    for(i in 1:nrow(combinations)){
        ##the genotype must be 0 for reference allele and 1 for alternative allele
        HTR_matrix[Reduce(intersect, 
                          lapply(1:nsnp,function(x)
                          {
                              which(SNP1[,x]==combinations[i,x])
                          })),i]=0.5
        HTR_matrix2[Reduce(intersect, 
                           lapply(1:nsnp,function(x)
                           {
                               which(SNP2[,x]==combinations[i,x])
                           })),i]=0.5
    }
    HTR_matrix = HTR_matrix + HTR_matrix2
    colnames(HTR_matrix)=Reduce(paste0,combinations)
    
    if(rareremove){
      rare <- vector()
      for(d in 1:ncol(HTR_matrix)){
        if(sum(HTR_matrix[,d])<n*rare_threshold){
          rare <- c(rare,d)
          print(d)
        }
      }
      if(length(rare)!=0){
        HTR_matrix <- HTR_matrix[,-rare]
      }
    }
    
    HTR_matrix
}

make_htrx<-function(SNP1,SNP2,rareremove=FALSE,fixedfeature=NULL,rare_threshold=0.001){
    ## Make a HTRX feature matrix
    ## All the combinations of 0,1,X of SNPs
    ## Each element of combinations become 'factor'.
    n=n_total=dim(SNP1)[1]
    nsnp=dim(SNP1)[2]
    if(is.null(fixedfeature)){
      combinations=expand.grid(lapply(1:nsnp,function(x)c(0,1,'X')))
      combinations=combinations[-nrow(combinations),]
      HTRX_matrix <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))
      HTRX_matrix2 <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))
      ##the genotype must be 0 for reference allele and 1 for alternative allele
      for(i in 1:nrow(combinations)){
        HTRX_matrix[Reduce(intersect, 
                           lapply(1:nsnp,function(x)
                           {
                             if(combinations[i,x]=='X')return(1:n);
                             if(combinations[i,x]!='X')return(which(SNP1[,x]==as.numeric(
                               levels(combinations[i,x])[combinations[i,x]])));
                           })
        ),i]=0.5
        HTRX_matrix2[Reduce(intersect, 
                            lapply(1:nsnp,function(x)
                            {
                              if(combinations[i,x]=='X')return(1:n);
                              if(combinations[i,x]!='X')return(which(SNP2[,x]==as.numeric(
                                levels(combinations[i,x])[combinations[i,x]])));
                            })
        ),i]=0.5
      }
    }else{
      combinations=as.data.frame(matrix(NA,nrow=length(fixedfeature),ncol=nsnp))
      for(i in 1:length(fixedfeature)){
        combinations[i,]=unlist(strsplit(fixedfeature[i],split=''))
      }
      
      HTRX_matrix <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))
      HTRX_matrix2 <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))

      for(i in 1:nrow(combinations)){
        HTRX_matrix[Reduce(intersect, 
                           lapply(1:nsnp,function(x)
                           {
                             if(combinations[i,x]=='X')return(1:n);
                             if(combinations[i,x]!='X')return(which(SNP1[,x]==as.numeric(
                               combinations[i,x])));
                           })
        ),i]=0.5
        HTRX_matrix2[Reduce(intersect, 
                            lapply(1:nsnp,function(x)
                            {
                              if(combinations[i,x]=='X')return(1:n);
                              if(combinations[i,x]!='X')return(which(SNP2[,x]==as.numeric(
                                combinations[i,x])));
                            })
        ),i]=0.5
      }
      
    }
    
    HTRX_matrix = HTRX_matrix + HTRX_matrix2
    colnames(HTRX_matrix)=Reduce(paste0,combinations)
    
    #remove haplotypes with frequency=100%
    missing <- vector()
    for(i in 1:nrow(combinations)){
        if(sum(HTRX_matrix[,i])==0){
            missing=c(missing,i)
            cat('Remove',i,'\n')
        } 
    }
    if(length(missing)!=0) HTRX_matrix=HTRX_matrix[,-missing];
    
    #remove rare SNPs or not
    if(rareremove){
      rare <- vector()
      for(d in 1:ncol(HTRX_matrix)){
        if(sum(HTRX_matrix[,d])<n*rare_threshold){
          rare <- c(rare,d)
          print(d)
        }
      }
      if(length(rare)!=0){
        HTRX_matrix <- HTRX_matrix[,-rare]
      }
    }

    return(HTRX_matrix)
}


make_cumulative_htrx <- function(SNP1,SNP2,featurename,rareremove=FALSE,rare_threshold=0.001){
  ## make a HTRX feature matrix for all the N-SNP haplotype 
  ## with given featurename of N-1-SNP haplotype for cumulative HTRX
  n=n_total=dim(SNP1)[1]
  nsnp=dim(SNP1)[2]
  exist_haps <- length(featurename)
  combinations=as.data.frame(matrix(NA,nrow=(3*exist_haps+2),ncol=nsnp))
  for(i in 1:exist_haps){
    combinations[3*i-2,-nsnp]=combinations[3*i-1,-nsnp]=combinations[3*i,-nsnp]=
      unlist(strsplit(featurename[i],split=''))
    combinations[3*i-2,nsnp]=0
    combinations[3*i-1,nsnp]=1
    combinations[3*i,nsnp]='X'
  }
  combinations[(3*exist_haps+1),-nsnp]=combinations[(3*exist_haps+2),-nsnp]=rep('X',nsnp-1)
  combinations[(3*exist_haps+1),nsnp]=0
  combinations[(3*exist_haps+2),nsnp]=1
  
  HTRX_matrix <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))
  HTRX_matrix2 <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))
  
  ##the genotype must be 0 for reference allele and 1 for alternative allele
  for(i in 1:nrow(combinations)){
    index1=Reduce(intersect, 
                  lapply(1:nsnp,function(x)
                  {
                    if(combinations[i,x]=='X')return(1:n);
                    if(combinations[i,x]!='X')return(which(SNP1[,x]==as.numeric(combinations[i,x])));
                  })
    )
    index2=Reduce(intersect, 
                  lapply(1:nsnp,function(x)
                  {
                    if(combinations[i,x]=='X')return(1:n);
                    if(combinations[i,x]!='X')return(which(SNP2[,x]==as.numeric(combinations[i,x])));
                  })
    )
    HTRX_matrix[index1,i]=0.5
    HTRX_matrix2[index2,i]=0.5
  }
  
  HTRX_matrix = HTRX_matrix + HTRX_matrix2
  colnames(HTRX_matrix)=Reduce(paste0,combinations)
  
  missing <- vector()
  #remove haplotypes with frequency=100%
  for(i in 1:nrow(combinations)){
    if(sum(HTRX_matrix[,i])==0){
      missing=c(missing,i)
      cat('Remove',i,'\n')
    } 
  }
  if(length(missing)!=0) HTRX_matrix=HTRX_matrix[,-missing];
  
  #remove rare SNPs or not
  if(rareremove){
    rare <- vector()
    for(d in 1:ncol(HTRX_matrix)){
      if(sum(HTRX_matrix[,d])<n*rare_threshold){
        rare <- c(rare,d)
        print(d)
      }
    }
    if(length(rare)!=0){
      HTRX_matrix <- HTRX_matrix[,-rare]
    }
  }
  
  return(HTRX_matrix)
}




htr_max<-function(nsnp,cap=40){
  ## This is based on the theoretical number of linearly independent features:
  ## If we have N snps, there are at most 2^n-1 independent haplotypes 
  n_hap=2^nsnp-1
  if(n_hap>cap){
    n_hap=cap
  }
  n_hap
}

htrx_max<-function(nsnp,ncol_HTRX_matrix=3^nsnp-1,cap=30){
  ## This is based on the theoretical number of linearly independent features:
  ## If we have N snps, there are at most 2^n-1 independent haplotypes 
    n_hapx=2^nsnp-1 ## Dimension of HTR   
    if(n_hapx>ncol_HTRX_matrix) n_hapx=ncol_HTRX_matrix;
    if(n_hapx>cap){
        n_hapx=cap
    }
    n_hapx
}

traintest_simple<-function(index_all,train_proportion){
  ## Make a random train/test split
  n_total=length(index_all)
  index_all<-sample(index_all)
  train <- index_all[1:round(n_total*train_proportion,0)]
  test <- index_all[(round(n_total*train_proportion,0)+1):n_total]
  list(train=train,test=test)
}

traintest_stratified<-function(index_all,strat,train_proportion){
  ## Make a stratified train/test split, 
  ##such that all sets have the same proportion of 0s and 1s in the "strat" variable
  num0=sum(strat==0)
  num1=sum(strat==1)
  if(num0+num1!=length(strat)) stop("Stratification vector must be 0/1")
  index0<-sample(index_all[strat==0])
  index1<-sample(index_all[strat==1])
  train0 <- index0[1:round(num0*train_proportion,0)]
  test0 <- index0[(round(num0*train_proportion,0)+1):num0]
  
  train1 <- index1[1:round(num1*train_proportion,0)]
  
  test1 <- index1[(round(num1*train_proportion,0)+1):num1]
  
  train <- sample(c(train0,train1))
  test <- sample(c(test0,test1))
  list(train=train,
       test=test)
}

tenfold_simple<-function(index_all){
  ## Make a random train/test split into 10 sets (folds)
  require("caret")
  folds <- createFolds(index_all, k = 10, list = TRUE, returnTrain = FALSE)
  return(folds)
}

tenfold_stratified<-function(strat){
  ## Make a stratified train/test split for 10 different sets (folds), 
  ##such that all sets have the same proportion of 0s and 1s in the "strat" variable
  num0=which(strat==0)
  num1=which(strat==1)
  if(length(num0)+length(num1)!=length(strat)) stop("Stratification vector must be 0/1")
  require("caret")
  foldcontrol <- createFolds(num0, k = 10, list = TRUE, returnTrain = FALSE)
  foldcase <- createFolds(num1, k = 10, list = TRUE, returnTrain = FALSE)
  return(list(fold1=c(foldcontrol[[1]],foldcase[[1]]),
              fold2=c(foldcontrol[[2]],foldcase[[2]]),
              fold3=c(foldcontrol[[3]],foldcase[[3]]),
              fold4=c(foldcontrol[[4]],foldcase[[4]]),
              fold5=c(foldcontrol[[5]],foldcase[[5]]),
              fold6=c(foldcontrol[[6]],foldcase[[6]]),
              fold7=c(foldcontrol[[7]],foldcase[[7]]),
              fold8=c(foldcontrol[[8]],foldcase[[8]]),
              fold9=c(foldcontrol[[9]],foldcase[[9]]),
              fold10=c(foldcontrol[[10]],foldcase[[10]])))
}





infer_step1 <- function(data_nosnp,featuredata,
                           train,criteria="BIC",
                           maxfeature=dim(featuredata)[2],usebinary=TRUE,
                           runparallel=FALSE, mc.cores=10) {
  ## It's Step 1: select candidate models
  ## For a variable called "outcome" in "data_nosnp"
  ## appending and sequentially searching one feature at a time in "featuredata"
  ## Using "train" (indices) for computing BIC for each model
  ## Select model based on the smallest BIC
  ## "usebinary" controls the model, by default it uses "fastglm"
  ## "gain" controls whether we report the R2 or gain over the covariates (default)
  
  featurelist=1:length(colnames(featuredata))
  wholedata=cbind(data_nosnp,featuredata)
  nfeature=length(featurelist)
  ncovar=dim(data_nosnp)[2]-1
  n_total=nrow(featuredata)    
  modellist=list()
  minseq <- vector()
  information_each <- vector()
  featurename <- vector()
  data_use=data_nosnp

  ##train
  print("Training...")
  for(i in 1:maxfeature){
    cat('Adding Feature Number',i,'\n')
    cal <- function(j){
      data_try=cbind(data_use[train,],featuredata[train,j,drop=FALSE])
      model_try=themodel(outcome~.,data_try,usebinary)
      if(criteria=="AIC"){
        information_try_gain = AIC(model_try)
        cat('... trying feature',j,'with AIC',information_try_gain,'\n')
      }else{
        information_try_gain = AIC(model_try,k=log(nrow(data_try)))
        cat('... trying feature',j,'with BIC',information_try_gain,'\n')
      } 
      return(information_try_gain)
    }
    if(runparallel==TRUE){
      require("parallel")
      information=mclapply(featurelist,cal,mc.cores=mc.cores)
    }else{
      information=lapply(featurelist,cal)
    }
    
    gc()
    minnumber=which.min(unlist(information))
    information_each[i] = min(unlist(information))
    minseq[i]=featurelist[minnumber]
    
    data_use=cbind(data_use,featuredata[,minseq[i],drop=FALSE])
    modellist[[i]]=themodel(outcome~.,data_use[train,],usebinary)
    featurename[i]=colnames(featuredata)[minseq[i]]
    colnames(data_use)[ncol(data_use)]=featurename[i]
    featurelist=featurelist[-minnumber]
    
    cat('... Using feature',minseq[i],'\n')
    
    #keep three different models to increase the models in the candidate model pool
    if(i>=3){
      if(information_each[i-1]>information_each[i-2]){
        break;
      }
    }
  }
  
  #choose the model with the top 3 smallest BIC
  
  #If there are only 2-3 features, we don't have so many models
  if(maxfeature==2){
    n_feature = order(information_each,decreasing=FALSE)[1:2]
    
    cat('BIC selects',n_feature[1],'features but we also keep models with',
        n_feature[2],'features \n')
    
    return(list(model1=modellist[[n_feature[1]]],
                model2=modellist[[n_feature[2]]]))
  }else{
    n_feature = order(information_each,decreasing=FALSE)[1:3]
    
    cat('BIC selects',n_feature[1],'features but we also keep models with',
        n_feature[2],'and',n_feature[3],'features \n')
    
    return(list(model1=modellist[[n_feature[1]]],
                model2=modellist[[n_feature[2]]],
                model3=modellist[[n_feature[3]]]))
  }
  
}




infer_fixedfeatures <- function(data_nosnp,featuredata,train=(1:nrow(data_nosnp))[-test],test,
                                features,coefficients=NULL,gain=TRUE,usebinary=TRUE,
                                R2only=FALSE){
    ## Make a model with a specified set of features from the training data
    ## Reporting the results on the test data
    ## Optionally setting coefficients
    data_use=cbind(data_nosnp,featuredata[,features])
    model_use=themodel(outcome~.,data_use[train,],usebinary)
    if(gain) model_nosnp=themodel(outcome~.,data_nosnp[train,],usebinary)
    if(!all(is.null(coefficients))){
        model_use$coefficients[]=coefficients[names(model_use$coefficients)]
    }
    R2_use_gain = myR2(mypredict(model_use,
                                 newdata=data_use[test,]),
                       data_nosnp[test,"outcome"],usebinary)
    if(gain) {   
        R2_nosnp_test= myR2(mypredict(model_nosnp,
                                 newdata=data_nosnp[test,]),
                         data_nosnp[test,"outcome"],usebinary)
        R2_use_gain=R2_use_gain - R2_nosnp_test
    }
    cat('Relative gain = ',R2_use_gain,'\n')
    if(R2only){
      list(R2=R2_use_gain)
    }else{
      list(R2=R2_use_gain,model=model_use,null=model_nosnp)
    }
}


do_cv_step1 <- function(covar_data,feature_data,train_proportion=0.5,
                     featurecap=dim(feature_data)[2],usebinary=TRUE,
                     method="stratified",criteria="BIC",
                     seed=123,runparallel=FALSE,mc.cores=10){
  #The first step for HTRX
  #split the dataset at first
  #Then pass all the required data/parameters to "infer_step1" function to select candidate models
  
  set.seed(seed)
  n_total=nrow(covar_data)
  if(method=="simple"){
    split=traintest_simple(1:n_total,train_proportion)
  }else if(method=="stratified"){
    split=traintest_stratified(1:n_total,covar_data[,"outcome"],
                               train_proportion)
  }else stop("method must be either simple or stratified")
  res  <- infer_step1(covar_data,feature_data,
                      split$train,criteria=criteria,
                      maxfeature=featurecap,usebinary=usebinary,
                      runparallel=runparallel,mc.cores=mc.cores)
  
  res
}

do_cv_2step <- function(covar_data,feature_data,train_proportion=0.5,
                        sim_times,
                        featurecap=dim(feature_data)[2],usebinary=TRUE,
                        method="stratified",criteria="BIC",gain=TRUE,
                        runparallel=FALSE,mc.cores=10){
  #First step: obtain all the candidate models from running "sim_times" times simulation
  candidate_models=lapply(1:sim_times,function(s){
    results=do_cv_step1(covar_data,feature_data,train_proportion,
                     featurecap=featurecap,usebinary=usebinary,
                     method=method,criteria=criteria,seed=s,
                     runparallel=runparallel,mc.cores=mc.cores)
  })
  
  #extract all the candidate models
  candidate_pool=as.data.frame(matrix(NA,nrow=sim_times*min(featurecap,3),ncol=featurecap))
  #if there are only two features, in each seed of step 1 we only select two candidate models
  if(featurecap==2){
    for(i in 1:sim_times){
      selected_features1=row.names(as.data.frame(candidate_models[[i]]$model1$coefficients))[-(1:ncol(covar_data))]
      selected_features2=row.names(as.data.frame(candidate_models[[i]]$model2$coefficients))[-(1:ncol(covar_data))]
      candidate_pool[(2*i-1),(1:length(selected_features1))]=selected_features1
      candidate_pool[(2*i),(1:length(selected_features2))]=selected_features2
    }
  }else{
    for(i in 1:sim_times){
      selected_features1=row.names(as.data.frame(candidate_models[[i]]$model1$coefficients))[-(1:ncol(covar_data))]
      selected_features2=row.names(as.data.frame(candidate_models[[i]]$model2$coefficients))[-(1:ncol(covar_data))]
      selected_features3=row.names(as.data.frame(candidate_models[[i]]$model3$coefficients))[-(1:ncol(covar_data))]
      candidate_pool[(3*i-2),(1:length(selected_features1))]=selected_features1
      candidate_pool[(3*i-1),(1:length(selected_features2))]=selected_features2
      candidate_pool[(3*i),(1:length(selected_features3))]=selected_features3
    }
  }
  
  candidate_pool=unique(candidate_pool)
  
  cat('Step 1 selects',nrow(candidate_pool),'candidate models','\n')
  
  n_total=nrow(covar_data)
  
  set.seed(1)
  
  #split data into 10 folds
  if(method=="simple"){
    split=tenfold_simple(1:n_total)
  }else if(method=="stratified"){
    split=tenfold_stratified(covar_data[,"outcome"])
  }else stop("method must be either simple or stratified")
  
  #start 10-fold cross-validation
  
  R2_10fold=as.data.frame(matrix(NA,nrow=10,ncol=nrow(candidate_pool)))
  
  R2_10fold_average=vector()
  
  for(i in 1:nrow(candidate_pool)){
    if(runparallel){
      R2_test_gain=mclapply(1:10,function(s){
        infer_fixedfeatures(covar_data,feature_data,test=split[[s]],
                            features=as.character(gsub('`','',candidate_pool[i,which(!is.na(candidate_pool[i,]))])),
                            usebinary=usebinary,gain=gain,R2only=TRUE)
      },mc.cores=mc.cores)
    }else{
      R2_test_gain=lapply(1:10,function(s){
        infer_fixedfeatures(covar_data,feature_data,test=split[[s]],
                            features=as.character(gsub('`','',candidate_pool[i,which(!is.na(candidate_pool[i,]))])),
                            usebinary=usebinary,gain=gain,R2only=TRUE)
      })
    }
    R2_10fold[,i]=unlist(R2_test_gain)
    R2_10fold_average[i]=mean(R2_10fold[,i])
    cat('Average gain for candidate model',i,'is',R2_10fold_average[i],'\n')
  }
  
  #select the best model based on the largest out-of-sample R^2 from 10-fold cv
  best_candidate_index=which.max(R2_10fold_average)
  selected_features=candidate_pool[best_candidate_index,
                                   which(!is.na(candidate_pool[best_candidate_index,]))]
  
  return(list(R2_test_gain=R2_10fold[,best_candidate_index],
              selected_features=selected_features))
}



#function for adding a SNP to extend a haplotype for cumulative HTRX
extend_haps <- function(data_nosnp,featuredata,
                        train,
                        maxfeature=dim(featuredata)[2],usebinary=TRUE,gain=TRUE,
                        runparallel=FALSE,mc.cores=10) {
  ## Perform training
  ## For a variable called "outcome" in "data_nosnp"
  ## appending and sequentially searching one feature at a time in "featuredata"
  ## Using "train" (indices) only
  ## "usebinary" controls the model, by default it uses "fastglm"
  ## "gain" controls whether we report the R2 or gain over the covariates (default)
  
  featurelist=1:length(colnames(featuredata))
  wholedata=cbind(data_nosnp,featuredata)
  nfeature=length(featurelist)
  ncovar=dim(data_nosnp)[2]-1
  n_total=nrow(featuredata)    
  modellist=list()
  maxseq <- vector()
  Freq <- vector()
  featurename <- vector()
  data_use=data_nosnp
  
  if(gain){
    print("Creating null model...")
    model_nosnp=themodel(outcome~.,data_nosnp[train,,drop=FALSE],usebinary)
    R2_nosnp_train=myR2(mypredict(model_nosnp,
                                  newdata=data_nosnp[train,,drop=FALSE]),
                        data_nosnp[train,"outcome"],usebinary)
  }else{
    model_nosnp=NULL
    R2_nosnp_train=0
  }
  ##train
  print("Training...")
  for(i in 1:maxfeature){
    cat('Adding Feature Number',i,'\n')
    cal <- function(j){
      data_try=cbind(data_use[train,],featuredata[train,j,drop=FALSE])
      model_try=themodel(outcome~.,data_try,usebinary)
      R2_try_gain = myR2(mypredict(model_try,
                                   newdata=data_try),
                         data_nosnp[train,"outcome"],usebinary) - R2_nosnp_train
      if(gain)cat('... trying feature',j,'with gain',R2_try_gain,'\n')
      else cat('... trying feature',j,'with score',R2_try_gain,'\n')
      return(R2_try_gain)
    }
    if(runparallel==TRUE){
      #running parallel
      require("parallel")
      R2=mclapply(featurelist,cal,mc.cores=mc.cores)
    }else{
      R2=lapply(featurelist,cal)
    }
    
    gc()
    maxnumber=which.max(unlist(R2))
    maxseq[i]=featurelist[maxnumber]
    
    cat('... Using feature',maxseq[i],'\n')
    data_use=cbind(data_use,featuredata[,maxseq[i],drop=FALSE])
    featurename[i]=colnames(featuredata)[maxseq[i]]
    colnames(data_use)[ncol(data_use)]=featurename[i]
    featurelist=featurelist[-maxnumber]
  }
  
  return(featurename)
}


#The first step of cumulative HTRX
do_cumulative_htrx_step1 <- function(covar_data,hap1,hap2,train_proportion=0.5,
                                     featurecap=40,usebinary=TRUE,randomorder=TRUE,fixorder=NULL,
                                     method="stratified",criteria="BIC",
                                     seed=123,gain=TRUE,runparallel=FALSE,
                                     rareremove=FALSE,mc.cores=10){
  set.seed(seed)
  n_total=nrow(hap1)
  nsnp=ncol(hap1)
  
  #random order of SNPs added into cumulative HTRX process
  if(randomorder){
    snp_random=sample(1:nsnp)
  }else{
    if(!is.null(fixorder)){
      if(length(fixorder)!=nsnp){
        snp_random=fixorder
      }else{
        snp_to_random=(1:nsnp)[-fixorder]
        
        snp_random=c(fixorder,sample(snp_to_random))
      }
    }
  }
  hap1=hap1[,snp_random]
  hap2=hap2[,snp_random]
  
  if(method=="simple"){
    split=traintest_simple(1:n_total,train_proportion)
  }else if(method=="stratified"){
    split=traintest_stratified(1:n_total,covar_data[,"outcome"],
                               train_proportion)
  }else stop("method must be either simple or stratified")

  
  if(nsnp<7) stop("no need cumulative HTRX, please directly use HTRX")
  
  for(k in 6:nsnp){
    ###select haplotypes based on cumulative R^2 on the training set
    if(k==6){
      htrx=make_htrx(hap1[,1:k],hap2[,1:k],rareremove=rareremove)
      featurename=extend_haps(covar_data,htrx,split$train,
                                featurecap,usebinary,gain=gain,runparallel=runparallel,mc.cores=mc.cores)

    }else{
      ###begin adding SNPs
      if(k<nsnp){
        htrx=make_cumulative_htrx(hap1[,1:k],hap2[,1:k],featurename)
        featurename=extend_haps(covar_data,htrx,split$train,
                                  featurecap,usebinary,gain=gain,runparallel=runparallel,mc.cores=mc.cores)
      }else{
        htrx=make_cumulative_htrx(hap1[,1:k],hap2[,1:k],featurename)
        if(randomorder){
          #return to the correct sequence of haplotype names
          for(q in 1:ncol(htrx)){
            colnames(htrx)[q]=Reduce(paste0,unlist(strsplit(colnames(htrx)[q],split=''))[order(snp_random)])
          }
        }

        #when the haplotypes include all the SNPs, we use all the remaining haplotypes for standard HTRX
        #The first step is to select candidate models
        res  <- infer_step1(covar_data,htrx,
                            split$train,criteria=criteria,
                            maxfeature=featurecap,usebinary=usebinary,
                            runparallel=runparallel,mc.cores=mc.cores)
        
      }
    }
  }
  res
}


do_cumulative_cv_twostep <- function(covar_data,hap1,hap2,train_proportion=0.5,
                                     sim_times=10,
                                     featurecap=40,usebinary=TRUE,randomorder=TRUE,fixorder=NULL,
                                     method="stratified",criteria="BIC",gain=TRUE,
                                     runparallel=FALSE,rareremove=FALSE,mc.cores=10,
                                     dataseed=1:sim_times){

  n_total=nrow(covar_data)
  
  #store all the candidate models from each simulation
  candidate_models=lapply(dataseed,function(s){
    results=do_cumulative_htrx_step1(covar_data,hap1,hap2,train_proportion,
                                     featurecap=featurecap,usebinary=usebinary,
                                     fixorder=fixorder,
                                     method=method,criteria=criteria,seed=s,
                                     runparallel=runparallel)
  })
  
  #if there are only two features, in each seed of step 1 we only select two candidate models
  candidate_pool=as.data.frame(matrix(NA,nrow=sim_times*min(featurecap,3),ncol=featurecap))
  if(featurecap==2){
    for(i in 1:sim_times){
      selected_features1=row.names(as.data.frame(candidate_models[[i]]$model1$coefficients))[-(1:ncol(covar_data))]
      selected_features2=row.names(as.data.frame(candidate_models[[i]]$model2$coefficients))[-(1:ncol(covar_data))]
      candidate_pool[(2*i-1),(1:length(selected_features1))]=selected_features1
      candidate_pool[(2*i),(1:length(selected_features2))]=selected_features2
    }
  }else{
    for(i in 1:sim_times){
      selected_features1=row.names(as.data.frame(candidate_models[[i]]$model1$coefficients))[-(1:ncol(covar_data))]
      selected_features2=row.names(as.data.frame(candidate_models[[i]]$model2$coefficients))[-(1:ncol(covar_data))]
      selected_features3=row.names(as.data.frame(candidate_models[[i]]$model3$coefficients))[-(1:ncol(covar_data))]
      candidate_pool[(3*i-2),(1:length(selected_features1))]=selected_features1
      candidate_pool[(3*i-1),(1:length(selected_features2))]=selected_features2
      candidate_pool[(3*i),(1:length(selected_features3))]=selected_features3
    }
  }
  #all the unuqie candidate models
  candidate_pool=unique(candidate_pool)
  
  cat('Step 1 selects',nrow(candidate_pool),'candidate models','\n')
  
  set.seed(123)
  
  #start 10-fold cross-validation
  
  if(method=="simple"){
    split=tenfold_simple(1:n_total)
  }else if(method=="stratified"){
    split=tenfold_stratified(covar_data[,"outcome"])
  }else stop("method must be either simple or stratified")
  
  R2_10fold=as.data.frame(matrix(NA,nrow=10,ncol=nrow(candidate_pool)))
  
  R2_10fold_average=vector()
  
  for(i in 1:nrow(candidate_pool)){
    if(runparallel){
      R2_test_gain=mclapply(1:10,function(s){
        feature_data=make_htrx(hap1,hap2,rareremove=rareremove,
                               fixedfeature=as.character(candidate_pool[i,which(!is.na(candidate_pool[i,]))]))
        infer_fixedfeatures(covar_data,feature_data,test=split[[s]],
                            features=as.character(candidate_pool[i,which(!is.na(candidate_pool[i,]))]),
                            usebinary=usebinary,gain=gain,R2only=TRUE)
      },mc.cores=mc.cores)
    }else{
      R2_test_gain=lapply(1:10,function(s){
        feature_data=make_htrx(hap1,hap2,rareremove=rareremove,
                               fixedfeature=as.character(candidate_pool[i,which(!is.na(candidate_pool[i,]))]))
        infer_fixedfeatures(covar_data,feature_data,test=split[[s]],
                            features=as.character(candidate_pool[i,which(!is.na(candidate_pool[i,]))]),
                            usebinary=usebinary,gain=gain,R2only=TRUE)
      })
    }
    R2_10fold[,i]=unlist(R2_test_gain)
    R2_10fold_average[i]=mean(R2_10fold[,i])
    cat('Average gain for candidate model',i,'is',R2_10fold_average[i],'\n')
  }
  #select the best model based on the largest out-of-sample R^2 from 10-fold cv
  best_candidate_index=which.max(R2_10fold_average)
  selected_features=candidate_pool[best_candidate_index,
                                   which(!is.na(candidate_pool[best_candidate_index,]))]
  
  return(list(R2_test_gain=R2_10fold[,best_candidate_index],
              selected_features=selected_features))
}

