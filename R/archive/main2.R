# Load libraries ----------------------------------------------------------
rm(list = ls())
library(tidyverse)
library(tictoc)

# READ: R user functions --------------------------------------------------
source("./R/parseFileName.R")
source("./R/patientDetails.R")
source("./R/readConsFile.R")
source("./R/eyeLayerThickness.R")
source("./R/fovealCentre.R")
source("./R/renderEyeImage.R")
source("./R/spiralMatrixToArray.R")
source("./R/spiralMatrixToArray3.R")
source("./R/gclThickness.R")
source("./R/tidyConsData.R")


# READ: Patient Details ---------------------------------------------------
testPath <- './data'
testFileName <- '22_1_od.xls'
testPatient <- patientDetails(testPath,testFileName)

# READ: Reading a CONS file -----------------------------------------------
testConsData <- readConsFile(path = testPath,fileName = testFileName)

# EXECUTE: Remove excess horizontal layers from the eye image data --------
testTidyConsData <- tidyConsData(testConsData)[,1:500]

# EXECUTE: Calculate retinal thickness and identify foveal centre ---------
(center <- fovealCentre(consData = testTidyConsData))
eyeLayerThickness(testTidyConsData)[,-c(1:5)][(center[1]-2):(center[1]+2),(center[2]-2):(center[2]+2)]

# EXECUTE: Display heatmap to manually check foveal centre-----------------
renderEyeImage(consData = testConsData,imageDirectory = "./images")
renderEyeImage(consData = testTidyConsData,imageDirectory = "./images")

# EXECUTE: Calculae GCL thickness -----------------------------------------
gclMatrix <- gclThickness(consData = testTidyConsData)
spiralMatrixToArray(gclData = gclMatrix)
spiralMatrixToArray3(gclData = gclMatrix, eyeCenter = center)

nfl <- testTidyConsData %>% 
    filter(EyeLayer == "NFL")
gcl <- testTidyConsData %>% 
    filter(EyeLayer == "GCL")


# EXECUTE: GCL matrix to array from center --------------------------------
testArray <- spiralMatrixToArray(GCLmatrix)

# TESTING -----------------------------------------------------------------
(sampleData <- testThickness[1:10,1:10])
(minDims <- which(sampleData == min(sampleData, na.rm = TRUE), arr.ind = TRUE))
sampleData[minDims]
(testArray <- spiralMatrixToArray(sampleData))


