#' @title HTRX Model selection on short haplotypes
#' @description Two-step cross-validation used to select the best HTRX model.
#' It can be applied to select haplotypes based on HTR, or select single nucleotide polymorphisms (SNPs).
#' @name do_cv
#'
#' @param data_nosnp a data frame with outcome (the outcome must be the first column)
#'  and fixed covariates (for example, sex, age and the first 18 PCs)
#' and without SNPs or haplotypes.
#' @param featuredata a data frame of the feature data, e.g. haplotype data created by HTRX or SNPs.
#' These features exclude all the data in data_nosnp, and will be selected using 2-step cross-validation.
#' @param train_proportion a positive number between 0 and 1 giving
#' the proportion of the training dataset when splitting data into 2 folds.
#' By default, train_proportion=0.5.
#' @param sim_times an integer giving the number of simulations in step 1 (see details).
#' By default, sim_times=20.
#' @param featurecap a positive integer which manually sets the maximum number of independent features.
#' By default, featurecap=40.
#' @param usebinary a non-negative number representing different models.
#' Use linear model if usebinary=0,
#' use logistic regression model via fastglm if usebinary=1 (by default),
#' and use logistic regression model via glm if usebinary>1.
#' @param method the method used for data splitting, either "simple" (default) or "stratified".
#' @param criteria the information criteria for model selection, either "BIC" (default) or "AIC".
#' @param gain logical. If gain=TRUE (default), report the variance explained in addition to fixed covariates;
#' otherwise, report the total variance explained by all the variables.
#' @param runparallel logical. Use parallel programming based on "mclapply" function or not.
#' Note that for Windows users, "mclapply" doesn't work, so please set runparallel=FALSE (default).
#' @param mc.cores an integer giving the number of cores used for parallel programming.
#' By default, mc.cores=6.
#' This only works when runparallel=TRUE.
#' @param tenfoldseed a positive integer specifying the seed used to
#' split data for 10-fold cross validation. By default, tenfoldseed=123.
#' @param returnall logical. If returnall=TRUE, return all the candidate models and
#' the variance explained in each of 10 test set for these the candidate models.
#' If returnall=FALSE (default), only return the best candidate model
#' and the variance explained in each of 10 test set by this model.
#' @param returnwork logical. If returnwork=TRUE, return a vector of the maximum number
#' of features that are assessed in each simulation, excluding the fixed covariates.
#' This is used to assess how much computational 'work' is done in step 1(2) of HTRX (see details).
#' By default, returnwork=FALSE.
#' @param verbose logical. If verbose=TRUE, print out the inference steps. By default, verbose=FALSE.
#' @param splitseed a positive integer giving the seed of data split.
#' @param train a vector of the indexes of the training data.
#' @param test a vector of the indexes of the test data.
#' @param features a character of the names of the fixed features, excluding the intercept.
#' @param coefficients a vector giving the coefficients of the fixed features, including the intercept.
#' If the fixed features don't have fixed coefficients, set coefficients=NULL (default).
#' @param R2only logical. If R2only=TRUE, function infer_fixedfeatures only
#' returns the variance explained in the test data.
#' By default, R2only=FALSE.
#'
#' @details Function \code{\link{do_cv}} is the main function used for selecting haplotypes from HTRX or SNPs.
#' It is a two-step issued and is used for alleviate overfitting.
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
#' (2) Start from a model with fixed covariates (e.g. 18 PCs, sex and age),
#' and perform forward regression on the subset,
#' i.e. iteratively choose a feature (in addition to the fixed covariates)
#' to add whose inclusion enables the model to explain the largest variance,
#' and select s models with the lowest Bayesian Information Criteria (BIC)
#' to enter the candidate model pool;
#'
#' (3) repeat (1)-(2) B times, and select all the different models in the candidate model pool
#'  as the candidate models.
#'
#' Step 2: select the best model using 10-fold cross-validation.
#'
#' (1) Randomly split the whole data into 10 groups with approximately equal sizes,
#' using stratified sampling when the outcome is binary;
#'
#' (2) In each of the 10 folds, use a different group as the test dataset,
#' and take the remaining groups as the training dataset.
#' Then, fit all the candidate models on the training dataset,
#' and use these fitted models to compute the additional variance explained by features
#' (out-of-sample R2) in the test dataset.
#' Finally, select the candidate model with the biggest
#' average out-of-sample R2 as the best model.
#'
#' Function \code{\link{do_cv_step1}} is the Step 1 (1)-(2) described above.
#' Function \code{\link{infer_step1}} is the Step 1 (2) described above.
#' Function \code{\link{infer_fixedfeatures}} is used to fit all the candidate models on the training dataset,
#' and compute the additional variance explained by features (out-of-sample R2) in the test dataset,
#' as described in the Step 2 (2) bove.
#'
#' @return \code{\link{do_cv}} returns a list containing the best model selected, and the out-of-sample variance explained in each test set.
#' If returnall=TRUE, this function also returns all the candidate models,
#' and the out-of-sample variance explained in each test set by each candidate model.
#'
#' \code{\link{do_cv_step1}} and \code{\link{infer_step1}} return a list of three candidate models selected by a single simulation.
#'
#' \code{\link{infer_fixedfeatures}} returns a list of the variance explained in the test set if R2only=TRUE,
#' otherwise, it returns a list of the variance explained in the test set, the model including all the variables,
#' and the null model, i.e. the model with outcome and fixed covariates only.
#'
#' @references Barrie W, Yang Y, Attfield K E, et al. Genetic risk for Multiple Sclerosis originated in Pastoralist Steppe populations. bioRxiv (2022).
#'
#' Efron, B. Bootstrap Methods: Another Look at the Jackknife. Ann. Stat. 7, 1-26 (1979).
#'
#' Kass, R. E. & Wasserman, L. A Reference Bayesian Test for Nested Hypotheses and its Relationship to the Schwarz Criterion. J. Am. Stat. Assoc. 90, 928-934 (1995).
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
#' htrx_results <- do_cv(HTRX::example_data_nosnp[1:300,1:2],
#'                       HTRX_matrix,train_proportion=0.5,
#'                       sim_times=1,featurecap=4,usebinary=1,
#'                       method="simple",criteria="BIC",
#'                       gain=TRUE,runparallel=FALSE,verbose=TRUE)
#' ## If we want to compute the total variance explained
#' ## we can set gain=FALSE in the above example
#'
#' ## Below is an example with a large sample size and simulations
#' \donttest{
#' HTRX_matrix=make_htrx(HTRX::example_hap1[,1:4],
#'                       HTRX::example_hap1[,1:4])
#' ## next compute the maximum number of independent features
#' featurecap=htrx_max(nsnp=4,cap=10)
#' ## then perform HTRX using 2-step cross-validation
#' htrx_results <- do_cv(HTRX::example_data_nosnp[,1:3],
#'                       HTRX_matrix,train_proportion=0.5,
#'                       sim_times=5,featurecap=featurecap,usebinary=1,
#'                       method="stratified",criteria="BIC",
#'                       gain=TRUE,runparallel=FALSE,verbose=TRUE)
#' }
#' #This result would be more precise when setting larger sim_times and featurecap
NULL

#' @rdname do_cv
#' @export
do_cv <- function(data_nosnp,featuredata,train_proportion=0.5,
                  sim_times=20,
                  featurecap=dim(featuredata)[2],usebinary=1,
                  method="simple",criteria="BIC",gain=TRUE,
                  runparallel=FALSE,mc.cores=6,tenfoldseed=123,
                  returnall=FALSE,returnwork=FALSE,verbose=FALSE){

  colnames(data_nosnp)[1]='outcome'

  #First step: obtain all the candidate models from running "sim_times" times simulation
  candidate_models=lapply(1:sim_times,function(s){
    results=do_cv_step1(data_nosnp,featuredata,train_proportion,
                        featurecap=featurecap,usebinary=usebinary,
                        method=method,criteria=criteria,splitseed=s,
                        runparallel=runparallel,mc.cores=mc.cores,verbose=verbose)
  })

  #extract all the candidate models
  candidate_pool=as.data.frame(matrix(NA,nrow=sim_times*min(featurecap,3),ncol=featurecap))
  #if there are only two features, in each seed of step 1 we only select two candidate models
  if(featurecap==2){
    for(i in 1:sim_times){
      selected_features1=row.names(as.data.frame(candidate_models[[i]]$model1$coefficients))[-(1:ncol(data_nosnp))]
      selected_features2=row.names(as.data.frame(candidate_models[[i]]$model2$coefficients))[-(1:ncol(data_nosnp))]
      candidate_pool[(2*i-1),(1:length(selected_features1))]=selected_features1
      candidate_pool[(2*i),(1:length(selected_features2))]=selected_features2
    }
  }else{
    for(i in 1:sim_times){
      selected_features1=row.names(as.data.frame(candidate_models[[i]]$model1$coefficients))[-(1:ncol(data_nosnp))]
      selected_features2=row.names(as.data.frame(candidate_models[[i]]$model2$coefficients))[-(1:ncol(data_nosnp))]
      selected_features3=row.names(as.data.frame(candidate_models[[i]]$model3$coefficients))[-(1:ncol(data_nosnp))]
      candidate_pool[(3*i-2),(1:length(selected_features1))]=selected_features1
      candidate_pool[(3*i-1),(1:length(selected_features2))]=selected_features2
      candidate_pool[(3*i),(1:length(selected_features3))]=selected_features3
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

  set.seed(tenfoldseed)

  #split data into 10 folds
  if(method=="simple"){
    split=tenfold_split(1:n_total)
  }else if(method=="stratified"){
    split=tenfold_split(1:n_total,strat=data_nosnp[,"outcome"],method)
  }else stop("method must be either simple or stratified")

  #start 10-fold cross-validation

  R2_10fold=as.data.frame(matrix(NA,nrow=10,ncol=nrow(candidate_pool)))

  R2_10fold_average=vector()

  for(i in 1:nrow(candidate_pool)){
    if(verbose) cat('Candidate model',i,'has feature',
                    unlist(candidate_pool[i,which(!is.na(candidate_pool[i,]))]),'\n')
    if(runparallel){
      R2_test_gain=parallel::mclapply(1:10,function(s){
        infer_fixedfeatures(data_nosnp,featuredata,test=split[[s]],
                            features=as.character(gsub('`','',candidate_pool[i,which(!is.na(candidate_pool[i,]))])),
                            usebinary=usebinary,gain=gain,R2only=TRUE,verbose=verbose)
      },mc.cores=mc.cores)
    }else{
      R2_test_gain=lapply(1:10,function(s){
        infer_fixedfeatures(data_nosnp,featuredata,test=split[[s]],
                            features=as.character(gsub('`','',candidate_pool[i,which(!is.na(candidate_pool[i,]))])),
                            usebinary=usebinary,gain=gain,R2only=TRUE,verbose=verbose)
      })
    }
    R2_10fold[,i]=unlist(R2_test_gain)
    R2_10fold_average[i]=mean(R2_10fold[,i])
    if(gain){
      if(verbose) cat('Average gain for candidate model',i,'is',R2_10fold_average[i],'\n')
    }else{
      if(verbose) cat('Average total variance explained by candidate model',i,'is',
                      R2_10fold_average[i],'\n')
    }

  }

  #select the best model based on the largest out-of-sample R^2 from 10-fold cv
  best_candidate_index=which.max(R2_10fold_average)
  if(gain){
    if(verbose) cat('The best model is Model',best_candidate_index,'with average gain',
                    R2_10fold_average[best_candidate_index],'\n')
  }else{
    if(verbose) cat('The best model is Model',best_candidate_index,'which explains',
                    R2_10fold_average[best_candidate_index],'average total variance \n')
  }
  selected_features=candidate_pool[best_candidate_index,
                                   which(!is.na(candidate_pool[best_candidate_index,]))]
  if(returnall){
    if(returnwork){
      return(list(R2_test_gain_candidates=R2_10fold,
                  candidates=candidate_pool,
                  R2_test_gain=R2_10fold[,best_candidate_index],
                  selected_features=selected_features,
                  work=work))
    }else{
      return(list(R2_test_gain_candidates=R2_10fold,
                  candidates=candidate_pool,
                  R2_test_gain=R2_10fold[,best_candidate_index],
                  selected_features=selected_features))
    }
  }else{
    if(returnwork){
      return(list(R2_test_gain=R2_10fold[,best_candidate_index],
                  selected_features=selected_features,
                  work=work))
    }else{
      return(list(R2_test_gain=R2_10fold[,best_candidate_index],
                  selected_features=selected_features))
    }
  }
}


#' @rdname do_cv
#' @export
do_cv_step1 <- function(data_nosnp,featuredata,train_proportion=0.5,
                        featurecap=dim(featuredata)[2],usebinary=1,
                        method="simple",criteria="BIC",
                        splitseed=123,runparallel=FALSE,mc.cores=6,verbose=FALSE){

  colnames(data_nosnp)[1]='outcome'

  #The first step for HTRX
  #split the dataset at first
  #Then pass all the required data/parameters to "infer_step1" function to select candidate models

  set.seed(splitseed)
  n_total=nrow(data_nosnp)
  if(method=="simple"){
    split=twofold_split(1:n_total,train_proportion)
  }else if(method=="stratified"){
    split=twofold_split(1:n_total,train_proportion,data_nosnp[,"outcome"],method)
  }else stop("method must be either simple or stratified")
  res  <- infer_step1(data_nosnp,featuredata,
                      split$train,criteria=criteria,
                      featurecap=featurecap,usebinary=usebinary,
                      runparallel=runparallel,mc.cores=mc.cores,verbose=verbose)

  return(res)
}


#' @rdname do_cv
#' @export
infer_step1 <- function(data_nosnp,featuredata,
                        train,criteria="BIC",
                        featurecap=dim(featuredata)[2],usebinary=1,
                        runparallel=FALSE, mc.cores=6,verbose=FALSE) {

  colnames(data_nosnp)[1]='outcome'

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
    if(i>=3){
      if(information_each[i-1]>information_each[i-2]){
        max_feature_sim <- i
        break;
      }
    }
  }

  #choose the model with the top 3 smallest BIC

  #If there are only 2-3 features, we don't have so many models
  if(featurecap==2){
    n_feature = order(information_each,decreasing=FALSE)[1:2]

    if(verbose) cat('BIC selects',n_feature[1],'features but we also keep models with',
                    n_feature[2],'features \n')

    return(list(model1=modellist[[n_feature[1]]],
                model2=modellist[[n_feature[2]]]))
  }else{
    n_feature = order(information_each,decreasing=FALSE)[1:3]

    if(verbose) cat('BIC selects',n_feature[1],'features but we also keep models with',
                    n_feature[2],'and',n_feature[3],'features \n')

    return(list(model1=modellist[[n_feature[1]]],
                model2=modellist[[n_feature[2]]],
                model3=modellist[[n_feature[3]]],
                max_feature_sim=max_feature_sim))
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
