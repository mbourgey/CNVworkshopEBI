## set environement
cd $HOME/ebicancerworkshop201607/CNV/SNParray

R

library(ASCAT)

ascat.bc = ascat.loadData("C0056/tumor/tumor_LRR.tsv","C0056/tumor/tumor_BAF.tsv", "C0056/normal/normal_LRR.tsv","C0056/normal/normal_BAF.tsv")

ascat.plotRawData(ascat.bc)

ascat.seg = ascat.aspcf(ascat.bc)

ascat.plotSegmentedData(ascat.seg)

ascat.output = ascat.runAscat(ascat.seg)

params.estimate=data.frame(Sample=names(ascat.output$aberrantcellfraction),Aberrant_cell_fraction=round(ascat.output$aberrantcellfraction,2),Ploidy=round(ascat.output$ploidy,2))
write.table(params.estimate,"sample.Param_estimate.tsv",sep="\t",quote=F,col.names=T,row.names=F)

CNA=rep(".",dim(ascat.output$segments)[1])
CNA[rowSums(ascat.output$segments[,5:6]) > round(ascat.output$ploidy)]="DUP"
CNA[rowSums(ascat.output$segments[,5:6]) < round(ascat.output$ploidy)]="DEL"
output.table=data.frame(ascat.output$segments,CNA=CNA)
write.table(output.table[output.table$CNA != ".",],"sample_CNVcalls.tsv",quote=F,sep="\t",col.names=T,row.names=F)
q(save="yes")
