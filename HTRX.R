HTRX <- function(chr6,covariates,snpnumber){
  ##### Make the data for HTRX
  data1=chr6[,2*snpnumber-1]
  data2=chr6[,2*snpnumber]
  nsnp=length(snpnumber)
  
  # All the combinations of 0,1,X of SNPs
  # Each element of combinations become 'factor'.
  combinations=expand.grid(lapply(1:nsnp,function(x)c(0,1,'X')))
  combinations=combinations[-nrow(combinations),]
  HTR_matrix <- as.data.frame(matrix(0,nrow=nrow(chr6),ncol=nrow(combinations)))
  HTR_matrix2 <- as.data.frame(matrix(0,nrow=nrow(chr6),ncol=nrow(combinations)))
  
  for(i in 1:nrow(combinations)){
    print(i)
    #In the genotype data, the genotype is 2 for risk allele and 1 for reference allele
    HTR_matrix[Reduce(intersect, 
                      lapply(1:nsnp,function(x)
                      {
                        if(combinations[i,x]=='X')return(1:nrow(chr6));
                        if(combinations[i,x]!='X')return(which(data1[,x]==as.numeric(
                          levels(combinations[i,x])[combinations[i,x]])+1));
                      })
    ),i]=0.5
    HTR_matrix2[Reduce(intersect, 
                       lapply(1:nsnp,function(x)
                       {
                         if(combinations[i,x]=='X')return(1:nrow(chr6));
                         if(combinations[i,x]!='X')return(which(data2[,x]==as.numeric(
                           levels(combinations[i,x])[combinations[i,x]])+1));
                       })
    ),i]=0.5
  }
  HTR_matrix = HTR_matrix + HTR_matrix2
  colnames(HTR_matrix)=Reduce(paste0,combinations)
  
  missing <- vector()
  for(i in 1:nrow(combinations)){
    if(sum(HTR_matrix[,i])==0){
      missing=c(missing,i)
      cat('Remove',i,'\n')
    } 
  }
  if(length(missing)!=0) HTR_matrix=HTR_matrix[,-missing];
  
  whole_data_htr <- cbind(covariates,HTR_matrix)
  
  
  
  ##### Fit forward regression model
  data_use <- covariates
  adjR2_nosnp <- summary(lm(outcome~.,data=data_use))$adj.r.squared
  
  haplotypelist=1:(ncol(whole_data_htr)-21)
  adjR2_cumu=vector()
  haplotypename=vector()
  
  n_hap=ncol(whole_data_htr)-21
  # we only want the top 20
  if(n_hap>20){
    n_hap=20
  }
  
  for(i in 1:n_hap){
    cat('The',i,'time\n')
    for(j in haplotypelist){
      cat('haplotype',j)
      data_try <- cbind(data_use,whole_data_htr[,21+j])
      fit <- lm(outcome~.,data=data_try)
      if(j==haplotypelist[1]){
        adjR2=summary(fit)$adj.r.squared-adjR2_nosnp
        biggest=j
      }else{
        adjR2_compare=summary(fit)$adj.r.squared-adjR2_nosnp
        if(adjR2_compare>adjR2){
          adjR2=adjR2_compare
          biggest=j
        }
      }
      print(adjR2)
    }
    
    adjR2_cumu[i]=adjR2
    
    haplotypename[i]=colnames(whole_data_htr)[21+biggest]
    data_use <- cbind(data_use,whole_data_htr[,21+biggest])
    colnames(data_use)[ncol(data_use)]=haplotypename[i]
    haplotypelist=haplotypelist[-which(haplotypelist==biggest)]
    cat('haplotype',biggest,haplotypename[i],'Frequency',Freq[i])
  }
  
  adjR2_cumulative_htrx <- data.frame(Number=1:n_hap,haplotype=haplotypename,Cumulative_adjR2_htr=adjR2_cumu)
  return(adjR2_cumulative_htrx)
}

load('whole_data_genotype.Rdata')
whole_data=whole_data_genotype[,c(1:22,119:152)]
whole_data <- whole_data[-which(rowSums(is.na(whole_data)) > 0),]
chr6<-read.table("6.ped")
chr6snp<-read.table("6.bim")
chr6 <- chr6[match(whole_data[,1],chr6[,2]),-(1:6)]
colnames(chr6) <- rep(chr6snp$V4,each=2)
colnames(chr6)[seq(2,68,2)] <- paste0(colnames(chr6)[seq(2,68,2)],'_2')
covariates <- whole_data[,2:22]

#30060631-31346822 (4SNP)
HTRX_30.06_31.34 = HTRX(chr6,covariates,4:7)
write.table(HTRX_30.06_31.34,"HTRX_30.06_31.34.txt",sep=',',row.names=FALSE)

#31497244-32145399 (5SNP)
HTRX_31.49_32.14 = HTRX(chr6,covariates,8:12)
write.table(HTRX_31.49_32.14,"HTRX_31.49_32.14.txt",sep=',',row.names=FALSE)

#32367997-32681483 (6SNP)
HTRX_32.36_32.68 = HTRX(chr6,covariates,13:18)
write.table(HTRX_32.36_32.68,"HTRX_32.36_32.68.txt",sep=',',row.names=FALSE)

#33047466-33081823 (4SNP)
HTRX_33.04_33.08 = HTRX(chr6,covariates,19:22)
write.table(HTRX_33.04_33.08,"HTRX_33.04_33.08.txt",sep=',',row.names=FALSE)






