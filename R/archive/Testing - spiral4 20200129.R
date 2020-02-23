# Load libraries ----------------------------------------------------------
rm(list = ls())
library(tidyverse)
library(tictoc)
source("./CONS/R/CONS.R")
source("./CONS/R/spiralMatrixToArray4.R")

# Read files --------------------------------------------------------------
eyeData <- CONS(codeDir = "./CONS/R", dataDir = "./CONS/data2", imageDir = "./CONS/images")

codeDir <- "./CONS/R"
dataDir<- "./CONS/data2"
imageDir <- "./CONS/images"
fileName <- "167_1_os.xls"

# Read R codes
rCodes <- list.files(path = codeDir,pattern = ".R$") %>% 
    setdiff(c("CONS.R","createDirectory.R","runMe.R"))
walk(
    rCodes,
    function(x){
        fileName <- file.path(codeDir,x)
        source(fileName)
    })

patient <- patientDetails(path = dataDir,fileName = fileName)
cons <- readConsFile(path = dataDir,fileName = fileName) %>% 
    tidyConsData()
center <- fovealCentre(consData = cons)
gclMatrix <- gclThickness(consData = cons)
gclArray <- spiralMatrixToArray3(gclData = gclMatrix, eyeCenter = center)
renderEyeImage(consData = cons,imageDirectory = imageDir)
# data <- list(patientInfo = patient,scanData = cons,gclMatrix = gclMatrix)
data <- list(patientInfo = patient,scanData = cons,gclMatrix = gclMatrix, gclArray = gclArray)

eyeLayerThickness(cons)[,-c(1:5)][(center[1]-2):(center[1]+2),(center[2]-2):(center[2]+2)]


maxCols <- 263 #outofbounds
maxCols <- 257 #outofbounds
maxCols <- 256 #outofbounds
maxCols <- 255 #outofbounds
maxCols <- 254
testTidyConsData <- cons[,1:maxCols]
ncol(testTidyConsData) - 7
# EXECUTE: Calculae GCL thickness -----------------------------------------
gclMatrix <- gclThickness(consData = testTidyConsData)
center <- fovealCentre(consData = testTidyConsData)
# spiralMatrixToArray(gclData = gclMatrix)
spiralMatrixToArray3(gclData = gclMatrix, eyeCenter = center)
spiralMatrixToArray4(gclData = gclMatrix, eyeCenter = center)


gclData <- gclMatrix[,-c(1:5)] %>%
    as.matrix
dims <- dim(gclData)
maxR <- dims[1]
maxC <- dims[2]
currentR <- center[1]
currentC <- center[2]
totalSides <- max(maxC - currentC,currentC - 1) * 4 + 1
(totalSides-1)/4

