library(data.table)
library(dplyr)
library(tidyr)
library(Seurat)
library(SeuratData)
library(SeuratDisk)

## ----- CRC 10X -----
# ----- Add Metadata -----
CRC.10X <- read.table("rawData/CRC/GSE146771_CRC.Leukocyte.10x.TPM.txt.gz",header = T) %>% CreateSeuratObject(project = "CRC")

CRC.10X.meta <- read.table("rawData/CRC/GSE146771_CRC.Leukocyte.10x.Metadata.txt.gz",fill = T,sep = "\t",header = T)
rownames(CRC.10X.meta) <- CRC.10X.meta$CellName
CRC.10X.meta <- CRC.10X.meta %>% separate("Sub_Cluster",into = c("ID","Sub_Cluster"),sep = "_")
CRC.10X.meta <- select(CRC.10X.meta, -one_of("ID","Sub_ClusterID"))
CRC.10X.meta <- CRC.10X.meta[,-c(11:14,17:22)]

metaNow <- CRC.10X@meta.data
metaNow$CellName <- rownames(metaNow)

metaNow <- merge(metaNow, CRC.10X.meta, by = "CellName")
rownames(metaNow) <- metaNow$CellName
CRC.10X <- AddMetaData(object = CRC.10X, metadata = metaNow) 
CRC.10X[["tech_10X"]] <- "10X3" # for batch removal 10X3' and 10X5'

## ----- CRC SS2 -----
# ----- Add Metadata -----
CRC.SS2 <- read.table("rawData/CRC/GSE146771_CRC.Leukocyte.Smart-seq2.TPM.txt.gz",header = T) %>% CreateSeuratObject(project = "CRC")

CRC.SS2.meta <- read.table("rawData/CRC/GSE146771_CRC.Leukocyte.Smart-seq2.Metadata.txt.gz",fill = T,sep = "\t",header = T)
rownames(CRC.SS2.meta) <- CRC.SS2.meta$CellName
CRC.SS2.meta <- CRC.SS2.meta %>% separate("Sub_Cluster",into = c("ID","Sub_Cluster"),sep = "_")
CRC.SS2.meta <- select(CRC.SS2.meta, -one_of("ID","Sub_ClusterID"))
CRC.SS2.meta <- CRC.SS2.meta[,-c(11:14,17:22)]

metaNow <- CRC.SS2@meta.data
metaNow$CellName <- rownames(metaNow)

metaNow <- merge(metaNow, CRC.SS2.meta, by = "CellName")
rownames(metaNow) <- metaNow$CellName
CRC.SS2 <- AddMetaData(object = CRC.SS2, metadata = metaNow) 
CRC.SS2[["tech_10X"]] <- "SmartSeq2"

## -----Merge two CRC-----
CRC <- merge(x = CRC.10X, y = CRC.SS2)

## -----Extract Myeloid-----
CRC.myeloid <- CRC[, CRC@meta.data[, "Global_Cluster"] == "Myeloid cell"]

# saveRDS(CRC.myeloid,file = "processedData/CRC.processsed/CRC-myeloid-raw.RDS")

## ----- QC -----
# Calculate
CRC.myeloid[["percent_mito"]] <- PercentageFeatureSet(object = CRC.myeloid, pattern = "^MT-", assay = "RNA")
CRC.myeloid[["percent_hsp"]] <- PercentageFeatureSet(object = CRC.myeloid, pattern = "^HSP", assay = "RNA")

# filter
CRC.myeloid <- subset(x = CRC.myeloid, 
                       subset= (nCount_RNA >= 2000) & 
                         (nCount_RNA <= 40000) & 
                         (nFeature_RNA >= 500) & 
                         (nFeature_RNA <= 5000) &
                         (percent_mito < 10))
CRC.myeloid

# Gene QC

# Extract counts
counts <- GetAssayData(object = CRC.myeloid, slot = "counts",assay = "RNA")

# Output a logical vector for every gene on whether the more than zero counts per cell
nonzero <- counts > 0

# Sums all TRUE values and returns TRUE if more than 3 TRUE values per gene
keep_genes <- Matrix::rowSums(nonzero) >= 2

# Only keeping those genes expressed in more than 3 cells
filtered_counts <- counts[keep_genes, ]

# Reassign to filtered Seurat object
CRC.myeloid.clean <- CreateSeuratObject(filtered_counts, meta.data = CRC.myeloid@meta.data)

CRC.myeloid.clean@meta.data <- select(CRC.myeloid.clean@meta.data,-"Barcode")

## ----- Add MajorCluster -----

defineMajor <- function(x){
  if(grepl("^pDC",x)){
    return("pDC")
  }else if(grepl("^cDC",x)){
    return("cDC")
  }else if(grepl("Macro|Mono|TAM",x)){
    return("Mono/Macro")
  }else if(grepl("^Mast",x)){
    return("Mast")
  }
}

CRC.myeloid.clean@meta.data$MajorCluster <- CRC.myeloid.clean@meta.data$Sub_Cluster
for (i in 1:nrow(CRC.myeloid.clean@meta.data)) {
  CRC.myeloid.clean@meta.data[i,"MajorCluster"] <- defineMajor(CRC.myeloid.clean@meta.data[i,"Sub_Cluster"])
}

colnames(CRC.myeloid.clean@meta.data)[2] <- "n_counts"
colnames(CRC.myeloid.clean@meta.data)[3] <- "n_genes"
colnames(CRC.myeloid.clean@meta.data)[6] <- "patient"
colnames(CRC.myeloid.clean@meta.data)[7] <- "tissue"
colnames(CRC.myeloid.clean@meta.data)[8] <- "tech"

CRC.myeloid.clean[["cancer"]] <- "CRC"

CRC.myeloid.clean@meta.data <- select(CRC.myeloid.clean@meta.data, one_of("n_counts","n_genes","cancer","patient","tissue","tech","tech_10X","percent_mito","percent_hsp","MajorCluster","Sub_Cluster"))

saveRDS(CRC.myeloid.clean,file = "processedData/CRC.processsed/CRC-myeloid-filtered.RDS")
## ----------------------------

## Save as .h5 -----
SaveH5Seurat(CRC.myeloid.clean, filename = "processedData/CRC.processsed/CRC-myeloid-filtered.h5Seurat")
Convert("processedData/CRC.processsed/CRC-myeloid-filtered.h5Seurat", dest = "h5ad")

