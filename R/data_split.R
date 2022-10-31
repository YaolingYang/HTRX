#' @title Data split
#' @description \code{kfold_split} splits data into k folds with equal sizes, which is used for cross-validation.
#' \code{twofold_split} splits data into two folds, which samples the training set.
#' Both stratified sampling and simple sampling are allowed.
#' The details can be found in function \code{\link{do_cv}} and \code{\link{do_cumulative_htrx}}.
#' @name data_split
#' @param outcome a vector of the variable (usually the outcome)
#' based on which the data is going to be stratified.
#' This only works when \code{method="stratified"}.
#' @param fold a positive integer specifying how many folds the data should be split into.
#' @param method the method to be used for data split, either \code{"simple"} (default) or \code{"stratified"}.
#' @param train_proportion a positive number between 0 and 1 giving
#' the proportion of the training dataset when splitting data into 2 folds.
#' By default, \code{train_proportion=0.5}.
#'
#' @details Stratified sampling works only when the \code{outcome} variable is binary (either 0 or 1),
#' and it ensures each fold has almost the same number of \code{outcome=0} and \code{outcome=1}.
#'
#' Simple sampling randomly splits the data into k folds.
#'
#' Two-fold data split is used to select candidate models in Step 1 of HTRX or cumulative HTRX,
#' while k-fold data split is used for 10-fold cross-validation in Step 2 which aims at selecting the best model.
#' @return Both functions return a list containing the indexes of different folds.
#' @examples
#' ## create the binary outcome (20% prevalence)
#' outcome=rbinom(200,1,0.2)
#'
#' ## simple sampling (10 folds)
#' kfold_split(outcome,10)
#'
#' ## stratified sampling (10 folds)
#' kfold_split(outcome,10,"stratified")
#'
#' ## stratified sampling (2 folds, with 50% training data)
#' twofold_split(outcome,0.5,"stratified")

NULL

#' @rdname data_split
#' @export
kfold_split<-function(outcome,fold,method="simple"){
  if(method=="stratified"){
    ## Make a stratified train/test split for k different sets (folds),
    num0=which(outcome==0)
    num1=which(outcome==1)
    if(length(num0)+length(num1)!=length(outcome)) stop("Stratification vector must be 0/1")
    foldcontrol <- caret::createFolds(num0, k = fold, list = TRUE, returnTrain = FALSE)
    foldcase <- caret::createFolds(num1, k = fold, list = TRUE, returnTrain = FALSE)
    split_data=list()
    for(i in 1:fold){
      split_data[[i]]=c(foldcontrol[[i]],foldcase[[i]])
    }
    return(split_data)
  }else{
    index_all=1:length(outcome)
    folds <- caret::createFolds(index_all, k = fold, list = TRUE, returnTrain = FALSE)
    return(folds)
  }
}


#' @rdname data_split
#' @export
twofold_split<-function(outcome,train_proportion=0.5,method="simple"){
  n_total=length(outcome)
  index_all=1:n_total
  if(method=="stratified"){
    ## Make a stratified train/test split,
    ##such that all sets have the same proportion of 0s and 1s in the "strat" variable
    num0=sum(outcome==0)
    num1=sum(outcome==1)
    if(num0+num1!=length(outcome)) stop("Stratification vector must be 0/1")
    index0<-sample(index_all[outcome==0])
    index1<-sample(index_all[outcome==1])
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
    index_all<-sample(index_all)
    train <- index_all[1:round(n_total*train_proportion,0)]
    test <- index_all[(round(n_total*train_proportion,0)+1):n_total]
    return(list(train=train,
                test=test))
  }
}
