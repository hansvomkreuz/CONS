# Load libraries ----------------------------------------------------------
rm(list = ls())
library(tidyverse)
# library(purrr)

# READ: R user functions --------------------------------------------------
source("./R/patientDetails.R")
source("./R/readConsFile.R")
source("./R/fovealcentre.R")
source("./R/spiralMatrixToArray.R")
source("./R/GCLThickness.R")
source("./R/centrecheck.R")

# READ: Patient Details ---------------------------------------------------
testPath <- './data'
testFileName <- '3_1_os.xls'
testPatient <- patientDetails(testPath,testFileName)

# READ: Reading a CONS file -----------------------------------------------
testConsData <- readConsFile(testPath,testFileName)

# EXECUTE: Calcuate retinal thickness and identify foveal centre ----------
fovealcentre <- fovealcentre(testConsData)

# EXECUTE: Display heatmap to manually check foveal centre-----------------
centrecheck(testConsData)

# EXECUTE: Calculae GCL thickness -----------------------------------------
GCLmatrix <- GCLThickness(testConsData)

# EXECUTE: GCL matrix to array from center --------------------------------
testArray <- spiralMatrixToArray(GCLmatrix)

# TESTING -----------------------------------------------------------------
(sampleData <- testThickness[1:10,1:10])
(minDims <- which(sampleData == min(sampleData, na.rm = TRUE), arr.ind = TRUE))
sampleData[minDims]
(testArray <- spiralMatrixToArray(sampleData))


