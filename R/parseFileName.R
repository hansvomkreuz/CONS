# FUNCTION: File name parser ----------------------------------------------
parseFileName <- function(fileName){
    fileName2 <- str_replace(string = fileName,pattern = ".xls",replacement = "")
    strings <- str_split(string = fileName2,pattern = "_")[[1]]
    data <- data.frame(
        FileName = fileName
        ,FileName2 = fileName2
        ,PatientNumber = strings[1]
        ,VisitNumber = strings[2]
        ,EyeSide = strings[3])
    return(data)
}

# Sample use
# testFileName <- '3_1_os.xls'
# testFileNameParsed <- parseFileName(testFileName)

