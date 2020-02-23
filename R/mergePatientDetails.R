# FUNCTION: Merge patient data --------------------------------------------
mergePatientDetails <- function(eyeDataInitial){
    path <- stringr::str_split(eyeDataInitial,"/")[[1]]
    path <- file.path(paste0(path[-length(path)],collapse = "/"),"mergedPatientDetails.rds")
    tictoc::tic(paste("Merged patient data. File saved in",path))
    mergedPatientDetails <- readRDS(eyeDataInitial) %>% 
        purrr::map_dfr(
            function(x){
                x$patientInfo %>% 
                    dplyr::mutate_all(as.character)
            })
    
    saveRDS(object = mergedPatientDetails,file = path)
    gc()
    tictoc::toc()
}
