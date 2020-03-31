# Load libraries ----------------------------------------------------------
rm(list = ls())
gc()
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

# Load initial data -------------------------------------------------------
mem_used()
eyeDataInitial <- readRDS("~/Downloads/Joos Meyer - CONS - DONT DELETE/all_data/eyeDataInitial.rds")
mergedPatientDetails <- readRDS("~/Downloads/Joos Meyer - CONS - DONT DELETE/all_data/mergedPatientDetails.rds")
mergedCleanedGclArray_13 <- readRDS("~/Downloads/Joos Meyer - CONS - DONT DELETE/all_data/mergedCleanedGclArray_13.rds")
mem_used()

# First values (VL1) of all arrays ----------------------------------------
first.vals <- map_dbl(eyeDataInitial
        ,function(x){
            x <- x$gclArray[4]
            x
        }) %>% 
    data.frame
colnames(first.vals) <- "VL1"
summary(first.vals)
mem_used()

# Centers of all scan data ------------------------------------------------
centers <- map_dfc(eyeDataInitial
        ,function(x){
            x <- fovealCentre(x$scanData)[1,]
            x
        })
centers <- data.frame(t(centers))
colnames(centers) <- c("row","column")
summary(centers)
mem_used()

# Sample scan data --------------------------------------------------------
scan <- eyeDataInitial[[7]]$scanData
gcl <- eyeDataInitial[[7]]$gclMatrix

# Longest array less first 3 values ---------------------------------------
array.length <- map_dbl(eyeDataInitial
        ,function(x){
            x <- length(x$gclArray) - 3
            x
        })
summary(array.length)
sqrt(array.length)


sqrt(263169)
sqrt(299209)
sqrt(1046529)


