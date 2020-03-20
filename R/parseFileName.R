# FUNCTION: File name parser ----------------------------------------------
parseFileName <- function(fileName){
    fileName2 <- str_replace(string = fileName,pattern = ".xls",replacement = "")
    strings <- str_split(string = fileName2,pattern = "_")[[1]]
    data <- data.frame(
        FileName = as.character(fileName)
        ,FileName2 = as.character(fileName2)
        ,PatientNumber = as.integer(strings[1])
        ,VisitNumber = as.integer(strings[2])
        ,EyeSide = as.character(strings[3]))
    return(data)
}

# Sample use
# testFileName <- '3_1_os.xls'
# testFileNameParsed <- parseFileName(testFileName)

