# Compressive Optic Neuropathy Study (CONS) -------------------------------
#' This is the main code to read and process the eye data for the CONS study
#' This code does the following:
#' 1. loads the required libraries: tidyverse and tictoc
#' 2. loads and calls on the CONS function
#' 
#' These are the parameters of the CONS function:
#' 1. codeDir is where the R codes are stored, to be loaded, and called
#' 2. dataDir is where the .xls files are stored
#' 3. imageDir is where the images are saved for each of the .xls filed processed

# Load libraries ----------------------------------------------------------
rm(list = ls())
library(tidyverse)
library(tictoc)
library(pryr)

# Load all R codes --------------------------------------------------------
codeDir <- "./CONS/R"
list.files(path = codeDir,pattern = ".R$") %>% 
    walk(
        function(x){
            fileName <- file.path(codeDir,x)
            source(fileName)
        })

# Read files --------------------------------------------------------------
eyeDataInitial <- CONS(dataDir = "./data", imageDir = "./images")

# Create merged files -----------------------------------------------------
mergePatientDetails(eyeDataInitial = "./data/eyeDataInitial.rds")
mergeScanData(eyeDataInitial = "./data/eyeDataInitial.rds")
mergeGclMatrix(eyeDataInitial = "./data/eyeDataInitial.rds")
mergeCleanGclArray(eyeDataInitial = "./data/eyeDataInitial.rds")

