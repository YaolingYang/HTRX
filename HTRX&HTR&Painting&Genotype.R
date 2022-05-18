library(ggplot2)
library(ggrepel)
library(ggthemes)
library(reshape2)
### HTRX, HTR, painting,genotype in the same dataset

cumulative_adj_R2 <- function(snpnumber){
  nsnp=length(snpnumber)
  data1=chr6[,2*snpnumber-1]
  data2=chr6[,2*snpnumber]
  SNPname=chr6snp[snpnumber,4]
  
  data_nosnp=whole_data[,1:21]
  adjR2_nosnp <- summary(lm(outcome~.,data=data_nosnp))$adj.r.squared
  
  
  #HTR
  combinations=expand.grid(lapply(1:nsnp,function(x)c(0,1)))
  HTR_matrix <- as.data.frame(matrix(0,nrow=nrow(chr6),ncol=nrow(combinations)))
  HTR_matrix2 <- as.data.frame(matrix(0,nrow=nrow(chr6),ncol=nrow(combinations)))
  
  for(i in 1:nrow(combinations)){
    print(i)
    #In the genotype data, the genotype is 2 for risk allele and 1 for reference allele
    HTR_matrix[Reduce(intersect, 
                      lapply(1:nsnp,function(x)
                      {
                        which(data1[,x]==combinations[i,x]+1)
                      })),i]=0.5
    HTR_matrix2[Reduce(intersect, 
                       lapply(1:nsnp,function(x)
                       {
                         which(data2[,x]==combinations[i,x]+1)
                       })),i]=0.5
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
  
  whole_data_htr <- cbind(whole_data[,1:21],HTR_matrix)
  
  data_use=data_nosnp
  haplotypelist=1:(ncol(whole_data_htr)-21)
  adjR2_cumu=vector()
  haplotypename=vector()
  Beta=vector()
  Freq=vector()
  
  n_hap=ncol(whole_data_htr)-21
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
    
    haplotypename[i]=paste0('H',colnames(whole_data_htr)[21+biggest])
    Freq[i]=sum(HTR_matrix[,biggest])/nrow(chr6)
    data_use <- cbind(data_use,whole_data_htr[,21+biggest])
    
    data_beta <- cbind(data_nosnp,whole_data_htr[,21+biggest])
    Beta[i] <- summary(lm(outcome~.,data=data_beta))$coefficients[22,1]
    
    colnames(data_use)[ncol(data_use)]=haplotypename[i]
    
    haplotypelist=haplotypelist[-which(haplotypelist==biggest)]
    cat('haplotype',biggest,haplotypename[i],'Frequency',Freq[i])
  }
  
  adjR2_cumulative_htr <- data.frame(HTR=haplotypename,Cumulative_adjR2_htr=adjR2_cumu,Beta_HTR=Beta,Freq_HTR=Freq)
  
  
  #HTRX
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
  
  whole_data_htr <- cbind(whole_data[,1:21],HTR_matrix)
  
  
  
  ##### Fit forward regression model
  data_use <- whole_data[,1:21]
  adjR2_nosnp <- summary(lm(outcome~.,data=data_use))$adj.r.squared
  
  haplotypelist=1:(ncol(whole_data_htr)-21)
  adjR2_cumu=vector()
  haplotypename=vector()
  Beta=vector()
  Freq=vector()
  
  n_hapx=ncol(whole_data_htr)-21
  # we only want the top 20
  if(n_hapx>20){
    n_hapx=20
  }
  
  for(i in 1:n_hapx){
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
    
    haplotypename[i]=paste0('H',colnames(whole_data_htr)[21+biggest])
    Freq[i]=sum(HTR_matrix[,biggest])/nrow(chr6)
    data_use <- cbind(data_use,whole_data_htr[,21+biggest])
    
    data_beta <- cbind(data_nosnp,whole_data_htr[,21+biggest])
    Beta[i] <- summary(lm(outcome~.,data=data_beta))$coefficients[22,1]
    
    colnames(data_use)[ncol(data_use)]=haplotypename[i]
    
    haplotypelist=haplotypelist[-which(haplotypelist==biggest)]
    cat('haplotype',biggest,haplotypename[i],'Frequency',Freq[i])
  }
  
  adjR2_cumulative_htrx <- data.frame(HTRX=haplotypename,Cumulative_adjR2_htrx=adjR2_cumu,Beta_HTRX=Beta,Freq_HTRX=Freq)
  
  
  #genotype
  whole_data_geno <- whole_data[,c(1:21,(225+snpnumber))]
  data_use=data_nosnp
  genolist=1:nsnp
  adjR2_cumu=vector()
  genoname=vector()
  Beta=vector()
  
  for(i in 1:nsnp){
    cat('The',i,'time\n')
    for(j in genolist){
      cat('geno',j)
      data_try <- cbind(data_use,whole_data_geno[,21+j])
      fit <- lm(outcome~.,data=data_try)
      if(j==genolist[1]){
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
    
    genoname[i]=paste0('G',SNPname[biggest])
    data_use <- cbind(data_use,whole_data_geno[,21+biggest])
    
    data_beta <- cbind(data_nosnp,whole_data_geno[,21+biggest])
    Beta[i] <- summary(lm(outcome~.,data=data_beta))$coefficients[22,1]
    
    colnames(data_use)[ncol(data_use)]=genoname[i]
    
    genolist=genolist[-which(genolist==biggest)]
    cat('geno',biggest,genoname[i])
  }
  
  adjR2_cumulative_geno <- data.frame(geno=genoname,Cumulative_adjR2_geno=adjR2_cumu,Beta_geno=Beta)
  
  
  #painting
  whole_data_painting <- whole_data[,c(1:21,(21+snpnumber),
                                       (21+34+snpnumber),
                                       (21+34*2+snpnumber),
                                       (21+34*3+snpnumber),
                                       (21+34*4+snpnumber),
                                       (21+34*5+snpnumber))]
  colnames(whole_data_painting)[22:(21+nsnp)]=gsub('Steppe','S',colnames(whole_data_painting)[22:(21+nsnp)])
  colnames(whole_data_painting)[(22+nsnp):(21+nsnp*2)]=gsub('CHG','C',colnames(whole_data_painting)[(22+nsnp):(21+nsnp*2)])
  colnames(whole_data_painting)[(22+nsnp*2):(21+nsnp*3)]=gsub('EHG','E',colnames(whole_data_painting)[(22+nsnp*2):(21+nsnp*3)])
  colnames(whole_data_painting)[(22+nsnp*3):(21+nsnp*4)]=gsub('Farmer','F',colnames(whole_data_painting)[(22+nsnp*3):(21+nsnp*4)])
  colnames(whole_data_painting)[(22+nsnp*4):(21+nsnp*5)]=gsub('WHG','W',colnames(whole_data_painting)[(22+nsnp*4):(21+nsnp*5)])
  colnames(whole_data_painting)[(22+nsnp*5):(21+nsnp*6)]=gsub('African','A',colnames(whole_data_painting)[(22+nsnp*5):(21+nsnp*6)])
  
  data_use=data_nosnp
  paintinglist=1:(6*nsnp)
  adjR2_cumu=vector()
  paintingname=vector()
  Beta=vector()
  
  n_ancestry=6*nsnp
  if(nsnp>6){
    n_ancestry=30
  }
  
  for(i in 1:n_ancestry){
    cat('The',i,'time\n')
    for(j in paintinglist){
      cat('painting',j)
      data_try <- cbind(data_use,whole_data_painting[,21+j])
      fit <- lm(outcome~.,data=data_try)
      if(j==paintinglist[1]){
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
    
    paintingname[i]=colnames(whole_data_painting)[21+biggest]
    data_use <- cbind(data_use,whole_data_painting[,21+biggest])
    
    data_beta <- cbind(data_nosnp,whole_data_painting[,21+biggest])
    Beta[i] <- summary(lm(outcome~.,data=data_beta))$coefficients[22,1]
    
    colnames(data_use)[ncol(data_use)]=paintingname[i]
    
    paintinglist=paintinglist[-which(paintinglist==biggest)]
    cat('painting',biggest,paintingname[i])
  }
  
  adjR2_cumulative_painting <- data.frame(painting=paintingname,Cumulative_adjR2_painting=adjR2_cumu,Beta_painting=Beta)
  
  nrows=max(n_hap,n_hapx,n_ancestry)
  
  adjR2_cumulative=as.data.frame(matrix(NA,nrow=nrows,ncol=14))
  colnames(adjR2_cumulative)=c(colnames(adjR2_cumulative_htr),
                               colnames(adjR2_cumulative_htrx),
                               colnames(adjR2_cumulative_painting),
                               colnames(adjR2_cumulative_geno))
  adjR2_cumulative[1:n_hap,1:4]=adjR2_cumulative_htr
  adjR2_cumulative[1:n_hapx,5:8]=adjR2_cumulative_htrx
  adjR2_cumulative[1:n_ancestry,9:11]=adjR2_cumulative_painting
  adjR2_cumulative[1:nsnp,12:14]=adjR2_cumulative_geno
  
  return(adjR2_cumulative)
}

#pre-work
#setwd("C:/Ubuntu/yaoling_covariates/compare painting and genotype")
load('whole_data_genotype.Rdata')
load('whole_data_painting.Rdata')

genosnp <- 41-c(1:3,5:6,8,10:17,20,21,23:40)
whole_data <- cbind(whole_data[,c(1:22,genosnp+121,
                                  genosnp+121+225,
                                  genosnp+121+225*2,
                                  genosnp+121+225*3,
                                  genosnp+121+225*4,
                                  genosnp+121+225*5)],whole_data_genotype[,119:152])
missingrows=which(rowSums(is.na(whole_data)) > 0)
whole_data <- whole_data[-missingrows,]


chr6<-read.table("6.ped")
chr6snp<-read.table("6.bim")

a=match(whole_data[,1],chr6[,2])
chr6 <- chr6[a,-(1:6)]
colnames(chr6) <- rep(chr6snp$V4,each=2)
colnames(chr6)[seq(2,68,2)] <- paste0(colnames(chr6)[seq(2,68,2)],'_2')

whole_data <- whole_data[,-1]

#30060631-31346822 (4SNP)
ALL_30.06_31.34 = cumulative_adj_R2(4:7)
write.table(ALL_30.06_31.34,"ALL_30.06_31.34.csv",sep=',',row.names=FALSE)

#31497244-32145399 (5SNP)
ALL_31.49_32.14 = cumulative_adj_R2(8:12)
write.table(ALL_31.49_32.14,"ALL_31.49_32.14.csv",sep=',',row.names=FALSE)

#32367997-32681483 (6SNP)
ALL_32.36_32.68 = cumulative_adj_R2(13:18)
write.table(ALL_32.36_32.68,"ALL_32.36_32.68.csv",sep=',',row.names=FALSE)

#33047466-33081823 (4SNP)
ALL_33.04_33.08 = cumulative_adj_R2(19:22)
write.table(ALL_33.04_33.08,"ALL_33.04_33.08.csv",sep=',',row.names=FALSE)


#32410351-32609173 (2SNP)
ALL_32.41and32.60 = cumulative_adj_R2(c(14,16))
write.table(ALL_32.41and32.60,"ALL_32.41and32.60.csv",sep=',',row.names=FALSE)

#32410351-32634302 (2SNP)
ALL_32.41and32.63 = cumulative_adj_R2(c(14,17))
write.table(ALL_32.41and32.63,"ALL_32.41and32.63.csv",sep=',',row.names=FALSE)





###ggplots
#####genotype, htr, htrx and painting in the same plot!#####
plotcomparison <- function(SNPname,eachSNP,nsnp,nfeature){
  beta=vector()
  for(i in 1:(3*nfeature+nsnp)){
    if(i<=nfeature){
      if(data_plot[i,3]>=0) beta[i]='positive';
      if(data_plot[i,3]<0) beta[i]='negative';
    }
    if(i>nfeature&i<=2*nfeature){
      if(data_plot[i-nfeature,7]>=0) beta[i]='positive';
      if(data_plot[i-nfeature,7]<0) beta[i]='negative';
    }
    if(i>2*nfeature&i<=3*nfeature){
      if(data_plot[i-2*nfeature,11]>=0) beta[i]='positive';
      if(data_plot[i-2*nfeature,11]<0) beta[i]='negative';
    }
    if(i>3*nfeature){
      if(data_plot[i-3*nfeature,14]>=0) beta[i]='positive';
      if(data_plot[i-3*nfeature,14]<0) beta[i]='negative';
    }
  }
  data_use_plot=data.frame(Number=c(1:nfeature,1:nfeature,1:nfeature,1:nsnp),
                           adjR2=c(data_plot[1:nfeature,2],
                                   data_plot[1:nfeature,6],
                                   data_plot[1:nfeature,10],
                                   data_plot[1:nsnp,13]),
                           Model=c(rep('HTR',nfeature),
                                   rep('HTRX',nfeature),
                                   rep('Painting',nfeature),
                                   rep('Genotype',nsnp)),
                           name=c(gsub('H','',data_plot[1:nfeature,1]),
                                  gsub('H','',data_plot[1:nfeature,5]),
                                  data_plot[1:nfeature,9],
                                  data_plot[1:nsnp,12]),
                           Effect_size=beta)
  ggplot(data_use_plot,aes(x=Number,y=adjR2))+geom_point(size=4,aes(color=Model,shape=Effect_size))+
    geom_line(size=1.2,aes(color=Model))+
    xlab('Number of features')+
    ylab('Cumulative adjusted R\u00B2')+ggtitle(paste("Chromosome 6 position",SNPname))+labs(subtitle=eachSNP)+
    theme_stata() + scale_color_stata() +
    geom_text_repel(aes(x=Number,y=adjR2,color=Model,label=name))+
    scale_shape_manual(values=c(16,17))+
    theme(plot.title = element_text(hjust = 0.5, size=22),
          axis.title.x = element_text(size=20),
          axis.title.y = element_text(size=20),
          legend.title = element_text(size=20),
          legend.text = element_text(size=20),
          axis.text.x = element_text(size=17),
          axis.text.y = element_text(size=17),
          plot.subtitle=element_text(size=16, hjust=0.5))
}

data_plot=read.table('ALL_30.06_31.34.csv',header=TRUE,sep=',')
plotcomparison(SNPname='30060631-31346822',
               eachSNP='Including 4 SNPs: 30060631(G/C), 31322522(C/A), 31323677(C/T), 31346822(T/C)',
               nsnp=4,nfeature=15)

data_plot=read.table('ALL_31.49_32.14.csv',header=TRUE,sep=',')
plotcomparison(SNPname='31497244-32145399',
               eachSNP='Including 5 SNPs: 31497244(A/G), 31518354(G/A), 31539767(C/T), 31540757(A/C), 32145399(C/G)',
               nsnp=5,nfeature=20)

data_plot=read.table('ALL_32.36_32.68.csv',header=TRUE,sep=',')
plotcomparison(SNPname='32367997-32681483',
               eachSNP='Including 6 SNPs: 32367997(T/A), 32413051(A/G), 32586854(G/A), 32609173(C/G), 32634302(A/G), 32681483(T/C)',
               nsnp=6,nfeature=20)

data_plot=read.table('ALL_33.04_33.08.csv',header=TRUE,sep=',')
plotcomparison(SNPname='33047466-33081823',
               eachSNP='Including 4 SNPs: 33047466(T/C), 33047612(G/C), 33081632(A/G), 33081823(A/G)',
               nsnp=4,nfeature=15)


data_plot=read.table('ALL_32.41and32.60.csv',header=TRUE,sep=',')
plotcomparison(SNPname='32410351 and 32609173',
               eachSNP='Including 2 SNPs: 32413051(A/G), 32609173(C/G)',
               nsnp=2,nfeature=4)

data_plot=read.table('ALL_32.41and32.63.csv',header=TRUE,sep=',')
plotcomparison(SNPname='32410351 and 32634302',
               eachSNP='Including 4 SNPs: 32413051(A/G), 32634302(A/G)',
               nsnp=2,nfeature=4)
