#' @title Model fitting
#' @name themodel
#' @description Model-agnostic functions for model fitting (both linear and generalized linear models).
#' @param formula a formula for model-fitting, starting with outcome~.
#' @param data a data frame contains all the variables included in the formula.
#' The outcome must be the first column with colnames(data)[1]="outcome".
#' @param usebinary a non-negative number representing different models.
#' Use linear model if \code{usebinary=0},
#' use logistic regression model via \code{fastglm} if \code{usebinary=1} (by default),
#' and use logistic regression model via \code{glm} if \code{usebinary>1}.
#' @param clean logical. If \code{clean=TRUE} (by default), remove additional storages that
#' the \code{predict} function, \code{"AIC"} and \code{"BIC"} criteria do not need.
#'
#' @return a fitted model.
#' @details This function returns a fitted model (either linear model or logistic regression model).
#' For logistic regression, we use function \code{fastglm} from \code{fastglm} package, which is much faster than \code{glm}.
#'
#' @rdname themodel
#' @examples
#' ## create the dataset for variables and outcome
#' x=matrix(runif(100,-2,2),ncol=5)
#' outcome=0.5*x[,2] - 0.8*x[,4] + 0.3*x[,5]
#' data1=data.frame(outcome,x)
#'
#' ## fit a linear model
#' themodel(outcome~.,data1,usebinary=0)
#'
#' ## create binary outcome
#' outcome=outcome>runif(100,-2,2)
#' outcome[outcome]=1
#' data2=data.frame(outcome,x)
#'
#' ## fit a logistic regression model
#' themodel(outcome~.,data2,usebinary=1)
NULL

#' @rdname themodel
#' @export
themodel<- function(formula,data,usebinary=1,clean=TRUE){
  colnames(data)[1]='outcome'
  if(usebinary==0){
    model=lm(formula=formula,data=data)
  }else if(usebinary>1){
    model=glm(formula=formula,data=data,family=binomial(link='logit'))
  }else if(usebinary==1){
    data=cbind("(Intercept)"=1,data)
    tout=which(colnames(data)=="outcome")
    model=fastglm::fastglm(x=as.matrix(data[,-tout]),y=data[,"outcome"],
                           family=binomial(link='logit'),method=3)
  }
  if(clean){
    if(!is(model,"lm")) model$residuals=NULL;
    model$fitted.values=NULL
    model$weights=NULL
    model$data=NULL
    model$y=NULL
    model$prior.weights=NULL
    model$linear.predictors=NULL
  }
  return(model)
}
