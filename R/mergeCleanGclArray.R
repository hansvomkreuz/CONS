# FUNCTION: Clean and merge gcl array -------------------------------------
mergeCleanGclArray <- function(eyeDataInitial){
    path <- stringr::str_split(eyeDataInitial,"/")[[1]]
    path <- file.path(paste0(path[-length(path)],collapse = "/"),"mergedCleanedGclArray")
    tictoc::tic(paste0("Merged GCL array data and fixed to same length array completed and saved in ",path,"_N.rds"))
    memBefore <- as.numeric(pryr::mem_used()/1024^2)
    initialData <- readRDS(eyeDataInitial) %>% 
        purrr::map(
            function(x){
                x$gclArray
            })
    memAfter <- as.numeric(mem_used()/1024^2)
    memChange <- memAfter - memBefore
    iters <- ceiling(memChange/500)
    listLength <- length(initialData)
    maxArrayLength <- initialData %>% 
        purrr::map_dbl(length) %>% 
        max
    elementsPerIter <- ceiling(listLength/iters)
    initialData <- NULL
    rm(initialData)
    gc()
    for (i in seq.int(iters)) {
        pathI <- paste0(path,"_",i,".rds")
        tictoc::tic(paste0(i," of ",iters," - merged and fixed to same lengths of GCL array into a data.frame. Saved in ",pathI))
        indexStart <- elementsPerIter*(i-1)+1
        indexEnd <- ifelse(elementsPerIter * i < listLength, elementsPerIter * i, listLength)
        matrixRows <- indexEnd - indexStart + 1
        mergedGclArray <- readRDS(eyeDataInitial)[indexStart:indexEnd] %>%
            purrr::map(
                function(x){
                    gclArray <- x$gclArray
                    paddedGclArray <- c(gclArray,rep(NA,maxArrayLength - length(gclArray)))
                    return(paddedGclArray)
                }) %>% 
            purrr::flatten_dbl() %>%
            matrix(nrow = matrixRows,ncol = maxArrayLength) %>%
            as.data.frame()
        names(mergedGclArray) <- c("studyId","visit","eye",paste0("C",c(1:(maxArrayLength-3))))
        saveRDS(object = mergedGclArray,file = pathI)
        gc()
        tictoc::toc()
    }
    gc()
    tictoc::toc()
}
