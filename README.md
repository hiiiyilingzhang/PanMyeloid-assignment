# PanMyeloid Assignment
* Author: ZHANG, Yiling
* Date: 27/10 - 6/11
* Paper: [A pan-cancer single-cell transcriptional atlas of tumor infiltrating myeloid cells, Cheng,Sijin et al.,Cell,2021](https://www.cell.com/cell/fulltext/S0092-8674(21)00010-6#secsectitle0075)

---

Here is **source code** for assignment. Report and relevant files please refer to  

* Report: [GitBook-Report](https://hiiiyilingzhang.gitbook.io/panmyeloid-assignment/)
* Paper Reproduction Notebook: [LING-Notebook for Python](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FapieLloV8ZqobtO01up9%2Fuploads%2FVk499jB1kdPqdV1rn3ch%2FPaperReproduction.html?alt=media&token=562f72fa-b9c3-44e8-bb73-31f4030c8511)
* Data Exploration Notebook: [LINK-Notebook for R](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FapieLloV8ZqobtO01up9%2Fuploads%2Fa7wVwlaq597mKrRb6g0R%2FPanMyeloidAssignment-Yiling.html?alt=media&token=205414a7-ae6b-463a-aedd-096efccc11db) & [LINK-Notebook for Python](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FapieLloV8ZqobtO01up9%2Fuploads%2FPYIsIRAU8x82Xh1uxVbq%2FDataExploration-scGen.html?alt=media&token=343257d5-0e2a-46da-86e8-f6468a7199e1)
* TROUBLESHOOTING: [GitBook-TROUBLESHOOTING](https://app.gitbook.com/s/apieLloV8ZqobtO01up9/troubleshooting)

---

```bash
├── output
│   └── rmd-output
├── PanMyeloid-assignment.Rproj
├── processedData
│   ├── alldata.obj
│   │   ├── alldata-metadata.csv
│   │   ├── bbknn-completed.h5ad
│   │   ├── compute-HVG-alldata.h5ad
│   │   ├── compute-HVG-PCA-alldata.h5ad
│   │   ├── finish-integration-with-umap.h5ad
│   │   ├── finish-integration-with-umap.h5seurat
│   │   ├── newly-generated-data-fixed-obs.h5ad
│   │   ├── regressed-alldata.h5ad
│   │   ├── regressed-alldata.h5seurat
│   │   ├── scgen-data-umap.csv
│   │   ├── scgen-data-umap.txt
│   │   ├── scgen-data-with-umap.h5ad
│   │   └── scgen-data-with-umap.h5seurat
│   ├── CRC.processsed
│   │   ├── CRC-myeloid-filtered.h5ad
│   │   ├── CRC-myeloid-filtered.h5Seurat
│   │   ├── CRC-myeloid-filtered.RDS
│   │   └── CRC-myeloid-raw.RDS
│   └── tmp.data
│       ├── ori-lisi-res.RData
│       ├── pancreas.h5ad
│       └── saved_models
│           └── model_batch_removal.pt
│               ├── attr.pkl
│               ├── model_params.pt
│               └── var_names.csv
├── rawData
│   ├── anno.ref
│   │   ├── hpca-se.RData
│   │   └── ImmGen.RData
│   ├── CRC
│   │   ├── GSE146771_CRC.Leukocyte.10x.Metadata.txt.gz
│   │   ├── GSE146771_CRC.Leukocyte.10x.TPM.txt.gz
│   │   ├── GSE146771_CRC.Leukocyte.Smart-seq2.Metadata.txt.gz
│   │   └── GSE146771_CRC.Leukocyte.Smart-seq2.TPM.txt.gz
│   ├── ESCA
│   │   ├── GSE154763_ESCA_metadata.csv.gz
│   │   └── GSE154763_ESCA_normalized_expression.csv.gz
│   ├── LYM
│   │   ├── GSE154763_LYM_metadata.csv.gz
│   │   └── GSE154763_LYM_normalized_expression.csv.gz
│   ├── MYE
│   │   ├── GSE154763_MYE_metadata.csv.gz
│   │   └── GSE154763_MYE_normalized_expression.csv.gz
│   ├── OV-FTC
│   │   ├── GSE154763_OV-FTC_metadata.csv.gz
│   │   └── GSE154763_OV-FTC_normalized_expression.csv.gz
│   ├── PAAD
│   │   ├── GSE154763_PAAD_metadata.csv.gz
│   │   └── GSE154763_PAAD_normalized_expression.csv.gz
│   └── UCEC
│       ├── GSE154763_UCEC_metadata.csv.gz
│       └── GSE154763_UCEC_normalized_expression.csv.gz
├── README.md
├── report
│   ├── DataExploration-scGen.ipynb
│   ├── PanMyeloidAssignment-Yiling.html
│   ├── PanMyeloidAssignment-Yiling.Rmd
│   └── PaperReproduction.ipynb
└── src
    ├── script
    │   ├── py.script
    │   │   └── 01-InitializeData.py
    │   └── R.script
    │       ├── 01-InitializeSeuratObject.R
    │       └── CRC-preprocess.R
    └── upload-pic
        ├── CellNumberChexk.png
        └── sampleDiscription.png
```
