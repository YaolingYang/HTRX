#' @title Two-stage HTRX: Model selection on short haplotypes
#' @description Two-step cross-validation used to select the best HTRX model.
#' It can be applied to select haplotypes based on HTR, or select single nucleotide polymorphisms (SNPs).
#' @name do_cv
#'
#' @param data_nosnp a data frame with outcome (the outcome must be the first column),
#' fixed covariates (for example, sex, age and the first 18 PCs) if there are,
#' and without SNPs or haplotypes.
#' @param featuredata a data frame of the feature data, e.g. haplotype data created by HTRX or SNPs.
#' These features exclude all the data in \code{data_nosnp}, and will be selected using 2-step cross-validation.
#' @param train_proportion a positive number between 0 and 1 giving
#' the proportion of the training dataset when splitting data into 2 folds.
#' By default, \code{train_proportion=0.5}.
#' @param sim_times an integer giving the number of simulations in Step 1 (see details).
#' By default, \code{sim_times=5}.
#' @param featurecap a positive integer which manually sets the maximum number of independent features.
#' By default, \code{featurecap=40}.
#' @param usebinary a non-negative number representing different models.
#' Use linear model if \code{usebinary=0},
#' use logistic regression model via \code{fastglm} if \code{usebinary=1} (by default),
#' and use logistic regression model via \code{glm} if \code{usebinary>1}.
#' @param method the method used for data splitting, either \code{"simple"} (default) or \code{"stratified"}.
#' @param criteria the criteria for model selection, either \code{"BIC"} (default), \code{"AIC"} or \code{"lasso"}.
#' @param gain logical. If \code{gain=TRUE} (default), report the variance explained in addition to fixed covariates;
#' otherwise, report the total variance explained by all the variables.
#' @param nmodel a positive integer specifying the number of candidate models
#' that the criterion selects. By default, \code{nmodel=3}.
#' @param dataseed a vector of the seed that each simulation in Step 1 (see details) uses.
#' The length of \code{dataseed} must be the same as \code{sim_times}.
#' By default, \code{dataseed=1:sim_times}.
#' @param runparallel logical. Use parallel programming based on \code{mclapply} function from R package \code{"parallel"} or not.
#' Note that for Windows users, \code{mclapply} doesn't work, so please set \code{runparallel=FALSE} (default).
#' @param mc.cores an integer giving the number of cores used for parallel programming.
#' By default, \code{mc.cores=6}.
#' This only works when \code{runparallel=TRUE}.
#' @param fold a positive integer specifying how many folds
#' the data should be split into for cross-validation.
#' @param kfoldseed a positive integer specifying the seed used to
#' split data for k-fold cross validation. By default, \code{kfoldseed=123}.
#' @param returnwork logical. If \code{returnwork=TRUE}, return a vector of the maximum number
#' of features that are assessed in each simulation, excluding the fixed covariates.
#' This is used to assess how much computational 'work' is done in Step 1(2) of HTRX (see details).
#' By default, \code{returnwork=FALSE}.
#' @param verbose logical. If \code{verbose=TRUE}, print out the inference steps. By default, \code{verbose=FALSE}.
#' @param splitseed a positive integer giving the seed of data split.
#' @param train a vector of the indexes of the training data.
#' @param test a vector of the indexes of the test data.
#' @param features a character of the names of the fixed features, excluding the intercept.
#' @param coefficients a vector giving the coefficients of the fixed features, including the intercept.
#' If the fixed features don't have fixed coefficients, set \code{coefficients=NULL} (default).
#' @param R2only logical. If \code{R2only=TRUE}, function \code{infer_fixedfeatures} only
#' returns the variance explained in the test data.
#' By default, \code{R2only=FALSE}.
#'
#' @details Function \code{do_cv} is the main function used for selecting haplotypes from HTRX or SNPs.
#' It is a two-step algorithm and is used for alleviating overfitting.
#'
#' Step 1: select candidate models. This is to address the model search problem,
#' and is chosen to obtain a set of models more diverse than
#' traditional bootstrap resampling.
#'
#' (1) Randomly sample a subset (50%) of data.
#' Specifically, when the outcome is binary,
#' stratified sampling is used to ensure the subset has approximately
#' the same proportion of cases and controls as the whole data;
#'
#' (2) If \code{criteria="AIC"} or \code{criteria="BIC"},
#' start from a model with fixed covariates (e.g. 18 PCs, sex and age),
#' and perform forward regression on the subset,
#' i.e. iteratively choose a feature (in addition to the fixed covariates)
#' to add whose inclusion enables the model to explain the largest variance,
#' and select s models with the lowest Akaike information criterion (AIC) or
#' Bayesian Information Criteria (BIC)
#' to enter the candidate model pool;
#' If \code{criteria="lasso"}, using least absolute shrinkage and selection operator (lasso)
#' to directly select the best s models to enter the candidate model pool;
#'
#' (3) repeat (1)-(2) B times, and select all the different models in the candidate model pool
#'  as the candidate models.
#'
#' Step 2: select the best model using k-fold cross-validation.
#'
#' (1) Randomly split the whole data into k groups with approximately equal sizes,
#' using stratified sampling when the outcome is binary;
#'
#' (2) In each of the k folds, use a fold as the validation dataset, a fold as the test dataset,
#' and the remaining folds as the training dataset.
#' Then, fit all the candidate models on the training dataset,
#' and use these fitted models to compute the additional variance explained by features
#' (out-of-sample variance explained) in the validation and test dataset.
#' Finally, select the candidate model with the biggest
#' average out-of-sample variance explained in the validation set as the best model,
#' and report the out-of-sample variance explained in the test set.
#'
#' Function \code{do_cv_step1} is the Step 1 (1)-(2) described above.
#' Function \code{infer_step1} is the Step 1 (2) described above.
#' Function \code{infer_fixedfeatures} is used to fit all the candidate models on the training dataset,
#' and compute the additional variance explained by features (out-of-sample R2) in the test dataset,
#' as described in the Step 2 (2) above.
#'
#' @return \code{do_cv} returns a list containing the best model selected,
#' and the out-of-sample variance explained in each test set.
#'
#' \code{do_cv_step1} and \code{infer_step1} return a list of three candidate models selected by a single simulation.
#'
#' \code{infer_fixedfeatures} returns a list of the variance explained in the test set if \code{R2only=TRUE},
#' otherwise, it returns a list of the variance explained in the test set, the model including all the variables,
#' and the null model, i.e. the model with outcome and fixed covariates only.
#'
#' @references
#' Yang Y, Lawson DJ. HTRX: an R package for learning non-contiguous haplotypes associated with a phenotype. Bioinformatics Advances 1.1 (2023): vbab038.
#'
#' Barrie, William, et al. "Genetic risk for Multiple Sclerosis originated in Pastoralist Steppe populations." bioRxiv (2022): 2022.09.23.509097.
#'
#' Eforn, B. "Bootstrap methods: another look at the jackknife." The Annals of Statistics 7 (1979): 1-26.
#'
#' Schwarz, Gideon. "Estimating the dimension of a model." The annals of statistics (1978): 461-464.
#'
#' McFadden, Daniel. "Conditional logit analysis of qualitative choice behavior." (1973).
#'
#' Akaike, Hirotugu. "A new look at the statistical model identification." IEEE transactions on automatic control 19.6 (1974): 716-723.
#'
#' Tibshirani, Robert. "Regression shrinkage and selection via the lasso." Journal of the Royal Statistical Society: Series B (Methodological) 58.1 (1996): 267-288.
#'
#' @examples
#' ## use dataset "example_hap1", "example_hap2" and "example_data_nosnp"
#' ## "example_hap1" and "example_hap2" are
#' ## both genomes of 8 SNPs for 5,000 individuals (diploid data)
#' ## "example_data_nosnp" is an example dataset
#' ## which contains the outcome (binary), sex, age and 18 PCs
#'
#' ## visualise the covariates data
#' ## we will use only the first two covariates: sex and age in the example
#' head(HTRX::example_data_nosnp)
#'
#' ## visualise the genotype data for the first genome
#' head(HTRX::example_hap1)
#'
#' ## we perform HTRX on the first 4 SNPs
#' ## we first generate all the haplotype data, as defined by HTRX
#' HTRX_matrix=make_htrx(HTRX::example_hap1[1:300,1:4],
#'                       HTRX::example_hap2[1:300,1:4])
#'
#' ## If the data is haploid, please set
#' ## HTRX_matrix=make_htrx(HTRX::example_hap1[1:300,1:4],
#' ##                       HTRX::example_hap1[1:300,1:4])
#'
#' ## then perform HTRX using 2-step cross-validation in a single small example
#' ## to compute additional variance explained by haplotypes
#' ## If you want to compute total variance explained, please set gain=FALSE
#' CV_results <- do_cv(HTRX::example_data_nosnp[1:300,1:2],
#'                     HTRX_matrix,train_proportion=0.5,
#'                     sim_times=1,featurecap=4,usebinary=1,
#'                     method="simple",criteria="BIC",
#'                     gain=TRUE,runparallel=FALSE,verbose=TRUE)
#'
#' #This result would be more precise when setting larger sim_times and featurecap
NULL

#' @rdname do_cv
#' @export
do_cv <- function(data_nosnp,featuredata,train_proportion=0.5,
                  sim_times=5,featurecap=dim(featuredata)[2],usebinary=1,
                  method="simple",criteria="BIC",gain=TRUE,nmodel=3,dataseed=1:sim_times,
                  runparallel=FALSE,mc.cores=6,fold=10,kfoldseed=123,
                  returnwork=FALSE,verbose=FALSE){

  colnames(data_nosnp)[1]='outcome'

  #First step: obtain all the candidate models from running "sim_times" times simulation
  candidate_models=lapply(dataseed,function(s){
    results=do_cv_step1(data_nosnp,featuredata,train_proportion,
                        featurecap=featurecap,usebinary=usebinary,
                        method=method,criteria=criteria,nmodel=nmodel,splitseed=s,
                        runparallel=runparallel,mc.cores=mc.cores,verbose=verbose)
  })

  #extract all the candidate models

  if(criteria=="lasso"){
    candidate_pool=as.data.frame(matrix(NA,nrow=sim_times*nmodel,ncol=featurecap))
    k=1
    for(i in 1:sim_times){
      for(j in 1:nmodel){
        selected_features=candidate_models[[i]]$model[[j]]
        if(length(selected_features)>featurecap){
          candidate_pool[k,1:featurecap]=selected_features[1:featurecap]
        }else{
          candidate_pool[k,1:length(selected_features)]=selected_features
        }
        k=k+1
      }
    }
  }else{
    candidate_pool=as.data.frame(matrix(NA,nrow=sim_times*nmodel,ncol=featurecap))

    for(i in 1:sim_times){
      for(j in 1:nmodel){
        selected_features=row.names(as.data.frame(candidate_models[[i]]$model[[j]]$coefficients))[-(1:ncol(data_nosnp))]
        candidate_pool[(nmodel*(i-1)+j),(1:length(selected_features))]=selected_features
      }
    }
  }

  candidate_pool=unique(candidate_pool)

  if(verbose) cat('Step 1 selects',nrow(candidate_pool),'candidate models','\n')

  if(returnwork){
    work=vector()
    for(i in 1:sim_times){
      work[i]=candidate_models[[i]]$max_feature_sim
    }
  }

  n_total=nrow(data_nosnp)

  set.seed(kfoldseed)

  #split data into k folds
  if(method=="simple"){
    split=kfold_split(data_nosnp[,"outcome"],fold=fold)
  }else if(method=="stratified"){
    split=kfold_split(data_nosnp[,"outcome"],fold=fold,method=method)
  }else stop("method must be either simple or stratified")

  #start k-fold cross-validation

  R2_kfold_valid=as.data.frame(matrix(NA,nrow=fold,ncol=nrow(candidate_pool)))
  R2_kfold_test=as.data.frame(matrix(NA,nrow=fold,ncol=nrow(candidate_pool)))

  R2_kfold_average_valid=vector()
  R2_kfold_average_test=vector()

  test_index <- function(p){
    if(p<fold) return(p+1)
    if(p==fold) return(1)
  }

  for(i in 1:nrow(candidate_pool)){
    if(verbose) cat('Candidate model',i,'has feature',
                    unlist(candidate_pool[i,which(!is.na(candidate_pool[i,]))]),'\n')
    if(runparallel){
      if(verbose) cat('Begin validation \n')
      R2_valid_gain=parallel::mclapply(1:fold,function(s){
        infer_fixedfeatures(data_nosnp,featuredata,
                            train=(1:n_total)[-c(split[[s]],split[[test_index(s)]])],
                            test=split[[s]],
                            features=as.character(gsub('`','',candidate_pool[i,which(!is.na(candidate_pool[i,]))])),
                            usebinary=usebinary,gain=gain,R2only=TRUE,verbose=verbose)
      },mc.cores=mc.cores)
      if(verbose) cat('Begin test \n')
      R2_test_gain=parallel::mclapply(1:fold,function(s){
        infer_fixedfeatures(data_nosnp,featuredata,
                            train=(1:n_total)[-c(split[[s]],split[[test_index(s)]])],
                            test=split[[test_index(s)]],
                            features=as.character(gsub('`','',candidate_pool[i,which(!is.na(candidate_pool[i,]))])),
                            usebinary=usebinary,gain=gain,R2only=TRUE,verbose=verbose)
      },mc.cores=mc.cores)
    }else{
      if(verbose) cat('Begin validation \n')
      R2_valid_gain=lapply(1:fold,function(s){
        infer_fixedfeatures(data_nosnp,featuredata,
                            train=(1:n_total)[-c(split[[s]],split[[test_index(s)]])],
                            test=split[[s]],
                            features=as.character(gsub('`','',candidate_pool[i,which(!is.na(candidate_pool[i,]))])),
                            usebinary=usebinary,gain=gain,R2only=TRUE,verbose=verbose)
      })
      if(verbose) cat('Begin test \n')
      R2_test_gain=lapply(1:fold,function(s){
        infer_fixedfeatures(data_nosnp,featuredata,
                            train=(1:n_total)[-c(split[[s]],split[[test_index(s)]])],
                            test=split[[test_index(s)]],
                            features=as.character(gsub('`','',candidate_pool[i,which(!is.na(candidate_pool[i,]))])),
                            usebinary=usebinary,gain=gain,R2only=TRUE,verbose=verbose)
      })
    }
    R2_kfold_valid[,i]=unlist(R2_valid_gain)
    R2_kfold_average_valid[i]=mean(R2_kfold_valid[,i])
    R2_kfold_test[,i]=unlist(R2_test_gain)
    R2_kfold_average_test[i]=mean(R2_kfold_test[,i])
    if(gain){
      if(verbose) cat('Average gain for candidate model',i,'in validation set is',R2_kfold_average_valid[i],'\n')
    }else{
      if(verbose) cat('Average total variance explained by candidate model',i,'in validation set is',
                      R2_kfold_average_valid[i],'\n')
    }

  }

  #select the best model based on the largest out-of-sample R^2 from k-fold cv
  best_candidate_index=which.max(R2_kfold_average_valid)
  if(gain){
    if(verbose) cat('The best model is Model',best_candidate_index,'with average out-of-sample gain',
                    R2_kfold_average_test[best_candidate_index],'\n')
  }else{
    if(verbose) cat('The best model is Model',best_candidate_index,'which explains',
                    R2_kfold_average_test[best_candidate_index],'average out-of-sample variance \n')
  }
  selected_features=candidate_pool[best_candidate_index,
                                   which(!is.na(candidate_pool[best_candidate_index,]))]

  if(returnwork){
    return(list(R2_test_gain=R2_kfold_test[,best_candidate_index],
                selected_features=selected_features,
                work=work))
  }else{
    return(list(R2_test_gain=R2_kfold_test[,best_candidate_index],
                selected_features=selected_features))
  }
}


#' @rdname do_cv
#' @export
do_cv_step1 <- function(data_nosnp,featuredata,train_proportion=0.5,
                        featurecap=dim(featuredata)[2],usebinary=1,
                        method="simple",criteria="BIC",nmodel=3,
                        splitseed=123,runparallel=FALSE,mc.cores=6,verbose=FALSE){

  colnames(data_nosnp)[1]='outcome'

  #The first step for HTRX
  #split the dataset at first
  #Then pass all the required data/parameters to "infer_step1" function to select candidate models

  set.seed(splitseed)
  n_total=nrow(data_nosnp)
  if(method=="simple"){
    split=twofold_split(data_nosnp[,"outcome"],train_proportion)
  }else if(method=="stratified"){
    split=twofold_split(data_nosnp[,"outcome"],train_proportion,method)
  }else stop("method must be either simple or stratified")
  res  <- infer_step1(data_nosnp,featuredata,
                      split$train,criteria=criteria,
                      featurecap=featurecap,usebinary=usebinary,nmodel=nmodel,
                      runparallel=runparallel,mc.cores=mc.cores,verbose=verbose)

  return(res)
}


#' @rdname do_cv
#' @export
infer_step1 <- function(data_nosnp,featuredata,train,criteria="BIC",
                        featurecap=dim(featuredata)[2],usebinary=1,nmodel=nmodel,
                        runparallel=FALSE, mc.cores=6,verbose=FALSE) {

  colnames(data_nosnp)[1]='outcome'

  if(criteria=='lasso'){
    if(usebinary==0){
      cvfit <- glmnet::cv.glmnet(as.matrix(featuredata[train,]), data_nosnp[train,'outcome'])
    }else{
      cvfit <- glmnet::cv.glmnet(as.matrix(featuredata[train,]), data_nosnp[train,'outcome'],family="binomial")
    }

    lambda_order=order(cvfit$cvm)
    cv_lambda <- cvfit$lambda[lambda_order]

    modellist <- list()
    k=1
    for(i in 1:length(cv_lambda)){
      coef_model=coef(cvfit, s = cv_lambda[i])[-1,]
      feature_select=names(coef_model)[which(coef_model!=0)]
      if(length(feature_select)!=0){
        modellist[[k]]=feature_select
        k=k+1
      }
    }
    modellist=unique(modellist)

    if(length(modellist)<nmodel){
      if(verbose) cat('Selecting', length(modellist), 'different models \n')
      modellist[(length(modellist)+1):nmodel]=modellist[length(modellist)]
      return(list(model=modellist[1:nmodel],
                  max_feature_sim=length(cv_lambda)))
    }

    if(length(modellist)>=nmodel){
      if(verbose) cat('Selecting features',modellist[[1]],'but we also keep another 2 choices \n')
      return(list(model=modellist[1:nmodel],
                  max_feature_sim=length(cv_lambda)))
    }

  }else{
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

    if(featurecap>dim(featuredata)[2]) featurecap=dim(featuredata)[2]

    ##train
    if(verbose) print("Training...")

    ##store the maximum number of features fit in the simulation
    max_feature_sim=featurecap
    for(i in 1:featurecap){
      if(verbose) cat('Adding Feature Number',i,'\n')
      cal <- function(j){
        data_try=cbind(data_use[train,,drop=FALSE],featuredata[train,j,drop=FALSE])
        model_try=themodel(outcome~.,data_try,usebinary)
        if(criteria=="AIC"){
          information_try_gain = AIC(model_try)
          if(verbose) cat('... trying feature',j,colnames(featuredata)[j],'with AIC',information_try_gain,'\n')
        }else{
          information_try_gain = AIC(model_try,k=log(nrow(data_try)))
          if(verbose) cat('... trying feature',j,colnames(featuredata)[j],'with BIC',information_try_gain,'\n')
        }
        return(information_try_gain)
      }
      if(runparallel==TRUE){
        information=parallel::mclapply(featurelist,cal,mc.cores=mc.cores)
      }else{
        information=lapply(featurelist,cal)
      }


      gc()
      minnumber=which.min(unlist(information))
      information_each[i] = min(unlist(information))
      minseq[i]=featurelist[minnumber]

      data_use=cbind(data_use,featuredata[,minseq[i],drop=FALSE])
      modellist[[i]]=themodel(outcome~.,data_use[train,,drop=FALSE],usebinary)
      featurename[i]=colnames(featuredata)[minseq[i]]
      colnames(data_use)[ncol(data_use)]=featurename[i]
      featurelist=featurelist[-minnumber]

      if(verbose) cat('... Using feature',minseq[i],colnames(featuredata)[minseq[i]],'\n')

      #keep three different models to increase the models in the candidate model pool
      if(i>=nmodel){
        if(information_each[i-(nmodel-2)]>information_each[i-(nmodel-1)]){
          max_feature_sim <- i
          break;
        }
      }
    }

    #choose the model with the top 3 smallest BIC

    #If there are only 2-3 features, we don't have so many models
    if(featurecap<nmodel){
      n_feature = order(information_each,decreasing=FALSE)[1:featurecap]

      if(verbose) cat(criteria, 'selects',featurecap,'different models \n')

      modellist[(length(modellist)+1):nmodel]=modellist[length(modellist)]

      return(list(model=modellist[n_feature[1:nmodel]],
                  max_feature_sim=max_feature_sim))
    }else{
      n_feature = order(information_each,decreasing=FALSE)[1:nmodel]

      if(verbose) cat(criteria, 'selects',nmodel,'different models \n')

      return(list(model=modellist[n_feature[1:nmodel]],
                  max_feature_sim=max_feature_sim))
    }
  }

}


#' @rdname do_cv
#' @export
infer_fixedfeatures <- function(data_nosnp,featuredata,train=(1:nrow(data_nosnp))[-test],test,
                                features,coefficients=NULL,gain=TRUE,usebinary=1,
                                R2only=FALSE,verbose=FALSE){

  colnames(data_nosnp)[1]='outcome'

  ## Make a model with a specified set of features from the training data
  ## Reporting the results on the test data
  ## Optionally setting coefficients
  data_use=cbind(data_nosnp,featuredata[,features,drop=FALSE])
  model_use=themodel(outcome~.,data_use[train,,drop=FALSE],usebinary)
  if(gain) model_nosnp=themodel(outcome~.,data_nosnp[train,,drop=FALSE],usebinary)
  if(!all(is.null(coefficients))){
    model_use$coefficients[]=coefficients
  }
  R2_use_gain = computeR2(mypredict(model_use,
                                    newdata=data_use[test,,drop=FALSE]),
                          data_nosnp[test,"outcome"],usebinary)
  if(gain) {
    R2_nosnp_test= computeR2(mypredict(model_nosnp,
                                       newdata=data_nosnp[test,,drop=FALSE]),
                             data_nosnp[test,"outcome"],usebinary)
    R2_use_gain=R2_use_gain - R2_nosnp_test
    if(verbose) cat('Relative gain = ',R2_use_gain,'\n')
  }else{
    if(verbose) cat('Total variance explained = ',R2_use_gain,'\n')
  }
  if(R2only){
    list(R2=R2_use_gain)
  }else{
    list(R2=R2_use_gain,model=model_use,null=model_nosnp)
  }
}


