CONS <- function(dataDir = "./data", imageDir = "./images"){
    
    # Creating and setting directories
    createDirectory(dir = dataDir)
    cat("Data will be sourced from",dataDir,"\n\n")
    createDirectory(dir = imageDir)
    cat("Images will be saved in",imageDir,"\n\n")
    
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
    toc()
    return(eyeDataInitial)
}
