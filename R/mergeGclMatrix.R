# FUNCTION: Merge gcl matrix data -----------------------------------------
mergeGclMatrix <- function(eyeDataInitial){
    path <- stringr::str_split(eyeDataInitial,"/")[[1]]
    path <- file.path(paste0(path[-length(path)],collapse = "/"),"mergedGclMatrix.rds")
    tictoc::tic(paste("Merged GCL matrix data. File saved in",path))
    mergedGclMatrix <- readRDS(eyeDataInitial) %>% 
        purrr::map_dfr(
            function(x){
                x$gclMatrix %>% 
                    dplyr::mutate_if(is.factor,as.character)
            })    
    saveRDS(object = mergedGclMatrix,file = path)
    gc()
    tictoc::toc()
}
