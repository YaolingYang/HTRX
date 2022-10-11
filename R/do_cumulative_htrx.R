#' @title Cumulative HTRX on long haplotypes
#' @description Two-step cross-validation used to select the best HTRX model for longer haplotypes,
#' i.e. include at least 7 single nucleotide polymorphisms (SNPs).
#' @name do_cumulative_htrx
#'
#' @param data_nosnp a data frame with outcome (the outcome must be the first column)
#' and fixed covariates (for example, sex, age and the first 18 PCs)
#' and without SNPs or haplotypes.
#' @param hap1 a data frame of the SNPs' genotype of the first genome. The genotype of a SNP for each individual is either 0 (reference allele) or 1 (alternative allele).
#' @param hap2 a data frame of the SNPs' genotype of the second genome.
#' The genotype of a SNP for each individual is either 0 (reference allele) or 1 (alternative allele).
#' #' By default, hap2=hap1 representing haploid.
#' @param train_proportion a positive number between 0 and 1 giving
#' the proportion of the training dataset when splitting data into 2 folds.
#' By default, train_proportion=0.5.
#' @param sim_times an integer giving the number of simulations in step 1 (see details).
#' By default, sim_times=10.
#' @param featurecap a positive integer which manually sets the maximum number of independent features.
#' By default, featurecap=40.
#' @param usebinary a non-negative number representing different models.
#' Use linear model if usebinary=0,
#' use logistic regression model via fastglm if usebinary=1 (by default),
#' and use logistic regression model via glm if usebinary>1.
#' @param randomorder logical. If randomorder=TRUE (default),
#' use random order of all the SNPs to add SNPs in cumulative HTRX.
#' @param fixorder a vector of the fixed order of SNPs to be added in cumulative HTRX.
#' This only works by setting randomorder=FALSE. Otherwise, fixorder=NULL (default).
#' The length of "fixorder" can be smaller than the total number of SNPs,
#' i.e. users can specify the order of some instead of all of the SNPs.
#' @param method the method used for data splitting, either "simple" (default) or "stratified".
#' @param criteria the information criteria for model selection, either "BIC" (default) or "AIC".
#' @param gain logical. If gain=TRUE (default), report the variance explained in addition to fixed covariates;
#' otherwise, report the total variance explained by all the variables.
#' @param runparallel logical. Use parallel programming based on "mclapply" function or not.
#' Note that for Windows users, "mclapply" doesn't work, so please set runparallel=FALSE (default).
#' @param mc.cores an integer giving the number of cores used for parallel programming.
#' By default, mc.cores=6.
#' This only works when runparallel=TRUE.
#' @param rareremove logical. Remove rare SNPs and haplotypes or not. By default, rareremove=FALSE.
#' @param rare_threshold a numeric number below which the haplotype or SNP is removed.
#' This only works when rareremove=TRUE. By default, rare_threshold=0.001.
#' @param dataseed a vector of the seed that each simulation in step 1 (see details) uses.
#' The length of dataseed must be the same as sim_times.
#' By default, dataseed=1:sim_times.
#' @param tenfoldseed a positive integer specifying the seed used to
#' split data for 10-fold cross validation. By default, tenfoldseed=123.
#' @param returnall logical. If returnall=TRUE, return all the candidate models and
#' the variance explained in each of 10 test set for these the candidate models.
#' If returnall=FALSE (default), only return the best candidate model
#' and the variance explained in each of 10 test set by this model.
#' @param htronly logical. If htronly=TRUE, only haplotypes with interaction
#' between all the SNPs will be assessed. Please set max_int=NULL when htronly=TRUE.
#' By default, htronly=FALSE.
#' @param max_int a positive integer which specifies the maximum number of SNPs that can interact.
#' If no value is given, interactions between all the SNPs will be considered.
#' @param returnwork logical. If returnwork=TRUE, return a vector of the maximum number
#' of features that are assessed in each simulation, excluding the fixed covariates.
#' This is used to assess how much computational 'work' is done in step 1(2) of HTRX (see details).
#' By default, returnwork=FALSE.
#' @param verbose logical. If verbose=TRUE, print out the inference steps. By default, verbose=FALSE.
#' @param splitseed a positive integer giving the seed that a single simulation in step 1 (see details) uses.
#' @param featuredata a data frame of the feature data, e.g. haplotype data created by HTRX or SNPs.
#' These features exclude all the data in data_nosnp, and will be selected using 2-step cross-validation.
#' @param train a vector of the indexes of the training data.
#' @param featurename a character giving the names of features (haplotypes).
#'
#' @details Longer haplotypes are important for discovering interactions.
#' However, there are \ifelse{html}{\out{3<sup>k</sup>}}{\eqn{3^k}}-1 haplotypes in HTRX
#' if the region contains k SNPs,
#' making HTRX (\code{\link{do_cv}}) unrealistic to apply on for regions with large numbers of SNPs.
#' To address this issue, we proposed "cumulative HTRX" (\code{\link{do_cumulative_htrx}})
#' that enables HTRX to run on longer haplotypes,
#'  i.e. haplotypes which include at least 7 SNPs (we recommend).
#'  There are 2 steps to implement cumulative HTRX.
#'
#' Step 1: extend haplotypes and select candidate models.
#'
#' (1) Randomly sample a subset (50%) of data,
#' use stratified sampling when the outcome is binary.
#' This subset is used for all the analysis in (2) and (3);
#'
#' (2) Start with L randomly chosen SNPs from the entire k SNPs,
#' and keep the top M haplotypes that are chosen from the forward regression.
#' Then add another SNP to the M  haplotypes to create 3M+2 haplotypes.
#' There are 3M haplotypes obtained by adding "0", "1" or "X" to the previous M haplotypes,
#' as well as 2 bases of the added SNP, i.e. "XX...X0" and "XX...X1"
#' (as "X" was implicitly used in the previous step).
#' The top M haplotypes from them are then selected using forward regression.
#' Repeat this process until obtaining M haplotypes which include k-1 SNPs;
#'
#' (3) Add the last SNP to create 3M+2 haplotypes.
#' Afterwards, start from a model with fixed covariates (e.g. 18 PCs, sex and age),
#' perform forward regression on the training set,
#' and select s models with the lowest BIC to enter the candidate model pool;
#'
#' (4) repeat (1)-(3) B times, and select all the different models
#' in the candidate model pool as the candidate models.
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
#' Function \code{\link{do_cumulative_htrx_step1}} is the Step 1 (1)-(3) described above.
#' Function \code{\link{extend_haps}} is used to select haplotypes in the Step 1 (2) described above.
#' Function \code{\link{make_cumulative_htrx}} is used to generate the haplotype data
#' (by adding a new SNP into the haplotypes) from M haplotypes to 3M+2 haplotypes,
#' which is also described in the Step 1 (2)-(3).
#'
#' @return \code{\link{do_cumulative_htrx}} returns a list containing the best model selected,
#'  and the out-of-sample variance explained in each test set.
#'  If returnall=TRUE, this function also returns all the candidate models,
#'  and the out-of-sample variance explained in each test set by each candidate model.
#'
#' \code{\link{do_cv_step1}} returns a list of three candidate models selected by a single simulation.
#'
#' \code{\link{extend_haps}} returns a character of the names of the selected features.
#'
#' \code{\link{make_cumulative_htrx}} returns a data frame of the haplotype matrix.
#'
#' @references Barrie W, Yang Y, Attfield K E, et al. Genetic risk for Multiple Sclerosis originated in Pastoralist Steppe populations. bioRxiv (2022).
#'
#' Efron, B. Bootstrap Methods: Another Look at the Jackknife. Ann. Stat. 7, 1-26 (1979).
#'
#' Kass, R. E. & Wasserman, L. A Reference Bayesian Test for Nested Hypotheses and its Relationship to the Schwarz Criterion. J. Am. Stat. Assoc. 90, 928-934 (1995).
#' @examples
#' ## use dataset "example_hap1", "example_hap2" and "example_data_nosnp"
#' ## "example_hap1" and "example_hap2" are
#' ## both genomes of 8 SNPs for 5,000 individuals (diploid data)
#' ## "example_data_nosnp" is a simulated dataset
#' ## which contains the outcome (binary), sex, age and 18 PCs
#'
#' ## visualise the covariates data
#' ## we will use only the first two covariates: sex and age in the example
#' head(HTRX::example_data_nosnp)
#'
#' ## visualise the genotype data for the first genome
#' head(HTRX::example_hap1)
#'
#' ## we perform cumulative HTRX on all the 8 SNPs using 2-step cross-validation
#' ## to compute additional variance explained by haplotypes
#' ## If the data is haploid, please set hap2=HTRX::example_hap1
#' ## If you want to compute total variance explained, please set gain=FALSE
#' ## For Linux/MAC users, we recommend setting runparallel=TRUE
#' \donttest{
#' cumu_htrx_results <- do_cumulative_htrx(HTRX::example_data_nosnp[1:500,1:3],
#'                                         HTRX::example_hap1[1:500,],
#'                                         HTRX::example_hap2[1:500,],
#'                                         train_proportion=0.5,sim_times=5,
#'                                         featurecap=10,usebinary=1,
#'                                         randomorder=TRUE,method="stratified",
#'                                         criteria="BIC",gain=TRUE,
#'                                         runparallel=FALSE,verbose=TRUE)
#' }
#' #This result would be more precise when setting larger sim_times and featurecap
NULL

#' @rdname do_cumulative_htrx
#' @export
do_cumulative_htrx <- function(data_nosnp,hap1,hap2=hap1,train_proportion=0.5,
                               sim_times=10,
                               featurecap=40,usebinary=1,randomorder=TRUE,fixorder=NULL,
                               method="simple",criteria="BIC",gain=TRUE,
                               runparallel=FALSE,mc.cores=6,rareremove=FALSE,
                               rare_threshold=0.001,
                               dataseed=1:sim_times,tenfoldseed=123,
                               returnall=FALSE,htronly=FALSE,max_int=NULL,
                               returnwork=FALSE,verbose=FALSE){

  colnames(data_nosnp)[1]='outcome'
  n_total=nrow(data_nosnp)

  #store all the candidate models from each simulation
  candidate_models=lapply(dataseed,function(s){
    results=do_cumulative_htrx_step1(data_nosnp,hap1,hap2,train_proportion,
                                     featurecap=featurecap,usebinary=usebinary,
                                     fixorder=fixorder,
                                     method=method,criteria=criteria,splitseed=s,
                                     runparallel=runparallel,
                                     rareremove=rareremove,rare_threshold=rare_threshold,
                                     htronly=htronly,max_int=max_int,verbose=verbose)
  })

  #if there are only two features, in each seed of step 1 we only select two candidate models
  candidate_pool=as.data.frame(matrix(NA,nrow=sim_times*min(featurecap,3),ncol=featurecap))
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
  #all the unuqie candidate models
  candidate_pool=unique(candidate_pool)

  if(verbose) cat('Step 1 selects',nrow(candidate_pool),'candidate models','\n')

  if(returnwork){
    work=vector()
    for(i in 1:sim_times){
      work[i]=candidate_models[[i]]$max_feature_sim
    }
  }

  set.seed(tenfoldseed)

  #start 10-fold cross-validation

  if(method=="simple"){
    split=tenfold_split(1:n_total)
  }else if(method=="stratified"){
    split=tenfold_split(1:n_total,data_nosnp[,"outcome"],method)
  }else stop("method must be either simple or stratified")

  R2_10fold=as.data.frame(matrix(NA,nrow=10,ncol=nrow(candidate_pool)))

  R2_10fold_average=vector()

  for(i in 1:nrow(candidate_pool)){
    if(verbose) cat('Candidate model',i,'has feature',unlist(candidate_pool[i,which(!is.na(candidate_pool[i,]))]),'\n')
    if(runparallel){
      R2_test_gain=parallel::mclapply(1:10,function(s){
        featuredata=make_htrx(hap1,hap2,rareremove=rareremove,rare_threshold=rare_threshold,
                              fixedfeature=as.character(candidate_pool[i,which(!is.na(candidate_pool[i,]))]))
        infer_fixedfeatures(data_nosnp,featuredata,test=split[[s]],
                            features=as.character(candidate_pool[i,which(!is.na(candidate_pool[i,]))]),
                            usebinary=usebinary,gain=gain,R2only=TRUE,verbose=verbose)
      },mc.cores=mc.cores)
    }else{
      R2_test_gain=lapply(1:10,function(s){
        featuredata=make_htrx(hap1,hap2,rareremove=rareremove,rare_threshold=rare_threshold,
                              fixedfeature=as.character(candidate_pool[i,which(!is.na(candidate_pool[i,]))]))
        infer_fixedfeatures(data_nosnp,featuredata,test=split[[s]],
                            features=as.character(candidate_pool[i,which(!is.na(candidate_pool[i,]))]),
                            usebinary=usebinary,gain=gain,R2only=TRUE,verbose=verbose)
      })
    }
    R2_10fold[,i]=unlist(R2_test_gain)
    R2_10fold_average[i]=mean(R2_10fold[,i])
    if(gain){
      if(verbose) cat('Average gain for candidate model',i,'is',R2_10fold_average[i],'\n')
    }else{
      if(verbose) cat('Average total variance explained by candidate model',i,'is',R2_10fold_average[i],'\n')
    }
  }
  #select the best model based on the largest out-of-sample R^2 from 10-fold cv
  best_candidate_index=which.max(R2_10fold_average)
  if(gain){
    if(verbose)  cat('The best model is Model',best_candidate_index,
                     'with average gain',R2_10fold_average[best_candidate_index],'\n')
  }else{
    if(verbose) cat('The best model is Model',best_candidate_index,
                    'which explains',R2_10fold_average[best_candidate_index],'average total variance \n')
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


#' @rdname do_cumulative_htrx
#' @export
do_cumulative_htrx_step1 <- function(data_nosnp,hap1,hap2=hap1,train_proportion=0.5,
                                     featurecap=40,usebinary=1,randomorder=TRUE,fixorder=NULL,
                                     method="simple",criteria="BIC",
                                     splitseed=123,gain=TRUE,runparallel=FALSE,
                                     mc.cores=6,rareremove=FALSE,rare_threshold=0.001,
                                     htronly=FALSE,max_int=NULL,verbose=FALSE){
  colnames(data_nosnp)[1]='outcome'
  set.seed(splitseed)
  n_total=nrow(hap1)
  nsnp=ncol(hap1)

  #random order of SNPs added into cumulative HTRX process
  if(randomorder){
    snp_random=sample(1:nsnp)
  }else{
    if(!is.null(fixorder)){
      if(length(fixorder)==nsnp){
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
    split=twofold_split(1:n_total,train_proportion)
  }else if(method=="stratified"){
    split=twofold_split(1:n_total,train_proportion,data_nosnp[,"outcome"],method)
  }else stop("method must be either simple or stratified")


  if(nsnp<7) stop("no need cumulative HTRX, please directly use HTRX")

  for(k in 6:nsnp){
    ###select haplotypes based on cumulative R^2 on the training set
    if(k==6){
      if(htronly){
        htrx=make_htr(hap1[,1:k],hap2[,1:k],rareremove=rareremove,
                       rare_threshold=rare_threshold)
      }else{
        htrx=make_htrx(hap1[,1:k],hap2[,1:k],rareremove=rareremove,
                       rare_threshold=rare_threshold,max_int=max_int)
      }

      featurename=extend_haps(data_nosnp,htrx,split$train,
                              featurecap,usebinary,gain=gain,
                              runparallel=runparallel,mc.cores=mc.cores,verbose=verbose)

    }else{
      ###begin adding SNPs
      if(k<nsnp){
        htrx=make_cumulative_htrx(hap1[,1:k],hap2[,1:k],featurename,
                                  rareremove=rareremove,rare_threshold=rare_threshold,
                                  htronly=htronly,max_int=max_int)
        featurename=extend_haps(data_nosnp,htrx,split$train,
                                featurecap,usebinary,gain=gain,runparallel=runparallel,
                                mc.cores=mc.cores,verbose=verbose)
      }else{
        htrx=make_cumulative_htrx(hap1[,1:k],hap2[,1:k],featurename,
                                  rareremove=rareremove,rare_threshold=rare_threshold,
                                  htronly=htronly,max_int=max_int)
        if(randomorder){
          #return to the correct sequence of haplotype names
          for(q in 1:ncol(htrx)){
            colnames(htrx)[q]=Reduce(paste0,unlist(strsplit(colnames(htrx)[q],split=''))[order(snp_random)])
          }
        }

        #when the haplotypes include all the SNPs, we use all the remaining haplotypes for standard HTRX
        #The first step is to select candidate models
        res  <- infer_step1(data_nosnp,htrx,
                            split$train,criteria=criteria,
                            featurecap=featurecap,usebinary=usebinary,
                            runparallel=runparallel,mc.cores=mc.cores,verbose=verbose)

      }
    }
  }
  return(res)
}


#' @rdname do_cumulative_htrx
#' @export
extend_haps <- function(data_nosnp,featuredata,
                        train,
                        featurecap=dim(featuredata)[2],usebinary=1,gain=TRUE,
                        runparallel=FALSE,mc.cores=6,verbose=FALSE) {
  ## Perform training
  ## For a variable called "outcome" in "data_nosnp"
  ## appending and sequentially searching one feature at a time in "featuredata"
  ## Using "train" (indices) only
  ## "usebinary" controls the model, by default it uses "fastglm"
  ## "gain" controls whether we report the R2 or gain over the covariates (default)

  colnames(data_nosnp)[1]='outcome'
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

  if(featurecap>dim(featuredata)[2]) featurecap=dim(featuredata)[2]

  if(gain){
    if(verbose) print("Creating null model...")
    model_nosnp=themodel(outcome~.,data_nosnp[train,,drop=FALSE],usebinary)
    R2_nosnp_train=computeR2(mypredict(model_nosnp,
                                       newdata=data_nosnp[train,,drop=FALSE]),
                             data_nosnp[train,"outcome"],usebinary)
  }else{
    model_nosnp=NULL
    R2_nosnp_train=0
  }
  ##train
  if(verbose) print("Training...")
  for(i in 1:featurecap){
    if(verbose) cat('Adding Feature Number',i,'\n')
    cal <- function(j){
      data_try=cbind(data_use[train,,drop=FALSE],featuredata[train,j,drop=FALSE])
      model_try=themodel(outcome~.,data_try,usebinary)
      R2_try_gain = computeR2(mypredict(model_try,
                                        newdata=data_try),
                              data_nosnp[train,"outcome"],usebinary) - R2_nosnp_train
      if(gain&&verbose) cat('... trying feature',j,colnames(featuredata)[j],
                            'with gain',R2_try_gain,'\n')
      if(!gain&&verbose) cat('... trying feature',j,colnames(featuredata)[j],
                             'with total variance explained',R2_try_gain,'\n')
      return(R2_try_gain)
    }
    if(runparallel==TRUE){
      #running parallel
      R2=parallel::mclapply(featurelist,cal,mc.cores=mc.cores)
    }else{
      R2=lapply(featurelist,cal)
    }

    gc()
    maxnumber=which.max(unlist(R2))
    maxseq[i]=featurelist[maxnumber]

    if(verbose) cat('... Using feature',maxseq[i],colnames(featuredata)[maxseq[i]],'\n')
    data_use=cbind(data_use,featuredata[,maxseq[i],drop=FALSE])
    featurename[i]=colnames(featuredata)[maxseq[i]]
    colnames(data_use)[ncol(data_use)]=featurename[i]
    featurelist=featurelist[-maxnumber]
  }

  return(featurename)
}


#' @rdname do_cumulative_htrx
#' @export
make_cumulative_htrx <- function(hap1,hap2=hap1,featurename,rareremove=FALSE,
                                 rare_threshold=0.001,htronly=FALSE,max_int=NULL){
  ## make a HTRX feature matrix for all the N-SNP haplotype
  ## with given featurename of N-1-SNP haplotype for cumulative HTRX
  n=n_total=dim(hap1)[1]
  nsnp=dim(hap1)[2]
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

  #retain rows with the interaction between max_int SNPs.
  if(!is.null(max_int)){
    if(htronly) stop('HTR cannot be performed because the given value of max_int.')
    retain_index <- vector()
    for(i in 1:nrow(combinations)){
      if(length(which(combinations[i,]!='X'))<=max_int) retain_index=c(retain_index,i);
    }
    combinations=combinations[retain_index,]
  }
  if(is.null(max_int)&htronly){
    retain_index <- vector()
    for(i in 1:nrow(combinations)){
      if(length(which(combinations[i,]!='X'))==nsnp) retain_index=c(retain_index,i);
    }
    combinations=combinations[retain_index,]
  }

  HTRX_matrix <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))
  HTRX_matrix2 <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))

  ##the genotype must be 0 for reference allele and 1 for alternative allele
  for(i in 1:nrow(combinations)){
    index1=Reduce(intersect,
                  lapply(1:nsnp,function(x)
                  {
                    if(combinations[i,x]=='X')return(1:n);
                    if(combinations[i,x]!='X')return(which(hap1[,x]==as.numeric(combinations[i,x])));
                  })
    )
    index2=Reduce(intersect,
                  lapply(1:nsnp,function(x)
                  {
                    if(combinations[i,x]=='X')return(1:n);
                    if(combinations[i,x]!='X')return(which(hap2[,x]==as.numeric(combinations[i,x])));
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
    if(sum(HTRX_matrix[,i])==0||sum(HTRX_matrix[,i])==nrow(HTRX_matrix)){
      missing=c(missing,i)
    }
  }
  if(length(missing)!=0) HTRX_matrix=HTRX_matrix[,-missing];

  #remove rare haplotypes or not
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
