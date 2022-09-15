source("HTRX_functions.R")

## This simulation compares GWAS, HTRX and HTR under a 4-SNP region
nsnp=4

## Function for simulation
runsimulation <- function(n=20000,usebinary=1,rarehap=FALSE,rareremove=FALSE,
                          sim_times=2,interaction=TRUE,runparallel=FALSE,mc.cores=5,
                          randomseed=1,offset=-7,effectscale=3){
  
  set.seed(randomseed)
  
  ## Generating the genetic data
  SNP1=as.data.frame(matrix(0,nrow=n,ncol=nsnp))
  SNP2=as.data.frame(matrix(0,nrow=n,ncol=nsnp))
  colnames(SNP1)=colnames(SNP2)=c('a','b','c','d')
  
  ### rare SNP: a and b
  if(rarehap){
    p=c(runif(2,0.02,0.05),runif(2,0.05,0.95))
  }else{
    p=runif(4,0.05,0.95)
  }
  for(j in 1:nsnp){
    SNP1[,j]=rbinom(n,1,p[j])
    SNP2[,j]=rbinom(n,1,p[j])
  }
  SNP = (SNP1 + SNP2)/2
  
  snpsds=apply(SNP,2,sd)
  beta_effect=runif(nsnp,min=-1,max=1)/snpsds ## to standardize the effect size
  
  ### generate covariate data: sex, age, 18PCs
  sex=sample(c(0,1),n,replace=TRUE)
  age=sample(20:90,n,replace=TRUE)
  PCs=as.data.frame(matrix(0,nrow=n,ncol=18))
  for(i in 1:18){
    PCs[,i]=runif(n,min=-1,max=1)
  }
  covariates=cbind(sex,age,PCs)
  
  covsds=apply(covariates,2,sd)
  
  #### generate a noise vector 
  e=rnorm(n,0,0.1)
  
  ## Generating the effect sizes
  ## get the covariate, interaction and SNP effects on a reasonable scale
  beta_covariates = runif(dim(covariates)[2],-0.1,0.1)/covsds
  
  if(interaction){
    beta_interaction = 2*mean(abs(beta_effect))
  }else{
    beta_interaction = 0
  }
  
  ## Generate a hap effect for 11XX
  hapeffect_matrix=matrix(((hap1=rowSums(SNP1[,1:2])==2)+
                             (hap2=rowSums(SNP2[,1:2])==2))/2,ncol=1)
  
  ## Realised effect vectors in individuals
  snpeffects=as.matrix(SNP) %*% matrix(beta_effect,ncol=1)
  coveffects=as.matrix(covariates) %*% matrix(beta_covariates,ncol=1)
  interaction_effects= hapeffect_matrix %*% matrix(beta_interaction,ncol=1)
  
  ## Sanity check the variance:
  c(snps=var(rowSums(t(t(SNP)*beta_effect))),
    noise=var(e),
    covariates=var(rowSums(t(t(covariates)*beta_covariates))),
    interaction=var(interaction_effects)
  )
  
  ##############
  ## SIMULATION
  ## The offset and effectscale are the "correct" ways to change the frequency of the outcome
  if(usebinary!=0){
    ## Binary outcome
    outcome_score=as.numeric(snpeffects*effectscale  + 
                             interaction_effects*effectscale + 
                             coveffects + e + offset)
    outcome_p=exp(outcome_score)/(1+exp(outcome_score))
    outcome=rbinom(length(outcome_score),1,prob=outcome_p)
  }else{
    outcome=as.numeric(snpeffects*effectscale + 
                       interaction_effects*effectscale + 
                       coveffects + e + offset)
  }
  #########
  ## Sanity checking
  mean(outcome)
  
  ########################
  ## Construct the final datasets

  ##create the whole_data as the outcome, covariates and genotype data
  basedata=data.frame(outcome,covariates)
  covar_index=1:dim(basedata)[2]
  whole_data=data.frame(basedata,SNP)
  
  
  ############################################
  
  ## Make the matrices
  HTRX_matrix=make_htrx(SNP1,SNP2,rareremove=rareremove)
  HTR_matrix=make_htr(SNP1,SNP2,rareremove=rareremove)
  SNP_matrix=SNP
  
  ## Construct the set of datasets used in each inference

  data_nosnp=cbind(whole_data[covar_index])
  data_snp=cbind(data_nosnp,SNP_matrix)
  data_htr=cbind(data_nosnp,HTR_matrix)
  data_htrx=cbind(data_nosnp,HTRX_matrix)
  data_truth=cbind(data_snp,interaction=hapeffect_matrix)
  
  #The true parameters for the inferred model
  beta_true=c('(Intercept)'=offset,
              beta_covariates,
              beta_effect*effectscale,
              interaction=beta_interaction*effectscale)

  
  
  ############################################
  ## Now we start to perform the two-step method for all measures
  
  #####Original method#####
  
  if(usebinary){
    method="stratified"
  }else{
    method="simple"
  }
  
  ## SNPs only
  lresults_snp_interaction=do_cv_2step(data_nosnp,SNP_matrix,0.5,
                                       sim_times=sim_times,usebinary=usebinary,method=method)
  
  
  ## HTR
  lresults_htr_interaction=do_cv_2step(data_nosnp,HTR_matrix,0.5,
                                       sim_times=sim_times,featurecap=8,
                                       usebinary=usebinary,runparallel=runparallel,
                                       method=method,mc.cores=mc.cores)
  
  
  ## HTRX
  lresults_htrx_interaction=do_cv_2step(data_nosnp,HTRX_matrix,0.5,
                                        sim_times=sim_times,featurecap=8,
                                        usebinary=usebinary,runparallel=runparallel,
                                        method=method,mc.cores=mc.cores)
  
  
  
  ## Results with the true parameter values
  
  set.seed(1) #the same seed used in 10-fold data-split (function do_cv_2step())
  if(method=="simple"){
    split=tenfold_simple(1:n)
  }else if(method=="stratified"){
    split=tenfold_stratified(data_nosnp[,"outcome"])
  }else stop("method must be either simple or stratified")
  
  lresults_truth_interaction=lapply(1:10,function(s){
    infer_fixedfeatures(data_nosnp,cbind(SNP_matrix,interaction=hapeffect_matrix),test=split[[s]],
                        features=c(colnames(SNP_matrix),"interaction"),coefficients=beta_true,
                        usebinary=usebinary,gain=TRUE,R2only=TRUE)
  })
  
  
  
  #####save results in a single file
  R2_sim <- vector()
  
  for(i in 1:10){
    R2_sim[i]=lresults_truth_interaction[[i]]$R2
  }
  
  R2_sim[11:20]=lresults_snp_interaction$R2_test_gain
  R2_sim[21:30]=lresults_htr_interaction$R2_test_gain
  R2_sim[31:40]=lresults_htrx_interaction$R2_test_gain
  
  
  R2_sim_interaction <-   data.frame(R2=R2_sim*100,Model=c(rep('Truth',10),
                                                           rep('SNP',10),
                                                           rep('HTR',10),
                                                           rep('HTRX',10)))
  R2_sim_interaction$Model = factor(R2_sim_interaction$Model,
                                    levels=c('Truth','SNP','HTR','HTRX'))
  return(R2_sim_interaction)
}

## simulation for glm with/without interaction
sim_glm_int <- runsimulation(usebinary=1,rarehap=FALSE,rareremove=FALSE,interaction=TRUE)
sim_glm <- runsimulation(usebinary=1,rarehap=FALSE,rareremove=FALSE,interaction=FALSE)

## simulation for lm with/without interaction
sim_lm_int <- runsimulation(usebinary=0,rarehap=FALSE,rareremove=FALSE,interaction=TRUE)
sim_lm <- runsimulation(usebinary=0,rarehap=FALSE,rareremove=FALSE,interaction=FALSE)

## simulation for glm with two rare SNPs, and with/without interaction
sim_glm_int_rare <- runsimulation(usebinary=1,rarehap=TRUE,rareremove=FALSE,interaction=TRUE)
sim_glm_rare <- runsimulation(usebinary=1,rarehap=TRUE,rareremove=FALSE,interaction=FALSE)

## simulation for lm with two rare SNPs, and with/without interaction
sim_lm_int_rare <- runsimulation(usebinary=0,rarehap=TRUE,rareremove=FALSE,interaction=TRUE)
sim_lm_rare <- runsimulation(usebinary=0,rarehap=TRUE,rareremove=FALSE,interaction=FALSE)

## simulation for glm with two rare SNPs and remove rare haplotypes, and with/without interaction
sim_glm_int_rare_remove <- runsimulation(usebinary=1,rarehap=TRUE,rareremove=TRUE,interaction=TRUE)
sim_glm_rare_remove <- runsimulation(usebinary=1,rarehap=TRUE,rareremove=TRUE,interaction=FALSE)

## simulation for lm with two rare SNPs and remove rare haplotypes, and with/without interaction
sim_lm_int_rare_remove <- runsimulation(usebinary=0,rarehap=TRUE,rareremove=TRUE,interaction=TRUE)
sim_lm_rare_remove <- runsimulation(usebinary=0,rarehap=TRUE,rareremove=TRUE,interaction=FALSE)

