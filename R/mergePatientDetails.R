rm(list = ls())
eyeDataInitial <- readRDS("~/Google Drive/Freelance/[Upwork] Joos Meyer/CONS/data/all_data/eyeDataInitial.rds")
readRDS("~/Google Drive/Freelance/[Upwork] Joos Meyer/CONS/data/all_data/eyeDataInitial.rds")

mergePatientDetails <- function(consData){
    path <- stringr::str_split(consData,"/")[[1]]
    path <- file.path(paste0(path[-length(path)],collapse = "/"),"mergedPatientDetails.rds")
    tictoc::tic(paste("Merged patient data. File saved in",path))
    gc()
    eyeDataInitial <- readRDS(consData)
    mergedPatientDetails <- purrr::map_dfr(
        eyeDataInitial,
        function(x){
            x$patientInfo %>% 
                dplyr::mutate_all(as.character)
        })
    
    saveRDS(object = mergedPatientDetails,file = path)
    tictoc::toc()
    return(mergedPatientDetails)
}

mergeScanData <- function(consData){
    path <- stringr::str_split(consData,"/")[[1]]
    path <- file.path(paste0(path[-length(path)],collapse = "/"),"mergedScanData.rds")
    tictoc::tic(paste("Merged scan data. File saved in",path))
    gc()
    eyeDataInitial <- readRDS(consData)

    mergedScanData <- purrr::map_dfr(
        eyeDataInitial,
        function(x){
            x$scanData %>% 
                dplyr::mutate_if(is.factor,as.character)
        })
    
    saveRDS(object = mergedScanData,file = path)
    tictoc::toc()
    return(mergedScanData)
}

mergeGclMatrix <- function(consData){
    path <- stringr::str_split(consData,"/")[[1]]
    path <- file.path(paste0(path[-length(path)],collapse = "/"),"mergedGclMatrix.rds")
    tictoc::tic(paste("Merged GCL matrix data. File saved in",path))
    gc()
    eyeDataInitial <- readRDS(consData)
    
    mergedGclMatrix <- purrr::map_dfr(
        eyeDataInitial,
        function(x){
            x$gclMatrix %>% 
                dplyr::mutate_if(is.factor,as.character)
        })    

    saveRDS(object = mergedGclMatrix,file = path)
    tictoc::toc()
    return(mergedGclMatrix)
}


mergeCleanGclArray <- function(consData){
    gc()
    path <- stringr::str_split(consData,"/")[[1]]
    path <- file.path(paste0(path[-length(path)],collapse = "/"),"mergedCleanedGclArray.rds")
    
    tictoc::tic(paste0("Merged GCL array data and fixed to same length array completed and saved in ",path,".rds"))
    
    memBefore <- pryr::mem_used()/1024^2
    # eyeDataInitial <- readRDS(consData)
    memAfter <- pryr::mem_used()/1024^2
    memChange <- memAfter - memBefore
    iters <- ceiling(memChange/1000)
    maxArrayLength <- purrr::map_dbl(
        readRDS(consData),
        function(x){
            length(x$gclArray)
        }) %>%
        max()
    mergedGclArray <- readRDS(consData) %>%
        purrr::map(
            function(x){
                x$gclArray
            }) %>% 
        purrr::map_dfr(
            function(x){
                arrayLength <- length(x)
                paddedArray <- c(x,rep(NA,maxArrayLength - arrayLength))
                return(paddedArray)
            })
    
    
    
    rm(eyeDataInitial)
    gc()
    listLength <- length(gclArray)
    maxArrayLength <- max(sapply(gclArray,length))
    columnNames <- c("studyId","visit","eye",paste0("C",c(1:(maxArrayLength-3))))
    paths <- NULL
    for (i in seq.int(iters)) {
        gc()
        pathI <- paste0(path,i,"xxx.rds")
        paths <- c(paths,pathI)
        indexStart <- 100*(i-1)+1
        indexEnd <- ifelse(100*i < listLength, 100*i, listLength)
        matrixRows <- indexEnd - indexStart + 1
        mergedGclArray <- gclArray[indexStart:indexEnd] %>%
            purrr::map(
                function(x){
                    arrayLength <- length(x)
                    paddedArray <- c(x,rep(NA,maxArrayLength - arrayLength))
                    return(paddedArray)
                })
        mergedGclArray <- purrr::flatten_dbl(mergedGclArray) %>% 
            matrix(nrow = matrixRows,ncol = maxArrayLength) %>% 
            as.data.frame()
        names(mergedGclArray) <- columnNames
        saveRDS(object = mergedGclArray,file = pathI)
        cat(paste(i,"of",iters,"merged GCL array data and fixed to same length array into a data.frame saved in",pathI),"\n")
    }
    gc()
    rm(gclArray)
    mergedGclArray <- purrr::map_dfr(paths,readRDS)
    saveRDS(object = mergedGclArray,file = paste0(path,".rds"))
    tictoc::toc()
    return(mergedGclArray)
}


patientDetails <- mergePatientDetails(consData = "./CONS/data/all_data/eyeDataInitial.rds")
scanData <- mergeScanData(consData = "./CONS/data/all_data/eyeDataInitial.rds")
gclMatrix <- mergeGclMatrix(consData = "./CONS/data/all_data/eyeDataInitial.rds")
mem_change(gclArray <- mergeCleanGclArray(consData = "./CONS/data/all_data/eyeDataInitial.rds"))
mem_used()
