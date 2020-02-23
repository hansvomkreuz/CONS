# FUNCTION: Merge scan data from the initial list of ----------------------
mergeScanData <- function(eyeDataInitial){
    path <- stringr::str_split(eyeDataInitial,"/")[[1]]
    path <- file.path(paste0(path[-length(path)],collapse = "/"),"mergedScanData.rds")
    tictoc::tic(paste("Merged scan data. File saved in",path))
    mergedScanData <- readRDS(eyeDataInitial) %>% 
        purrr::map_dfr(
            function(x){
                x$scanData %>% 
                    dplyr::mutate_if(is.factor,as.character)
            })
    
    saveRDS(object = mergedScanData,file = path)
    gc()
    tictoc::toc()
}

