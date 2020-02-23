# Load libraries ----------------------------------------------------------
rm(list = ls())
library(tidyverse)
# library(purrr)

# READ: R user functions --------------------------------------------------
source("./R/patientDetails.R")
source("./R/readConsFile.R")
source("./R/eyeThickness.R")
source("./R/spiralMatrixToArray.R")

# READ: Patient Details ---------------------------------------------------
testPath <- './data'
testFileName <- '3_1_os.xls'
testPatient <- patientDetails(testPath,testFileName)

# READ: Reading a CONS file -----------------------------------------------
testConsData <- readConsFile(testPath,testFileName)

# EXECUTE: Calcuate eye thickness -----------------------------------------
testThickness <- eyeThickness(testConsData)

# EXECUTE: Matrix to array from center ------------------------------------
testArray <- spiralMatrixToArray(testThickness)

# TESTING -----------------------------------------------------------------
(sampleData <- testThickness[1:10,1:10])
(minDims <- which(sampleData == min(sampleData, na.rm = TRUE), arr.ind = TRUE))
sampleData[minDims]
(testArray <- spiralMatrixToArray(sampleData))


