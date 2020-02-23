# FUNCTION: Patient Details -----------------------------------------------
patientDetails <- function(path,fileName){
    data <- read_table2(file = file.path(path,fileName),skip = 0,n_max = 1)
    colnames(data) <- c('Lastname','Firstname','DOB','PatientID','Eye','ImageID','ExamDate','ExamTime','TimeZone','AQMVersion','Quality','ARTMean')
    data <- cbind(FileName = fileName,data)
    return(data)
}

# Sample use
# testPath <- './data'
# testFileName <- '3_1_os.xls'
# testPatient <- patientDetails(testPath,testFileName)
