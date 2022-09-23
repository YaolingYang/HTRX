#' @title Data split
#' @description Split data into ten or two folds.
#' @name tenfold_split
#' @param index_all a vector of the indexes of all the individuals.
#' @param strat a vector of the variable (usually the outcome), based on which the data is going to be stratified. This only works when method="stratified".
#' @param method the method to be used, either "simple" (default) or "stratified".
#' @param train_proportion a positive number between 0 and 1 giving the proportion of the training dataset when splitting data into 2 folds.
#'
#' @details Stratified sampling works only when the "strat" variable is binary (either 0 or 1),
#' and it ensures each fold has almost the same number of strat=0 and strat=1.
#'
#' Simple sampling randomly splits the data into k folds (k=2 or 10).
#'
#' Two-fold data split is used to select candidate models in Step 1 of HTRX or cumulative HTRX,
#' while 10-fold data split is used for 10-fold cross-validation in Step 2 which aims at selecting the best model.
#'
#' @return a list containing the indexes of different folds.
#' @examples
#' ## create the binary outcome (20% prevalence)
#' outcome=rbinom(200,1,0.2)
#'
#' ## simple sampling (10 folds)
#' tenfold_split(1:200)
#'
#' ## stratified sampling (10 folds)
#' tenfold_split(1:200,outcome,"stratified")
#'
#' ## simple sampling (2 folds, with 50% training data)
#' twofold_split(1:200,0.5)
#'
#' ## stratified sampling (2 folds, with 50% training data)
#' twofold_split(1:200,0.5,outcome,"stratified")
NULL

#' @rdname tenfold_split
#' @export
tenfold_split<-function(index_all,strat=NULL,method="simple"){
  if(method=="stratified"){
    ## Make a stratified train/test split for 10 different sets (folds),
    num0=which(strat==0)
    num1=which(strat==1)
    if(length(num0)+length(num1)!=length(strat)) stop("Stratification vector must be 0/1")
    foldcontrol <- caret::createFolds(num0, k = 10, list = TRUE, returnTrain = FALSE)
    foldcase <- caret::createFolds(num1, k = 10, list = TRUE, returnTrain = FALSE)
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
  }else{
    folds <- caret::createFolds(index_all, k = 10, list = TRUE, returnTrain = FALSE)
    return(folds)
  }
}

#' @rdname tenfold_split
#' @export
twofold_split<-function(index_all,train_proportion=0.5,strat=NULL,method="simple"){
  if(method=="stratified"){
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
    return(list(train=train,
                test=test))
  }else{
    ## Make a random train/test split
    n_total=length(index_all)
    index_all<-sample(index_all)
    train <- index_all[1:round(n_total*train_proportion,0)]
    test <- index_all[(round(n_total*train_proportion,0)+1):n_total]
    return(list(train=train,
                test=test))
  }
}
