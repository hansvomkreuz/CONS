# FUNCTION: Patient Details -----------------------------------------------
patientDetails <- function(path,fileName){
    data <- read.table(file = file.path(path,fileName),header = T,nrows = 1,sep = "\t")[,1:11]
    fileName <- parseFileName(fileName = fileName)
    data <- cbind(fileName,data) %>% 
        mutate_if(is.factor,as.character)
    return(data)
}

# Sample use
# testPath <- './data'
# testFileName <- '3_1_os.xls'
# testPatient <- patientDetails(testPath,testFileName)
