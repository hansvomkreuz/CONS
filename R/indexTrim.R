# FUNCTION: Index for standardised row by col matrix ----------------------
indexTrim <- function(indexData,row = 25, col = 512){
    cat("Generating standardised indices...\n")
    tictoc::tic("Standardised index generated")
    rows <- nrow(indexData)
    cols <- ncol(indexData)
    cat("'indexData' has",rows,"rows and",cols,"columns\n")
    center <- which(indexData == ",4", arr.ind = TRUE)
    centerR <- as.integer(center[1,1])
    centerC <- as.integer(center[1,2])
    cat("Center of 'indexData' at",centerR,"and",centerC,"row/column\n")
    if(rows < row){
        row <- rows
        cat("'row' input value is more than expected, value set to",row,"\n")
    }
    if(cols < col){
        col <- cols
        cat("'col' input value is more than expected, value set to",col,"\n")
    }
    if(row >=4 && row %% 2 == 0){
        row <- row - 1
        cat("'row' value is even number, value set to",row,"\n")
    }
    if(col >=4 && col %% 2 == 0){
        col <- col - 1
        cat("'col' value is even number, value set to",col,"\n")
    }
    rowOffset <- row %/% 2
    rowStart <- centerR - rowOffset
    rowEnd <- centerR + rowOffset
    colOffset <- col %/% 2
    colStart <- centerC - colOffset
    colEnd <- centerC + colOffset
    indexData <- indexData[c(rowStart:rowEnd),c(colStart:colEnd)]
    tictoc::toc()
    return(indexData)
}
