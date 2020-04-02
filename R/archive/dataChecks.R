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

# C1 anomalies ------------------------------------------------------------
eyeDataInitial <- readRDS("~/Downloads/Joos Meyer - CONS - DONT DELETE/all_data/eyeDataInitial.rds")
anomaliesC1 <- map_dfr(eyeDataInitial
                       ,function(x){
                           x <- x$gclArray[1:4]
                           x <- data.frame(PatientNumber = x[1],VisitNumber = x[2],EyeSide = ifelse(x[3]==1,"od","os"),C1 = x[4]) %>% 
                               mutate(fileName = paste(PatientNumber,VisitNumber,EyeSide,sep = "_"))
                           return(x)
                       }) %>%
    filter(C1 < 0 | is.na(C1))
    
# Eye centers -------------------------------------------------------------
eyeDataInitial <- readRDS("~/Downloads/Joos Meyer - CONS - DONT DELETE/all_data/eyeDataInitial.rds")
eyeCenterRegional <- map_dfr(eyeDataInitial
                      ,function(x){
                          fileName <- as.character(x$patientInfo$FileName)
                          centers <- x$eyeCenter
                          centerRow <- as.integer(centers[1])
                          centerColumn <- as.integer(centers[2])
                          result <- data.frame(fileName,centerRow,centerColumn,centerType = "Regional")
                      })

eyeCenterAll <- map_dfr(eyeDataInitial
                      ,function(x){
                          fileName <- as.character(x$patientInfo$FileName)
                          centers <- fovealCentre(consData = x$scanData,regionalEyeCenter = FALSE)
                          centerRow <- as.integer(centers[1])
                          centerColumn <- as.integer(centers[2])
                          result <- data.frame(fileName,centerRow,centerColumn,centerType = "All")
                      })
