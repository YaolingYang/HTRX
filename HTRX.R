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



###ggplots
#genotype, htr and painting in the same plot!
plotcomparison <- function(SNPname,eachSNP,nsnp,nfeature){
  data_use_plot=data.frame(Number=c(1:nfeature,1:nfeature,1:nsnp,1:nfeature),
                           adjR2=c(HTRX_data[1:nfeature,3],
                                   HTR_Geno[1:nfeature,3],
                                   HTR_Geno[1:nsnp,5],
                                   Ancestry[1:nfeature,3]),
                           Model=c(rep('HTRX',nfeature),
                                   rep('HTR',nfeature),
                                   rep('Genotype',nsnp),
                                   rep('Painting',nfeature)),
                           name=c(HTRX_data[1:nfeature,2],
                                  HTR_Geno[1:nfeature,2],
                                  HTR_Geno[1:nsnp,4],
                                  Ancestry[1:nfeature,2]))
  ggplot(data_use_plot,aes(x=Number,y=adjR2,color=Model))+geom_point(size=4)+geom_line(size=1.5)+
    xlab('Number of features')+
    ylab('Cumulative adjusted R\u00B2')+ggtitle(paste('SNP',SNPname))+labs(subtitle=eachSNP)+
    theme_stata() + scale_color_stata() +
    geom_text_repel(aes(x=Number,y=adjR2,color=Model,label=name))+
    theme(plot.title = element_text(hjust = 0.5, size=22),
          axis.title.x = element_text(size=20),
          axis.title.y = element_text(size=20),
          legend.title = element_text(size=20),
          legend.text = element_text(size=20),
          axis.text.x = element_text(size=17),
          axis.text.y = element_text(size=17),
          plot.subtitle=element_text(size=16, hjust=0.5))
}
Ancestry=read.table('adjR2_30060631_31346822_eachpainting.csv',header=TRUE,sep=',')
HTR_Geno=read.table('adjR2_30060631_31346822.csv',header=TRUE,sep=',')
HTRX_data=read.table('HTRX_30.06_31.34.txt',header=TRUE,sep=',')
plotcomparison(SNPname='30060631-31346822',
               eachSNP='Including 4 SNPs: 30060631(G/C), 31322522(C/A), 31323677(C/T), 31346822(T/C)',
               nsnp=4,nfeature=15)

Ancestry=read.table('adjR2_31497244_32145399_eachpainting.csv',header=TRUE,sep=',')
HTR_Geno=read.table('adjR2_31497244_32145399.csv',header=TRUE,sep=',')
HTRX_data=read.table('HTRX_31.49_32.14.txt',header=TRUE,sep=',')
plotcomparison(SNPname='31497244-32145399',
               eachSNP='Including 5 SNPs: 31497244(A/G), 31518354(G/A), 31539767(C/T), 31540757(A/C), 32145399(C/G)',
               nsnp=5,nfeature=20)

Ancestry=read.table('adjR2_32367997_32681483_eachpainting.csv',header=TRUE,sep=',')
HTR_Geno=read.table('adjR2_32367997_32681483.csv',header=TRUE,sep=',')
HTRX_data=read.table('HTRX_32.36_32.68.txt',header=TRUE,sep=',')
plotcomparison(SNPname='32367997-32681483',
               eachSNP='Including 6 SNPs: 32367997(T/A), 32413051(A/G), 32586854(G/A), 32609173(C/G), 32634302(A/G), 32681483(T/C)',
               nsnp=6,nfeature=20)

Ancestry=read.table('adjR2_33047466_33081823_eachpainting.csv',header=TRUE,sep=',')
HTR_Geno=read.table('adjR2_33047466_33081823.csv',header=TRUE,sep=',')
HTRX_data=read.table('HTRX_33.04_33.08.txt',header=TRUE,sep=',')
plotcomparison(SNPname='33047466-33081823',
               eachSNP='Including 4 SNPs: 33047466(T/C), 33047612(G/C), 33081632(A/G), 33081823(A/G)',
               nsnp=4,nfeature=15)


