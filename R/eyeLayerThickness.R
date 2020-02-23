# FUNCTION: Generic eye thickness calculator given inputs -----------------
eyeLayerThickness <- function(consData,firstLayer = "ILM",lastLayer = "BM"){
    dataInfo <- consData %>% 
        select(c(1:5)) %>% 
        unique()
    firstLayer <- filter(consData,EyeLayer == firstLayer) %>% 
        select(-c(1:7))
    lastLayer <- filter(consData,EyeLayer == lastLayer) %>% 
        select(-c(1:7))
    data <- lastLayer - firstLayer
    data <- cbind(
        FileName = dataInfo$FileName
        ,FileName2 = dataInfo$FileName2
        ,PatientNumber = dataInfo$PatientNumber
        ,VisitNumber = dataInfo$VisitNumber
        ,EyeSide = dataInfo$EyeSide
        ,data)
    return(data)
}

# Sample use
# testPath <- './data'
# testFileName <- '3_1_os.xls'
# testConsData <- readConsFile(testPath,testFileName)
# testEyeLayerThickness <- eyeLayerThickness(consData = testConsData)

