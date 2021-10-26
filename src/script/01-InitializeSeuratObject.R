library(Seurat)
library(dplyr)
PAAD <- read.csv("rawData/PAAD/GSE154763_PAAD_normalized_expression.csv.gz", header = T, row.names = 1) %>% 
  CreateSeuratObject(project = "PAAD")
LYM <- read.csv("rawData/LYM/GSE154763_LYM_normalized_expression.csv.gz", header = T, row.names = 1) %>% 
  CreateSeuratObject(project = "LYM")
ESCA <- read.csv("rawData/ESCA/GSE154763_ESCA_normalized_expression.csv.gz", header = T, row.names = 1) %>% 
  CreateSeuratObject(project = "ESCA")
MYE <- read.csv("rawData/MYE/GSE154763_MYE_normalized_expression.csv.gz", header = T, row.names = 1) %>% 
  CreateSeuratObject(project = "MYE")
OV.FTC <- read.csv("rawData/OV-FTC/GSE154763_OV-FTC_normalized_expression.csv.gz", header = T, row.names = 1) %>% 
  CreateSeuratObject(project = "OV-FTC")
UCEC <- read.csv("rawData/UCEC/GSE154763_UCEC_normalized_expression.csv.gz", header = T, row.names = 1) %>% 
  CreateSeuratObject(project = "UCEC")

MEL <- read.table("rawData/MEL-treatment/GSE120575_Sade_Feldman_melanoma_single_cells_TPM_GEO.txt.gz", 
                  header = T, row.names = 1, fill = T)
MEL <- MEL[-1,] %>% t() %>% CreateSeuratObject(project = "MEL")
MEL.meta <- read.table("rawData/MEL-treatment/GSE120575_patient_ID_single_cells.txt.gz", skip = "#", 
                       fill = T)
