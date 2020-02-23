# FUNCTION: Convert matrix to array ---------------------------------------
spiralMatrixToArray <- function(gclData){
    tic("Completed matrix to array transformation")
    # dataInfo <- gclData[1,1:5]
    # PatientNumber <- dataInfo$PatientNumber
    # VisitNumber <- dataInfo$VisitNumber
    # EyeSide <- ifelse(dataInfo$EyeSide == "od",1,2)
    gclData <- gclData[,-c(1:5)]
    dims <- dim(gclData)
    center <- which(gclData == min(gclData, na.rm = TRUE), arr.ind = TRUE)
    maxR <- dims[1]
    maxC <- dims[2]
    centerR <- center[1]
    centerC <- center[2]
    maxIteration <- max((maxC - centerC)*2-1,(centerC-1)*2) + 1
    currentR <- centerR
    currentC <- centerC
    arrayData <- as.integer(gclData[currentR,currentC])
    for(i in 1:maxIteration){
        if(i%%2 == 1){
            for(j in 1:i){
                currentC <- currentC + 1
                if(between(currentR,1,maxR) & between(currentC,1,maxC)) {
                    arrayData <- append(arrayData,as.integer(gclData[currentR,currentC]))
                } else {
                    arrayData <- append(arrayData,NA)
                }
            }
            for(k in 1:i){
                currentR <- currentR - 1
                if(between(currentR,1,maxR) & between(currentC,1,maxC)) {
                    arrayData <- append(arrayData,as.integer(gclData[currentR,currentC]))
                } else {
                    arrayData <- append(arrayData,NA)
                }
            }
        } else {
            for(l in 1:i){
                currentC <- currentC - 1
                if(between(currentR,1,maxR) & between(currentC,1,maxC)) {
                    arrayData <- append(arrayData,as.integer(gclData[currentR,currentC]))
                } else {
                    arrayData <- append(arrayData,NA)
                }
            }
            for(m in 1:i){
                currentR <- currentR + 1
                if(between(currentR,1,maxR) & between(currentC,1,maxC)) {
                    arrayData <- append(arrayData,as.integer(gclData[currentR,currentC]))
                } else {
                    arrayData <- append(arrayData,NA)
                }
            }
        }
    }
    # arrayData <- c(PatientNumber,VisitNumber,EyeSide,arrayData)
    toc()
    # return(arrayData)
}