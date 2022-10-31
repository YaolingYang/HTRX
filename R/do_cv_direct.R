#' @title Direct HTRX: 10-fold cross-validation on short haplotypes
#' @description Direct 10-fold cross-validation used to compute the out-of-sample variance explained by selected features from HTRX.
#' It can be applied to select haplotypes based on HTR, or select single nucleotide polymorphisms (SNPs).
#' @name do_cv_direct
#'
#' @param data_nosnp a data frame with outcome (the outcome must be the first column),
#' fixed covariates (for example, sex, age and the first 18 PCs) if there are,
#' and without SNPs or haplotypes.
#' @param featuredata a data frame of the feature data, e.g. haplotype data created by HTRX or SNPs.
#' These features exclude all the data in \code{data_nosnp}, and will be selected using 2-step cross-validation.
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
#' @param runparallel logical. Use parallel programming based on \code{mclapply} function from R package \code{"parallel"} or not.
#' Note that for Windows users, \code{mclapply} doesn't work, so please set \code{runparallel=FALSE} (default).
#' @param mc.cores an integer giving the number of cores used for parallel programming.
#' By default, \code{mc.cores=6}.
#' This only works when \code{runparallel=TRUE}.
#' @param tenfoldseed a positive integer specifying the seed used to
#' split data for 10-fold cross validation. By default, \code{tenfoldseed=123}.
#' @param verbose logical. If \code{verbose=TRUE}, print out the inference steps. By default, \code{verbose=FALSE}.
#'
#' @details Function \code{do_cv_direct} directly performs 10-fold cross-validation: features are
#' selected from the training set using a specified \code{criteria},
#' and the out-of-sample variance explained by the selected features are computed on the test set.
#' This function runs faster than \code{\link{do_cv}} with large \code{sim_times}, but may lose
#' some accuracy, and it doesn't return a fixed set of features.
#'
#'
#' @return \code{do_cv_direct} returns a list of the out-of-sample variance explained in each of the test set,
#' and the features selected in each of the 10 training sets.
#'
#' @references Barrie W, Yang Y, Attfield K E, et al. Genetic risk for Multiple Sclerosis originated in Pastoralist Steppe populations. bioRxiv (2022).
#'
#' Efron, B. Bootstrap Methods: Another Look at the Jackknife. Ann. Stat. 7, 1-26 (1979).
#'
#' Kass, R. E. & Wasserman, L. A Reference Bayesian Test for Nested Hypotheses and its Relationship to the Schwarz Criterion. J. Am. Stat. Assoc. 90, 928-934 (1995).
#'
#' McFadden, D. Conditional logit analysis of qualitative choice behavior. (1973).
#'
#' Akaike, Hirotogu. "Information theory and an extension of the maximum likelihood principle." Selected papers of hirotugu akaike. Springer, New York, NY, 199-213 (1998).
#'
#' Tibshirani, R. Regression shrinkage and selection via the lasso. Journal of the Royal Statistical Society: Series B (Methodological), 58(1), 267-288 (1996).
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
#' HTRX_matrix=make_htrx(HTRX::example_hap1[,1:4],
#'                       HTRX::example_hap2[,1:4])
#'
#' ## If the data is haploid, please set
#' ## HTRX_matrix=make_htrx(HTRX::example_hap1[,1:4],
#' ##                       HTRX::example_hap1[,1:4])
#'
#' ## next compute the maximum number of independent features
#' featurecap=htrx_max(nsnp=4,cap=10)
#' ## then perform HTRX using direct cross-validation
#' ## If we want to compute the total variance explained
#' ## we can set gain=FALSE in the above example
#' \donttest{
#' htrx_results <- do_cv_direct(HTRX::example_data_nosnp[,1:3],
#'                              HTRX_matrix,featurecap=featurecap,
#'                              usebinary=1,method="stratified",
#'                              criteria="lasso",gain=TRUE,
#'                              runparallel=FALSE,verbose=TRUE)
#' }
NULL

#' @rdname do_cv_direct
#' @export
do_cv_direct <- function(data_nosnp,featuredata,
                         featurecap=dim(featuredata)[2],usebinary=1,
                         method="simple",criteria="BIC",gain=TRUE,
                         runparallel=FALSE,mc.cores=6,tenfoldseed=123,
                         verbose=FALSE){

  colnames(data_nosnp)[1]='outcome'

  set.seed(tenfoldseed)

  n_total=nrow(featuredata)

  #split data into 10 folds
  if(method=="simple"){
    split=tenfold_split(1:n_total)
  }else if(method=="stratified"){
    split=tenfold_split(1:n_total,strat=data_nosnp[,"outcome"],method)
  }else stop("method must be either simple or stratified")

  features <- list()
  R2_test <- vector()
  for(m in 1:10){
    if(verbose) cat('10-fold cv Round', m, '\n')
    test=split[[m]]
    train=(1:n_total)[-test]

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
      features[[m]]=as.character(gsub('`','',modellist[[1]]))
      if(verbose) cat('Selecting features',features[[m]],'\n')
    }else{
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
        if(i>=2){
          if(information_each[i]>information_each[i-1]){
            break;
          }
        }

        best_model <- modellist[[which.min(information_each)]]

        features[[m]]=as.character(gsub('`','',row.names(as.data.frame(best_model$coefficients)))[-(1:ncol(data_nosnp))])
        if(verbose) cat('Selecting features',features[[m]],'\n')
      }
    }


    R2_test[m] <- infer_fixedfeatures(data_nosnp,featuredata,test=test,
                                      features=features[[m]],
                                      usebinary=usebinary,gain=gain,R2only=TRUE,verbose=verbose)$R2
    if(gain){
      if(verbose){
        cat('The average out-of-sample gain is', mean(R2_test), '\n')
      }
    }else{
      if(verbose){
        cat('The average out-of-sample variance explained is', mean(R2_test), '\n')
      }
    }

  }
  return(list(R2_test_gain=R2_test,
              selected_features=features))

}
