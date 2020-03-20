# FUNCTION: Convert matrix to array ---------------------------------------
spiralMatrixToArray <- function(gclData, eyeCenter){
    tic("Completed matrix to array transformation")
    dataInfo <- gclData[1,1:5]
    PatientNumber <- dataInfo$PatientNumber
    VisitNumber <- dataInfo$VisitNumber
    IsRightEye <- ifelse(dataInfo$EyeSide == "od",1,0)
    gclData <- gclData[,-c(1:5)] %>%
        as.matrix
    dims <- dim(gclData)
    maxR <- dims[1]
    maxC <- dims[2]
    currentR <- eyeCenter[1]
    currentC <- eyeCenter[2]
    totalSides <- max(maxC - currentC,currentC - 1) * 4 + 1
    for(i in 1:totalSides){
        elements <- (i + 1) %/% 2
        if (i == 1){
            arrayData <- as.integer(gclData[currentR,currentC])
            currentC <- currentC + elements
        } else if (i %% 4 == 1){
            if(between(currentR,1,maxR)){
                if(currentC < 1){
                    startC <- 1
                    extraStartElements <- rep(NA,1-currentC)
                } else {
                    startC <- currentC
                    extraStartElements <- rep(NA,0)
                }
                endC <- currentC + elements - 1
                if(endC > maxC){
                    extraEndElements <- rep(NA,endC - maxC)
                    endC <- maxC
                } else {
                    extraEndElements <- rep(NA,0)
                }
                arrayData <- c(arrayData,extraStartElements,as.integer(gclData[currentR,startC:endC]),extraEndElements)
            } else {
                arrayData <- c(arrayData,rep(NA,elements))
            }
            currentC <- currentC + elements
        } else if (i %% 4 == 2){
            if(between(currentC,1,maxC)){
                if(currentR > maxR){
                    startR <- maxR
                    extraStartElements <- rep(NA,currentR - maxR)
                } else {
                    startR <- currentR
                    extraStartElements <- rep(NA,0)
                }
                endR <- currentR - elements + 1
                if(endR < 1){
                    extraEndElements <- rep(NA,1 - endR)
                    endR <- 1
                } else {
                    extraEndElements <- rep(NA,0)
                }
                arrayData <- c(arrayData,extraStartElements,as.integer(gclData[startR:endR,currentC]),extraEndElements)
            } else {
                arrayData <- c(arrayData,rep(NA,elements))
            }
            currentR <- currentR - elements
        } else if (i %% 4 == 3){
            if(between(currentR,1,maxR)){
                if(currentC > maxC){
                    startC <- maxC
                    extraStartElements <- rep(NA,currentC - maxC)
                } else {
                    startC <- currentC
                    extraStartElements <- rep(NA,0)
                }
                endC <- currentC - elements + 1
                if(endC < 1){
                    extraEndElements <- rep(NA,1 - endC)
                    endC <- 1
                } else {
                    extraEndElements <- rep(NA,0)
                }
                arrayData <- c(arrayData,extraStartElements,as.integer(gclData[currentR,startC:endC]),extraEndElements)
            } else {
                arrayData <- c(arrayData,rep(NA,elements))
            }
            currentC <- currentC - elements
        } else if (i %% 4 == 0){
            if(between(currentC,1,maxC)){
                if(currentR < 1){
                    startR <- 1
                    extraStartElements <- rep(NA,1 - currentR)
                } else {
                    startR <- currentR
                    extraStartElements <- rep(NA,0)
                }
                endR <- currentR + elements - 1
                if(endR > maxR){
                    extraEndElements <- rep(NA,endR - maxR)
                    endR <- maxR
                } else {
                    extraEndElements <- rep(NA,0)
                }
                arrayData <- c(arrayData,extraStartElements,as.integer(gclData[startR:endR,currentC]),extraEndElements)
            } else {
                arrayData <- c(arrayData,rep(NA,elements))
            }
            currentR <- currentR + elements
        }
    }    
    arrayData <- c(PatientNumber,VisitNumber,IsRightEye,arrayData)
    toc()
    return(arrayData)
}