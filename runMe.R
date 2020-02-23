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
source("./CONS/R/CONS.R")

# Read files --------------------------------------------------------------
eyeDataInitial <- CONS(codeDir = "./CONS/R", dataDir = "./CONS/data/data", imageDir = "./CONS/images")
