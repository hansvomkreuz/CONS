# FUNCTION: Index generator based on longest array ------------------------
indexGenerator <- function(eyeDataInitial){
    cat("Generating index data...\n")
    tictoc::tic("Index data generated")
    initialData <- readRDS(eyeDataInitial)
    arrayLength <- map_dbl(initialData
                            ,function(x){
                                x <- length(x$gclArray) - 3
                                x
                            })
    totalCells <- max(arrayLength)
    arrayData <- seq.int(totalCells)
    sideLength <- sqrt(totalCells)
    centerPoint <- round((sideLength + 1)/2)
    currentR <- centerPoint
    currentC <- centerPoint
    totalSides <- ((sideLength - centerPoint) * 4) + 1
    indexMatrix <- data.frame(matrix(data = 1,nrow = sideLength,ncol = sideLength))
    for(i in seq.int(totalSides)){
        elements <- (i + 1) %/% 2
        if (i == 1){
            indexMatrix[currentR,currentC] <- 1
            arrayData <- arrayData[-1]
            currentC <- currentC + elements
        } else if (i %% 4 == 1){
            startC <- currentC
            endC <- currentC + elements - 1
            indexMatrix[currentR,startC:endC] <- arrayData[seq.int(elements)]
            arrayData <- arrayData[-seq.int(elements)]
            currentC <- currentC + elements
        } else if (i %% 4 == 2){
            startR <- currentR
            endR <- currentR - elements + 1
            indexMatrix[startR:endR,currentC] <- arrayData[seq.int(elements)]
            arrayData <- arrayData[-seq.int(elements)]
            currentR <- currentR - elements
        } else if (i %% 4 == 3){
            startC <- currentC
            endC <- currentC - elements + 1
            indexMatrix[currentR,startC:endC] <- arrayData[seq.int(elements)]
            arrayData <- arrayData[-seq.int(elements)]
            currentC <- currentC - elements
        } else if (i %% 4 == 0){
            startR <- currentR
            endR <- currentR + elements - 1
            indexMatrix[startR:endR,currentC] <- arrayData[seq.int(elements)]
            arrayData <- arrayData[-seq.int(elements)]
            currentR <- currentR + elements
        }
    }
    tictoc::toc()
    return(indexMatrix)
}
    