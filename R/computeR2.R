#' @title Compute \ifelse{html}{\out{R<sup>2</sup>}}{\eqn{R^2}}
#' @description Compute the variance explained by a linear or
#' generalized linear model.
#' @name computeR2
#' @param model a fitted model, which is the output of "themodel" function.
#' @param newdata a data frame which contains all the variables included in the model.
#' This data frame is used to make prediction on.
#' @param pred a vector of the predicted outcome.
#' @param y a vector of the actual outcome.
#' @param usebinary a non-negative number representing different models.
#' Use linear model if usebinary=0,
#' use logistic regression model via fastglm if usebinary=1,
#' and use logistic regression model via glm if usebinary>1.
#'
#' @details The variance explained by a linear model is based on the conventional \ifelse{html}{\out{R<sup>2</sup>}}{\eqn{R^2}}.
#' As for logistic regression, we use McFadden's \ifelse{html}{\out{R<sup>2</sup>}}{\eqn{R^2}}.
#'
#' @return 'mypredict` returns a vector of the predicted outcome.
#'
#' 'computeR2` returns a positive number of the variance explained by the
#' linear model (conventional \ifelse{html}{\out{R<sup>2</sup>}}{\eqn{R^2}}) or the generalized linear model (McFadden's \ifelse{html}{\out{R<sup>2</sup>}}{\eqn{R^2}}).
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
computeR2 <- function(pred,y,usebinary=1){
  if(usebinary==0){
    return(1-sum((y-pred)^2)/sum((y-mean(y))^2))
  }else{
    loglik_model <- sum(-log(1+exp(pred))+y*pred)
    pred_null=log(mean(y)/(1-mean(y)))
    loglik_null <- sum(-log(1+exp(pred_null))+y*pred_null)
    return(1-loglik_model/loglik_null)
  }
}

