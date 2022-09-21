#' @title Generate haplotype data
#' @description Generate the feature data, either the genotype data for SNPs,
#' the feature data for Haplotype Trend Regression (HTR), or
#' the feature data for Haplotype Trend Regression with eXtra flexibility (HTRX).
#' @name make_htrx
#' @param SNP1 a data frame of the SNPs' genotype of the first genome. The genotype of a SNP for each individual is either 0 (reference allele) or 1 (alternative allele).
#' @param SNP2 a data frame of the SNPs' genotype of the second genome. The genotype of a SNP for each individual is either 0 (reference allele) or 1 (alternative allele).
#' @param rareremove logical. Remove rare SNPs and haplotypes or not. By default, rareremove=FALSE.
#' @param rare_threshold a numeric number below which the haplotype or SNP is removed. This only works when rareremove=TRUE.
#' @param fixedfeature a character consisted of the names of haplotypes.
#'
#' @details If there are n SNPs, there are \ifelse{html}{\out{2<sup>n</sup>}}{\eqn{2^n}} different haplotypes created by HTR,
#' and \ifelse{html}{\out{3<sup>n</sup>}}{\eqn{3^n}}-1 different haplotypes created by HTRX.
#' @return a data frame of the feature data (either for SNPs, HTR or HTRX).
#' @examples
#' ## create SNP data for both genomes
#' SNP1=as.data.frame(matrix(0,nrow=100,ncol=4))
#' SNP2=as.data.frame(matrix(0,nrow=100,ncol=4))
#' colnames(SNP1)=colnames(SNP2)=c('a','b','c','d')
#' p=runif(4,0.01,0.99)
#' for(j in 1:4){
#'   SNP1[,j]=rbinom(n,1,p[j])
#'   SNP2[,j]=rbinom(n,1,p[j])
#' }
#'
#' ## create the SNP data without removing rare SNPs
#' make_snp(SNP1,SNP2)
#'
#' ## create feature data for "HTR" removing haplotypes rarer than 0.5%
#' make_htr(SNP1,SNP2,TRUE,0.005)
#'
#' ## create feature data for "HTRX" without removing haplotypes
#' make_htrx(SNP1,SNP2)
#'
#' ## create feature data for feature"01XX" and "X101" without removing haplotypes
#' make_htrx(SNP1,SNP2,fixedfeature=c("01XX","X101"))
NULL

#' @rdname make_htrx
#' @export
make_htrx<-function(SNP1,SNP2,rareremove=FALSE,rare_threshold=0.001,fixedfeature=NULL){
  ## Make a HTRX feature matrix
  ## All the combinations of 0,1,X of SNPs
  ## Each element of combinations become 'factor'.
  n=n_total=dim(SNP1)[1]
  nsnp=dim(SNP1)[2]
  if(is.null(fixedfeature)){
    combinations=expand.grid(lapply(1:nsnp,function(x)c(0,1,'X')))
    combinations=combinations[-nrow(combinations),]
    HTRX_matrix <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))
    HTRX_matrix2 <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))
    ##the genotype must be 0 for reference allele and 1 for alternative allele
    for(i in 1:nrow(combinations)){
      HTRX_matrix[Reduce(intersect,
                         lapply(1:nsnp,function(x)
                         {
                           if(combinations[i,x]=='X')return(1:n);
                           if(combinations[i,x]!='X')return(which(SNP1[,x]==as.numeric(
                             levels(combinations[i,x])[combinations[i,x]])));
                         })
      ),i]=0.5
      HTRX_matrix2[Reduce(intersect,
                          lapply(1:nsnp,function(x)
                          {
                            if(combinations[i,x]=='X')return(1:n);
                            if(combinations[i,x]!='X')return(which(SNP2[,x]==as.numeric(
                              levels(combinations[i,x])[combinations[i,x]])));
                          })
      ),i]=0.5
    }
  }else{
    combinations=as.data.frame(matrix(NA,nrow=length(fixedfeature),ncol=nsnp))
    for(i in 1:length(fixedfeature)){
      combinations[i,]=unlist(strsplit(fixedfeature[i],split=''))
    }

    HTRX_matrix <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))
    HTRX_matrix2 <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))

    for(i in 1:nrow(combinations)){
      HTRX_matrix[Reduce(intersect,
                         lapply(1:nsnp,function(x)
                         {
                           if(combinations[i,x]=='X')return(1:n);
                           if(combinations[i,x]!='X')return(which(SNP1[,x]==as.numeric(
                             combinations[i,x])));
                         })
      ),i]=0.5
      HTRX_matrix2[Reduce(intersect,
                          lapply(1:nsnp,function(x)
                          {
                            if(combinations[i,x]=='X')return(1:n);
                            if(combinations[i,x]!='X')return(which(SNP2[,x]==as.numeric(
                              combinations[i,x])));
                          })
      ),i]=0.5
    }

  }

  HTRX_matrix = HTRX_matrix + HTRX_matrix2
  colnames(HTRX_matrix)=Reduce(paste0,combinations)

  #remove haplotypes with frequency=100%
  missing <- vector()
  for(i in 1:nrow(combinations)){
    if(sum(HTRX_matrix[,i])==0){
      missing=c(missing,i)
    }
  }
  if(length(missing)!=0) HTRX_matrix=HTRX_matrix[,-missing];

  #remove rare SNPs or not
  if(rareremove){
    rare <- vector()
    for(d in 1:ncol(HTRX_matrix)){
      if(sum(HTRX_matrix[,d])<n*rare_threshold){
        rare <- c(rare,d)
      }
    }
    if(length(rare)!=0){
      HTRX_matrix <- HTRX_matrix[,-rare]
    }
  }

  return(HTRX_matrix)
}

#' @rdname make_htrx
#' @export
make_htr<-function(SNP1,SNP2,rareremove=FALSE,rare_threshold=0.001){
  ## Make a HTR feature matrix
  n=n_total=dim(SNP1)[1]
  nsnp=dim(SNP1)[2]
  ## HTR
  combinations=expand.grid(lapply(1:nsnp,function(x)c(0,1)))
  HTR_matrix <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))
  HTR_matrix2 <- as.data.frame(matrix(0,nrow=n_total,ncol=nrow(combinations)))

  for(i in 1:nrow(combinations)){
    ##the genotype must be 0 for reference allele and 1 for alternative allele
    HTR_matrix[Reduce(intersect,
                      lapply(1:nsnp,function(x)
                      {
                        which(SNP1[,x]==combinations[i,x])
                      })),i]=0.5
    HTR_matrix2[Reduce(intersect,
                       lapply(1:nsnp,function(x)
                       {
                         which(SNP2[,x]==combinations[i,x])
                       })),i]=0.5
  }
  HTR_matrix = HTR_matrix + HTR_matrix2
  colnames(HTR_matrix)=Reduce(paste0,combinations)

  if(rareremove){
    rare <- vector()
    for(d in 1:ncol(HTR_matrix)){
      if(sum(HTR_matrix[,d])<n*rare_threshold){
        rare <- c(rare,d)
      }
    }
    if(length(rare)!=0){
      HTR_matrix <- HTR_matrix[,-rare]
    }
  }

  return(HTR_matrix)
}

#' @rdname make_htrx
#' @export
make_snp<-function(SNP1,SNP2,rareremove=FALSE,rare_threshold=0.001){
  ## Make a SNP feature matrix
  ## Convenience function to use the same format for making a SNP matrix from two haplotype matrices
  n=dim(SNP1)[1]
  SNP=SNP1+SNP2
  if(rareremove){
    rare <- vector()
    for(d in 1:ncol(SNP)){
      if(sum(SNP[,d])<n*rare_threshold){
        rare <- c(rare,d)
      }
    }
    if(length(rare)!=0){
      SNP <- SNP[,-rare]
    }
  }

  return(SNP)
}
