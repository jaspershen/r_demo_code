# BiocManager::install("pvca")

library(golubEsets)
library(pvca)
library(Biobase)

assay_data <- 
  matrix(runif(10000), nrow=100, ncol=100)

colnames(assay_data) <- paste("Sample", 1:100, sep = "")
rownames(assay_data) <- paste("gene", 1:100, sep = "")

sample_info <- 
  data.frame(Samples = colnames(assay_data),
             batch = c(rep(1,50), rep(2,50)),
             age = sample(1:1000, 100), 
             stringsAsFactors = FALSE)

pheno_data <- AnnotatedDataFrame(data = sample_info)

row.names(pheno_data) <- colnames(assay_data)

temp_data <- 
Biobase::ExpressionSet(
  assayData = assay_data,
  phenoData = pheno_data
  )

pct_threshold <- 0.6
batch.factors <- c("batch", "age")
pvcaObj <- pvcaBatchAssess(abatch = temp_data, 
                           batch.factors, 
                           pct_threshold)


bp <- barplot(pvcaObj$dat, xlab = "Effects",
                ylab = "Weighted average proportion variance",
                ylim= c(0,1.1),col = c("blue"), las=2,
                main="PVCA estimation bar chart")

axis(1, at = bp, labels = pvcaObj$label, xlab = "Effects", cex.axis = 0.5, las=2)
values = pvcaObj$dat
new_values = round(values , 3)
text(bp,pvcaObj$dat,labels = new_values, pos=3, cex = 0.8)





library(golubEsets)
data(Golub_Merge)
pct_threshold <- 0.6
batch.factors <- c("ALL.AML", "BM.PB", "PS")

pvcaObj <- pvcaBatchAssess (Golub_Merge, batch.factors, pct_threshold) 
bp <- barplot(pvcaObj$dat,  xlab = "Effects",
              ylab = "Weighted average proportion variance", ylim= c(0,1.1),
              col = c("blue"), las=2, main="PVCA estimation bar chart")
axis(1, at = bp, labels = pvcaObj$label, xlab = "Effects", cex.axis = 0.5, las=2)
values = pvcaObj$dat
new_values = round(values , 3)
text(bp,pvcaObj$dat,labels = new_values, pos=3, cex = 0.8) 
print(sessionInfo())