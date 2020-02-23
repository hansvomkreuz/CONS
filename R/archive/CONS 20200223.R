CONS <- function(codeDir = "./R", dataDir = "./data", imageDir = "./images"){
    
    # Creating and setting directories
    source(file.path(codeDir,"createDirectory.R"))
    createDirectory(dir = codeDir)
    cat("R codes will be sourced from",codeDir,"\n\n")
    createDirectory(dir = dataDir)
    cat("Data will be sourced from",dataDir,"\n\n")
    createDirectory(dir = imageDir)
    cat("Images will be saved in",imageDir,"\n\n")
    
    # Read R codes
    rCodes <- list.files(path = codeDir,pattern = ".R$") %>% 
        setdiff(c("CONS.R","createDirectory.R","runMe.R"))
    walk(
        rCodes,
        function(x){
            fileName <- file.path(codeDir,x)
            source(fileName)
        })
    
    # List all CONS files
    consFiles <- list.files(path = dataDir,pattern = ".xls$")
    cat("Processing files:\n")
    cat(paste(paste(consFiles,collapse = ", "),"\n\n"))
    
    messageString <- "Start processing all files...\n\n"
    cat(messageString)
    
    tic("Completed processing all files")
    suppressMessages(
        suppressWarnings(
            eyeDataInitial <- map(
                consFiles,
                function(x){
                    messageString <- paste("Processing",x,"file...\n")
                    cat(messageString)
                    messageString <- paste("Completed processing",x,"file")
                    tic(messageString)
                    patient <- patientDetails(path = dataDir,fileName = x)
                    cons <- readConsFile(path = dataDir,fileName = x) %>% 
                        tidyConsData()
                    center <- fovealCentre(consData = cons)
                    gclMatrix <- gclThickness(consData = cons)
                    gclArray <- spiralMatrixToArray(gclData = gclMatrix, eyeCenter = center)
                    renderEyeImage(consData = cons,imageDirectory = imageDir)
                    # data <- list(patientInfo = patient,scanData = cons,gclMatrix = gclMatrix)
                    data <- list(patientInfo = patient,scanData = cons,gclMatrix = gclMatrix, gclArray = gclArray)
                    toc()
                    cat("\n")
                    return(data)
                })
        )
    )
    
    saveRDS(object = eyeDataInitial,file = file.path(dataDir,"eyeDataInitial.rds"))
    
    patientInfo <- map_dfr(
        eyeDataInitial,
        function(x){
            x$patientInfo %>% 
                # mutate_if(is.factor,as.character)
                mutate_all(as.character)
        })
    
    scanData <- map_dfr(
        eyeDataInitial,
        function(x){
            x$scanData %>% 
                mutate_if(is.factor,as.character)
        })
    
    gclMatrix <- map_dfr(
        eyeDataInitial,
        function(x){
            x$gclMatrix %>% 
                mutate_if(is.factor,as.character)
        })
    
    gclArray <- map(
        eyeDataInitial,
        function(x){
            x$gclArray
        })        
    
    tic("Converting list of uneven length arrays to a data.frame")
    
    listLength <- length(gclArray)
    maxArrayLength <- max(sapply(gclArray,length))
    columnNames <- c("studyId","visit","eye",paste0("C",c(1:(maxArrayLength-3))))
    
    gclArray <- gclArray %>%
        map(
            function(x){
                arrayLength <- length(x)
                paddedArray <- c(x,rep(NA,maxArrayLength - arrayLength))
                return(paddedArray)
            })
    
    gclArray <- flatten_dbl(gclArray) %>% 
        matrix(nrow = listLength,ncol = maxArrayLength) %>% 
        as.data.frame()
    
    names(gclArray) <- columnNames
    
    toc()
    
    eyeDataFinal <- list(patientInfo = patientInfo,scanData = scanData,gclMatrix = gclMatrix, gclArray = gclArray)
    saveRDS(object = eyeDataFinal,file = file.path(dataDir,"eyeDataFinal.rds"))
    toc()
    return(eyeDataFinal)
}
