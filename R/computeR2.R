#' @title Compute variance explained by models
#' @description Compute the variance explained by a linear or
#' generalized linear model.
#' @name computeR2
#' @param model a fitted model, which is the output of \code{themodel}.
#' @param newdata a data frame which contains all the variables included in the model.
#' This data frame is used to make prediction on.
#' @param pred a vector of the predicted outcome.
#' @param outcome a vector of the actual outcome.
#' @param usebinary a non-negative number representing different models.
#' Use linear model if \code{usebinary=0},
#' use logistic regression model via \code{fastglm} if \code{usebinary=1} (by default),
#' and use logistic regression model via \code{glm} if \code{usebinary>1}.
#'
#' @details The variance explained by a linear model is based on the conventional \ifelse{html}{\out{R<sup>2</sup>}}{\eqn{R^2}}.
#' As for logistic regression, we use McFadden's \ifelse{html}{\out{R<sup>2</sup>}}{\eqn{R^2}}.
#'
#' @return \code{mypredict} returns a vector of the predicted outcome.
#'
#' \code{computeR2} returns a positive number of the variance explained by the
#' linear model (conventional \ifelse{html}{\out{R<sup>2</sup>}}{\eqn{R^2}}) or
#' the generalized linear model (McFadden's \ifelse{html}{\out{R<sup>2</sup>}}{\eqn{R^2}}).
#'
#' @references McFadden, D. Conditional logit analysis of qualitative choice behavior. (1973).
#' @examples
#' ## create datasets
#' x=matrix(runif(100,-2,2),ncol=5)
#' outcome=(0.5*x[,2] - 0.8*x[,4] + 0.3*x[,5])>runif(100,-2,2)
#'
#' ## create binary outcome
#' outcome[outcome]=1
#' data=data.frame(outcome,x)
#'
#' ## compute the variance explained by features
#' model=themodel(outcome~.,data[1:80,],usebinary=1)
#' outcome_predict=mypredict(model,data[81:100,])
#' computeR2(outcome_predict,data[81:100,'outcome'],usebinary=1)
NULL

#' @rdname computeR2
#' @export
mypredict<-function(model,newdata){
  colnames(newdata)[1]='outcome'
  if(is(model,"fastglm")){
    tcol=names(model$coefficients)
    newdata=cbind("(Intercept)"=1,newdata)
    pred=predict(model,newdata=as.matrix(newdata[,tcol]))
  }else{
    pred=predict(model,newdata=newdata)
  }
  pred
}

#' @rdname computeR2
#' @export
computeR2 <- function(pred,outcome,usebinary=1){
  if(usebinary==0){
    return(1-sum((outcome-pred)^2)/sum((outcome-mean(outcome))^2))
  }else{
    loglik_model <- sum(-log(1+exp(pred))+outcome*pred)
    pred_null=log(mean(outcome)/(1-mean(outcome)))
    loglik_null <- sum(-log(1+exp(pred_null))+outcome*pred_null)
    return(1-loglik_model/loglik_null)
  }
}

